package com.metahub.service.ingestion;

import com.metahub.model.DataSource;
import com.metahub.model.Dataset;
import com.metahub.model.SchemaDefinition;
import com.metahub.model.ColumnDefinition;
import com.metahub.model.enums.ColumnDataType;
import com.metahub.model.enums.DataSourceType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Extracts metadata from JDBC-accessible databases using DatabaseMetaData.
 */
@Slf4j
@Component
public class JdbcIngestionStrategy implements IngestionStrategy {

    @Override
    public boolean supports(DataSource source) {
        return source.getType() == DataSourceType.JDBC;
    }

    @Override
    public List<Dataset> ingest(DataSource source) {
        List<Dataset> datasets = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(source.getConnectionUrl())) {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet tables = meta.getTables(null, null, "%", new String[]{"TABLE"});

            while (tables.next()) {
                String tableName = tables.getString("TABLE_NAME");
                String schemaName = tables.getString("TABLE_SCHEM");
                String qualifiedName = source.getName() + "." +
                        (schemaName != null ? schemaName + "." : "") + tableName;

                Dataset dataset = Dataset.builder()
                        .name(tableName)
                        .qualifiedName(qualifiedName)
                        .description("Auto-ingested from " + source.getName())
                        .dataSource(source)
                        .build();

                SchemaDefinition schemaDef = SchemaDefinition.builder()
                        .name(schemaName != null ? schemaName : "default")
                        .version(1)
                        .dataset(dataset)
                        .build();

                // Extract columns
                ResultSet columns = meta.getColumns(null, schemaName, tableName, "%");
                int ordinal = 0;
                while (columns.next()) {
                    ColumnDefinition col = ColumnDefinition.builder()
                            .name(columns.getString("COLUMN_NAME"))
                            .dataType(mapSqlType(columns.getInt("DATA_TYPE")))
                            .nullable("YES".equals(columns.getString("IS_NULLABLE")))
                            .isPrimaryKey(false)
                            .ordinalPosition(++ordinal)
                            .schema(schemaDef)
                            .build();
                    schemaDef.getColumns().add(col);
                }

                // Mark primary keys
                ResultSet pks = meta.getPrimaryKeys(null, schemaName, tableName);
                while (pks.next()) {
                    String pkCol = pks.getString("COLUMN_NAME");
                    schemaDef.getColumns().stream()
                            .filter(c -> c.getName().equals(pkCol))
                            .forEach(c -> c.setIsPrimaryKey(true));
                }

                dataset.getSchemas().add(schemaDef);
                datasets.add(dataset);
            }

            log.info("Ingested {} tables from JDBC source: {}", datasets.size(), source.getName());
        } catch (SQLException e) {
            log.error("JDBC ingestion failed for source: {}", source.getName(), e);
            throw new com.metahub.exception.IngestionException("JDBC ingestion failed: " + e.getMessage(), e);
        }

        return datasets;
    }

    private ColumnDataType mapSqlType(int sqlType) {
        return switch (sqlType) {
            case Types.VARCHAR, Types.CHAR, Types.LONGVARCHAR, Types.NVARCHAR, Types.NCHAR -> ColumnDataType.STRING;
            case Types.INTEGER, Types.SMALLINT, Types.TINYINT -> ColumnDataType.INTEGER;
            case Types.BIGINT -> ColumnDataType.LONG;
            case Types.FLOAT, Types.REAL -> ColumnDataType.FLOAT;
            case Types.DOUBLE, Types.DECIMAL, Types.NUMERIC -> ColumnDataType.DOUBLE;
            case Types.BOOLEAN, Types.BIT -> ColumnDataType.BOOLEAN;
            case Types.DATE -> ColumnDataType.DATE;
            case Types.TIMESTAMP, Types.TIMESTAMP_WITH_TIMEZONE -> ColumnDataType.TIMESTAMP;
            case Types.BINARY, Types.VARBINARY, Types.LONGVARBINARY, Types.BLOB -> ColumnDataType.BINARY;
            default -> ColumnDataType.UNKNOWN;
        };
    }
}


-- ============================================================================
-- MetaHub — Comprehensive Enterprise-Grade Seed Data (MDM Demo Edition)
-- ============================================================================
-- 12 Users | 36 Tags | 18 Data Sources | 74 Datasets | 74 Schemas | ~500 Columns
-- 51 Lineage Edges | 13 Governance Policies | 48 Glossary Terms
-- 50 Quality Scores | 50 Audit Logs | 36 Bookmarks | 36 Comments
-- ============================================================================
-- MDM (Master Data Management) Domains:
--   • Product MDM Hub: 8 datasets (product_master, hierarchy, attributes,
--     relationships, digital_assets, pricing, compliance, xref)
--   • Customer MDM Hub: 7 datasets (customer_master, addresses, contacts,
--     hierarchy, preferences, match_groups, xref)
--   • Vendor MDM Hub: 5 datasets (vendor_master, contacts, compliance,
--     contracts, xref)
--   • Location MDM Hub: 5 datasets (location_master, hierarchy, attributes,
--     channels, xref)
--   • Reference Data: 5 datasets (country, currency, UOM, code_lists, taxonomy)
--   • Data Quality: 4 datasets (rules_catalog, scores_history, stewardship, audit)
-- ============================================================================
-- ────────────────────────────────────────────────────────────────────────────
-- USERS (12)
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO users (id, username, email, display_name, role, created_at, updated_at) VALUES
    ('a1b2c3d4-0001-0001-0001-000000000001', 'admin',       'admin@metahub.io',        'Platform Admin',    'ADMIN',        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('a1b2c3d4-0001-0001-0001-000000000002', 'jchen',       'jessica.chen@metahub.io', 'Jessica Chen',      'ADMIN',        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('a1b2c3d4-0001-0001-0001-000000000003', 'mwilliams',   'marcus.williams@metahub.io','Marcus Williams', 'DATA_STEWARD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('a1b2c3d4-0001-0001-0001-000000000004', 'spatel',      'sarah.patel@metahub.io',  'Sarah Patel',       'DATA_STEWARD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('a1b2c3d4-0001-0001-0001-000000000005', 'akim',        'alex.kim@metahub.io',     'Alex Kim',          'DATA_STEWARD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('a1b2c3d4-0001-0001-0001-000000000006', 'rlopes',      'roberto.lopes@metahub.io','Roberto Lopes',     'VIEWER',       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('a1b2c3d4-0001-0001-0001-000000000007', 'enakamura',   'emily.nakamura@metahub.io','Emily Nakamura',   'VIEWER',       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('a1b2c3d4-0001-0001-0001-000000000008', 'dthompson',   'david.thompson@metahub.io','David Thompson',   'VIEWER',       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('a1b2c3d4-0001-0001-0001-000000000009', 'lwang',       'lisa.wang@metahub.io',    'Lisa Wang',         'DATA_STEWARD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('a1b2c3d4-0001-0001-0001-000000000010', 'jmartinez',   'juan.martinez@metahub.io','Juan Martinez',     'VIEWER',       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('a1b2c3d4-0001-0001-0001-000000000011', 'asingh',      'anika.singh@metahub.io',  'Anika Singh',       'DATA_STEWARD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('a1b2c3d4-0001-0001-0001-000000000012', 'bkowalski',   'ben.kowalski@metahub.io', 'Ben Kowalski',      'VIEWER',       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- ────────────────────────────────────────────────────────────────────────────
-- TAGS (20)
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO tags (id, name, category, description, created_at, updated_at) VALUES
    ('b1b2c3d4-0001-0001-0001-000000000001', 'PII',          'Compliance',      'Personally Identifiable Information — name, email, phone, SSN, etc.',       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000002', 'PHI',          'Compliance',      'Protected Health Information under HIPAA regulations.',                      CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000003', 'GDPR',         'Compliance',      'Subject to GDPR data protection regulations (EU residents).',               CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000004', 'SOC2',         'Compliance',      'SOC 2 Type II compliant — audited access controls and encryption.',          CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000005', 'HIPAA',        'Compliance',      'HIPAA-regulated dataset requiring encryption and access controls.',          CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000006', 'Confidential', 'Compliance',      'Confidential business data with restricted access.',                        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000007', 'Financial',    'Domain',          'Financial and monetary data (revenue, billing, payments).',                  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000008', 'Marketing',    'Domain',          'Marketing campaigns, attribution, and advertising data.',                    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000009', 'HR',           'Domain',          'Human Resources — employee, payroll, and organizational data.',              CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000010', 'Engineering',  'Domain',          'Engineering systems, logs, and infrastructure data.',                        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000011', 'Customer',     'Domain',          'Customer-related entities and behavioral data.',                             CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000012', 'Product',      'Domain',          'Product catalog, usage analytics, and experimentation data.',                CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000013', 'Production',   'Environment',     'Production environment — mission-critical, SLA-governed.',                   CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000014', 'Staging',      'Environment',     'Staging / pre-production environment for validation.',                      CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000015', 'Development',  'Environment',     'Development / sandbox environment for experimentation.',                    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000016', 'Deprecated',   'Lifecycle',       'Scheduled for removal — migrate consumers before EOL.',                     CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000017', 'Beta',         'Lifecycle',       'Beta release — schema and semantics may change without notice.',            CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000018', 'Stable',       'Lifecycle',       'Stable, production-grade dataset with backward compatibility guarantees.',  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000019', 'Internal',     'Classification',  'Internal use only — not to be shared outside the organization.',            CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000020', 'Restricted',   'Classification',  'Restricted access — requires explicit approval and audit logging.',         CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- ────────────────────────────────────────────────────────────────────────────
-- DATA SOURCES (8)
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO data_sources (id, name, type, connection_url, description, created_at, updated_at) VALUES
    ('c1b2c3d4-0001-0001-0001-000000000001', 'Sales PostgreSQL',        'JDBC',          'jdbc:postgresql://sales-db.prod.internal:5432/sales',           'Production sales OLTP database (PostgreSQL 15) — customers, orders, products.',            CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('c1b2c3d4-0001-0001-0001-000000000002', 'Data Warehouse',          'JDBC',          'jdbc:snowflake://acme.snowflakecomputing.com/?db=WAREHOUSE',    'Enterprise Snowflake data warehouse — fact/dim tables for analytics.',                      CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('c1b2c3d4-0001-0001-0001-000000000003', 'Data Lake S3',            'CLOUD_STORAGE', 's3://acme-data-lake-prod/',                                     'AWS S3 data lake — raw ingestion zone for clickstream, logs, and campaign data.',           CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('c1b2c3d4-0001-0001-0001-000000000004', 'HR System API',           'API',           'https://hr.internal.acme.com/api/v2',                           'Workday HR REST API — employee directory, departments, and payroll.',                       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('c1b2c3d4-0001-0001-0001-000000000005', 'Product Analytics DB',    'JDBC',          'jdbc:postgresql://product-db.prod.internal:5432/analytics',      'Product analytics PostgreSQL — feature usage tracking and A/B experiments.',                CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('c1b2c3d4-0001-0001-0001-000000000006', 'Marketing Platform API',  'API',           'https://marketing.internal.acme.com/api/v1',                    'HubSpot / internal marketing platform REST API — campaigns and ad performance.',           CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('c1b2c3d4-0001-0001-0001-000000000007', 'Finance ERP Database',    'JDBC',          'jdbc:postgresql://finance-erp.prod.internal:5432/finance',       'SAP Finance ERP database — invoices, general ledger, and accounts receivable.',            CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('c1b2c3d4-0001-0001-0001-000000000008', 'Log Storage',             'FILE_SYSTEM',   '/mnt/nfs/logs/prod/',                                           'NFS-mounted centralized log storage — application logs and archived audit trails.',        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- ────────────────────────────────────────────────────────────────────────────
-- DATASETS (24)
-- ────────────────────────────────────────────────────────────────────────────
-- Sales Domain (Source: Sales PostgreSQL)
INSERT INTO datasets (id, name, description, qualified_name, data_source_id, owner_id, created_at, updated_at) VALUES
    ('d1b2c3d4-0001-0001-0001-000000000001', 'customers',          'Customer master data including contact info, registration date, and account status. Contains PII fields (email, phone, address).',                                  'sales_db.public.customers',          'c1b2c3d4-0001-0001-0001-000000000001', 'a1b2c3d4-0001-0001-0001-000000000003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000002', 'orders',             'Sales order transactions with status tracking, total amounts, and shipping details. Primary revenue source for the fact_daily_revenue pipeline.',                     'sales_db.public.orders',             'c1b2c3d4-0001-0001-0001-000000000001', 'a1b2c3d4-0001-0001-0001-000000000003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000003', 'order_items',        'Individual line items within each order — product, quantity, unit price, and computed subtotal. Granular data for product-level revenue analysis.',                  'sales_db.public.order_items',        'c1b2c3d4-0001-0001-0001-000000000001', 'a1b2c3d4-0001-0001-0001-000000000003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000004', 'products',           'Product catalog with SKU, pricing, category assignment, and active/inactive status. Source of truth for product attributes.',                                        'sales_db.public.products',           'c1b2c3d4-0001-0001-0001-000000000001', 'a1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000005', 'product_categories', 'Hierarchical product category tree with self-referencing parent_category_id for multi-level taxonomy.',                                                             'sales_db.public.product_categories', 'c1b2c3d4-0001-0001-0001-000000000001', 'a1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Warehouse / Analytics Domain (Source: Data Warehouse)
INSERT INTO datasets (id, name, description, qualified_name, data_source_id, owner_id, created_at, updated_at) VALUES
    ('d1b2c3d4-0001-0001-0001-000000000006', 'fact_daily_revenue',          'Daily revenue fact table aggregated from orders and order_items. Includes product, customer segment, region, and discount breakdowns.',                'warehouse.analytics.fact_daily_revenue',          'c1b2c3d4-0001-0001-0001-000000000002', 'a1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000007', 'dim_customers',               'Customer dimension table built from sales customers and employee data. Includes derived fields: segment, lifetime_value, and first_purchase_date.', 'warehouse.analytics.dim_customers',               'c1b2c3d4-0001-0001-0001-000000000002', 'a1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000008', 'fact_user_sessions',          'User session fact table derived from clickstream events. Captures session duration, page views, device, and geography.',                              'warehouse.analytics.fact_user_sessions',          'c1b2c3d4-0001-0001-0001-000000000002', 'a1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000009', 'dim_products',                'Product dimension table with enriched category hierarchy, brand, and price tier classification.',                                                    'warehouse.analytics.dim_products',                'c1b2c3d4-0001-0001-0001-000000000002', 'a1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000010', 'fact_marketing_attribution',  'Multi-touch marketing attribution fact table. Maps campaigns to conversions with first-touch and last-touch credit assignment.',                     'warehouse.analytics.fact_marketing_attribution',  'c1b2c3d4-0001-0001-0001-000000000002', 'a1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Data Lake Domain (Source: S3)
INSERT INTO datasets (id, name, description, qualified_name, data_source_id, owner_id, created_at, updated_at) VALUES
    ('d1b2c3d4-0001-0001-0001-000000000011', 'raw_clickstream_events', 'Raw clickstream events from web and mobile SDKs. High-volume append-only stream (approx 50M events/day). Partitioned by date.',                              's3://acme-data-lake-prod/raw/clickstream/',     'c1b2c3d4-0001-0001-0001-000000000003', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000012', 'raw_server_logs',        'Raw server access logs collected from all production services. Includes request path, status codes, latency, and trace IDs.',                                  's3://acme-data-lake-prod/raw/server-logs/',     'c1b2c3d4-0001-0001-0001-000000000003', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000013', 'raw_email_campaigns',    'Raw email campaign performance data synced from email service provider. Includes send counts, open rates, click-through rates, and unsubscribes.',             's3://acme-data-lake-prod/raw/email-campaigns/', 'c1b2c3d4-0001-0001-0001-000000000003', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- HR Domain (Source: HR System API)
INSERT INTO datasets (id, name, description, qualified_name, data_source_id, owner_id, created_at, updated_at) VALUES
    ('d1b2c3d4-0001-0001-0001-000000000014', 'employees',       'Employee directory from Workday HR. Contains PII (name, email, phone) and compensation data. HIPAA-adjacent due to benefits info.',                 'hr_api.workforce.employees',       'c1b2c3d4-0001-0001-0001-000000000004', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000015', 'departments',     'Organizational department structure with reporting hierarchy and cost center assignments.',                                                        'hr_api.workforce.departments',     'c1b2c3d4-0001-0001-0001-000000000004', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000016', 'payroll_summary', 'Aggregated payroll data per pay period. Highly sensitive — contains gross pay, deductions, and net pay per employee.',                                'hr_api.payroll.payroll_summary',    'c1b2c3d4-0001-0001-0001-000000000004', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Product Analytics Domain (Source: Product Analytics DB)
INSERT INTO datasets (id, name, description, qualified_name, data_source_id, owner_id, created_at, updated_at) VALUES
    ('d1b2c3d4-0001-0001-0001-000000000017', 'feature_usage',   'Product feature usage tracking — counts how often each feature is used, first/last usage timestamps. Powers product roadmap decisions.',              'product_db.analytics.feature_usage',   'c1b2c3d4-0001-0001-0001-000000000005', 'a1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000018', 'ab_test_results', 'A/B test experiment results. Each row = one user-variant-metric observation. Used by data science for experiment analysis.',                          'product_db.experiments.ab_test_results','c1b2c3d4-0001-0001-0001-000000000005', 'a1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Marketing Domain (Source: Marketing Platform API)
INSERT INTO datasets (id, name, description, qualified_name, data_source_id, owner_id, created_at, updated_at) VALUES
    ('d1b2c3d4-0001-0001-0001-000000000019', 'campaigns',       'Marketing campaign definitions — channel, budget, date ranges, and status. Source for marketing attribution pipeline.',                              'marketing_api.campaigns.campaigns',      'c1b2c3d4-0001-0001-0001-000000000006', 'a1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000020', 'ad_impressions',  'Advertising impression and click data aggregated by campaign and platform. Used for ROAS calculations and budget optimization.',                     'marketing_api.performance.ad_impressions','c1b2c3d4-0001-0001-0001-000000000006', 'a1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Finance Domain (Source: Finance ERP Database)
INSERT INTO datasets (id, name, description, qualified_name, data_source_id, owner_id, created_at, updated_at) VALUES
    ('d1b2c3d4-0001-0001-0001-000000000021', 'invoices',        'Customer invoices with amounts, due dates, payment status, and currency. Source for accounts receivable reporting.',                                  'finance_erp.ar.invoices',           'c1b2c3d4-0001-0001-0001-000000000007', 'a1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000022', 'general_ledger',  'General ledger entries with account codes, posting dates, and cost center allocations. Foundation for all financial reporting.',                      'finance_erp.gl.general_ledger',     'c1b2c3d4-0001-0001-0001-000000000007', 'a1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Logs Domain (Source: Log Storage)
INSERT INTO datasets (id, name, description, qualified_name, data_source_id, owner_id, created_at, updated_at) VALUES
    ('d1b2c3d4-0001-0001-0001-000000000023', 'application_logs',      'Processed application log files from all production microservices. Parsed from raw server logs with structured fields.',                        'log_storage.processed.application_logs',      'c1b2c3d4-0001-0001-0001-000000000008', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000024', 'audit_trail_archive',   'Archived audit trail records older than 2 years. Retained for compliance. Deprecated — new data goes to centralized audit service.',          'log_storage.archive.audit_trail_archive',     'c1b2c3d4-0001-0001-0001-000000000008', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- ────────────────────────────────────────────────────────────────────────────
-- DATASET-TAG ASSOCIATIONS
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO dataset_tags (dataset_id, tag_id) VALUES
    -- customers: PII, GDPR, Customer, Production, Stable, Internal
    ('d1b2c3d4-0001-0001-0001-000000000001', 'b1b2c3d4-0001-0001-0001-000000000001'),
    ('d1b2c3d4-0001-0001-0001-000000000001', 'b1b2c3d4-0001-0001-0001-000000000003'),
    ('d1b2c3d4-0001-0001-0001-000000000001', 'b1b2c3d4-0001-0001-0001-000000000011'),
    ('d1b2c3d4-0001-0001-0001-000000000001', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000001', 'b1b2c3d4-0001-0001-0001-000000000018'),
    ('d1b2c3d4-0001-0001-0001-000000000001', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- orders: Financial, Customer, Production, Stable, Internal
    ('d1b2c3d4-0001-0001-0001-000000000002', 'b1b2c3d4-0001-0001-0001-000000000007'),
    ('d1b2c3d4-0001-0001-0001-000000000002', 'b1b2c3d4-0001-0001-0001-000000000011'),
    ('d1b2c3d4-0001-0001-0001-000000000002', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000002', 'b1b2c3d4-0001-0001-0001-000000000018'),
    ('d1b2c3d4-0001-0001-0001-000000000002', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- order_items: Financial, Production, Internal
    ('d1b2c3d4-0001-0001-0001-000000000003', 'b1b2c3d4-0001-0001-0001-000000000007'),
    ('d1b2c3d4-0001-0001-0001-000000000003', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000003', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- products: Product, Production, Stable, Internal
    ('d1b2c3d4-0001-0001-0001-000000000004', 'b1b2c3d4-0001-0001-0001-000000000012'),
    ('d1b2c3d4-0001-0001-0001-000000000004', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000004', 'b1b2c3d4-0001-0001-0001-000000000018'),
    ('d1b2c3d4-0001-0001-0001-000000000004', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- product_categories: Product, Production, Internal
    ('d1b2c3d4-0001-0001-0001-000000000005', 'b1b2c3d4-0001-0001-0001-000000000012'),
    ('d1b2c3d4-0001-0001-0001-000000000005', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000005', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- fact_daily_revenue: Financial, SOC2, Production, Stable, Internal
    ('d1b2c3d4-0001-0001-0001-000000000006', 'b1b2c3d4-0001-0001-0001-000000000007'),
    ('d1b2c3d4-0001-0001-0001-000000000006', 'b1b2c3d4-0001-0001-0001-000000000004'),
    ('d1b2c3d4-0001-0001-0001-000000000006', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000006', 'b1b2c3d4-0001-0001-0001-000000000018'),
    ('d1b2c3d4-0001-0001-0001-000000000006', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- dim_customers: PII, GDPR, Customer, Production, Internal
    ('d1b2c3d4-0001-0001-0001-000000000007', 'b1b2c3d4-0001-0001-0001-000000000001'),
    ('d1b2c3d4-0001-0001-0001-000000000007', 'b1b2c3d4-0001-0001-0001-000000000003'),
    ('d1b2c3d4-0001-0001-0001-000000000007', 'b1b2c3d4-0001-0001-0001-000000000011'),
    ('d1b2c3d4-0001-0001-0001-000000000007', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000007', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- fact_user_sessions: Product, Production, Internal
    ('d1b2c3d4-0001-0001-0001-000000000008', 'b1b2c3d4-0001-0001-0001-000000000012'),
    ('d1b2c3d4-0001-0001-0001-000000000008', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000008', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- dim_products: Product, Production, Stable, Internal
    ('d1b2c3d4-0001-0001-0001-000000000009', 'b1b2c3d4-0001-0001-0001-000000000012'),
    ('d1b2c3d4-0001-0001-0001-000000000009', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000009', 'b1b2c3d4-0001-0001-0001-000000000018'),
    ('d1b2c3d4-0001-0001-0001-000000000009', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- fact_marketing_attribution: Marketing, Production, Internal
    ('d1b2c3d4-0001-0001-0001-000000000010', 'b1b2c3d4-0001-0001-0001-000000000008'),
    ('d1b2c3d4-0001-0001-0001-000000000010', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000010', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- raw_clickstream_events: PII, Product, Development, Internal
    ('d1b2c3d4-0001-0001-0001-000000000011', 'b1b2c3d4-0001-0001-0001-000000000001'),
    ('d1b2c3d4-0001-0001-0001-000000000011', 'b1b2c3d4-0001-0001-0001-000000000012'),
    ('d1b2c3d4-0001-0001-0001-000000000011', 'b1b2c3d4-0001-0001-0001-000000000015'),
    ('d1b2c3d4-0001-0001-0001-000000000011', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- raw_server_logs: Engineering, Development, Internal
    ('d1b2c3d4-0001-0001-0001-000000000012', 'b1b2c3d4-0001-0001-0001-000000000010'),
    ('d1b2c3d4-0001-0001-0001-000000000012', 'b1b2c3d4-0001-0001-0001-000000000015'),
    ('d1b2c3d4-0001-0001-0001-000000000012', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- raw_email_campaigns: Marketing, PII, Internal
    ('d1b2c3d4-0001-0001-0001-000000000013', 'b1b2c3d4-0001-0001-0001-000000000008'),
    ('d1b2c3d4-0001-0001-0001-000000000013', 'b1b2c3d4-0001-0001-0001-000000000001'),
    ('d1b2c3d4-0001-0001-0001-000000000013', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- employees: PII, HIPAA, HR, GDPR, Confidential, Restricted, Production
    ('d1b2c3d4-0001-0001-0001-000000000014', 'b1b2c3d4-0001-0001-0001-000000000001'),
    ('d1b2c3d4-0001-0001-0001-000000000014', 'b1b2c3d4-0001-0001-0001-000000000005'),
    ('d1b2c3d4-0001-0001-0001-000000000014', 'b1b2c3d4-0001-0001-0001-000000000009'),
    ('d1b2c3d4-0001-0001-0001-000000000014', 'b1b2c3d4-0001-0001-0001-000000000003'),
    ('d1b2c3d4-0001-0001-0001-000000000014', 'b1b2c3d4-0001-0001-0001-000000000006'),
    ('d1b2c3d4-0001-0001-0001-000000000014', 'b1b2c3d4-0001-0001-0001-000000000020'),
    ('d1b2c3d4-0001-0001-0001-000000000014', 'b1b2c3d4-0001-0001-0001-000000000013'),
    -- departments: HR, Production, Internal
    ('d1b2c3d4-0001-0001-0001-000000000015', 'b1b2c3d4-0001-0001-0001-000000000009'),
    ('d1b2c3d4-0001-0001-0001-000000000015', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000015', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- payroll_summary: PII, Financial, HR, SOC2, Confidential, Restricted, Production
    ('d1b2c3d4-0001-0001-0001-000000000016', 'b1b2c3d4-0001-0001-0001-000000000001'),
    ('d1b2c3d4-0001-0001-0001-000000000016', 'b1b2c3d4-0001-0001-0001-000000000007'),
    ('d1b2c3d4-0001-0001-0001-000000000016', 'b1b2c3d4-0001-0001-0001-000000000009'),
    ('d1b2c3d4-0001-0001-0001-000000000016', 'b1b2c3d4-0001-0001-0001-000000000004'),
    ('d1b2c3d4-0001-0001-0001-000000000016', 'b1b2c3d4-0001-0001-0001-000000000006'),
    ('d1b2c3d4-0001-0001-0001-000000000016', 'b1b2c3d4-0001-0001-0001-000000000020'),
    ('d1b2c3d4-0001-0001-0001-000000000016', 'b1b2c3d4-0001-0001-0001-000000000013'),
    -- feature_usage: Product, Production, Internal
    ('d1b2c3d4-0001-0001-0001-000000000017', 'b1b2c3d4-0001-0001-0001-000000000012'),
    ('d1b2c3d4-0001-0001-0001-000000000017', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000017', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- ab_test_results: Product, Beta, Internal
    ('d1b2c3d4-0001-0001-0001-000000000018', 'b1b2c3d4-0001-0001-0001-000000000012'),
    ('d1b2c3d4-0001-0001-0001-000000000018', 'b1b2c3d4-0001-0001-0001-000000000017'),
    ('d1b2c3d4-0001-0001-0001-000000000018', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- campaigns: Marketing, Production, Internal
    ('d1b2c3d4-0001-0001-0001-000000000019', 'b1b2c3d4-0001-0001-0001-000000000008'),
    ('d1b2c3d4-0001-0001-0001-000000000019', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000019', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- ad_impressions: Marketing, Production, Internal
    ('d1b2c3d4-0001-0001-0001-000000000020', 'b1b2c3d4-0001-0001-0001-000000000008'),
    ('d1b2c3d4-0001-0001-0001-000000000020', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000020', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- invoices: Financial, SOC2, Production, Internal
    ('d1b2c3d4-0001-0001-0001-000000000021', 'b1b2c3d4-0001-0001-0001-000000000007'),
    ('d1b2c3d4-0001-0001-0001-000000000021', 'b1b2c3d4-0001-0001-0001-000000000004'),
    ('d1b2c3d4-0001-0001-0001-000000000021', 'b1b2c3d4-0001-0001-0001-000000000013'),
    ('d1b2c3d4-0001-0001-0001-000000000021', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- general_ledger: Financial, SOC2, Confidential, Restricted, Production
    ('d1b2c3d4-0001-0001-0001-000000000022', 'b1b2c3d4-0001-0001-0001-000000000007'),
    ('d1b2c3d4-0001-0001-0001-000000000022', 'b1b2c3d4-0001-0001-0001-000000000004'),
    ('d1b2c3d4-0001-0001-0001-000000000022', 'b1b2c3d4-0001-0001-0001-000000000006'),
    ('d1b2c3d4-0001-0001-0001-000000000022', 'b1b2c3d4-0001-0001-0001-000000000020'),
    ('d1b2c3d4-0001-0001-0001-000000000022', 'b1b2c3d4-0001-0001-0001-000000000013'),
    -- application_logs: Engineering, Development, Internal
    ('d1b2c3d4-0001-0001-0001-000000000023', 'b1b2c3d4-0001-0001-0001-000000000010'),
    ('d1b2c3d4-0001-0001-0001-000000000023', 'b1b2c3d4-0001-0001-0001-000000000015'),
    ('d1b2c3d4-0001-0001-0001-000000000023', 'b1b2c3d4-0001-0001-0001-000000000019'),
    -- audit_trail_archive: Engineering, Deprecated, Internal
    ('d1b2c3d4-0001-0001-0001-000000000024', 'b1b2c3d4-0001-0001-0001-000000000010'),
    ('d1b2c3d4-0001-0001-0001-000000000024', 'b1b2c3d4-0001-0001-0001-000000000016'),
    ('d1b2c3d4-0001-0001-0001-000000000024', 'b1b2c3d4-0001-0001-0001-000000000019');
-- ────────────────────────────────────────────────────────────────────────────
-- SCHEMA DEFINITIONS (24 — one per dataset)
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO schema_definitions (id, name, version, dataset_id, created_at, updated_at) VALUES
    ('e1b2c3d4-0001-0001-0001-000000000001', 'public',      1, 'd1b2c3d4-0001-0001-0001-000000000001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000002', 'public',      1, 'd1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000003', 'public',      1, 'd1b2c3d4-0001-0001-0001-000000000003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000004', 'public',      1, 'd1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000005', 'public',      1, 'd1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000006', 'analytics',   1, 'd1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000007', 'analytics',   1, 'd1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000008', 'analytics',   1, 'd1b2c3d4-0001-0001-0001-000000000008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000009', 'analytics',   1, 'd1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000010', 'analytics',   1, 'd1b2c3d4-0001-0001-0001-000000000010', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000011', 'raw',         1, 'd1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000012', 'raw',         1, 'd1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000013', 'raw',         1, 'd1b2c3d4-0001-0001-0001-000000000013', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000014', 'workforce',   1, 'd1b2c3d4-0001-0001-0001-000000000014', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000015', 'workforce',   1, 'd1b2c3d4-0001-0001-0001-000000000015', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000016', 'payroll',     1, 'd1b2c3d4-0001-0001-0001-000000000016', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000017', 'analytics',   1, 'd1b2c3d4-0001-0001-0001-000000000017', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000018', 'experiments', 1, 'd1b2c3d4-0001-0001-0001-000000000018', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000019', 'campaigns',   1, 'd1b2c3d4-0001-0001-0001-000000000019', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000020', 'performance', 1, 'd1b2c3d4-0001-0001-0001-000000000020', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000021', 'ar',          1, 'd1b2c3d4-0001-0001-0001-000000000021', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000022', 'gl',          1, 'd1b2c3d4-0001-0001-0001-000000000022', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000023', 'processed',   1, 'd1b2c3d4-0001-0001-0001-000000000023', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000024', 'archive',     1, 'd1b2c3d4-0001-0001-0001-000000000024', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- ────────────────────────────────────────────────────────────────────────────
-- COLUMN DEFINITIONS (~152 columns across 24 datasets)
-- UUID pattern: f1b2c3d4-0001-0001-0001-00000000XXYY  (XX=schema, YY=col)
-- ────────────────────────────────────────────────────────────────────────────
-- Schema 01: customers (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000000101', 'customer_id',  'LONG',      false, true,  'Unique customer identifier (auto-increment)',           1, 'e1b2c3d4-0001-0001-0001-000000000001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000102', 'email',        'STRING',    false, false, 'Customer email address (PII, unique)',                   2, 'e1b2c3d4-0001-0001-0001-000000000001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000103', 'first_name',   'STRING',    false, false, 'Customer first name (PII)',                              3, 'e1b2c3d4-0001-0001-0001-000000000001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000104', 'last_name',    'STRING',    false, false, 'Customer last name (PII)',                               4, 'e1b2c3d4-0001-0001-0001-000000000001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000105', 'phone',        'STRING',    true,  false, 'Phone number with country code (PII, nullable)',         5, 'e1b2c3d4-0001-0001-0001-000000000001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000106', 'created_at',   'TIMESTAMP', false, false, 'Account registration timestamp',                        6, 'e1b2c3d4-0001-0001-0001-000000000001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 02: orders (7 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000000201', 'order_id',         'LONG',      false, true,  'Unique order identifier',                              1, 'e1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000202', 'customer_id',      'LONG',      false, false, 'FK to customers.customer_id',                          2, 'e1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000203', 'order_date',       'TIMESTAMP', false, false, 'Timestamp when order was placed',                      3, 'e1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000204', 'status',           'STRING',    false, false, 'Order status: PENDING, CONFIRMED, SHIPPED, DELIVERED, CANCELLED', 4, 'e1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000205', 'total_amount',     'DOUBLE',    false, false, 'Total order amount in USD',                            5, 'e1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000206', 'shipping_address', 'STRING',    true,  false, 'Delivery address (PII, nullable for digital orders)',   6, 'e1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000207', 'created_at',       'TIMESTAMP', false, false, 'Record creation timestamp',                            7, 'e1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 03: order_items (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000000301', 'item_id',    'LONG',   false, true,  'Unique line item identifier',                           1, 'e1b2c3d4-0001-0001-0001-000000000003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000302', 'order_id',   'LONG',   false, false, 'FK to orders.order_id',                                 2, 'e1b2c3d4-0001-0001-0001-000000000003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000303', 'product_id', 'LONG',   false, false, 'FK to products.product_id',                             3, 'e1b2c3d4-0001-0001-0001-000000000003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000304', 'quantity',   'INTEGER',false, false, 'Number of units ordered',                               4, 'e1b2c3d4-0001-0001-0001-000000000003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000305', 'unit_price', 'DOUBLE', false, false, 'Price per unit at time of order (snapshot)',             5, 'e1b2c3d4-0001-0001-0001-000000000003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000306', 'subtotal',   'DOUBLE', false, false, 'Computed: quantity * unit_price',                       6, 'e1b2c3d4-0001-0001-0001-000000000003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 04: products (7 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000000401', 'product_id',   'LONG',    false, true,  'Unique product identifier',                            1, 'e1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000402', 'name',         'STRING',  false, false, 'Product display name',                                 2, 'e1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000403', 'sku',          'STRING',  false, false, 'Stock keeping unit (unique)',                           3, 'e1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000404', 'description',  'STRING',  true,  false, 'Product description text',                             4, 'e1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000405', 'price',        'DOUBLE',  false, false, 'Current list price in USD',                            5, 'e1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000406', 'category_id',  'LONG',    false, false, 'FK to product_categories.category_id',                 6, 'e1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000407', 'is_active',    'BOOLEAN', false, false, 'Whether product is currently available for sale',       7, 'e1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 05: product_categories (4 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000000501', 'category_id',        'LONG',   false, true,  'Unique category identifier',                          1, 'e1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000502', 'name',               'STRING', false, false, 'Category display name',                               2, 'e1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000503', 'parent_category_id', 'LONG',   true,  false, 'Self-referencing FK for hierarchy (NULL = root)',      3, 'e1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000504', 'description',        'STRING', true,  false, 'Category description',                                4, 'e1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 06: fact_daily_revenue (7 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000000601', 'date_key',         'DATE',    false, false, 'Revenue date (partition key)',                         1, 'e1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000602', 'product_key',      'LONG',    false, false, 'FK to dim_products.product_key',                      2, 'e1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000603', 'customer_segment', 'STRING',  false, false, 'Customer segment: Enterprise, SMB, Consumer',         3, 'e1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000604', 'revenue',          'DOUBLE',  false, false, 'Total revenue in USD for this slice',                 4, 'e1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000605', 'units_sold',       'INTEGER', false, false, 'Number of units sold',                                5, 'e1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000606', 'discount_amount',  'DOUBLE',  false, false, 'Total discount applied in USD',                       6, 'e1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000607', 'region',           'STRING',  false, false, 'Geographic region: NA, EMEA, APAC, LATAM',            7, 'e1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 07: dim_customers (8 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000000701', 'customer_key',        'LONG',    false, true,  'Surrogate key for SCD Type 2',                       1, 'e1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000702', 'customer_id',         'LONG',    false, false, 'Natural key from source (customers.customer_id)',     2, 'e1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000703', 'email',               'STRING',  false, false, 'Customer email (PII)',                                3, 'e1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000704', 'full_name',           'STRING',  false, false, 'Concatenated first + last name (PII)',                4, 'e1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000705', 'segment',             'STRING',  false, false, 'Derived customer segment: Enterprise, SMB, Consumer', 5, 'e1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000706', 'lifetime_value',      'DOUBLE',  false, false, 'Computed CLV based on historical orders',             6, 'e1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000707', 'first_purchase_date', 'DATE',    true,  false, 'Date of first order (NULL if never ordered)',          7, 'e1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000708', 'is_active',           'BOOLEAN', false, false, 'Whether customer has ordered in last 12 months',      8, 'e1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 08: fact_user_sessions (7 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000000801', 'session_id',     'STRING',    false, true,  'Unique session UUID',                                  1, 'e1b2c3d4-0001-0001-0001-000000000008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000802', 'user_id',        'LONG',      false, false, 'FK to customers or anonymous user hash',               2, 'e1b2c3d4-0001-0001-0001-000000000008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000803', 'session_start',  'TIMESTAMP', false, false, 'Session start timestamp (UTC)',                        3, 'e1b2c3d4-0001-0001-0001-000000000008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000804', 'session_end',    'TIMESTAMP', true,  false, 'Session end timestamp (NULL if still active)',          4, 'e1b2c3d4-0001-0001-0001-000000000008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000805', 'page_views',     'INTEGER',   false, false, 'Total pages viewed in session',                        5, 'e1b2c3d4-0001-0001-0001-000000000008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000806', 'device_type',    'STRING',    false, false, 'Device: desktop, mobile, tablet',                      6, 'e1b2c3d4-0001-0001-0001-000000000008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000807', 'country',        'STRING',    false, false, 'ISO 3166-1 alpha-2 country code',                      7, 'e1b2c3d4-0001-0001-0001-000000000008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 09: dim_products (7 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000000901', 'product_key',   'LONG',   false, true,  'Surrogate key for product dimension',                   1, 'e1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000902', 'product_id',    'LONG',   false, false, 'Natural key from source (products.product_id)',          2, 'e1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000903', 'product_name',  'STRING', false, false, 'Product display name',                                  3, 'e1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000904', 'category',      'STRING', false, false, 'Top-level category name (denormalized)',                 4, 'e1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000905', 'subcategory',   'STRING', true,  false, 'Sub-category name (nullable)',                           5, 'e1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000906', 'brand',         'STRING', false, false, 'Product brand or manufacturer',                         6, 'e1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000000907', 'price_tier',    'STRING', false, false, 'Price tier: Budget, Mid-Range, Premium, Luxury',         7, 'e1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 10: fact_marketing_attribution (7 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000001001', 'attribution_id',   'LONG',    false, true,  'Unique attribution record ID',                        1, 'e1b2c3d4-0001-0001-0001-000000000010', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001002', 'campaign_id',      'LONG',    false, false, 'FK to campaigns.campaign_id',                         2, 'e1b2c3d4-0001-0001-0001-000000000010', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001003', 'channel',          'STRING',  false, false, 'Marketing channel: Email, Paid Search, Social, Display, Organic', 3, 'e1b2c3d4-0001-0001-0001-000000000010', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001004', 'touchpoint_date',  'DATE',    false, false, 'Date of the marketing touchpoint',                    4, 'e1b2c3d4-0001-0001-0001-000000000010', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001005', 'conversion_value', 'DOUBLE',  false, false, 'Attributed conversion value in USD',                  5, 'e1b2c3d4-0001-0001-0001-000000000010', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001006', 'is_first_touch',   'BOOLEAN', false, false, 'Whether this is the first-touch attribution point',   6, 'e1b2c3d4-0001-0001-0001-000000000010', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001007', 'is_last_touch',    'BOOLEAN', false, false, 'Whether this is the last-touch attribution point',    7, 'e1b2c3d4-0001-0001-0001-000000000010', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 11: raw_clickstream_events (7 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000001101', 'event_id',        'STRING',    false, true,  'Unique event UUID assigned by SDK',                   1, 'e1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001102', 'session_id',      'STRING',    false, false, 'Session UUID for grouping events',                    2, 'e1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001103', 'user_id',         'LONG',      true,  false, 'Authenticated user ID (NULL for anonymous)',           3, 'e1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001104', 'event_type',      'STRING',    false, false, 'Event type: page_view, click, scroll, form_submit',   4, 'e1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001105', 'page_url',        'STRING',    false, false, 'Full URL of the page where event occurred',           5, 'e1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001106', 'event_timestamp', 'TIMESTAMP', false, false, 'Client-side event timestamp (UTC)',                   6, 'e1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001107', 'user_agent',      'STRING',    true,  false, 'Browser user agent string',                           7, 'e1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 12: raw_server_logs (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000001201', 'log_id',       'STRING',    false, true,  'Unique log entry identifier',                          1, 'e1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001202', 'timestamp',    'TIMESTAMP', false, false, 'Log event timestamp (UTC)',                            2, 'e1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001203', 'level',        'STRING',    false, false, 'Log level: DEBUG, INFO, WARN, ERROR, FATAL',           3, 'e1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001204', 'service_name', 'STRING',    false, false, 'Originating microservice name',                        4, 'e1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001205', 'message',      'STRING',    false, false, 'Log message text',                                    5, 'e1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001206', 'trace_id',     'STRING',    true,  false, 'Distributed tracing correlation ID',                   6, 'e1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 13: raw_email_campaigns (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000001301', 'campaign_id',      'LONG',    false, true,  'Email campaign identifier',                           1, 'e1b2c3d4-0001-0001-0001-000000000013', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001302', 'subject',          'STRING',  false, false, 'Email subject line',                                  2, 'e1b2c3d4-0001-0001-0001-000000000013', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001303', 'sent_date',        'DATE',    false, false, 'Date email batch was sent',                           3, 'e1b2c3d4-0001-0001-0001-000000000013', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001304', 'recipient_count',  'INTEGER', false, false, 'Total number of recipients',                          4, 'e1b2c3d4-0001-0001-0001-000000000013', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001305', 'open_rate',        'FLOAT',   false, false, 'Percentage of recipients who opened (0.0 - 1.0)',     5, 'e1b2c3d4-0001-0001-0001-000000000013', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001306', 'click_rate',       'FLOAT',   false, false, 'Percentage of recipients who clicked (0.0 - 1.0)',    6, 'e1b2c3d4-0001-0001-0001-000000000013', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 14: employees (8 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000001401', 'employee_id',    'LONG',      false, true,  'Unique employee identifier',                          1, 'e1b2c3d4-0001-0001-0001-000000000014', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001402', 'first_name',     'STRING',    false, false, 'Employee first name (PII)',                           2, 'e1b2c3d4-0001-0001-0001-000000000014', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001403', 'last_name',      'STRING',    false, false, 'Employee last name (PII)',                            3, 'e1b2c3d4-0001-0001-0001-000000000014', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001404', 'email',          'STRING',    false, false, 'Corporate email address (PII)',                       4, 'e1b2c3d4-0001-0001-0001-000000000014', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001405', 'department_id',  'LONG',      false, false, 'FK to departments.department_id',                     5, 'e1b2c3d4-0001-0001-0001-000000000014', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001406', 'title',          'STRING',    false, false, 'Job title',                                           6, 'e1b2c3d4-0001-0001-0001-000000000014', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001407', 'hire_date',      'DATE',      false, false, 'Date of hire',                                        7, 'e1b2c3d4-0001-0001-0001-000000000014', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001408', 'salary',         'DOUBLE',    false, false, 'Annual salary in USD (Confidential)',                 8, 'e1b2c3d4-0001-0001-0001-000000000014', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 15: departments (4 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000001501', 'department_id',     'LONG',   false, true,  'Unique department identifier',                        1, 'e1b2c3d4-0001-0001-0001-000000000015', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001502', 'name',              'STRING', false, false, 'Department name',                                     2, 'e1b2c3d4-0001-0001-0001-000000000015', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001503', 'head_employee_id',  'LONG',   true,  false, 'FK to employees.employee_id (department head)',       3, 'e1b2c3d4-0001-0001-0001-000000000015', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001504', 'cost_center',       'STRING', false, false, 'Accounting cost center code',                         4, 'e1b2c3d4-0001-0001-0001-000000000015', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 16: payroll_summary (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000001601', 'payroll_id',   'LONG',   false, true,  'Unique payroll record identifier',                     1, 'e1b2c3d4-0001-0001-0001-000000000016', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001602', 'employee_id',  'LONG',   false, false, 'FK to employees.employee_id',                          2, 'e1b2c3d4-0001-0001-0001-000000000016', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001603', 'pay_period',   'DATE',   false, false, 'Pay period end date',                                  3, 'e1b2c3d4-0001-0001-0001-000000000016', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001604', 'gross_pay',    'DOUBLE', false, false, 'Gross pay amount in USD (Confidential)',               4, 'e1b2c3d4-0001-0001-0001-000000000016', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001605', 'deductions',   'DOUBLE', false, false, 'Total deductions (tax, benefits, 401k)',               5, 'e1b2c3d4-0001-0001-0001-000000000016', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001606', 'net_pay',      'DOUBLE', false, false, 'Net pay after all deductions (Confidential)',           6, 'e1b2c3d4-0001-0001-0001-000000000016', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 17: feature_usage (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000001701', 'event_id',      'LONG',      false, true,  'Unique usage event identifier',                       1, 'e1b2c3d4-0001-0001-0001-000000000017', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001702', 'user_id',       'LONG',      false, false, 'FK to user who triggered the event',                  2, 'e1b2c3d4-0001-0001-0001-000000000017', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001703', 'feature_name',  'STRING',    false, false, 'Feature identifier (e.g., dark_mode, export_csv)',    3, 'e1b2c3d4-0001-0001-0001-000000000017', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001704', 'usage_count',   'INTEGER',   false, false, 'Cumulative usage count for this feature by user',     4, 'e1b2c3d4-0001-0001-0001-000000000017', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001705', 'first_used',    'TIMESTAMP', false, false, 'First usage timestamp',                               5, 'e1b2c3d4-0001-0001-0001-000000000017', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001706', 'last_used',     'TIMESTAMP', false, false, 'Most recent usage timestamp',                         6, 'e1b2c3d4-0001-0001-0001-000000000017', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 18: ab_test_results (7 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000001801', 'test_id',          'LONG',      false, true,  'Unique test observation ID',                         1, 'e1b2c3d4-0001-0001-0001-000000000018', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001802', 'experiment_name',  'STRING',    false, false, 'Name of the A/B test experiment',                    2, 'e1b2c3d4-0001-0001-0001-000000000018', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001803', 'variant',          'STRING',    false, false, 'Assigned variant: control, treatment_a, treatment_b', 3, 'e1b2c3d4-0001-0001-0001-000000000018', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001804', 'user_id',          'LONG',      false, false, 'User assigned to this variant',                      4, 'e1b2c3d4-0001-0001-0001-000000000018', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001805', 'metric_name',      'STRING',    false, false, 'Measured metric: conversion_rate, revenue, engagement', 5, 'e1b2c3d4-0001-0001-0001-000000000018', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001806', 'metric_value',     'DOUBLE',    false, false, 'Observed metric value',                              6, 'e1b2c3d4-0001-0001-0001-000000000018', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001807', 'recorded_at',      'TIMESTAMP', false, false, 'When the observation was recorded',                  7, 'e1b2c3d4-0001-0001-0001-000000000018', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 19: campaigns (7 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000001901', 'campaign_id', 'LONG',   false, true,  'Unique campaign identifier',                           1, 'e1b2c3d4-0001-0001-0001-000000000019', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001902', 'name',        'STRING', false, false, 'Campaign display name',                                2, 'e1b2c3d4-0001-0001-0001-000000000019', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001903', 'channel',     'STRING', false, false, 'Marketing channel: Email, Paid Search, Social, Display', 3, 'e1b2c3d4-0001-0001-0001-000000000019', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001904', 'start_date',  'DATE',   false, false, 'Campaign start date',                                  4, 'e1b2c3d4-0001-0001-0001-000000000019', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001905', 'end_date',    'DATE',   true,  false, 'Campaign end date (NULL if evergreen)',                 5, 'e1b2c3d4-0001-0001-0001-000000000019', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001906', 'budget',      'DOUBLE', false, false, 'Campaign budget in USD',                               6, 'e1b2c3d4-0001-0001-0001-000000000019', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000001907', 'status',      'STRING', false, false, 'Status: Draft, Active, Paused, Completed',             7, 'e1b2c3d4-0001-0001-0001-000000000019', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 20: ad_impressions (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000002001', 'impression_id', 'LONG',    false, true,  'Unique impression record ID',                         1, 'e1b2c3d4-0001-0001-0001-000000000020', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002002', 'campaign_id',   'LONG',    false, false, 'FK to campaigns.campaign_id',                         2, 'e1b2c3d4-0001-0001-0001-000000000020', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002003', 'platform',      'STRING',  false, false, 'Ad platform: Google Ads, Meta, LinkedIn, Twitter',    3, 'e1b2c3d4-0001-0001-0001-000000000020', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002004', 'impressions',   'LONG',    false, false, 'Total number of ad impressions',                      4, 'e1b2c3d4-0001-0001-0001-000000000020', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002005', 'clicks',        'INTEGER', false, false, 'Total number of ad clicks',                           5, 'e1b2c3d4-0001-0001-0001-000000000020', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002006', 'spend',         'DOUBLE',  false, false, 'Total ad spend in USD',                               6, 'e1b2c3d4-0001-0001-0001-000000000020', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 21: invoices (7 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000002101', 'invoice_id',   'LONG',   false, true,  'Unique invoice identifier',                            1, 'e1b2c3d4-0001-0001-0001-000000000021', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002102', 'customer_id',  'LONG',   false, false, 'FK to customers.customer_id',                          2, 'e1b2c3d4-0001-0001-0001-000000000021', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002103', 'invoice_date', 'DATE',   false, false, 'Date invoice was issued',                              3, 'e1b2c3d4-0001-0001-0001-000000000021', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002104', 'due_date',     'DATE',   false, false, 'Payment due date',                                    4, 'e1b2c3d4-0001-0001-0001-000000000021', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002105', 'amount',       'DOUBLE', false, false, 'Invoice amount in specified currency',                 5, 'e1b2c3d4-0001-0001-0001-000000000021', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002106', 'status',       'STRING', false, false, 'Payment status: Pending, Paid, Overdue, Void',        6, 'e1b2c3d4-0001-0001-0001-000000000021', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002107', 'currency',     'STRING', false, false, 'ISO 4217 currency code (USD, EUR, GBP)',               7, 'e1b2c3d4-0001-0001-0001-000000000021', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 22: general_ledger (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000002201', 'entry_id',     'LONG',   false, true,  'Unique GL entry identifier',                           1, 'e1b2c3d4-0001-0001-0001-000000000022', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002202', 'account_code', 'STRING', false, false, 'GL account code (e.g., 4010-Revenue, 5020-COGS)',      2, 'e1b2c3d4-0001-0001-0001-000000000022', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002203', 'posting_date', 'DATE',   false, false, 'Date the entry was posted',                            3, 'e1b2c3d4-0001-0001-0001-000000000022', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002204', 'amount',       'DOUBLE', false, false, 'Debit (+) or Credit (-) amount in USD',                4, 'e1b2c3d4-0001-0001-0001-000000000022', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002205', 'description',  'STRING', true,  false, 'Journal entry description',                            5, 'e1b2c3d4-0001-0001-0001-000000000022', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002206', 'cost_center',  'STRING', false, false, 'Cost center for expense allocation',                   6, 'e1b2c3d4-0001-0001-0001-000000000022', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 23: application_logs (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000002301', 'log_id',       'STRING',    false, true,  'Unique processed log entry ID',                       1, 'e1b2c3d4-0001-0001-0001-000000000023', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002302', 'timestamp',    'TIMESTAMP', false, false, 'Log event timestamp (UTC)',                           2, 'e1b2c3d4-0001-0001-0001-000000000023', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002303', 'level',        'STRING',    false, false, 'Log level: DEBUG, INFO, WARN, ERROR',                 3, 'e1b2c3d4-0001-0001-0001-000000000023', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002304', 'application',  'STRING',    false, false, 'Application/service name',                            4, 'e1b2c3d4-0001-0001-0001-000000000023', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002305', 'message',      'STRING',    false, false, 'Structured log message',                              5, 'e1b2c3d4-0001-0001-0001-000000000023', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002306', 'stack_trace',  'STRING',    true,  false, 'Exception stack trace (NULL for non-error logs)',      6, 'e1b2c3d4-0001-0001-0001-000000000023', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 24: audit_trail_archive (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000002401', 'audit_id',        'LONG',      false, true,  'Unique audit record identifier',                     1, 'e1b2c3d4-0001-0001-0001-000000000024', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002402', 'event_timestamp', 'TIMESTAMP', false, false, 'When the audited action occurred',                   2, 'e1b2c3d4-0001-0001-0001-000000000024', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002403', 'actor',           'STRING',    false, false, 'User or system that performed the action',           3, 'e1b2c3d4-0001-0001-0001-000000000024', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002404', 'action',          'STRING',    false, false, 'Action performed: CREATE, UPDATE, DELETE, READ',     4, 'e1b2c3d4-0001-0001-0001-000000000024', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002405', 'resource',        'STRING',    false, false, 'Resource that was acted upon',                       5, 'e1b2c3d4-0001-0001-0001-000000000024', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002406', 'details',         'STRING',    true,  false, 'JSON payload with action details',                   6, 'e1b2c3d4-0001-0001-0001-000000000024', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- ────────────────────────────────────────────────────────────────────────────
-- DATA LINEAGE (18 edges — realistic ETL/ELT pipeline DAG)
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO data_lineage (id, source_dataset_id, target_dataset_id, transformation_description, job_name, created_at, updated_at) VALUES
    -- Layer 1: Source → Dimension tables
    ('11b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000007', 'Build customer dimension from customer master data: derive segment and CLV', 'dbt-dim-customers', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000002', 'd1b2c3d4-0001-0001-0001-000000000014', 'd1b2c3d4-0001-0001-0001-000000000007', 'Enrich customer dimension with employee data for B2B customer matching', 'dbt-dim-customers', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000004', 'd1b2c3d4-0001-0001-0001-000000000009', 'Build product dimension from product catalog with category enrichment', 'dbt-dim-products', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000004', 'd1b2c3d4-0001-0001-0001-000000000005', 'd1b2c3d4-0001-0001-0001-000000000009', 'Flatten product category hierarchy into dimension attributes', 'dbt-dim-products', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    -- Layer 1: Raw → Processed
    ('11b2c3d4-0001-0001-0001-000000000005', 'd1b2c3d4-0001-0001-0001-000000000011', 'd1b2c3d4-0001-0001-0001-000000000008', 'Sessionize raw clickstream events into user sessions with page view counts', 'spark-sessionizer', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000006', 'd1b2c3d4-0001-0001-0001-000000000011', 'd1b2c3d4-0001-0001-0001-000000000017', 'Extract feature usage signals from clickstream event types and page URLs', 'spark-feature-extractor', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000007', 'd1b2c3d4-0001-0001-0001-000000000012', 'd1b2c3d4-0001-0001-0001-000000000023', 'Parse and structure raw server logs into application-level log entries', 'fluentd-log-processor', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    -- Layer 2: Source + Dimensions → Fact tables
    ('11b2c3d4-0001-0001-0001-000000000008', 'd1b2c3d4-0001-0001-0001-000000000002', 'd1b2c3d4-0001-0001-0001-000000000006', 'Aggregate daily order revenue by product, customer segment, and region', 'dbt-fact-revenue', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000009', 'd1b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000006', 'Join order line items for product-level revenue breakdowns', 'dbt-fact-revenue', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000010', 'd1b2c3d4-0001-0001-0001-000000000007', 'd1b2c3d4-0001-0001-0001-000000000006', 'Enrich revenue fact with customer segment from dimension table', 'dbt-fact-revenue', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000011', 'd1b2c3d4-0001-0001-0001-000000000009', 'd1b2c3d4-0001-0001-0001-000000000006', 'Join product dimension for category and price tier in revenue fact', 'dbt-fact-revenue', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    -- Layer 2: Marketing attribution
    ('11b2c3d4-0001-0001-0001-000000000012', 'd1b2c3d4-0001-0001-0001-000000000019', 'd1b2c3d4-0001-0001-0001-000000000010', 'Map campaign definitions to attribution touchpoints', 'dbt-marketing-attribution', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000013', 'd1b2c3d4-0001-0001-0001-000000000020', 'd1b2c3d4-0001-0001-0001-000000000010', 'Attribute ad impressions and clicks to campaign conversions', 'dbt-marketing-attribution', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000014', 'd1b2c3d4-0001-0001-0001-000000000013', 'd1b2c3d4-0001-0001-0001-000000000010', 'Include email campaign touchpoints in attribution model', 'dbt-marketing-attribution', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000015', 'd1b2c3d4-0001-0001-0001-000000000008', 'd1b2c3d4-0001-0001-0001-000000000010', 'Join user sessions for session-level attribution and conversion paths', 'dbt-marketing-attribution', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    -- Finance flows
    ('11b2c3d4-0001-0001-0001-000000000016', 'd1b2c3d4-0001-0001-0001-000000000021', 'd1b2c3d4-0001-0001-0001-000000000022', 'Post invoice amounts to accounts receivable GL accounts', 'erp-invoice-posting', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000017', 'd1b2c3d4-0001-0001-0001-000000000016', 'd1b2c3d4-0001-0001-0001-000000000022', 'Post payroll summary to salary expense and liability GL accounts', 'erp-payroll-posting', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    -- A/B test enrichment
    ('11b2c3d4-0001-0001-0001-000000000018', 'd1b2c3d4-0001-0001-0001-000000000018', 'd1b2c3d4-0001-0001-0001-000000000008', 'Enrich user sessions with A/B test variant assignments for experiment analysis', 'spark-ab-enrichment', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- ────────────────────────────────────────────────────────────────────────────
-- GOVERNANCE POLICIES (8)
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO governance_policies (id, name, description, rules, status, created_at, updated_at) VALUES
    ('21b2c3d4-0001-0001-0001-000000000001', 'PII Data Retention Policy',       'All datasets containing PII must have data purged or anonymized after the retention period. Applies to email, phone, SSN, name, and address fields.',                    '{"retention_days": 1095, "applies_to": ["PII"], "action": "anonymize_or_delete", "exceptions": "legal_hold"}', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('21b2c3d4-0001-0001-0001-000000000002', 'GDPR Right to Erasure',           'Data subjects in EU/EEA have the right to request deletion of personal data. Requests must be fulfilled within 30 calendar days across all PII-tagged datasets.',          '{"max_response_days": 30, "scope": "EU_EEA_residents", "applies_to": ["GDPR", "PII"], "process": "automated_deletion_pipeline"}', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('21b2c3d4-0001-0001-0001-000000000003', 'Production Data Quality SLA',     'All production datasets must maintain minimum quality scores. Violations trigger PagerDuty alerts to the owning team.',                                                    '{"min_completeness": 0.95, "min_freshness": 0.80, "min_overall": 0.85, "check_frequency": "daily", "alert_channel": "pagerduty"}', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('21b2c3d4-0001-0001-0001-000000000004', 'SOC2 Access Control Policy',      'SOC2-tagged datasets require quarterly access reviews. All access must be logged and auditable. Service accounts must use short-lived tokens.',                            '{"review_frequency_days": 90, "requires_audit_log": true, "token_max_ttl_hours": 24, "applies_to": ["SOC2"]}', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('21b2c3d4-0001-0001-0001-000000000005', 'HIPAA Data Protection',           'HIPAA-regulated datasets must be encrypted at rest (AES-256) and in transit (TLS 1.2+). Access restricted to authorized healthcare data roles only.',                      '{"encryption_at_rest": "AES-256", "encryption_in_transit": "TLS_1.2+", "authorized_roles": ["HR_Admin", "Benefits_Admin"], "applies_to": ["HIPAA"]}', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('21b2c3d4-0001-0001-0001-000000000006', 'Data Classification Policy',      'All datasets must be classified with at least one Classification tag (Internal, Restricted, or Public) before being promoted to production.',                              '{"required_categories": ["Classification"], "enforcement": "pre_production_gate", "default_classification": "Internal"}', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('21b2c3d4-0001-0001-0001-000000000007', 'Schema Change Management',        'Schema changes to critical datasets require approval from the data steward and a 48-hour review window. Breaking changes require a migration plan.',                      '{"approval_required": true, "review_window_hours": 48, "breaking_change_requires": "migration_plan", "approvers": ["DATA_STEWARD"]}', 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('21b2c3d4-0001-0001-0001-000000000008', 'Legacy Data Archival Policy',     'Deprecated datasets must be archived within 90 days of deprecation. Archived data is moved to cold storage with read-only access. Superseded by new retention framework.', '{"archive_deadline_days": 90, "storage_tier": "cold", "access_mode": "read_only"}', 'ARCHIVED', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Policy-Dataset associations
INSERT INTO policy_datasets (policy_id, dataset_id) VALUES
    -- PII Data Retention: customers, dim_customers, employees, payroll_summary, raw_clickstream_events, raw_email_campaigns
    ('21b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000001'),
    ('21b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000007'),
    ('21b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000014'),
    ('21b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000016'),
    ('21b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000011'),
    ('21b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000013'),
    -- GDPR Right to Erasure: customers, dim_customers, employees
    ('21b2c3d4-0001-0001-0001-000000000002', 'd1b2c3d4-0001-0001-0001-000000000001'),
    ('21b2c3d4-0001-0001-0001-000000000002', 'd1b2c3d4-0001-0001-0001-000000000007'),
    ('21b2c3d4-0001-0001-0001-000000000002', 'd1b2c3d4-0001-0001-0001-000000000014'),
    -- Data Quality SLA: fact_daily_revenue, dim_customers, dim_products, orders, customers
    ('21b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000006'),
    ('21b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000007'),
    ('21b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000009'),
    ('21b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000002'),
    ('21b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000001'),
    -- SOC2 Access Control: fact_daily_revenue, invoices, general_ledger, payroll_summary
    ('21b2c3d4-0001-0001-0001-000000000004', 'd1b2c3d4-0001-0001-0001-000000000006'),
    ('21b2c3d4-0001-0001-0001-000000000004', 'd1b2c3d4-0001-0001-0001-000000000021'),
    ('21b2c3d4-0001-0001-0001-000000000004', 'd1b2c3d4-0001-0001-0001-000000000022'),
    ('21b2c3d4-0001-0001-0001-000000000004', 'd1b2c3d4-0001-0001-0001-000000000016'),
    -- HIPAA: employees, payroll_summary
    ('21b2c3d4-0001-0001-0001-000000000005', 'd1b2c3d4-0001-0001-0001-000000000014'),
    ('21b2c3d4-0001-0001-0001-000000000005', 'd1b2c3d4-0001-0001-0001-000000000016'),
    -- Data Classification: customers, orders, products, fact_daily_revenue, dim_customers, invoices
    ('21b2c3d4-0001-0001-0001-000000000006', 'd1b2c3d4-0001-0001-0001-000000000001'),
    ('21b2c3d4-0001-0001-0001-000000000006', 'd1b2c3d4-0001-0001-0001-000000000002'),
    ('21b2c3d4-0001-0001-0001-000000000006', 'd1b2c3d4-0001-0001-0001-000000000004'),
    ('21b2c3d4-0001-0001-0001-000000000006', 'd1b2c3d4-0001-0001-0001-000000000006'),
    ('21b2c3d4-0001-0001-0001-000000000006', 'd1b2c3d4-0001-0001-0001-000000000007'),
    ('21b2c3d4-0001-0001-0001-000000000006', 'd1b2c3d4-0001-0001-0001-000000000021'),
    -- Schema Change Management (DRAFT): customers, orders, dim_customers, fact_daily_revenue
    ('21b2c3d4-0001-0001-0001-000000000007', 'd1b2c3d4-0001-0001-0001-000000000001'),
    ('21b2c3d4-0001-0001-0001-000000000007', 'd1b2c3d4-0001-0001-0001-000000000002'),
    ('21b2c3d4-0001-0001-0001-000000000007', 'd1b2c3d4-0001-0001-0001-000000000007'),
    ('21b2c3d4-0001-0001-0001-000000000007', 'd1b2c3d4-0001-0001-0001-000000000006'),
    -- Legacy Archival (ARCHIVED): audit_trail_archive
    ('21b2c3d4-0001-0001-0001-000000000008', 'd1b2c3d4-0001-0001-0001-000000000024');
-- ────────────────────────────────────────────────────────────────────────────
-- GLOSSARY TERMS (18)
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO glossary_terms (id, term, definition, category, created_at, updated_at) VALUES
    ('31b2c3d4-0001-0001-0001-000000000001', 'PII',                      'Personally Identifiable Information — any data that can be used to identify a specific individual, such as name, email, phone number, Social Security Number, or physical address.',                     'Compliance',    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000002', 'ETL',                      'Extract, Transform, Load — a data integration pattern that extracts data from source systems, transforms it into a target schema, and loads it into a destination (warehouse or lake).',                   'Engineering',   CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000003', 'Data Lineage',             'The complete lifecycle of data — its origin, how it moves through systems, and the transformations applied at each stage. Critical for impact analysis and regulatory compliance.',                         'Governance',    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000004', 'Data Steward',             'A role responsible for managing and overseeing data assets. Data stewards ensure data quality, enforce governance policies, and serve as the point of contact for dataset-related questions.',               'Organization',  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000005', 'Schema Drift',             'Unplanned or unexpected changes to a data schema over time — such as added/removed columns, type changes, or renamed fields — that can break downstream consumers.',                                      'Engineering',   CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000006', 'GDPR',                     'General Data Protection Regulation — EU regulation governing the collection, processing, and storage of personal data for EU/EEA residents. Enforces rights like data access, rectification, and erasure.', 'Compliance',    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000007', 'Data Mesh',                'A decentralized data architecture pattern where domain teams own and publish their data as products, with federated governance and self-serve data infrastructure.',                                       'Architecture',  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000008', 'SLA',                      'Service Level Agreement — a formal commitment defining expected performance levels (uptime, latency, data freshness, quality scores) between a service provider and its consumers.',                       'Operations',    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000009', 'Data Lake',                'A centralized repository for storing raw, unprocessed data at any scale. Data lakes store structured, semi-structured, and unstructured data in its native format.',                                        'Architecture',  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000010', 'Data Warehouse',           'A structured, optimized data store designed for analytical queries. Data is cleaned, transformed, and organized into schemas (star/snowflake) for business intelligence.',                                  'Architecture',  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000011', 'Dimension Table',          'A table in a star or snowflake schema that contains descriptive attributes (who, what, where, when) used to slice and filter fact table metrics.',                                                          'Analytics',     CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000012', 'Fact Table',               'A table in a star schema that contains quantitative, measurable business metrics (revenue, clicks, units sold) at the grain of the business process.',                                                     'Analytics',     CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000013', 'Customer Lifetime Value',  'CLV — the total predicted net revenue a business expects to earn from a customer over the entire duration of their relationship. Used for segmentation and marketing ROI analysis.',                        'Business',      CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000014', 'Attribution Model',        'A framework for assigning credit to marketing touchpoints that contributed to a conversion. Common models: first-touch, last-touch, linear, time-decay, and data-driven.',                                  'Marketing',     CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000015', 'Data Quality',             'A measure of how well data serves its intended purpose. Dimensions include completeness, accuracy, consistency, timeliness, validity, and uniqueness.',                                                     'Governance',    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000016', 'Cost Center',              'An organizational unit within a company used to track and allocate costs for budgeting and financial reporting purposes. Each department or project may have its own cost center code.',                    'Finance',       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000017', 'A/B Testing',              'A controlled experiment methodology where users are randomly split into groups (control vs. treatment) to measure the causal impact of a change on key metrics.',                                          'Product',       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000018', 'Data Catalog',             'An organized inventory of data assets in an organization. Provides metadata, lineage, quality scores, ownership, and discoverability for all datasets across the enterprise.',                              'Governance',    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Glossary Synonyms
INSERT INTO glossary_synonyms (term_id, synonym) VALUES
    ('31b2c3d4-0001-0001-0001-000000000001', 'Personal Data'),
    ('31b2c3d4-0001-0001-0001-000000000001', 'Sensitive Data'),
    ('31b2c3d4-0001-0001-0001-000000000001', 'Personal Information'),
    ('31b2c3d4-0001-0001-0001-000000000002', 'Data Pipeline'),
    ('31b2c3d4-0001-0001-0001-000000000002', 'ELT'),
    ('31b2c3d4-0001-0001-0001-000000000003', 'Data Provenance'),
    ('31b2c3d4-0001-0001-0001-000000000003', 'Data Flow'),
    ('31b2c3d4-0001-0001-0001-000000000006', 'General Data Protection Regulation'),
    ('31b2c3d4-0001-0001-0001-000000000007', 'Decentralized Data Architecture'),
    ('31b2c3d4-0001-0001-0001-000000000008', 'Service Level Objective'),
    ('31b2c3d4-0001-0001-0001-000000000009', 'Raw Data Store'),
    ('31b2c3d4-0001-0001-0001-000000000010', 'DWH'),
    ('31b2c3d4-0001-0001-0001-000000000010', 'OLAP'),
    ('31b2c3d4-0001-0001-0001-000000000011', 'Lookup Table'),
    ('31b2c3d4-0001-0001-0001-000000000013', 'CLV'),
    ('31b2c3d4-0001-0001-0001-000000000013', 'LTV'),
    ('31b2c3d4-0001-0001-0001-000000000014', 'MTA'),
    ('31b2c3d4-0001-0001-0001-000000000014', 'Multi-Touch Attribution'),
    ('31b2c3d4-0001-0001-0001-000000000017', 'Split Testing'),
    ('31b2c3d4-0001-0001-0001-000000000017', 'Controlled Experiment'),
    ('31b2c3d4-0001-0001-0001-000000000018', 'Metadata Catalog');
-- Glossary-Dataset associations
INSERT INTO glossary_term_datasets (term_id, dataset_id) VALUES
    ('31b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000001'),
    ('31b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000014'),
    ('31b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000007'),
    ('31b2c3d4-0001-0001-0001-000000000002', 'd1b2c3d4-0001-0001-0001-000000000006'),
    ('31b2c3d4-0001-0001-0001-000000000002', 'd1b2c3d4-0001-0001-0001-000000000007'),
    ('31b2c3d4-0001-0001-0001-000000000009', 'd1b2c3d4-0001-0001-0001-000000000011'),
    ('31b2c3d4-0001-0001-0001-000000000009', 'd1b2c3d4-0001-0001-0001-000000000012'),
    ('31b2c3d4-0001-0001-0001-000000000010', 'd1b2c3d4-0001-0001-0001-000000000006'),
    ('31b2c3d4-0001-0001-0001-000000000010', 'd1b2c3d4-0001-0001-0001-000000000007'),
    ('31b2c3d4-0001-0001-0001-000000000010', 'd1b2c3d4-0001-0001-0001-000000000009'),
    ('31b2c3d4-0001-0001-0001-000000000011', 'd1b2c3d4-0001-0001-0001-000000000007'),
    ('31b2c3d4-0001-0001-0001-000000000011', 'd1b2c3d4-0001-0001-0001-000000000009'),
    ('31b2c3d4-0001-0001-0001-000000000012', 'd1b2c3d4-0001-0001-0001-000000000006'),
    ('31b2c3d4-0001-0001-0001-000000000012', 'd1b2c3d4-0001-0001-0001-000000000008'),
    ('31b2c3d4-0001-0001-0001-000000000012', 'd1b2c3d4-0001-0001-0001-000000000010'),
    ('31b2c3d4-0001-0001-0001-000000000013', 'd1b2c3d4-0001-0001-0001-000000000007'),
    ('31b2c3d4-0001-0001-0001-000000000014', 'd1b2c3d4-0001-0001-0001-000000000010'),
    ('31b2c3d4-0001-0001-0001-000000000016', 'd1b2c3d4-0001-0001-0001-000000000015'),
    ('31b2c3d4-0001-0001-0001-000000000016', 'd1b2c3d4-0001-0001-0001-000000000022'),
    ('31b2c3d4-0001-0001-0001-000000000017', 'd1b2c3d4-0001-0001-0001-000000000018');
-- ────────────────────────────────────────────────────────────────────────────
-- DATA QUALITY SCORES (24 — one per dataset)
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO data_quality_scores (id, dataset_id, overall_score, completeness_score, freshness_score, schema_coverage_score, computed_at, created_at, updated_at) VALUES
    ('61b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000001', 95, 98, 92, 95, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000002', 'd1b2c3d4-0001-0001-0001-000000000002', 93, 96, 88, 95, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000003', 91, 94, 87, 92, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000004', 'd1b2c3d4-0001-0001-0001-000000000004', 97, 99, 95, 97, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000005', 'd1b2c3d4-0001-0001-0001-000000000005', 98, 100, 96, 98, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000006', 'd1b2c3d4-0001-0001-0001-000000000006', 96, 98, 93, 97, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000007', 'd1b2c3d4-0001-0001-0001-000000000007', 94, 97, 90, 95, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000008', 'd1b2c3d4-0001-0001-0001-000000000008', 88, 92, 82, 90, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000009', 'd1b2c3d4-0001-0001-0001-000000000009', 95, 98, 92, 95, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000010', 'd1b2c3d4-0001-0001-0001-000000000010', 82, 85, 78, 83, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000011', 'd1b2c3d4-0001-0001-0001-000000000011', 72, 75, 68, 73, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000012', 'd1b2c3d4-0001-0001-0001-000000000012', 65, 70, 58, 67, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000013', 'd1b2c3d4-0001-0001-0001-000000000013', 78, 82, 72, 80, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000014', 'd1b2c3d4-0001-0001-0001-000000000014', 96, 98, 93, 97, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000015', 'd1b2c3d4-0001-0001-0001-000000000015', 99, 100, 98, 99, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000016', 'd1b2c3d4-0001-0001-0001-000000000016', 94, 96, 91, 95, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000017', 'd1b2c3d4-0001-0001-0001-000000000017', 80, 84, 74, 82, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000018', 'd1b2c3d4-0001-0001-0001-000000000018', 75, 78, 70, 77, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000019', 'd1b2c3d4-0001-0001-0001-000000000019', 87, 90, 83, 88, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000020', 'd1b2c3d4-0001-0001-0001-000000000020', 83, 86, 79, 84, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000021', 'd1b2c3d4-0001-0001-0001-000000000021', 92, 95, 88, 93, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000022', 'd1b2c3d4-0001-0001-0001-000000000022', 97, 99, 94, 98, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000023', 'd1b2c3d4-0001-0001-0001-000000000023', 60, 65, 52, 63, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000024', 'd1b2c3d4-0001-0001-0001-000000000024', 45, 50, 38, 47, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- ────────────────────────────────────────────────────────────────────────────
-- BOOKMARKS (20)
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO bookmarks (id, user_id, dataset_id, created_at, updated_at) VALUES
    ('41b2c3d4-0001-0001-0001-000000000001', 'a1b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000002', 'a1b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000003', 'a1b2c3d4-0001-0001-0001-000000000001', 'd1b2c3d4-0001-0001-0001-000000000014', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000004', 'a1b2c3d4-0001-0001-0001-000000000002', 'd1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000005', 'a1b2c3d4-0001-0001-0001-000000000002', 'd1b2c3d4-0001-0001-0001-000000000022', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000006', 'a1b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000007', 'a1b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000008', 'a1b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000009', 'a1b2c3d4-0001-0001-0001-000000000005', 'd1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000010', 'a1b2c3d4-0001-0001-0001-000000000005', 'd1b2c3d4-0001-0001-0001-000000000008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000011', 'a1b2c3d4-0001-0001-0001-000000000005', 'd1b2c3d4-0001-0001-0001-000000000010', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000012', 'a1b2c3d4-0001-0001-0001-000000000007', 'd1b2c3d4-0001-0001-0001-000000000017', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000013', 'a1b2c3d4-0001-0001-0001-000000000007', 'd1b2c3d4-0001-0001-0001-000000000018', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000014', 'a1b2c3d4-0001-0001-0001-000000000008', 'd1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000015', 'a1b2c3d4-0001-0001-0001-000000000008', 'd1b2c3d4-0001-0001-0001-000000000008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000016', 'a1b2c3d4-0001-0001-0001-000000000011', 'd1b2c3d4-0001-0001-0001-000000000014', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000017', 'a1b2c3d4-0001-0001-0001-000000000011', 'd1b2c3d4-0001-0001-0001-000000000016', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000018', 'a1b2c3d4-0001-0001-0001-000000000012', 'd1b2c3d4-0001-0001-0001-000000000019', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000019', 'a1b2c3d4-0001-0001-0001-000000000012', 'd1b2c3d4-0001-0001-0001-000000000020', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000020', 'a1b2c3d4-0001-0001-0001-000000000006', 'd1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- ────────────────────────────────────────────────────────────────────────────
-- COMMENTS (18)
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO comments (id, content, dataset_id, author_id, created_at, updated_at) VALUES
    ('51b2c3d4-0001-0001-0001-000000000001', 'This dataset contains sensitive PII data (email, phone, name). Ensure proper access controls are in place before sharing with external teams. See PII Data Retention Policy for compliance requirements.', 'd1b2c3d4-0001-0001-0001-000000000001', 'a1b2c3d4-0001-0001-0001-000000000003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000002', 'Added phone column in v1.2 migration. All existing records have NULL phone values. Backfill in progress via batch job — ETA 2 weeks.', 'd1b2c3d4-0001-0001-0001-000000000001', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000003', 'The orders table is the primary source of truth for revenue calculations. Do NOT use order_items.subtotal for total revenue — use orders.total_amount instead (includes discounts and tax).', 'd1b2c3d4-0001-0001-0001-000000000002', 'a1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000004', 'The fact_daily_revenue pipeline (dbt-fact-revenue) runs at 3 AM UTC daily. If you see stale data, check the Airflow DAG status first. SLA is 99.5% freshness.', 'd1b2c3d4-0001-0001-0001-000000000006', 'a1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000005', 'Customer segment logic: Enterprise = CLV > $50K, SMB = $5K-$50K, Consumer = < $5K. Segment is recalculated weekly by the dbt-dim-customers job.', 'd1b2c3d4-0001-0001-0001-000000000007', 'a1b2c3d4-0001-0001-0001-000000000005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000006', 'Session timeout is 30 minutes of inactivity. If session_end is NULL, the session was still active when the daily snapshot ran.', 'd1b2c3d4-0001-0001-0001-000000000008', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000007', 'Price tier classification: Budget < $25, Mid-Range $25-$99, Premium $100-$499, Luxury >= $500. Updated quarterly by product team.', 'd1b2c3d4-0001-0001-0001-000000000009', 'a1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000008', 'Attribution model uses 7-day lookback window. First-touch and last-touch flags are mutually exclusive per conversion, but the same campaign_id can appear in both roles across different conversions.', 'd1b2c3d4-0001-0001-0001-000000000010', 'a1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000009', 'Raw clickstream volume: ~50M events/day. Data is partitioned by date in S3. Retention is 90 days in hot storage, then archived to Glacier.', 'd1b2c3d4-0001-0001-0001-000000000011', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000010', 'CRITICAL: This dataset contains HIPAA-adjacent data. Access requires HR_Admin or Benefits_Admin role. All queries are audited. Contact Anika Singh for access requests.', 'd1b2c3d4-0001-0001-0001-000000000014', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000011', 'Salary data is encrypted at rest and masked in non-production environments. Never expose salary values in analytics dashboards without VP-level approval.', 'd1b2c3d4-0001-0001-0001-000000000016', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000012', 'Feature usage data powers the product roadmap prioritization dashboard. Contact Emily Nakamura for access to the Looker dashboard.', 'd1b2c3d4-0001-0001-0001-000000000017', 'a1b2c3d4-0001-0001-0001-000000000007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000013', 'A/B test results are pre-aggregated at the user-variant-metric level. For raw event-level data, use raw_clickstream_events and filter by experiment-tagged events.', 'd1b2c3d4-0001-0001-0001-000000000018', 'a1b2c3d4-0001-0001-0001-000000000008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000014', 'Campaign budgets are in USD. For multi-currency campaigns, the budget reflects the USD-equivalent at campaign creation time (not real-time FX rates).', 'd1b2c3d4-0001-0001-0001-000000000019', 'a1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000015', 'Invoice amounts may be in non-USD currencies. Always join with the currency column and apply FX conversion before aggregating across invoices.', 'd1b2c3d4-0001-0001-0001-000000000021', 'a1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000016', 'GL account codes follow the standard chart of accounts: 4xxx = Revenue, 5xxx = COGS, 6xxx = OpEx, 7xxx = Payroll. See Finance wiki for full mapping.', 'd1b2c3d4-0001-0001-0001-000000000022', 'a1b2c3d4-0001-0001-0001-000000000004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000017', 'Log retention: 30 days in hot storage (NFS), 90 days in S3, then purged. If you need logs older than 90 days, file a request with the platform team.', 'd1b2c3d4-0001-0001-0001-000000000023', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000018', 'DEPRECATED: This dataset is no longer being updated. New audit trails go to the centralized audit service (audit-svc). Migrate your consumers before Q3.', 'd1b2c3d4-0001-0001-0001-000000000024', 'a1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- ────────────────────────────────────────────────────────────────────────────
-- AUDIT LOGS (25 — simulated historical activity)
-- ────────────────────────────────────────────────────────────────────────────
INSERT INTO audit_logs (id, entity_type, entity_id, action, changed_by, change_details, created_at, updated_at) VALUES
    ('71b2c3d4-0001-0001-0001-000000000001', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000001', 'CREATED', 'mwilliams',  'created dataset: customers (sales_db.public.customers)',                     DATEADD('DAY', -90, CURRENT_TIMESTAMP), DATEADD('DAY', -90, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000002', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000002', 'CREATED', 'mwilliams',  'created dataset: orders (sales_db.public.orders)',                           DATEADD('DAY', -90, CURRENT_TIMESTAMP), DATEADD('DAY', -90, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000003', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000004', 'CREATED', 'spatel',     'created dataset: products (sales_db.public.products)',                       DATEADD('DAY', -88, CURRENT_TIMESTAMP), DATEADD('DAY', -88, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000004', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000006', 'CREATED', 'akim',       'created dataset: fact_daily_revenue (warehouse.analytics.fact_daily_revenue)', DATEADD('DAY', -85, CURRENT_TIMESTAMP), DATEADD('DAY', -85, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000005', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000007', 'CREATED', 'akim',       'created dataset: dim_customers (warehouse.analytics.dim_customers)',          DATEADD('DAY', -85, CURRENT_TIMESTAMP), DATEADD('DAY', -85, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000006', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000014', 'CREATED', 'asingh',     'created dataset: employees (hr_api.workforce.employees)',                     DATEADD('DAY', -80, CURRENT_TIMESTAMP), DATEADD('DAY', -80, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000007', 'Policy',     '21b2c3d4-0001-0001-0001-000000000001', 'CREATED', 'asingh',     'created policy: PII Data Retention Policy (ACTIVE)',                          DATEADD('DAY', -78, CURRENT_TIMESTAMP), DATEADD('DAY', -78, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000008', 'Policy',     '21b2c3d4-0001-0001-0001-000000000002', 'CREATED', 'asingh',     'created policy: GDPR Right to Erasure (ACTIVE)',                              DATEADD('DAY', -78, CURRENT_TIMESTAMP), DATEADD('DAY', -78, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000009', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000001', 'UPDATED', 'lwang',      'updated dataset: customers — added phone column to schema v1.2',              DATEADD('DAY', -60, CURRENT_TIMESTAMP), DATEADD('DAY', -60, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000010', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000011', 'CREATED', 'lwang',      'created dataset: raw_clickstream_events (s3://acme-data-lake-prod/raw/clickstream/)', DATEADD('DAY', -55, CURRENT_TIMESTAMP), DATEADD('DAY', -55, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000011', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000019', 'CREATED', 'bkowalski',  'created dataset: campaigns (marketing_api.campaigns.campaigns)',               DATEADD('DAY', -50, CURRENT_TIMESTAMP), DATEADD('DAY', -50, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000012', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000010', 'CREATED', 'akim',       'created dataset: fact_marketing_attribution (warehouse.analytics.fact_marketing_attribution)', DATEADD('DAY', -45, CURRENT_TIMESTAMP), DATEADD('DAY', -45, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000013', 'Policy',     '21b2c3d4-0001-0001-0001-000000000003', 'CREATED', 'jchen',      'created policy: Production Data Quality SLA (ACTIVE)',                        DATEADD('DAY', -40, CURRENT_TIMESTAMP), DATEADD('DAY', -40, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000014', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000021', 'CREATED', 'spatel',     'created dataset: invoices (finance_erp.ar.invoices)',                         DATEADD('DAY', -35, CURRENT_TIMESTAMP), DATEADD('DAY', -35, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000015', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000022', 'CREATED', 'spatel',     'created dataset: general_ledger (finance_erp.gl.general_ledger)',              DATEADD('DAY', -35, CURRENT_TIMESTAMP), DATEADD('DAY', -35, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000016', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000006', 'UPDATED', 'akim',       'updated dataset: fact_daily_revenue — added discount_amount and region columns', DATEADD('DAY', -28, CURRENT_TIMESTAMP), DATEADD('DAY', -28, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000017', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000024', 'UPDATED', 'lwang',      'updated dataset: audit_trail_archive — marked as Deprecated',                  DATEADD('DAY', -21, CURRENT_TIMESTAMP), DATEADD('DAY', -21, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000018', 'Policy',     '21b2c3d4-0001-0001-0001-000000000008', 'UPDATED', 'asingh',     'updated policy: Legacy Data Archival Policy — status changed to ARCHIVED',     DATEADD('DAY', -21, CURRENT_TIMESTAMP), DATEADD('DAY', -21, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000019', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000018', 'CREATED', 'enakamura',  'created dataset: ab_test_results (product_db.experiments.ab_test_results)',    DATEADD('DAY', -14, CURRENT_TIMESTAMP), DATEADD('DAY', -14, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000020', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000007', 'UPDATED', 'akim',       'updated dataset: dim_customers — recalculated CLV segment thresholds',        DATEADD('DAY', -10, CURRENT_TIMESTAMP), DATEADD('DAY', -10, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000021', 'Policy',     '21b2c3d4-0001-0001-0001-000000000007', 'CREATED', 'mwilliams',  'created policy: Schema Change Management (DRAFT)',                             DATEADD('DAY', -7, CURRENT_TIMESTAMP), DATEADD('DAY', -7, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000022', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000010', 'UPDATED', 'bkowalski',  'updated dataset: fact_marketing_attribution — added email channel touchpoints', DATEADD('DAY', -5, CURRENT_TIMESTAMP), DATEADD('DAY', -5, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000023', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000017', 'UPDATED', 'enakamura',  'updated dataset: feature_usage — added last_used column for recency tracking', DATEADD('DAY', -3, CURRENT_TIMESTAMP), DATEADD('DAY', -3, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000024', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000008', 'UPDATED', 'dthompson',  'updated dataset: fact_user_sessions — enriched with A/B test variants',        DATEADD('DAY', -2, CURRENT_TIMESTAMP), DATEADD('DAY', -2, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000025', 'Policy',     '21b2c3d4-0001-0001-0001-000000000004', 'UPDATED', 'asingh',     'updated policy: SOC2 Access Control — reduced token TTL from 48h to 24h',      DATEADD('DAY', -1, CURRENT_TIMESTAMP), DATEADD('DAY', -1, CURRENT_TIMESTAMP));

-- ============================================================================
-- EXTENDED SEED DATA — Additional Domains (IoT, CRM, Support, Compliance)
-- ============================================================================
-- ADDITIONAL TAGS (4)
INSERT INTO tags (id, name, category, description, created_at, updated_at) VALUES
    ('b1b2c3d4-0001-0001-0001-000000000021', 'IoT',     'Domain', 'Internet of Things — sensor data, device telemetry, and edge computing.',           CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000022', 'Support', 'Domain', 'Customer support tickets, SLA tracking, and agent performance data.',               CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000023', 'CRM',     'Domain', 'Customer Relationship Management — leads, opportunities, and sales pipeline.',      CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('b1b2c3d4-0001-0001-0001-000000000024', 'Legal',   'Domain', 'Legal and compliance data — contracts, retention policies, and privacy assessments.',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ADDITIONAL DATA SOURCES (4)
INSERT INTO data_sources (id, name, type, connection_url, description, created_at, updated_at) VALUES
    ('c1b2c3d4-0001-0001-0001-000000000009', 'IoT Platform',      'API',           'https://iot.internal.acme.com/api/v2',                   'IoT platform REST API — sensor readings, device registry, alerts.',         CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('c1b2c3d4-0001-0001-0001-000000000010', 'CRM System',        'JDBC',          'jdbc:postgresql://crm-db.prod.internal:5432/salesforce', 'Salesforce replica database — leads, opportunities, accounts, contacts.',   CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('c1b2c3d4-0001-0001-0001-000000000011', 'Support Ticketing', 'API',           'https://support.internal.acme.com/api/v1',               'Zendesk/internal ticketing system API — tickets, agents, SLA metrics.',     CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('c1b2c3d4-0001-0001-0001-000000000012', 'Compliance Vault',  'CLOUD_STORAGE', 's3://acme-compliance-vault/',                            'AWS S3 compliance vault — retention records, privacy assessments, holds.',  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ADDITIONAL DATASETS (16)
INSERT INTO datasets (id, name, description, qualified_name, data_source_id, owner_id, created_at, updated_at) VALUES
    ('d1b2c3d4-0001-0001-0001-000000000025', 'sensor_readings',       'Real-time sensor telemetry data from IoT devices. ~100M readings/day.',                'iot_api.telemetry.sensor_readings',       'c1b2c3d4-0001-0001-0001-000000000009', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000026', 'device_registry',       'Master registry of all IoT devices with metadata and firmware versions.',              'iot_api.devices.device_registry',         'c1b2c3d4-0001-0001-0001-000000000009', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000027', 'alert_events',          'Alert events triggered when sensor readings exceed thresholds.',                        'iot_api.monitoring.alert_events',         'c1b2c3d4-0001-0001-0001-000000000009', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000028', 'firmware_versions',     'Firmware version history and rollout status for IoT devices.',                          'iot_api.devices.firmware_versions',       'c1b2c3d4-0001-0001-0001-000000000009', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000029', 'leads',                 'Sales leads from marketing campaigns. Contains PII (name, email).',                     'crm_db.sales.leads',                      'c1b2c3d4-0001-0001-0001-000000000010', 'a1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000030', 'opportunities',         'Sales opportunities with pipeline stage and expected close date.',                      'crm_db.sales.opportunities',              'c1b2c3d4-0001-0001-0001-000000000010', 'a1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000031', 'accounts',              'Company/organization accounts with industry and relationship status.',                  'crm_db.sales.accounts',                   'c1b2c3d4-0001-0001-0001-000000000010', 'a1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000032', 'contacts',              'Individual contacts within accounts. Contains PII (name, email, phone).',               'crm_db.sales.contacts',                   'c1b2c3d4-0001-0001-0001-000000000010', 'a1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000033', 'tickets',               'Customer support tickets with priority, status, and resolution details.',               'support_api.helpdesk.tickets',            'c1b2c3d4-0001-0001-0001-000000000011', 'a1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000034', 'agents',                'Support agent profiles with skills, availability, and performance metrics.',            'support_api.workforce.agents',            'c1b2c3d4-0001-0001-0001-000000000011', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000035', 'sla_metrics',           'SLA performance metrics per ticket category and priority.',                             'support_api.analytics.sla_metrics',       'c1b2c3d4-0001-0001-0001-000000000011', 'a1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000036', 'satisfaction_scores',   'Customer satisfaction (CSAT) and NPS responses linked to tickets.',                     'support_api.feedback.satisfaction_scores','c1b2c3d4-0001-0001-0001-000000000011', 'a1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000037', 'data_retention_records','Data retention tracking with expiration dates and purge status.',                       's3://acme-compliance-vault/retention/',   'c1b2c3d4-0001-0001-0001-000000000012', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000038', 'privacy_assessments',   'Privacy Impact Assessments (PIA) and DPIAs for data processing activities.',            's3://acme-compliance-vault/privacy/',     'c1b2c3d4-0001-0001-0001-000000000012', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000039', 'legal_holds',           'Legal hold records for litigation and regulatory investigations.',                      's3://acme-compliance-vault/legal-holds/', 'c1b2c3d4-0001-0001-0001-000000000012', 'a1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('d1b2c3d4-0001-0001-0001-000000000040', 'consent_records',       'Customer consent records for marketing, data processing, and third-party sharing.',     's3://acme-compliance-vault/consent/',     'c1b2c3d4-0001-0001-0001-000000000012', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ADDITIONAL DATASET-TAG ASSOCIATIONS
INSERT INTO dataset_tags (dataset_id, tag_id) VALUES
    ('d1b2c3d4-0001-0001-0001-000000000025', 'b1b2c3d4-0001-0001-0001-000000000021'),
    ('d1b2c3d4-0001-0001-0001-000000000025', 'b1b2c3d4-0001-0001-0001-000000000010'),
    ('d1b2c3d4-0001-0001-0001-000000000026', 'b1b2c3d4-0001-0001-0001-000000000021'),
    ('d1b2c3d4-0001-0001-0001-000000000026', 'b1b2c3d4-0001-0001-0001-000000000018'),
    ('d1b2c3d4-0001-0001-0001-000000000027', 'b1b2c3d4-0001-0001-0001-000000000021'),
    ('d1b2c3d4-0001-0001-0001-000000000028', 'b1b2c3d4-0001-0001-0001-000000000021'),
    ('d1b2c3d4-0001-0001-0001-000000000029', 'b1b2c3d4-0001-0001-0001-000000000023'),
    ('d1b2c3d4-0001-0001-0001-000000000029', 'b1b2c3d4-0001-0001-0001-000000000001'),
    ('d1b2c3d4-0001-0001-0001-000000000030', 'b1b2c3d4-0001-0001-0001-000000000023'),
    ('d1b2c3d4-0001-0001-0001-000000000030', 'b1b2c3d4-0001-0001-0001-000000000007'),
    ('d1b2c3d4-0001-0001-0001-000000000031', 'b1b2c3d4-0001-0001-0001-000000000023'),
    ('d1b2c3d4-0001-0001-0001-000000000031', 'b1b2c3d4-0001-0001-0001-000000000011'),
    ('d1b2c3d4-0001-0001-0001-000000000032', 'b1b2c3d4-0001-0001-0001-000000000023'),
    ('d1b2c3d4-0001-0001-0001-000000000032', 'b1b2c3d4-0001-0001-0001-000000000001'),
    ('d1b2c3d4-0001-0001-0001-000000000033', 'b1b2c3d4-0001-0001-0001-000000000022'),
    ('d1b2c3d4-0001-0001-0001-000000000033', 'b1b2c3d4-0001-0001-0001-000000000001'),
    ('d1b2c3d4-0001-0001-0001-000000000034', 'b1b2c3d4-0001-0001-0001-000000000022'),
    ('d1b2c3d4-0001-0001-0001-000000000034', 'b1b2c3d4-0001-0001-0001-000000000009'),
    ('d1b2c3d4-0001-0001-0001-000000000035', 'b1b2c3d4-0001-0001-0001-000000000022'),
    ('d1b2c3d4-0001-0001-0001-000000000036', 'b1b2c3d4-0001-0001-0001-000000000022'),
    ('d1b2c3d4-0001-0001-0001-000000000037', 'b1b2c3d4-0001-0001-0001-000000000024'),
    ('d1b2c3d4-0001-0001-0001-000000000037', 'b1b2c3d4-0001-0001-0001-000000000003'),
    ('d1b2c3d4-0001-0001-0001-000000000038', 'b1b2c3d4-0001-0001-0001-000000000024'),
    ('d1b2c3d4-0001-0001-0001-000000000038', 'b1b2c3d4-0001-0001-0001-000000000003'),
    ('d1b2c3d4-0001-0001-0001-000000000039', 'b1b2c3d4-0001-0001-0001-000000000024'),
    ('d1b2c3d4-0001-0001-0001-000000000039', 'b1b2c3d4-0001-0001-0001-000000000006'),
    ('d1b2c3d4-0001-0001-0001-000000000040', 'b1b2c3d4-0001-0001-0001-000000000024'),
    ('d1b2c3d4-0001-0001-0001-000000000040', 'b1b2c3d4-0001-0001-0001-000000000001');

-- ADDITIONAL SCHEMA DEFINITIONS (16)
INSERT INTO schema_definitions (id, name, version, dataset_id, created_at, updated_at) VALUES
    ('e1b2c3d4-0001-0001-0001-000000000025', 'telemetry',  1, 'd1b2c3d4-0001-0001-0001-000000000025', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000026', 'devices',    1, 'd1b2c3d4-0001-0001-0001-000000000026', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000027', 'monitoring', 1, 'd1b2c3d4-0001-0001-0001-000000000027', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000028', 'firmware',   1, 'd1b2c3d4-0001-0001-0001-000000000028', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000029', 'sales',      1, 'd1b2c3d4-0001-0001-0001-000000000029', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000030', 'sales',      1, 'd1b2c3d4-0001-0001-0001-000000000030', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000031', 'sales',      1, 'd1b2c3d4-0001-0001-0001-000000000031', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000032', 'sales',      1, 'd1b2c3d4-0001-0001-0001-000000000032', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000033', 'helpdesk',   1, 'd1b2c3d4-0001-0001-0001-000000000033', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000034', 'workforce',  1, 'd1b2c3d4-0001-0001-0001-000000000034', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000035', 'analytics',  1, 'd1b2c3d4-0001-0001-0001-000000000035', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000036', 'feedback',   1, 'd1b2c3d4-0001-0001-0001-000000000036', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000037', 'retention',  1, 'd1b2c3d4-0001-0001-0001-000000000037', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000038', 'privacy',    1, 'd1b2c3d4-0001-0001-0001-000000000038', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000039', 'legal',      1, 'd1b2c3d4-0001-0001-0001-000000000039', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('e1b2c3d4-0001-0001-0001-000000000040', 'consent',    1, 'd1b2c3d4-0001-0001-0001-000000000040', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ADDITIONAL COLUMN DEFINITIONS (~96 columns)
-- Schema 25: sensor_readings (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000002501', 'reading_id',  'STRING',    false, true,  'Unique sensor reading UUID',                           1, 'e1b2c3d4-0001-0001-0001-000000000025', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002502', 'device_id',   'STRING',    false, false, 'FK to device_registry.device_id',                     2, 'e1b2c3d4-0001-0001-0001-000000000025', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002503', 'sensor_type', 'STRING',    false, false, 'Sensor type: temperature, humidity, pressure, motion',3, 'e1b2c3d4-0001-0001-0001-000000000025', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002504', 'value',       'DOUBLE',    false, false, 'Sensor reading value',                                4, 'e1b2c3d4-0001-0001-0001-000000000025', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002505', 'unit',        'STRING',    false, false, 'Unit of measurement',                                 5, 'e1b2c3d4-0001-0001-0001-000000000025', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002506', 'timestamp',   'TIMESTAMP', false, false, 'Reading timestamp (UTC)',                             6, 'e1b2c3d4-0001-0001-0001-000000000025', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 26: device_registry (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000002601', 'device_id',        'STRING',    false, true,  'Unique device identifier',              1, 'e1b2c3d4-0001-0001-0001-000000000026', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002602', 'device_name',      'STRING',    false, false, 'Human-readable device name',            2, 'e1b2c3d4-0001-0001-0001-000000000026', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002603', 'device_type',      'STRING',    false, false, 'Device type: sensor, gateway, actuator',3, 'e1b2c3d4-0001-0001-0001-000000000026', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002604', 'firmware_version', 'STRING',    false, false, 'Current firmware version',              4, 'e1b2c3d4-0001-0001-0001-000000000026', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002605', 'location',         'STRING',    true,  false, 'Physical location or zone',             5, 'e1b2c3d4-0001-0001-0001-000000000026', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002606', 'status',           'STRING',    false, false, 'Device status: active, inactive',       6, 'e1b2c3d4-0001-0001-0001-000000000026', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 27: alert_events (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000002701', 'alert_id',     'STRING',    false, true,  'Unique alert event identifier',              1, 'e1b2c3d4-0001-0001-0001-000000000027', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002702', 'device_id',    'STRING',    false, false, 'FK to device_registry.device_id',            2, 'e1b2c3d4-0001-0001-0001-000000000027', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002703', 'alert_type',   'STRING',    false, false, 'Alert type: threshold_breach, offline',      3, 'e1b2c3d4-0001-0001-0001-000000000027', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002704', 'severity',     'STRING',    false, false, 'Severity: low, medium, high, critical',      4, 'e1b2c3d4-0001-0001-0001-000000000027', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002705', 'message',      'STRING',    false, false, 'Alert description message',                  5, 'e1b2c3d4-0001-0001-0001-000000000027', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002706', 'triggered_at', 'TIMESTAMP', false, false, 'Alert trigger timestamp',                    6, 'e1b2c3d4-0001-0001-0001-000000000027', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 28: firmware_versions (5 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000002801', 'version_id',    'STRING',    false, true,  'Unique firmware version ID',      1, 'e1b2c3d4-0001-0001-0001-000000000028', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002802', 'version',       'STRING',    false, false, 'Semantic version (e.g., 2.1.3)',  2, 'e1b2c3d4-0001-0001-0001-000000000028', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002803', 'release_notes', 'STRING',    true,  false, 'Release notes and changelog',     3, 'e1b2c3d4-0001-0001-0001-000000000028', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002804', 'is_stable',     'BOOLEAN',   false, false, 'Whether this is stable release',  4, 'e1b2c3d4-0001-0001-0001-000000000028', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002805', 'released_at',   'TIMESTAMP', false, false, 'Firmware release timestamp',      5, 'e1b2c3d4-0001-0001-0001-000000000028', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 29: leads (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000002901', 'lead_id',    'LONG',      false, true,  'Unique lead identifier',               1, 'e1b2c3d4-0001-0001-0001-000000000029', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002902', 'email',      'STRING',    false, false, 'Lead email address (PII)',             2, 'e1b2c3d4-0001-0001-0001-000000000029', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002903', 'name',       'STRING',    false, false, 'Lead full name (PII)',                 3, 'e1b2c3d4-0001-0001-0001-000000000029', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002904', 'company',    'STRING',    true,  false, 'Company name',                         4, 'e1b2c3d4-0001-0001-0001-000000000029', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002905', 'source',     'STRING',    false, false, 'Lead source: website, referral, etc.', 5, 'e1b2c3d4-0001-0001-0001-000000000029', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000002906', 'status',     'STRING',    false, false, 'Lead status: new, qualified, etc.',    6, 'e1b2c3d4-0001-0001-0001-000000000029', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 30: opportunities (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000003001', 'opportunity_id', 'LONG',   false, true,  'Unique opportunity identifier',        1, 'e1b2c3d4-0001-0001-0001-000000000030', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003002', 'account_id',     'LONG',   false, false, 'FK to accounts.account_id',            2, 'e1b2c3d4-0001-0001-0001-000000000030', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003003', 'name',           'STRING', false, false, 'Opportunity name',                     3, 'e1b2c3d4-0001-0001-0001-000000000030', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003004', 'stage',          'STRING', false, false, 'Pipeline stage',                       4, 'e1b2c3d4-0001-0001-0001-000000000030', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003005', 'amount',         'DOUBLE', false, false, 'Deal amount in USD',                   5, 'e1b2c3d4-0001-0001-0001-000000000030', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003006', 'close_date',     'DATE',   true,  false, 'Expected close date',                  6, 'e1b2c3d4-0001-0001-0001-000000000030', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 31: accounts (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000003101', 'account_id',     'LONG',   false, true,  'Unique account identifier',        1, 'e1b2c3d4-0001-0001-0001-000000000031', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003102', 'name',           'STRING', false, false, 'Company/organization name',        2, 'e1b2c3d4-0001-0001-0001-000000000031', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003103', 'industry',       'STRING', true,  false, 'Industry vertical',                3, 'e1b2c3d4-0001-0001-0001-000000000031', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003104', 'size',           'STRING', true,  false, 'Company size: SMB, Enterprise',    4, 'e1b2c3d4-0001-0001-0001-000000000031', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003105', 'annual_revenue', 'DOUBLE', true,  false, 'Estimated annual revenue',         5, 'e1b2c3d4-0001-0001-0001-000000000031', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003106', 'created_at',     'TIMESTAMP',false,false,'Account creation timestamp',       6, 'e1b2c3d4-0001-0001-0001-000000000031', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 32: contacts (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000003201', 'contact_id', 'LONG',   false, true,  'Unique contact identifier',        1, 'e1b2c3d4-0001-0001-0001-000000000032', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003202', 'account_id', 'LONG',   false, false, 'FK to accounts.account_id',        2, 'e1b2c3d4-0001-0001-0001-000000000032', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003203', 'name',       'STRING', false, false, 'Contact full name (PII)',          3, 'e1b2c3d4-0001-0001-0001-000000000032', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003204', 'email',      'STRING', false, false, 'Contact email (PII)',              4, 'e1b2c3d4-0001-0001-0001-000000000032', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003205', 'phone',      'STRING', true,  false, 'Contact phone (PII)',              5, 'e1b2c3d4-0001-0001-0001-000000000032', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003206', 'title',      'STRING', true,  false, 'Job title',                        6, 'e1b2c3d4-0001-0001-0001-000000000032', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 33: tickets (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000003301', 'ticket_id',   'LONG',      false, true,  'Unique ticket identifier',           1, 'e1b2c3d4-0001-0001-0001-000000000033', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003302', 'customer_id', 'LONG',      false, false, 'FK to customers.customer_id',        2, 'e1b2c3d4-0001-0001-0001-000000000033', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003303', 'subject',     'STRING',    false, false, 'Ticket subject line',                3, 'e1b2c3d4-0001-0001-0001-000000000033', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003304', 'priority',    'STRING',    false, false, 'Priority: low, normal, high, urgent',4, 'e1b2c3d4-0001-0001-0001-000000000033', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003305', 'status',      'STRING',    false, false, 'Status: open, pending, closed',      5, 'e1b2c3d4-0001-0001-0001-000000000033', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003306', 'created_at',  'TIMESTAMP', false, false, 'Ticket creation timestamp',          6, 'e1b2c3d4-0001-0001-0001-000000000033', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 34: agents (5 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000003401', 'agent_id',     'LONG',    false, true,  'Unique agent identifier',            1, 'e1b2c3d4-0001-0001-0001-000000000034', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003402', 'name',         'STRING',  false, false, 'Agent full name',                    2, 'e1b2c3d4-0001-0001-0001-000000000034', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003403', 'email',        'STRING',  false, false, 'Agent email address',                3, 'e1b2c3d4-0001-0001-0001-000000000034', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003404', 'skills',       'STRING',  true,  false, 'Comma-separated skill tags',         4, 'e1b2c3d4-0001-0001-0001-000000000034', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003405', 'is_available', 'BOOLEAN', false, false, 'Whether agent is available',         5, 'e1b2c3d4-0001-0001-0001-000000000034', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 35: sla_metrics (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000003501', 'metric_id',          'LONG',   false, true,  'Unique SLA metric record ID',        1, 'e1b2c3d4-0001-0001-0001-000000000035', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003502', 'date',               'DATE',   false, false, 'Metric date',                        2, 'e1b2c3d4-0001-0001-0001-000000000035', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003503', 'priority',           'STRING', false, false, 'Ticket priority for this metric',    3, 'e1b2c3d4-0001-0001-0001-000000000035', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003504', 'avg_first_response', 'DOUBLE', false, false, 'Avg first response time (minutes)',  4, 'e1b2c3d4-0001-0001-0001-000000000035', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003505', 'avg_resolution',     'DOUBLE', false, false, 'Avg resolution time (hours)',        5, 'e1b2c3d4-0001-0001-0001-000000000035', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003506', 'breach_rate',        'FLOAT',  false, false, 'SLA breach rate (0.0-1.0)',          6, 'e1b2c3d4-0001-0001-0001-000000000035', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 36: satisfaction_scores (5 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000003601', 'response_id',  'LONG',      false, true,  'Unique survey response ID',     1, 'e1b2c3d4-0001-0001-0001-000000000036', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003602', 'ticket_id',    'LONG',      false, false, 'FK to tickets.ticket_id',       2, 'e1b2c3d4-0001-0001-0001-000000000036', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003603', 'csat_score',   'INTEGER',   false, false, 'CSAT score (1-5)',              3, 'e1b2c3d4-0001-0001-0001-000000000036', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003604', 'nps_score',    'INTEGER',   true,  false, 'NPS score (0-10)',              4, 'e1b2c3d4-0001-0001-0001-000000000036', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003605', 'submitted_at', 'TIMESTAMP', false, false, 'Survey submission timestamp',   5, 'e1b2c3d4-0001-0001-0001-000000000036', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 37: data_retention_records (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000003701', 'record_id',       'STRING',    false, true,  'Unique retention record UUID',    1, 'e1b2c3d4-0001-0001-0001-000000000037', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003702', 'dataset_name',    'STRING',    false, false, 'Name of the tracked dataset',     2, 'e1b2c3d4-0001-0001-0001-000000000037', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003703', 'retention_days',  'INTEGER',   false, false, 'Retention period in days',        3, 'e1b2c3d4-0001-0001-0001-000000000037', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003704', 'expiration_date', 'DATE',      false, false, 'Data expiration date',            4, 'e1b2c3d4-0001-0001-0001-000000000037', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003705', 'purge_status',    'STRING',    false, false, 'Status: pending, completed',      5, 'e1b2c3d4-0001-0001-0001-000000000037', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003706', 'created_at',      'TIMESTAMP', false, false, 'Record creation timestamp',       6, 'e1b2c3d4-0001-0001-0001-000000000037', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 38: privacy_assessments (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000003801', 'assessment_id',   'STRING',    false, true,  'Unique PIA/DPIA identifier',      1, 'e1b2c3d4-0001-0001-0001-000000000038', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003802', 'project_name',    'STRING',    false, false, 'Name of assessed project',        2, 'e1b2c3d4-0001-0001-0001-000000000038', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003803', 'assessment_type', 'STRING',    false, false, 'Assessment type: PIA, DPIA',      3, 'e1b2c3d4-0001-0001-0001-000000000038', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003804', 'risk_level',      'STRING',    false, false, 'Risk level: low, medium, high',   4, 'e1b2c3d4-0001-0001-0001-000000000038', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003805', 'status',          'STRING',    false, false, 'Status: draft, approved',         5, 'e1b2c3d4-0001-0001-0001-000000000038', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003806', 'assessed_at',     'TIMESTAMP', false, false, 'Assessment completion timestamp', 6, 'e1b2c3d4-0001-0001-0001-000000000038', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 39: legal_holds (5 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000003901', 'hold_id',           'STRING',    false, true,  'Unique legal hold identifier',     1, 'e1b2c3d4-0001-0001-0001-000000000039', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003902', 'matter_name',       'STRING',    false, false, 'Legal matter or case name',        2, 'e1b2c3d4-0001-0001-0001-000000000039', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003903', 'affected_datasets', 'STRING',    false, false, 'Affected dataset IDs (CSV)',       3, 'e1b2c3d4-0001-0001-0001-000000000039', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003904', 'status',            'STRING',    false, false, 'Status: active, released',         4, 'e1b2c3d4-0001-0001-0001-000000000039', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000003905', 'created_at',        'TIMESTAMP', false, false, 'Hold creation timestamp',          5, 'e1b2c3d4-0001-0001-0001-000000000039', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- Schema 40: consent_records (6 columns)
INSERT INTO column_definitions (id, name, data_type, nullable, is_primary_key, description, ordinal_position, schema_id, created_at, updated_at) VALUES
    ('f1b2c3d4-0001-0001-0001-000000004001', 'consent_id',   'STRING',    false, true,  'Unique consent record identifier',   1, 'e1b2c3d4-0001-0001-0001-000000000040', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000004002', 'customer_id',  'LONG',      false, false, 'FK to customers.customer_id',        2, 'e1b2c3d4-0001-0001-0001-000000000040', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000004003', 'consent_type', 'STRING',    false, false, 'Type: marketing, analytics, etc.',   3, 'e1b2c3d4-0001-0001-0001-000000000040', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000004004', 'granted',      'BOOLEAN',   false, false, 'Whether consent was granted',        4, 'e1b2c3d4-0001-0001-0001-000000000040', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000004005', 'source',       'STRING',    false, false, 'Consent source: web, app, email',    5, 'e1b2c3d4-0001-0001-0001-000000000040', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('f1b2c3d4-0001-0001-0001-000000004006', 'recorded_at',  'TIMESTAMP', false, false, 'Consent recording timestamp',        6, 'e1b2c3d4-0001-0001-0001-000000000040', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ADDITIONAL DATA LINEAGE (10 edges)
INSERT INTO data_lineage (id, source_dataset_id, target_dataset_id, transformation_description, job_name, created_at, updated_at) VALUES
    ('11b2c3d4-0001-0001-0001-000000000019', 'd1b2c3d4-0001-0001-0001-000000000025', 'd1b2c3d4-0001-0001-0001-000000000027', 'Process sensor readings to generate threshold-based alerts', 'iot-alert-processor', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000020', 'd1b2c3d4-0001-0001-0001-000000000026', 'd1b2c3d4-0001-0001-0001-000000000025', 'Enrich sensor readings with device metadata', 'iot-enrichment-job', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000021', 'd1b2c3d4-0001-0001-0001-000000000028', 'd1b2c3d4-0001-0001-0001-000000000026', 'Update device registry with firmware versions', 'iot-firmware-updater', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000022', 'd1b2c3d4-0001-0001-0001-000000000029', 'd1b2c3d4-0001-0001-0001-000000000030', 'Convert qualified leads into opportunities', 'crm-lead-conversion', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000023', 'd1b2c3d4-0001-0001-0001-000000000031', 'd1b2c3d4-0001-0001-0001-000000000030', 'Link opportunities to parent accounts', 'crm-opportunity-enrichment', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000024', 'd1b2c3d4-0001-0001-0001-000000000032', 'd1b2c3d4-0001-0001-0001-000000000029', 'Map contacts to leads for targeting', 'crm-contact-lead-mapper', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000025', 'd1b2c3d4-0001-0001-0001-000000000033', 'd1b2c3d4-0001-0001-0001-000000000035', 'Aggregate ticket resolution times into SLA metrics', 'support-sla-aggregator', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000026', 'd1b2c3d4-0001-0001-0001-000000000033', 'd1b2c3d4-0001-0001-0001-000000000036', 'Link satisfaction surveys to closed tickets', 'support-csat-linker', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000027', 'd1b2c3d4-0001-0001-0001-000000000040', 'd1b2c3d4-0001-0001-0001-000000000037', 'Generate retention records from consent withdrawals', 'compliance-retention-generator', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('11b2c3d4-0001-0001-0001-000000000028', 'd1b2c3d4-0001-0001-0001-000000000039', 'd1b2c3d4-0001-0001-0001-000000000037', 'Override retention policies for legal holds', 'compliance-hold-override', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ADDITIONAL DATA QUALITY SCORES (16)
INSERT INTO data_quality_scores (id, dataset_id, overall_score, completeness_score, freshness_score, schema_coverage_score, computed_at, created_at, updated_at) VALUES
    ('61b2c3d4-0001-0001-0001-000000000025', 'd1b2c3d4-0001-0001-0001-000000000025', 89, 92, 85, 90, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000026', 'd1b2c3d4-0001-0001-0001-000000000026', 96, 99, 93, 96, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000027', 'd1b2c3d4-0001-0001-0001-000000000027', 84, 88, 79, 85, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000028', 'd1b2c3d4-0001-0001-0001-000000000028', 98, 100, 96, 98, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000029', 'd1b2c3d4-0001-0001-0001-000000000029', 82, 85, 78, 83, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000030', 'd1b2c3d4-0001-0001-0001-000000000030', 90, 93, 86, 91, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000031', 'd1b2c3d4-0001-0001-0001-000000000031', 94, 97, 90, 95, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000032', 'd1b2c3d4-0001-0001-0001-000000000032', 88, 91, 84, 89, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000033', 'd1b2c3d4-0001-0001-0001-000000000033', 91, 94, 87, 92, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000034', 'd1b2c3d4-0001-0001-0001-000000000034', 97, 99, 94, 98, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000035', 'd1b2c3d4-0001-0001-0001-000000000035', 93, 96, 89, 94, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000036', 'd1b2c3d4-0001-0001-0001-000000000036', 86, 89, 82, 87, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000037', 'd1b2c3d4-0001-0001-0001-000000000037', 99, 100, 98, 99, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000038', 'd1b2c3d4-0001-0001-0001-000000000038', 95, 98, 92, 95, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000039', 'd1b2c3d4-0001-0001-0001-000000000039', 100, 100, 100, 100, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('61b2c3d4-0001-0001-0001-000000000040', 'd1b2c3d4-0001-0001-0001-000000000040', 92, 95, 88, 93, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ADDITIONAL BOOKMARKS (10)
INSERT INTO bookmarks (id, user_id, dataset_id, created_at, updated_at) VALUES
    ('41b2c3d4-0001-0001-0001-000000000021', 'a1b2c3d4-0001-0001-0001-000000000009', 'd1b2c3d4-0001-0001-0001-000000000025', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000022', 'a1b2c3d4-0001-0001-0001-000000000009', 'd1b2c3d4-0001-0001-0001-000000000026', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000023', 'a1b2c3d4-0001-0001-0001-000000000012', 'd1b2c3d4-0001-0001-0001-000000000029', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000024', 'a1b2c3d4-0001-0001-0001-000000000012', 'd1b2c3d4-0001-0001-0001-000000000030', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000025', 'a1b2c3d4-0001-0001-0001-000000000006', 'd1b2c3d4-0001-0001-0001-000000000033', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000026', 'a1b2c3d4-0001-0001-0001-000000000006', 'd1b2c3d4-0001-0001-0001-000000000035', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000027', 'a1b2c3d4-0001-0001-0001-000000000011', 'd1b2c3d4-0001-0001-0001-000000000037', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000028', 'a1b2c3d4-0001-0001-0001-000000000011', 'd1b2c3d4-0001-0001-0001-000000000040', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000029', 'a1b2c3d4-0001-0001-0001-000000000002', 'd1b2c3d4-0001-0001-0001-000000000039', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('41b2c3d4-0001-0001-0001-000000000030', 'a1b2c3d4-0001-0001-0001-000000000003', 'd1b2c3d4-0001-0001-0001-000000000031', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ADDITIONAL COMMENTS (12)
INSERT INTO comments (id, content, dataset_id, author_id, created_at, updated_at) VALUES
    ('51b2c3d4-0001-0001-0001-000000000019', 'High-volume dataset: ~100M readings/day. Use date partitioning in queries to avoid full table scans.', 'd1b2c3d4-0001-0001-0001-000000000025', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000020', 'Device registry is the source of truth for all IoT device metadata. Always join sensor readings here.', 'd1b2c3d4-0001-0001-0001-000000000026', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000021', 'Alert events are generated every 5 minutes by the iot-alert-processor job.', 'd1b2c3d4-0001-0001-0001-000000000027', 'a1b2c3d4-0001-0001-0001-000000000009', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000022', 'Leads contain marketing PII. Verify consent_records before outreach campaigns.', 'd1b2c3d4-0001-0001-0001-000000000029', 'a1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000023', 'Opportunity amounts are in USD. Use close_date for revenue forecasting.', 'd1b2c3d4-0001-0001-0001-000000000030', 'a1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000024', 'Account segments: Enterprise (>$100M ARR), Mid-Market ($10M-$100M), SMB (<$10M).', 'd1b2c3d4-0001-0001-0001-000000000031', 'a1b2c3d4-0001-0001-0001-000000000012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000025', 'Support tickets contain customer PII in subject and description. Mask before sharing.', 'd1b2c3d4-0001-0001-0001-000000000033', 'a1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000026', 'SLA targets: Urgent=1hr response, High=4hr, Normal=8hr, Low=24hr.', 'd1b2c3d4-0001-0001-0001-000000000035', 'a1b2c3d4-0001-0001-0001-000000000006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000027', 'Retention records auto-generated based on PII Data Retention Policy. Legal holds are exempt.', 'd1b2c3d4-0001-0001-0001-000000000037', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000028', 'Privacy assessments required before processing any new category of personal data.', 'd1b2c3d4-0001-0001-0001-000000000038', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000029', 'CRITICAL: Do NOT delete data from datasets listed in legal_holds. Legal sanctions apply.', 'd1b2c3d4-0001-0001-0001-000000000039', 'a1b2c3d4-0001-0001-0001-000000000002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('51b2c3d4-0001-0001-0001-000000000030', 'Consent records are the single source of truth. Always verify before marketing communications.', 'd1b2c3d4-0001-0001-0001-000000000040', 'a1b2c3d4-0001-0001-0001-000000000011', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ADDITIONAL AUDIT LOGS (15)
INSERT INTO audit_logs (id, entity_type, entity_id, action, changed_by, change_details, created_at, updated_at) VALUES
    ('71b2c3d4-0001-0001-0001-000000000026', 'DataSource', 'c1b2c3d4-0001-0001-0001-000000000009', 'CREATED', 'lwang',     'created data source: IoT Platform',                 DATEADD('DAY', -30, CURRENT_TIMESTAMP), DATEADD('DAY', -30, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000027', 'DataSource', 'c1b2c3d4-0001-0001-0001-000000000010', 'CREATED', 'bkowalski', 'created data source: CRM System',                   DATEADD('DAY', -28, CURRENT_TIMESTAMP), DATEADD('DAY', -28, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000028', 'DataSource', 'c1b2c3d4-0001-0001-0001-000000000011', 'CREATED', 'rlopes',    'created data source: Support Ticketing',            DATEADD('DAY', -25, CURRENT_TIMESTAMP), DATEADD('DAY', -25, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000029', 'DataSource', 'c1b2c3d4-0001-0001-0001-000000000012', 'CREATED', 'asingh',    'created data source: Compliance Vault',             DATEADD('DAY', -22, CURRENT_TIMESTAMP), DATEADD('DAY', -22, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000030', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000025', 'CREATED', 'lwang',     'created dataset: sensor_readings',                  DATEADD('DAY', -20, CURRENT_TIMESTAMP), DATEADD('DAY', -20, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000031', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000026', 'CREATED', 'lwang',     'created dataset: device_registry',                  DATEADD('DAY', -20, CURRENT_TIMESTAMP), DATEADD('DAY', -20, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000032', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000029', 'CREATED', 'bkowalski', 'created dataset: leads',                            DATEADD('DAY', -18, CURRENT_TIMESTAMP), DATEADD('DAY', -18, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000033', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000030', 'CREATED', 'bkowalski', 'created dataset: opportunities',                    DATEADD('DAY', -18, CURRENT_TIMESTAMP), DATEADD('DAY', -18, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000034', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000033', 'CREATED', 'rlopes',    'created dataset: tickets',                          DATEADD('DAY', -15, CURRENT_TIMESTAMP), DATEADD('DAY', -15, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000035', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000037', 'CREATED', 'asingh',    'created dataset: data_retention_records',           DATEADD('DAY', -12, CURRENT_TIMESTAMP), DATEADD('DAY', -12, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000036', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000039', 'CREATED', 'jchen',     'created dataset: legal_holds',                      DATEADD('DAY', -10, CURRENT_TIMESTAMP), DATEADD('DAY', -10, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000037', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000040', 'CREATED', 'asingh',    'created dataset: consent_records',                  DATEADD('DAY', -8, CURRENT_TIMESTAMP), DATEADD('DAY', -8, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000038', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000027', 'UPDATED', 'lwang',     'updated dataset: alert_events — added severity col',DATEADD('DAY', -6, CURRENT_TIMESTAMP), DATEADD('DAY', -6, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000039', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000030', 'UPDATED', 'bkowalski', 'updated dataset: opportunities — added probability',DATEADD('DAY', -4, CURRENT_TIMESTAMP), DATEADD('DAY', -4, CURRENT_TIMESTAMP)),
    ('71b2c3d4-0001-0001-0001-000000000040', 'Dataset',    'd1b2c3d4-0001-0001-0001-000000000035', 'UPDATED', 'rlopes',    'updated dataset: sla_metrics — added breach_rate',  DATEADD('DAY', -2, CURRENT_TIMESTAMP), DATEADD('DAY', -2, CURRENT_TIMESTAMP));

-- ADDITIONAL GLOSSARY TERMS (8)
INSERT INTO glossary_terms (id, term, definition, category, created_at, updated_at) VALUES
    ('31b2c3d4-0001-0001-0001-000000000019', 'IoT',             'Internet of Things — network of physical devices with sensors and connectivity.',              'Technology',  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000020', 'Telemetry',       'Automated collection and transmission of data from remote sources for monitoring.',            'Technology',  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000021', 'CRM',             'Customer Relationship Management — strategy and software for managing customer interactions.',  'Business',    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000022', 'Lead Conversion', 'Process of transforming a marketing lead into a qualified sales opportunity.',                  'Sales',       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000023', 'Support SLA',     'Service Level Agreement for support tickets — defining expected response and resolution times.', 'Support',     CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000024', 'CSAT',            'Customer Satisfaction Score — metric measuring customer satisfaction, typically 1-5 scale.',    'Support',     CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000025', 'NPS',             'Net Promoter Score — metric measuring customer loyalty, scored 0-10.',                          'Support',     CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('31b2c3d4-0001-0001-0001-000000000026', 'DPIA',            'Data Protection Impact Assessment — process to identify and minimize data protection risks.',   'Compliance',  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO glossary_synonyms (term_id, synonym) VALUES
    ('31b2c3d4-0001-0001-0001-000000000019', 'Internet of Things'),
    ('31b2c3d4-0001-0001-0001-000000000020', 'Sensor Data'),
    ('31b2c3d4-0001-0001-0001-000000000021', 'Customer Relationship Management'),
    ('31b2c3d4-0001-0001-0001-000000000022', 'MQL to SQL'),
    ('31b2c3d4-0001-0001-0001-000000000023', 'Ticket SLA'),
    ('31b2c3d4-0001-0001-0001-000000000024', 'Customer Satisfaction'),
    ('31b2c3d4-0001-0001-0001-000000000025', 'Net Promoter Score'),
    ('31b2c3d4-0001-0001-0001-000000000026', 'Privacy Impact Assessment');

INSERT INTO glossary_term_datasets (term_id, dataset_id) VALUES
    ('31b2c3d4-0001-0001-0001-000000000019', 'd1b2c3d4-0001-0001-0001-000000000025'),
    ('31b2c3d4-0001-0001-0001-000000000019', 'd1b2c3d4-0001-0001-0001-000000000026'),
    ('31b2c3d4-0001-0001-0001-000000000020', 'd1b2c3d4-0001-0001-0001-000000000025'),
    ('31b2c3d4-0001-0001-0001-000000000021', 'd1b2c3d4-0001-0001-0001-000000000029'),
    ('31b2c3d4-0001-0001-0001-000000000021', 'd1b2c3d4-0001-0001-0001-000000000030'),
    ('31b2c3d4-0001-0001-0001-000000000022', 'd1b2c3d4-0001-0001-0001-000000000029'),
    ('31b2c3d4-0001-0001-0001-000000000023', 'd1b2c3d4-0001-0001-0001-000000000035'),
    ('31b2c3d4-0001-0001-0001-000000000024', 'd1b2c3d4-0001-0001-0001-000000000036'),
    ('31b2c3d4-0001-0001-0001-000000000025', 'd1b2c3d4-0001-0001-0001-000000000036'),
    ('31b2c3d4-0001-0001-0001-000000000026', 'd1b2c3d4-0001-0001-0001-000000000038')
import type { Schema } from '../../types';

interface Props {
  schema: Schema;
}

export default function SchemaViewer({ schema }: Props) {
  return (
    <div className="mb-4">
      <div className="flex items-center gap-2 mb-2">
        <span className="text-sm font-medium text-gray-700">{schema.name}</span>
        <span className="text-xs text-gray-400">v{schema.version}</span>
      </div>

      <div className="overflow-x-auto">
        <table className="w-full text-xs">
          <thead>
            <tr className="bg-gray-50 text-left text-gray-500 uppercase">
              <th className="px-3 py-2 font-medium">#</th>
              <th className="px-3 py-2 font-medium">Column</th>
              <th className="px-3 py-2 font-medium">Type</th>
              <th className="px-3 py-2 font-medium">PK</th>
              <th className="px-3 py-2 font-medium">Nullable</th>
              <th className="px-3 py-2 font-medium">Description</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-100">
            {schema.columns
              .sort((a, b) => (a.ordinalPosition ?? 0) - (b.ordinalPosition ?? 0))
              .map((col) => (
                <tr key={col.id} className="hover:bg-gray-50">
                  <td className="px-3 py-1.5 text-gray-400">{col.ordinalPosition}</td>
                  <td className="px-3 py-1.5 font-mono text-gray-900">{col.name}</td>
                  <td className="px-3 py-1.5">
                    <span className="bg-purple-50 text-purple-700 px-1.5 py-0.5 rounded">
                      {col.dataType}
                    </span>
                  </td>
                  <td className="px-3 py-1.5">{col.isPrimaryKey ? '🔑' : ''}</td>
                  <td className="px-3 py-1.5">{col.nullable ? '✓' : '✗'}</td>
                  <td className="px-3 py-1.5 text-gray-500 max-w-[150px] truncate">
                    {col.description}
                  </td>
                </tr>
              ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}


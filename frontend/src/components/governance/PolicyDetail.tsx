import type { GovernancePolicy } from '../../types';

interface Props {
  policy: GovernancePolicy;
}

export default function PolicyDetail({ policy }: Props) {
  return (
    <div className="bg-white rounded-xl border border-gray-200 p-6 sticky top-6">
      <h2 className="text-xl font-bold mb-1">{policy.name}</h2>
      <span
        className={`inline-block text-xs px-2 py-1 rounded-full font-medium mb-3 ${
          policy.status === 'ACTIVE'
            ? 'bg-green-100 text-green-700'
            : policy.status === 'DRAFT'
            ? 'bg-yellow-100 text-yellow-700'
            : 'bg-gray-100 text-gray-500'
        }`}
      >
        {policy.status}
      </span>

      {policy.description && (
        <p className="text-sm text-gray-600 mb-4">{policy.description}</p>
      )}

      {policy.rules && (
        <div className="mb-4">
          <h4 className="text-xs font-semibold text-gray-500 uppercase mb-2">Rules</h4>
          <pre className="bg-gray-50 rounded-lg p-3 text-xs text-gray-700 overflow-x-auto">
            {(() => {
              try {
                return JSON.stringify(JSON.parse(policy.rules), null, 2);
              } catch {
                return policy.rules;
              }
            })()}
          </pre>
        </div>
      )}

      {policy.applicableDatasets && policy.applicableDatasets.length > 0 && (
        <div>
          <h4 className="text-xs font-semibold text-gray-500 uppercase mb-2">
            Applied to Datasets ({policy.applicableDatasets.length})
          </h4>
          <ul className="space-y-1">
            {policy.applicableDatasets.map((ds) => (
              <li key={ds.id} className="text-sm text-gray-700 flex items-center gap-2">
                <span className="w-1.5 h-1.5 bg-blue-500 rounded-full" />
                {ds.name}
                <span className="text-xs text-gray-400 font-mono">{ds.qualifiedName}</span>
              </li>
            ))}
          </ul>
        </div>
      )}

      <div className="mt-4 pt-4 border-t border-gray-100 text-xs text-gray-400">
        <p>Created: {new Date(policy.createdAt).toLocaleString()}</p>
        <p>Updated: {new Date(policy.updatedAt).toLocaleString()}</p>
      </div>
    </div>
  );
}


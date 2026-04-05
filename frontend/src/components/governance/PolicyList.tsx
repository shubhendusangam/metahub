import type { GovernancePolicy } from '../../types';

interface Props {
  policies: GovernancePolicy[];
  selectedId: string | null;
  onSelect: (id: string) => void;
}

export default function PolicyList({ policies, selectedId, onSelect }: Props) {
  if (policies.length === 0) {
    return (
      <div className="bg-white rounded-xl border border-gray-200 p-8 text-center text-gray-500">
        No governance policies defined yet.
      </div>
    );
  }

  const statusColor: Record<string, string> = {
    ACTIVE: 'bg-green-100 text-green-700',
    DRAFT: 'bg-yellow-100 text-yellow-700',
    ARCHIVED: 'bg-gray-100 text-gray-500',
  };

  return (
    <div className="space-y-2">
      {policies.map((policy) => (
        <div
          key={policy.id}
          onClick={() => onSelect(policy.id)}
          className={`bg-white rounded-lg border p-4 cursor-pointer transition-all ${
            selectedId === policy.id
              ? 'border-blue-500 ring-2 ring-blue-100'
              : 'border-gray-200 hover:border-gray-300 hover:shadow-sm'
          }`}
        >
          <div className="flex items-center justify-between">
            <h3 className="font-semibold text-gray-900">{policy.name}</h3>
            <span
              className={`text-xs px-2 py-1 rounded-full font-medium ${
                statusColor[policy.status] || 'bg-gray-100 text-gray-500'
              }`}
            >
              {policy.status}
            </span>
          </div>
          {policy.description && (
            <p className="text-sm text-gray-600 mt-1 line-clamp-2">{policy.description}</p>
          )}
        </div>
      ))}
    </div>
  );
}


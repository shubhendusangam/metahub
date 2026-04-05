import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { getAuditLogs } from '../api/auditLog';
import { Database, Plus, Pencil, Trash2 } from 'lucide-react';

const actionIcons: Record<string, { icon: typeof Plus; color: string }> = {
  CREATED: { icon: Plus, color: 'text-green-600 bg-green-100' },
  UPDATED: { icon: Pencil, color: 'text-blue-600 bg-blue-100' },
  DELETED: { icon: Trash2, color: 'text-red-600 bg-red-100' },
};

const entityFilters = ['All', 'Dataset', 'Policy', 'Tag', 'User'];

export default function ActivityPage() {
  const [entityType, setEntityType] = useState<string>('All');
  const [page, setPage] = useState(0);

  const { data, isLoading } = useQuery({
    queryKey: ['audit-logs', entityType, page],
    queryFn: () => getAuditLogs(entityType === 'All' ? undefined : entityType, page, 20),
  });

  const pagedData = data?.data?.data;
  const logs = pagedData?.content ?? [];

  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Activity Feed</h1>

      {/* Filter Tabs */}
      <div className="flex gap-2 mb-6">
        {entityFilters.map((filter) => (
          <button
            key={filter}
            onClick={() => { setEntityType(filter); setPage(0); }}
            className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${
              entityType === filter
                ? 'bg-blue-600 text-white'
                : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
            }`}
          >
            {filter}
          </button>
        ))}
      </div>

      {isLoading ? (
        <p className="text-gray-500">Loading activity feed...</p>
      ) : logs.length === 0 ? (
        <div className="bg-white rounded-xl border border-gray-200 p-8 text-center text-gray-500">
          No activity recorded yet. Changes to datasets and other entities will appear here.
        </div>
      ) : (
        <>
          <div className="space-y-3">
            {logs.map((log) => {
              const ai = actionIcons[log.action] ?? { icon: Database, color: 'text-gray-600 bg-gray-100' };
              const ActionIcon = ai.icon;
              return (
                <div key={log.id} className="bg-white rounded-lg border border-gray-200 p-4 flex items-start gap-4">
                  <div className={`p-2 rounded-lg ${ai.color}`}>
                    <ActionIcon size={16} />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2">
                      <span className="font-medium text-gray-900">{log.action}</span>
                      <span className="text-xs bg-gray-100 text-gray-600 px-2 py-0.5 rounded-full">{log.entityType}</span>
                    </div>
                    <p className="text-sm text-gray-600 mt-1">{log.changeDetails}</p>
                    <div className="flex items-center gap-3 mt-2 text-xs text-gray-400">
                      <span>👤 {log.changedBy}</span>
                      <span>📅 {new Date(log.createdAt).toLocaleString()}</span>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>

          {pagedData && pagedData.totalPages > 1 && (
            <div className="flex gap-2 mt-4">
              <button
                onClick={() => setPage((p) => Math.max(0, p - 1))}
                disabled={page === 0}
                className="px-3 py-1 rounded bg-gray-200 disabled:opacity-50 text-sm"
              >
                Prev
              </button>
              <span className="px-3 py-1 text-sm text-gray-600">
                Page {page + 1} of {pagedData.totalPages}
              </span>
              <button
                onClick={() => setPage((p) => p + 1)}
                disabled={pagedData.last}
                className="px-3 py-1 rounded bg-gray-200 disabled:opacity-50 text-sm"
              >
                Next
              </button>
            </div>
          )}
        </>
      )}
    </div>
  );
}


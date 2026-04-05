import type { Dataset } from '../../types';
import BookmarkButton from './BookmarkButton';
import { TagList } from '../common/TagBadge';
import { EmptyState } from '../common/LoadingSpinner';
import { Database } from 'lucide-react';

interface Props {
  datasets: Dataset[];
  selectedId: string | null;
  onSelect: (id: string) => void;
}

export default function DatasetList({ datasets, selectedId, onSelect }: Props) {
  if (datasets.length === 0) {
    return (
      <EmptyState
        icon={<Database size={48} />}
        title="No datasets found"
        description="Create one or run an ingestion job to get started."
      />
    );
  }

  return (
    <div className="space-y-2">
      {datasets.map((ds) => (
        <DatasetCard
          key={ds.id}
          dataset={ds}
          isSelected={selectedId === ds.id}
          onSelect={() => onSelect(ds.id)}
        />
      ))}
    </div>
  );
}

interface DatasetCardProps {
  dataset: Dataset;
  isSelected: boolean;
  onSelect: () => void;
}

function DatasetCard({ dataset: ds, isSelected, onSelect }: DatasetCardProps) {
  return (
    <div
      onClick={onSelect}
      className={`bg-white rounded-lg border p-4 cursor-pointer transition-all ${
        isSelected
          ? 'border-blue-500 ring-2 ring-blue-100'
          : 'border-gray-200 hover:border-gray-300 hover:shadow-sm'
      }`}
    >
      <div className="flex items-start justify-between">
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2">
            <h3 className="font-semibold text-gray-900 truncate">{ds.name}</h3>
            <BookmarkButton datasetId={ds.id} size={16} />
          </div>
          <p className="text-xs text-gray-400 font-mono mt-0.5 truncate">
            {ds.qualifiedName}
          </p>
          {ds.description && (
            <p className="text-sm text-gray-600 mt-1 line-clamp-2">{ds.description}</p>
          )}
        </div>
        {ds.dataSourceName && (
          <span className="ml-3 text-xs bg-gray-100 text-gray-600 px-2 py-1 rounded-full whitespace-nowrap">
            {ds.dataSourceName}
          </span>
        )}
      </div>

      <TagList tags={ds.tags || []} className="mt-2" />

      <div className="flex items-center gap-3 mt-2 text-xs text-gray-400">
        {ds.ownerName && <span>👤 {ds.ownerName}</span>}
        <span>📅 {new Date(ds.createdAt).toLocaleDateString()}</span>
      </div>
    </div>
  );
}


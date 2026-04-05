import type { SearchHit } from '../../types';
import { Link } from 'react-router-dom';

interface Props {
  hits: SearchHit[];
  totalHits: number;
}

export default function SearchResults({ hits, totalHits }: Props) {
  if (hits.length === 0) {
    return (
      <div className="text-center py-12 text-gray-500">
        No results found. Try a different search term.
      </div>
    );
  }

  return (
    <div>
      <p className="text-sm text-gray-500 mb-4">
        Found <strong>{totalHits}</strong> result{totalHits !== 1 ? 's' : ''}
      </p>

      <div className="space-y-3">
        {hits.map((hit) => (
          <div
            key={hit.id}
            className="bg-white rounded-lg border border-gray-200 p-4 hover:shadow-sm transition-shadow"
          >
            <div className="flex items-start justify-between">
              <div className="flex-1">
                <h3 className="font-semibold text-gray-900">{hit.name}</h3>
                <p className="text-xs text-gray-400 font-mono">{hit.qualifiedName}</p>
                {hit.description && (
                  <p className="text-sm text-gray-600 mt-1">{hit.description}</p>
                )}
              </div>
              <div className="ml-3 flex flex-col items-end gap-1">
                {hit.dataSourceName && (
                  <span className="text-xs bg-gray-100 text-gray-600 px-2 py-1 rounded-full">
                    {hit.dataSourceName}
                  </span>
                )}
                <Link
                  to={`/lineage/${hit.id}`}
                  className="text-xs text-blue-600 hover:text-blue-800"
                >
                  View Lineage →
                </Link>
              </div>
            </div>

            {hit.tags && hit.tags.length > 0 && (
              <div className="flex flex-wrap gap-1 mt-2">
                {hit.tags.map((tag) => (
                  <span
                    key={tag}
                    className="text-xs bg-blue-50 text-blue-700 px-2 py-0.5 rounded-full"
                  >
                    {tag}
                  </span>
                ))}
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}


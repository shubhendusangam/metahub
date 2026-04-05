import type { Dataset } from '../../types';
import SchemaViewer from './SchemaViewer';
import BookmarkButton from './BookmarkButton';
import CommentSection from './CommentSection';
import AIInsightsPanel from '../ai/AIInsightsPanel';
import { Link } from 'react-router-dom';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { addTags } from '../../api/datasets';
import { Sparkles } from 'lucide-react';
import { useState } from 'react';

interface Props {
  dataset: Dataset;
}

export default function DatasetDetail({ dataset }: Props) {
  const [showAIInsights, setShowAIInsights] = useState(false);
  const queryClient = useQueryClient();

  const addTagMutation = useMutation({
    mutationFn: (tagName: string) => addTags(dataset.id, [tagName]),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['datasets'] });
    },
  });

  const handleApplyTag = (tagName: string) => {
    addTagMutation.mutate(tagName);
  };

  return (
    <div className="space-y-4">
      <div className="bg-white rounded-xl border border-gray-200 p-6 sticky top-6">
        <div className="flex items-center justify-between mb-1">
          <h2 className="text-xl font-bold">{dataset.name}</h2>
          <div className="flex items-center gap-2">
            <button
              onClick={() => setShowAIInsights(!showAIInsights)}
              className={`p-1.5 rounded-lg transition-colors ${
                showAIInsights
                  ? 'bg-purple-100 text-purple-600'
                  : 'text-gray-400 hover:text-purple-600 hover:bg-purple-50'
              }`}
              title="AI Insights"
            >
              <Sparkles size={18} />
            </button>
            <BookmarkButton datasetId={dataset.id} size={20} />
          </div>
        </div>
        <p className="text-xs text-gray-400 font-mono mb-3">{dataset.qualifiedName}</p>

        {dataset.description && (
          <p className="text-sm text-gray-600 mb-4">{dataset.description}</p>
        )}

        <div className="space-y-3 mb-4">
          <DetailRow label="Data Source" value={dataset.dataSourceName} />
          <DetailRow label="Owner" value={dataset.ownerName} />
          <DetailRow label="Created" value={new Date(dataset.createdAt).toLocaleString()} />
          <DetailRow label="Updated" value={new Date(dataset.updatedAt).toLocaleString()} />
        </div>

        {dataset.tags && dataset.tags.length > 0 && (
          <div className="mb-4">
            <h4 className="text-xs font-semibold text-gray-500 uppercase mb-2">Tags</h4>
            <div className="flex flex-wrap gap-1">
              {Array.from(dataset.tags).map((tag) => (
                <span key={tag} className="text-xs bg-blue-50 text-blue-700 px-2 py-1 rounded-full">
                  {tag}
                </span>
              ))}
            </div>
          </div>
        )}

        <Link
          to={`/lineage/${dataset.id}`}
          className="inline-block text-sm text-blue-600 hover:text-blue-800 mb-4"
        >
          🔗 View Lineage →
        </Link>

        {dataset.schemas && dataset.schemas.length > 0 && (
          <div>
            <h4 className="text-xs font-semibold text-gray-500 uppercase mb-2">Schema</h4>
            {dataset.schemas.map((schema) => (
              <SchemaViewer key={schema.id} schema={schema} />
            ))}
          </div>
        )}

        <div className="mt-4 pt-4 border-t border-gray-100">
          <CommentSection datasetId={dataset.id} />
        </div>
      </div>

      {/* AI Insights Panel */}
      {showAIInsights && (
        <AIInsightsPanel datasetId={dataset.id} onApplyTag={handleApplyTag} />
      )}
    </div>
  );
}

function DetailRow({ label, value }: { label: string; value?: string | null }) {
  if (!value) return null;
  return (
    <div className="flex justify-between text-sm">
      <span className="text-gray-500">{label}</span>
      <span className="text-gray-900 font-medium">{value}</span>
    </div>
  );
}


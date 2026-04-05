import { useQuery } from '@tanstack/react-query';
import { getAIInsights, suggestTags, AIInsight, TagSuggestion } from '../../api/ai';
import {
  Sparkles,
  AlertTriangle,
  Info,
  AlertCircle,
  Tag,
  Loader2,
  ChevronDown,
  ChevronRight,
  Lightbulb,
  Shield,
  BarChart3,
  GitBranch,
} from 'lucide-react';
import { useState } from 'react';

interface AIInsightsPanelProps {
  datasetId: string;
  onApplyTag?: (tagName: string) => void;
}

export default function AIInsightsPanel({ datasetId, onApplyTag }: AIInsightsPanelProps) {
  const [showTagSuggestions, setShowTagSuggestions] = useState(false);

  const { data: insightsData, isLoading: insightsLoading } = useQuery({
    queryKey: ['ai-insights', datasetId],
    queryFn: () => getAIInsights(datasetId),
    enabled: !!datasetId,
  });

  const { data: tagsData, isLoading: tagsLoading } = useQuery({
    queryKey: ['ai-tag-suggestions', datasetId],
    queryFn: () => suggestTags(datasetId),
    enabled: !!datasetId && showTagSuggestions,
  });

  const insights = insightsData?.data?.data ?? [];
  const tagSuggestions = tagsData?.data?.data ?? [];

  const getSeverityStyles = (severity: string) => {
    switch (severity) {
      case 'CRITICAL':
        return {
          bg: 'bg-red-50',
          border: 'border-red-200',
          icon: <AlertCircle size={16} className="text-red-500" />,
          badge: 'bg-red-100 text-red-700',
        };
      case 'WARNING':
        return {
          bg: 'bg-yellow-50',
          border: 'border-yellow-200',
          icon: <AlertTriangle size={16} className="text-yellow-600" />,
          badge: 'bg-yellow-100 text-yellow-700',
        };
      default:
        return {
          bg: 'bg-blue-50',
          border: 'border-blue-200',
          icon: <Info size={16} className="text-blue-500" />,
          badge: 'bg-blue-100 text-blue-700',
        };
    }
  };

  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'GOVERNANCE_RISK':
        return <Shield size={14} className="text-orange-500" />;
      case 'QUALITY_ISSUE':
        return <BarChart3 size={14} className="text-emerald-500" />;
      case 'LINEAGE_TIP':
        return <GitBranch size={14} className="text-indigo-500" />;
      default:
        return <Lightbulb size={14} className="text-purple-500" />;
    }
  };

  const getConfidenceBar = (confidence: number) => {
    const pct = Math.round(confidence * 100);
    let color = 'bg-gray-300';
    if (pct >= 80) color = 'bg-green-500';
    else if (pct >= 60) color = 'bg-yellow-500';
    else color = 'bg-orange-500';

    return (
      <div className="flex items-center gap-2">
        <div className="w-16 h-1.5 bg-gray-200 rounded-full overflow-hidden">
          <div className={`h-full ${color} rounded-full`} style={{ width: `${pct}%` }} />
        </div>
        <span className="text-xs text-gray-500">{pct}%</span>
      </div>
    );
  };

  if (insightsLoading) {
    return (
      <div className="bg-white border border-gray-200 rounded-xl p-6">
        <div className="flex items-center gap-2 text-gray-500">
          <Loader2 size={18} className="animate-spin" />
          <span>Analyzing dataset...</span>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      {/* AI Insights Section */}
      <div className="bg-white border border-gray-200 rounded-xl overflow-hidden">
        <div className="p-4 border-b bg-gradient-to-r from-purple-50 to-blue-50">
          <div className="flex items-center gap-2">
            <div className="p-1.5 bg-gradient-to-r from-purple-500 to-blue-500 rounded-lg text-white">
              <Sparkles size={16} />
            </div>
            <div>
              <h3 className="font-semibold text-gray-900">AI Insights</h3>
              <p className="text-xs text-gray-500">
                {insights.length} recommendations detected
              </p>
            </div>
          </div>
        </div>

        <div className="p-4 space-y-3">
          {insights.length === 0 ? (
            <p className="text-sm text-gray-500 text-center py-4">
              ✨ No issues detected. This dataset looks well-maintained!
            </p>
          ) : (
            insights.map((insight, idx) => {
              const styles = getSeverityStyles(insight.severity);
              return (
                <div
                  key={idx}
                  className={`${styles.bg} ${styles.border} border rounded-lg p-3`}
                >
                  <div className="flex items-start gap-2">
                    {styles.icon}
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 flex-wrap">
                        <span className="font-medium text-sm text-gray-900">
                          {insight.title}
                        </span>
                        <span className={`text-xs px-1.5 py-0.5 rounded ${styles.badge}`}>
                          {insight.severity}
                        </span>
                        <span className="flex items-center gap-1 text-xs text-gray-500">
                          {getTypeIcon(insight.type)}
                          {insight.type.replace('_', ' ')}
                        </span>
                      </div>
                      <p className="text-sm text-gray-600 mt-1">{insight.content}</p>
                      <div className="mt-2 flex items-center gap-2">
                        <span className="text-xs text-gray-400">Confidence:</span>
                        {getConfidenceBar(insight.confidence)}
                      </div>
                    </div>
                  </div>
                </div>
              );
            })
          )}
        </div>
      </div>

      {/* AI Tag Suggestions Section */}
      <div className="bg-white border border-gray-200 rounded-xl overflow-hidden">
        <button
          onClick={() => setShowTagSuggestions(!showTagSuggestions)}
          className="w-full p-4 flex items-center justify-between hover:bg-gray-50 transition-colors"
        >
          <div className="flex items-center gap-2">
            <div className="p-1.5 bg-gradient-to-r from-green-500 to-teal-500 rounded-lg text-white">
              <Tag size={16} />
            </div>
            <div className="text-left">
              <h3 className="font-semibold text-gray-900">Smart Tag Suggestions</h3>
              <p className="text-xs text-gray-500">AI-powered tag recommendations</p>
            </div>
          </div>
          {showTagSuggestions ? (
            <ChevronDown size={18} className="text-gray-400" />
          ) : (
            <ChevronRight size={18} className="text-gray-400" />
          )}
        </button>

        {showTagSuggestions && (
          <div className="p-4 border-t bg-gray-50">
            {tagsLoading ? (
              <div className="flex items-center gap-2 text-gray-500 justify-center py-4">
                <Loader2 size={16} className="animate-spin" />
                <span className="text-sm">Analyzing for tag suggestions...</span>
              </div>
            ) : tagSuggestions.length === 0 ? (
              <p className="text-sm text-gray-500 text-center py-4">
                No additional tag suggestions at this time.
              </p>
            ) : (
              <div className="space-y-2">
                {tagSuggestions.map((suggestion, idx) => (
                  <div
                    key={idx}
                    className="bg-white border border-gray-200 rounded-lg p-3 flex items-center justify-between"
                  >
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2">
                        <span className="font-medium text-sm text-gray-900">
                          {suggestion.tagName}
                        </span>
                        <span className="text-xs bg-gray-100 text-gray-600 px-1.5 py-0.5 rounded">
                          {suggestion.category}
                        </span>
                      </div>
                      <p className="text-xs text-gray-500 mt-0.5">{suggestion.reason}</p>
                      <div className="mt-1 flex items-center gap-2">
                        <span className="text-xs text-gray-400">Confidence:</span>
                        {getConfidenceBar(suggestion.confidence)}
                      </div>
                    </div>
                    {onApplyTag && (
                      <button
                        onClick={() => onApplyTag(suggestion.tagName)}
                        className="ml-3 px-3 py-1.5 text-xs bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors flex-shrink-0"
                      >
                        Apply
                      </button>
                    )}
                  </div>
                ))}
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}


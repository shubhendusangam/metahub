import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { getQualityScores, computeQualityScores } from '../api/quality';
import { RefreshCw } from 'lucide-react';

function scoreColor(score: number) {
  if (score >= 80) return 'text-green-600 bg-green-50';
  if (score >= 50) return 'text-yellow-600 bg-yellow-50';
  return 'text-red-600 bg-red-50';
}

function scoreBg(score: number) {
  if (score >= 80) return 'bg-green-500';
  if (score >= 50) return 'bg-yellow-500';
  return 'bg-red-500';
}

export default function QualityPage() {
  const queryClient = useQueryClient();
  const { data, isLoading } = useQuery({
    queryKey: ['quality-scores'],
    queryFn: getQualityScores,
  });

  const mutation = useMutation({
    mutationFn: computeQualityScores,
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ['quality-scores'] }),
  });

  const scores = data?.data?.data ?? [];

  const avgScore = scores.length > 0
    ? Math.round(scores.reduce((sum, s) => sum + s.overallScore, 0) / scores.length)
    : 0;

  const distribution = {
    high: scores.filter(s => s.overallScore >= 80).length,
    medium: scores.filter(s => s.overallScore >= 50 && s.overallScore < 80).length,
    low: scores.filter(s => s.overallScore < 50).length,
  };

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-3xl font-bold">Data Quality</h1>
        <button
          onClick={() => mutation.mutate()}
          disabled={mutation.isPending}
          className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg text-sm font-medium hover:bg-blue-700 disabled:opacity-50 transition-colors"
        >
          <RefreshCw size={16} className={mutation.isPending ? 'animate-spin' : ''} />
          {mutation.isPending ? 'Computing...' : 'Recompute Scores'}
        </button>
      </div>

      {isLoading ? (
        <p className="text-gray-500">Loading quality scores...</p>
      ) : (
        <>
          {/* Summary Cards */}
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
            <div className="bg-white rounded-xl border border-gray-200 p-5">
              <p className="text-sm text-gray-500">Average Score</p>
              <p className={`text-3xl font-bold ${avgScore >= 80 ? 'text-green-600' : avgScore >= 50 ? 'text-yellow-600' : 'text-red-600'}`}>
                {avgScore}
              </p>
            </div>
            <div className="bg-white rounded-xl border border-gray-200 p-5">
              <p className="text-sm text-gray-500">High Quality (≥80)</p>
              <p className="text-3xl font-bold text-green-600">{distribution.high}</p>
            </div>
            <div className="bg-white rounded-xl border border-gray-200 p-5">
              <p className="text-sm text-gray-500">Needs Attention (50-79)</p>
              <p className="text-3xl font-bold text-yellow-600">{distribution.medium}</p>
            </div>
            <div className="bg-white rounded-xl border border-gray-200 p-5">
              <p className="text-sm text-gray-500">Low Quality (&lt;50)</p>
              <p className="text-3xl font-bold text-red-600">{distribution.low}</p>
            </div>
          </div>

          {/* Score Table */}
          {scores.length === 0 ? (
            <div className="bg-white rounded-xl border border-gray-200 p-8 text-center text-gray-500">
              No quality scores computed yet. Click "Recompute Scores" to generate them.
            </div>
          ) : (
            <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
              <table className="w-full text-sm">
                <thead>
                  <tr className="bg-gray-50 text-left text-gray-500 uppercase text-xs">
                    <th className="px-4 py-3 font-medium">Dataset</th>
                    <th className="px-4 py-3 font-medium text-center">Overall</th>
                    <th className="px-4 py-3 font-medium text-center">Completeness</th>
                    <th className="px-4 py-3 font-medium text-center">Freshness</th>
                    <th className="px-4 py-3 font-medium text-center">Schema Coverage</th>
                    <th className="px-4 py-3 font-medium">Computed</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {scores.map((score) => (
                    <tr key={score.id} className="hover:bg-gray-50">
                      <td className="px-4 py-3">
                        <div className="font-medium text-gray-900">{score.datasetName}</div>
                        <div className="text-xs text-gray-400 font-mono">{score.qualifiedName}</div>
                      </td>
                      <td className="px-4 py-3 text-center">
                        <span className={`inline-block px-2.5 py-1 rounded-full text-xs font-bold ${scoreColor(score.overallScore)}`}>
                          {score.overallScore}
                        </span>
                      </td>
                      <td className="px-4 py-3">
                        <div className="flex items-center gap-2 justify-center">
                          <div className="w-16 h-2 bg-gray-200 rounded-full overflow-hidden">
                            <div className={`h-full rounded-full ${scoreBg(score.completenessScore)}`}
                                 style={{ width: `${score.completenessScore}%` }} />
                          </div>
                          <span className="text-xs text-gray-600 w-8">{score.completenessScore}</span>
                        </div>
                      </td>
                      <td className="px-4 py-3">
                        <div className="flex items-center gap-2 justify-center">
                          <div className="w-16 h-2 bg-gray-200 rounded-full overflow-hidden">
                            <div className={`h-full rounded-full ${scoreBg(score.freshnessScore)}`}
                                 style={{ width: `${score.freshnessScore}%` }} />
                          </div>
                          <span className="text-xs text-gray-600 w-8">{score.freshnessScore}</span>
                        </div>
                      </td>
                      <td className="px-4 py-3">
                        <div className="flex items-center gap-2 justify-center">
                          <div className="w-16 h-2 bg-gray-200 rounded-full overflow-hidden">
                            <div className={`h-full rounded-full ${scoreBg(score.schemaCoverageScore)}`}
                                 style={{ width: `${score.schemaCoverageScore}%` }} />
                          </div>
                          <span className="text-xs text-gray-600 w-8">{score.schemaCoverageScore}</span>
                        </div>
                      </td>
                      <td className="px-4 py-3 text-xs text-gray-400">
                        {new Date(score.computedAt).toLocaleString()}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </>
      )}
    </div>
  );
}


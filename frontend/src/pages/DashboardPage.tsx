import { useQuery } from '@tanstack/react-query';
import { getDatasets } from '../api/datasets';
import { getBookmarks } from '../api/bookmarks';
import { getQualityScores } from '../api/quality';
import { Database, Tag, GitBranch, Shield, BarChart3, Activity, BookOpen, HelpCircle, Sparkles, Bot } from 'lucide-react';
import { Link } from 'react-router-dom';

const DEFAULT_USER_ID = 'a1b2c3d4-0001-0001-0001-000000000001';

export default function DashboardPage() {
  const { data, isLoading } = useQuery({
    queryKey: ['datasets-stats'],
    queryFn: () => getDatasets(0, 1),
  });

  const { data: bookmarksData } = useQuery({
    queryKey: ['bookmarks', DEFAULT_USER_ID],
    queryFn: () => getBookmarks(DEFAULT_USER_ID, 0, 5),
  });

  const { data: qualityData } = useQuery({
    queryKey: ['quality-scores-dash'],
    queryFn: getQualityScores,
  });

  const totalDatasets = data?.data?.data?.totalElements ?? 0;
  const bookmarks = bookmarksData?.data?.data?.content ?? [];
  const qualityScores = qualityData?.data?.data ?? [];
  const avgQuality = qualityScores.length > 0
    ? Math.round(qualityScores.reduce((s, q) => s + q.overallScore, 0) / qualityScores.length)
    : 0;

  const stats = [
    { label: 'Datasets', value: totalDatasets, icon: Database, color: 'bg-blue-500', link: '/catalog' },
    { label: 'Avg Quality', value: qualityScores.length > 0 ? avgQuality : '—', icon: BarChart3, color: 'bg-emerald-500', link: '/quality' },
    { label: 'Bookmarks', value: bookmarks.length, icon: Tag, color: 'bg-yellow-500', link: '/catalog' },
    { label: 'Search', value: '→', icon: GitBranch, color: 'bg-purple-500', link: '/search' },
    { label: 'Governance', value: '→', icon: Shield, color: 'bg-orange-500', link: '/governance' },
    { label: 'Glossary', value: '→', icon: BookOpen, color: 'bg-teal-500', link: '/glossary' },
    { label: 'Activity', value: '→', icon: Activity, color: 'bg-pink-500', link: '/activity' },
    { label: 'Lineage', value: '→', icon: GitBranch, color: 'bg-indigo-500', link: '/lineage' },
  ];

  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Dashboard</h1>

      {/* Welcome Banner */}
      <div className="bg-gradient-to-r from-blue-600 to-indigo-600 rounded-xl p-6 mb-8 text-white shadow-lg">
        <div className="flex items-start justify-between">
          <div className="flex items-start gap-4">
            <div className="p-3 bg-white/20 rounded-lg">
              <Sparkles size={28} />
            </div>
            <div>
              <h2 className="text-xl font-semibold mb-1">Welcome to MetaHub</h2>
              <p className="text-blue-100 text-sm max-w-xl">
                Your unified metadata platform for discovering, understanding, and governing enterprise data assets.
                Explore the catalog, trace data lineage, and ensure compliance across your data ecosystem.
              </p>
              <div className="mt-4 flex gap-3">
                <Link
                  to="/catalog"
                  className="inline-flex items-center gap-2 bg-white text-blue-600 px-4 py-2 rounded-lg text-sm font-medium hover:bg-blue-50 transition-colors"
                >
                  <Database size={16} />
                  Explore Catalog
                </Link>
                <Link
                  to="/guide"
                  className="inline-flex items-center gap-2 bg-white/20 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-white/30 transition-colors"
                >
                  <HelpCircle size={16} />
                  User Guide
                </Link>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* AI Features Banner */}
      <div className="bg-gradient-to-r from-purple-50 to-blue-50 border border-purple-200 rounded-xl p-5 mb-8">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-gradient-to-r from-purple-500 to-blue-500 rounded-xl text-white">
            <Bot size={24} />
          </div>
          <div className="flex-1">
            <h3 className="font-semibold text-purple-900 flex items-center gap-2">
              <Sparkles size={16} className="text-purple-500" />
              AI-Powered Features
            </h3>
            <p className="text-sm text-purple-700 mt-0.5">
              Use natural language to search, get smart tag suggestions, and receive AI insights for your datasets.
            </p>
          </div>
          <div className="flex gap-2">
            <button
              onClick={() => {
                // Trigger the AI assistant (it's in Layout, so we need to dispatch a custom event)
                const btn = document.querySelector('[title="AI Assistant"]') as HTMLButtonElement;
                btn?.click();
              }}
              className="px-4 py-2 bg-purple-600 text-white text-sm font-medium rounded-lg hover:bg-purple-700 transition-colors flex items-center gap-2"
            >
              <Bot size={16} />
              Try AI Assistant
            </button>
          </div>
        </div>
      </div>

      {isLoading ? (
        <p className="text-gray-500">Loading...</p>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
          {stats.map(({ label, value, icon: Icon, color, link }) => (
            <Link
              key={label}
              to={link}
              className="bg-white rounded-xl shadow-sm border border-gray-200 p-5 hover:shadow-md transition-shadow"
            >
              <div className="flex items-center gap-4">
                <div className={`${color} p-3 rounded-lg text-white`}>
                  <Icon size={24} />
                </div>
                <div>
                  <p className="text-sm text-gray-500">{label}</p>
                  <p className="text-2xl font-bold">{value}</p>
                </div>
              </div>
            </Link>
          ))}
        </div>
      )}

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* My Bookmarks */}
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold">⭐ My Bookmarks</h2>
            <Link to="/catalog" className="text-xs text-blue-600 hover:text-blue-800">View All →</Link>
          </div>
          {bookmarks.length === 0 ? (
            <p className="text-sm text-gray-400">No bookmarks yet. Star datasets in the catalog to see them here.</p>
          ) : (
            <ul className="space-y-2">
              {bookmarks.map((b) => (
                <li key={b.id} className="flex items-center gap-2 text-sm">
                  <span className="w-1.5 h-1.5 bg-yellow-500 rounded-full" />
                  <span className="font-medium text-gray-900">{b.datasetName}</span>
                  <span className="text-xs text-gray-400 font-mono">{b.datasetQualifiedName}</span>
                </li>
              ))}
            </ul>
          )}
        </div>

        {/* Quick Start */}
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <h2 className="text-lg font-semibold mb-4">Quick Start</h2>
          <div className="space-y-3 text-sm text-gray-600">
            <p>🤖 <strong>AI Assistant</strong> — Ask questions in natural language (bottom-right)</p>
            <p>📊 <strong>Catalog</strong> — Browse and manage your dataset inventory</p>
            <p>🔍 <strong>Search</strong> — Find datasets using full-text search</p>
            <p>🔗 <strong>Lineage</strong> — Visualize data flow and dependencies</p>
            <p>🛡️ <strong>Governance</strong> — Define and enforce data policies</p>
            <p>📈 <strong>Quality</strong> — Monitor data quality scores across datasets</p>
            <p>📝 <strong>Activity</strong> — Track all metadata changes in real-time</p>
            <p>✨ <strong>AI Insights</strong> — Click sparkle icon on datasets for smart recommendations</p>
          </div>
        </div>
      </div>
    </div>
  );
}


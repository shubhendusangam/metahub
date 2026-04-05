import { useState } from 'react';
import {
  Database,
  Search,
  GitBranch,
  Shield,
  BarChart3,
  Activity,
  BookOpen,
  MessageSquare,
  Star,
  ChevronDown,
  ChevronRight,
  Lightbulb,
  Zap,
  Target,
  Users,
  FileText,
  AlertTriangle,
  CheckCircle2,
  Bot,
  Sparkles,
} from 'lucide-react';

interface GuideSection {
  id: string;
  title: string;
  icon: React.ElementType;
  color: string;
  description: string;
  features: {
    title: string;
    description: string;
    tips?: string[];
  }[];
}

const guideSections: GuideSection[] = [
  {
    id: 'ai-assistant',
    title: 'AI Assistant',
    icon: Bot,
    color: 'bg-gradient-to-r from-purple-500 to-blue-500',
    description:
      'MetaHub\'s AI-powered assistant helps you discover data, understand metadata, and get intelligent recommendations using natural language.',
    features: [
      {
        title: 'Natural Language Search',
        description:
          'Ask questions in plain English like "Find customer datasets" or "Show me PII data". The AI understands your intent and suggests relevant actions.',
        tips: [
          'Click the AI bot icon in the bottom-right corner to open the assistant',
          'Try queries like "Which datasets have low quality?" or "What is the lineage of orders?"',
          'The assistant will detect your intent (Search, Lineage, Quality, Compliance) and guide you',
        ],
      },
      {
        title: 'Smart Tag Suggestions',
        description:
          'AI analyzes dataset schemas and content to suggest appropriate tags like PII, Financial, or Healthcare. Apply suggested tags with one click.',
        tips: [
          'Click the sparkle icon on any dataset to see AI insights',
          'Tag suggestions show confidence levels to help you decide',
          'Suggestions include explanations of why each tag was recommended',
        ],
      },
      {
        title: 'AI Insights & Recommendations',
        description:
          'Get automatic analysis of each dataset including sensitivity detection, quality issues, governance risks, and schema recommendations.',
        tips: [
          'Insights are categorized by severity: Critical, Warning, and Info',
          'AI detects sensitive columns (PII, financial data, health records)',
          'Recommendations help improve documentation and governance',
        ],
      },
      {
        title: 'Description Generation',
        description:
          'AI can automatically generate descriptions for datasets and columns based on schema patterns and naming conventions.',
        tips: [
          'Useful for onboarding new datasets quickly',
          'Generated descriptions follow best practices for documentation',
          'Review and customize AI-generated descriptions before saving',
        ],
      },
    ],
  },
  {
    id: 'catalog',
    title: 'Data Catalog',
    icon: Database,
    color: 'bg-blue-500',
    description:
      'Browse, discover, and manage your organization\'s data assets. The catalog provides a unified view of all datasets across your data ecosystem.',
    features: [
      {
        title: 'Browse Datasets',
        description:
          'View all datasets in a paginated list. Each dataset card shows the name, description, data source, owner, and associated tags.',
        tips: [
          'Use the pagination controls to navigate through large catalogs',
          'Click on a dataset name to view detailed information including schema and lineage',
        ],
      },
      {
        title: 'Schema Viewer',
        description:
          'Explore the structure of each dataset with the interactive schema viewer. See column names, data types, nullability, and descriptions.',
        tips: [
          'Primary key columns are marked with a key icon',
          'Hover over column descriptions for full details',
        ],
      },
      {
        title: 'Bookmarks',
        description:
          'Star your frequently accessed datasets for quick access. Bookmarked datasets appear on your dashboard.',
        tips: [
          'Click the star icon on any dataset to bookmark it',
          'Access all your bookmarks from the Dashboard',
        ],
      },
      {
        title: 'Comments & Collaboration',
        description:
          'Add comments to datasets to share knowledge, document data issues, or provide usage guidance to your team.',
        tips: [
          'Use comments to document data quality issues or known caveats',
          'Tag team members by mentioning their username',
        ],
      },
    ],
  },
  {
    id: 'search',
    title: 'Search',
    icon: Search,
    color: 'bg-purple-500',
    description:
      'Find datasets quickly using full-text search with AI-powered query understanding. Search across dataset names, descriptions, column names, and tags.',
    features: [
      {
        title: 'Full-Text Search',
        description:
          'Enter keywords to search across all dataset metadata. Results are ranked by relevance score.',
        tips: [
          'Use specific terms like column names or business concepts',
          'Search results show matching datasets with highlighted terms',
        ],
      },
      {
        title: 'Search Results',
        description:
          'Results display the dataset name, qualified name, description, data source, and tags. Click any result to view full details.',
        tips: [
          'Higher relevance scores indicate better matches',
          'Use tag names in your search to filter by classification',
        ],
      },
    ],
  },
  {
    id: 'lineage',
    title: 'Data Lineage',
    icon: GitBranch,
    color: 'bg-indigo-500',
    description:
      'Visualize how data flows through your organization. Understand upstream sources and downstream dependencies for impact analysis.',
    features: [
      {
        title: 'Lineage Graph',
        description:
          'Interactive visualization showing data flow as a directed graph. Nodes represent datasets, edges represent transformations.',
        tips: [
          'Click on a node to center the view on that dataset',
          'Hover over edges to see transformation details and job names',
        ],
      },
      {
        title: 'Impact Analysis',
        description:
          'Understand the blast radius of changes. See which downstream datasets and reports will be affected by upstream modifications.',
        tips: [
          'Use lineage before making schema changes to identify affected consumers',
          'Trace data quality issues back to their source',
        ],
      },
      {
        title: 'Dataset-Specific Lineage',
        description:
          'Navigate to lineage from any dataset detail page to see its specific upstream and downstream connections.',
        tips: [
          'Use the "View Lineage" button on dataset pages',
          'The lineage view automatically centers on the selected dataset',
        ],
      },
    ],
  },
  {
    id: 'governance',
    title: 'Governance',
    icon: Shield,
    color: 'bg-orange-500',
    description:
      'Define and enforce data governance policies. Manage compliance requirements, access controls, and data classification rules.',
    features: [
      {
        title: 'Policy Management',
        description:
          'Create, update, and manage governance policies. Policies can be in Draft, Active, or Archived status.',
        tips: [
          'Start policies in Draft status for review before activation',
          'Archive deprecated policies instead of deleting for audit purposes',
        ],
      },
      {
        title: 'Policy Rules',
        description:
          'Define policy rules in JSON format. Rules can specify retention periods, access controls, encryption requirements, and more.',
        tips: [
          'Use the applies_to field to target specific tags (e.g., PII, GDPR)',
          'Review the rule schema in the policy detail view',
        ],
      },
      {
        title: 'Dataset Coverage',
        description:
          'See which datasets are covered by each policy. Ensure all sensitive datasets have appropriate governance policies applied.',
        tips: [
          'Check the "Applicable Datasets" section on each policy',
          'Use tags to automatically apply policies to matching datasets',
        ],
      },
    ],
  },
  {
    id: 'quality',
    title: 'Data Quality',
    icon: BarChart3,
    color: 'bg-emerald-500',
    description:
      'Monitor data quality scores across your catalog. Track completeness, freshness, and schema coverage metrics.',
    features: [
      {
        title: 'Quality Scores',
        description:
          'View overall quality scores (0-100) for each dataset. Scores are computed from multiple dimensions.',
        tips: [
          'Scores above 90 indicate healthy datasets',
          'Investigate datasets with scores below 70',
        ],
      },
      {
        title: 'Quality Dimensions',
        description:
          'Understand the components of quality: Completeness (missing values), Freshness (data recency), and Schema Coverage (documented columns).',
        tips: [
          'Low completeness may indicate ETL issues',
          'Low freshness may indicate stale or failed pipelines',
        ],
      },
      {
        title: 'Quality Trends',
        description:
          'Quality scores are computed periodically. Monitor trends to catch regressions early.',
        tips: [
          'Set up alerts for quality score drops below thresholds',
          'Use the Activity log to correlate quality changes with metadata updates',
        ],
      },
    ],
  },
  {
    id: 'activity',
    title: 'Activity Log',
    icon: Activity,
    color: 'bg-pink-500',
    description:
      'Track all metadata changes across your catalog in real-time. See who changed what and when for full auditability.',
    features: [
      {
        title: 'Audit Trail',
        description:
          'Complete history of CREATE, UPDATE, and DELETE operations on datasets, policies, and other entities.',
        tips: [
          'Filter by entity type to focus on specific changes',
          'Use the activity log to troubleshoot unexpected changes',
        ],
      },
      {
        title: 'Change Details',
        description:
          'Each log entry shows the action, entity, user, and detailed change description.',
        tips: [
          'Click on entity IDs to navigate to the affected resource',
          'Recent changes appear at the top of the list',
        ],
      },
    ],
  },
  {
    id: 'glossary',
    title: 'Business Glossary',
    icon: BookOpen,
    color: 'bg-teal-500',
    description:
      'Maintain a shared vocabulary of business terms and definitions. Link terms to datasets for semantic context.',
    features: [
      {
        title: 'Term Definitions',
        description:
          'Create and manage business term definitions. Each term includes a definition, category, and optional synonyms.',
        tips: [
          'Use categories to organize terms (Compliance, Business, Technical)',
          'Add synonyms for terms that have multiple names',
        ],
      },
      {
        title: 'Term-Dataset Links',
        description:
          'Link glossary terms to relevant datasets. This helps users understand the business context of technical data.',
        tips: [
          'Link terms like "CLV" to datasets where customer lifetime value is calculated',
          'Use related datasets to discover data assets for a business concept',
        ],
      },
      {
        title: 'Search Integration',
        description:
          'Glossary terms and synonyms are searchable, helping users find data using business language.',
        tips: [
          'Search for "PII" or "Personal Data" to find all PII-related terms and datasets',
          'Use the glossary as a starting point for data discovery',
        ],
      },
    ],
  },
];

export default function GuidePage() {
  const [expandedSections, setExpandedSections] = useState<Set<string>>(
    new Set(['catalog'])
  );

  const toggleSection = (id: string) => {
    setExpandedSections((prev) => {
      const next = new Set(prev);
      if (next.has(id)) {
        next.delete(id);
      } else {
        next.add(id);
      }
      return next;
    });
  };

  const expandAll = () => {
    setExpandedSections(new Set(guideSections.map((s) => s.id)));
  };

  const collapseAll = () => {
    setExpandedSections(new Set());
  };

  return (
    <div className="max-w-4xl mx-auto">
      {/* Header */}
      <div className="mb-8">
        <div className="flex items-center gap-3 mb-2">
          <div className="p-2 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-lg text-white">
            <Lightbulb size={28} />
          </div>
          <h1 className="text-3xl font-bold">User Guide</h1>
        </div>
        <p className="text-gray-600">
          Learn how to use MetaHub to discover, understand, and govern your data assets.
        </p>
      </div>

      {/* Quick Start Card */}
      <div className="bg-gradient-to-r from-blue-50 to-indigo-50 border border-blue-200 rounded-xl p-6 mb-8">
        <div className="flex items-start gap-4">
          <div className="p-2 bg-blue-100 rounded-lg text-blue-600">
            <Zap size={24} />
          </div>
          <div>
            <h2 className="text-lg font-semibold text-blue-900 mb-2">Quick Start</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-3 text-sm">
              <div className="flex items-center gap-2 text-blue-800">
                <CheckCircle2 size={16} className="text-blue-500" />
                <span>Browse datasets in the <strong>Catalog</strong></span>
              </div>
              <div className="flex items-center gap-2 text-blue-800">
                <CheckCircle2 size={16} className="text-blue-500" />
                <span>Find data using <strong>Search</strong></span>
              </div>
              <div className="flex items-center gap-2 text-blue-800">
                <CheckCircle2 size={16} className="text-blue-500" />
                <span>Explore data flow in <strong>Lineage</strong></span>
              </div>
              <div className="flex items-center gap-2 text-blue-800">
                <CheckCircle2 size={16} className="text-blue-500" />
                <span>Monitor health in <strong>Quality</strong></span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Key Concepts */}
      <div className="bg-white border border-gray-200 rounded-xl p-6 mb-8">
        <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
          <Target size={20} className="text-gray-500" />
          Key Concepts
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
          <div className="flex items-start gap-3">
            <Database size={18} className="text-blue-500 mt-0.5" />
            <div>
              <strong className="text-gray-900">Dataset</strong>
              <p className="text-gray-600">A table, view, or file containing data (e.g., customers, orders)</p>
            </div>
          </div>
          <div className="flex items-start gap-3">
            <FileText size={18} className="text-green-500 mt-0.5" />
            <div>
              <strong className="text-gray-900">Schema</strong>
              <p className="text-gray-600">The structure of a dataset — columns, types, and constraints</p>
            </div>
          </div>
          <div className="flex items-start gap-3">
            <GitBranch size={18} className="text-indigo-500 mt-0.5" />
            <div>
              <strong className="text-gray-900">Lineage</strong>
              <p className="text-gray-600">The flow of data from sources through transformations to destinations</p>
            </div>
          </div>
          <div className="flex items-start gap-3">
            <AlertTriangle size={18} className="text-yellow-500 mt-0.5" />
            <div>
              <strong className="text-gray-900">Tag</strong>
              <p className="text-gray-600">A label for classification (e.g., PII, GDPR, Production)</p>
            </div>
          </div>
          <div className="flex items-start gap-3">
            <Shield size={18} className="text-orange-500 mt-0.5" />
            <div>
              <strong className="text-gray-900">Policy</strong>
              <p className="text-gray-600">A governance rule defining how data should be handled</p>
            </div>
          </div>
          <div className="flex items-start gap-3">
            <Users size={18} className="text-purple-500 mt-0.5" />
            <div>
              <strong className="text-gray-900">Data Steward</strong>
              <p className="text-gray-600">A person responsible for managing a dataset's quality and governance</p>
            </div>
          </div>
        </div>
      </div>

      {/* Expand/Collapse Controls */}
      <div className="flex justify-end gap-2 mb-4">
        <button
          onClick={expandAll}
          className="text-sm text-blue-600 hover:text-blue-800 px-2 py-1"
        >
          Expand All
        </button>
        <span className="text-gray-300">|</span>
        <button
          onClick={collapseAll}
          className="text-sm text-blue-600 hover:text-blue-800 px-2 py-1"
        >
          Collapse All
        </button>
      </div>

      {/* Accordion Sections */}
      <div className="space-y-3">
        {guideSections.map((section) => {
          const Icon = section.icon;
          const isExpanded = expandedSections.has(section.id);

          return (
            <div
              key={section.id}
              className="bg-white border border-gray-200 rounded-xl overflow-hidden"
            >
              {/* Section Header */}
              <button
                onClick={() => toggleSection(section.id)}
                className="w-full flex items-center gap-4 p-4 hover:bg-gray-50 transition-colors text-left"
              >
                <div className={`${section.color} p-2 rounded-lg text-white`}>
                  <Icon size={20} />
                </div>
                <div className="flex-1">
                  <h3 className="font-semibold text-gray-900">{section.title}</h3>
                  <p className="text-sm text-gray-500 line-clamp-1">{section.description}</p>
                </div>
                {isExpanded ? (
                  <ChevronDown size={20} className="text-gray-400" />
                ) : (
                  <ChevronRight size={20} className="text-gray-400" />
                )}
              </button>

              {/* Section Content */}
              {isExpanded && (
                <div className="border-t border-gray-100 p-4 bg-gray-50">
                  <p className="text-sm text-gray-700 mb-4">{section.description}</p>

                  <div className="space-y-4">
                    {section.features.map((feature, idx) => (
                      <div
                        key={idx}
                        className="bg-white border border-gray-200 rounded-lg p-4"
                      >
                        <h4 className="font-medium text-gray-900 mb-1">
                          {feature.title}
                        </h4>
                        <p className="text-sm text-gray-600 mb-2">
                          {feature.description}
                        </p>
                        {feature.tips && feature.tips.length > 0 && (
                          <div className="mt-3 bg-blue-50 border border-blue-100 rounded-lg p-3">
                            <p className="text-xs font-medium text-blue-800 mb-1 flex items-center gap-1">
                              <Lightbulb size={12} /> Tips
                            </p>
                            <ul className="text-xs text-blue-700 space-y-1">
                              {feature.tips.map((tip, tipIdx) => (
                                <li key={tipIdx} className="flex items-start gap-1">
                                  <span className="text-blue-400">•</span>
                                  {tip}
                                </li>
                              ))}
                            </ul>
                          </div>
                        )}
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>
          );
        })}
      </div>

      {/* Footer Help */}
      <div className="mt-8 bg-gray-100 border border-gray-200 rounded-xl p-6 text-center">
        <MessageSquare size={24} className="mx-auto text-gray-400 mb-2" />
        <h3 className="font-medium text-gray-900 mb-1">Need More Help?</h3>
        <p className="text-sm text-gray-600">
          Use the <Star className="inline w-4 h-4 text-yellow-500" /> bookmark feature to save datasets,
          add <MessageSquare className="inline w-4 h-4 text-blue-500" /> comments for team collaboration,
          or check the <Activity className="inline w-4 h-4 text-pink-500" /> Activity log for recent changes.
        </p>
      </div>
    </div>
  );
}


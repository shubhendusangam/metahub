import { useState, useEffect, useCallback, useRef } from 'react';
import { useQuery, useMutation } from '@tanstack/react-query';
import { useSearchParams } from 'react-router-dom';
import { search } from '../api/search';
import { processNLQuery, NLQueryResult } from '../api/ai';
import SearchBar from '../components/search/SearchBar';
import SearchResults from '../components/search/SearchResults';
import { Sparkles, Search, Lightbulb, ArrowRight } from 'lucide-react';

export default function SearchPage() {
  const [searchParams] = useSearchParams();
  const initialQuery = searchParams.get('q') || '';

  const [query, setQuery] = useState(initialQuery);
  const [submitted, setSubmitted] = useState(!!initialQuery);
  const [aiSuggestion, setAiSuggestion] = useState<NLQueryResult | null>(null);
  const initializedRef = useRef(false);

  const { data, isLoading } = useQuery({
    queryKey: ['search', query],
    queryFn: () => search(query),
    enabled: submitted && query.length > 0,
  });

  const aiMutation = useMutation({
    mutationFn: (q: string) => processNLQuery(q),
    onSuccess: (response) => {
      setAiSuggestion(response.data.data);
    },
  });

  const results = data?.data?.data;

  const handleSearch = useCallback((q: string) => {
    setQuery(q);
    setSubmitted(true);
    // Also get AI suggestions for the query
    if (q.length > 3) {
      aiMutation.mutate(q);
    }
  }, [aiMutation]);

  // Handle initial query from URL - only on mount
  useEffect(() => {
    if (initialQuery && !initializedRef.current) {
      initializedRef.current = true;
      handleSearch(initialQuery);
    }
  }, [initialQuery, handleSearch]);

  const suggestedQueries = [
    'customer data',
    'PII datasets',
    'revenue metrics',
    'user sessions',
    'marketing campaigns',
    'employee records',
  ];

  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Search Datasets</h1>
      <div className="mb-6">
        <SearchBar onSearch={handleSearch} isLoading={isLoading} initialValue={initialQuery} />
      </div>

      {/* AI Understanding */}
      {aiSuggestion && submitted && (
        <div className="mb-6 bg-gradient-to-r from-purple-50 to-blue-50 border border-purple-200 rounded-xl p-4">
          <div className="flex items-start gap-3">
            <div className="p-1.5 bg-purple-100 rounded-lg text-purple-600">
              <Sparkles size={18} />
            </div>
            <div className="flex-1">
              <p className="text-sm font-medium text-purple-900 mb-1">
                AI Understanding
              </p>
              <p className="text-sm text-purple-700">{aiSuggestion.suggestedResponse}</p>
              <div className="mt-2 flex flex-wrap gap-2">
                {aiSuggestion.intent && (
                  <span className="text-xs bg-purple-100 text-purple-700 px-2 py-0.5 rounded-full">
                    Intent: {aiSuggestion.intent}
                  </span>
                )}
                {aiSuggestion.searchTerms?.map((term, idx) => (
                  <span
                    key={idx}
                    className="text-xs bg-blue-100 text-blue-700 px-2 py-0.5 rounded-full"
                  >
                    {term}
                  </span>
                ))}
              </div>
            </div>
          </div>
        </div>
      )}

      {isLoading && <p className="text-gray-500">Searching...</p>}

      {results && (
        <SearchResults hits={results.hits} totalHits={results.totalHits} />
      )}

      {!submitted && (
        <div className="text-center py-12">
          <div className="inline-flex items-center justify-center w-16 h-16 bg-gray-100 rounded-full mb-4">
            <Search size={28} className="text-gray-400" />
          </div>
          <p className="text-lg text-gray-600 mb-2">Search for datasets by name, description, or column names</p>
          <p className="text-sm text-gray-400 mb-6">Try natural language queries like "find customer data with PII"</p>

          {/* Suggested Queries */}
          <div className="max-w-2xl mx-auto">
            <div className="flex items-center justify-center gap-2 text-sm text-gray-500 mb-3">
              <Lightbulb size={16} className="text-yellow-500" />
              <span>Try these searches:</span>
            </div>
            <div className="flex flex-wrap justify-center gap-2">
              {suggestedQueries.map((suggestion) => (
                <button
                  key={suggestion}
                  onClick={() => handleSearch(suggestion)}
                  className="flex items-center gap-1 text-sm bg-white border border-gray-200 text-gray-700 px-3 py-1.5 rounded-full hover:bg-blue-50 hover:border-blue-300 hover:text-blue-700 transition-colors"
                >
                  {suggestion}
                  <ArrowRight size={14} />
                </button>
              ))}
            </div>
          </div>
        </div>
      )}
    </div>
  );
}


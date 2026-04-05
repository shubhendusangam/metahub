import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { getGlossaryTerms, getGlossaryTerm } from '../api/glossary';
import { Search } from 'lucide-react';
import GlossaryList from '../components/glossary/GlossaryList';
import GlossaryTermDetail from '../components/glossary/GlossaryTermDetail';

export default function GlossaryPage() {
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [searchQuery, setSearchQuery] = useState('');
  const [page, setPage] = useState(0);

  const { data, isLoading } = useQuery({
    queryKey: ['glossary', searchQuery, page],
    queryFn: () => getGlossaryTerms(undefined, searchQuery || undefined, page, 50),
  });

  const { data: detailData } = useQuery({
    queryKey: ['glossary-term', selectedId],
    queryFn: () => getGlossaryTerm(selectedId!),
    enabled: !!selectedId,
  });

  const pagedData = data?.data?.data;
  const terms = pagedData?.content ?? [];
  const selectedTerm = detailData?.data?.data;

  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Data Dictionary</h1>

      {/* Search */}
      <div className="mb-6">
        <div className="relative max-w-md">
          <Search size={18} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => { setSearchQuery(e.target.value); setPage(0); }}
            placeholder="Search glossary terms..."
            className="w-full pl-10 pr-4 py-2.5 rounded-lg border border-gray-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-100 outline-none text-sm"
          />
        </div>
      </div>

      <div className="flex gap-6">
        <div className="flex-1">
          {isLoading ? (
            <p className="text-gray-500">Loading glossary...</p>
          ) : (
            <>
              <GlossaryList
                terms={terms}
                selectedId={selectedId}
                onSelect={setSelectedId}
              />
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

        {selectedTerm && (
          <div className="w-[480px]">
            <GlossaryTermDetail term={selectedTerm} />
          </div>
        )}
      </div>
    </div>
  );
}


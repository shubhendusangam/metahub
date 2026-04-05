import type { GlossaryTerm } from '../../types';

interface Props {
  terms: GlossaryTerm[];
  selectedId: string | null;
  onSelect: (id: string) => void;
}

export default function GlossaryList({ terms, selectedId, onSelect }: Props) {
  if (terms.length === 0) {
    return (
      <div className="bg-white rounded-xl border border-gray-200 p-8 text-center text-gray-500">
        No glossary terms found. Create one to get started.
      </div>
    );
  }

  // Group by category
  const categories = terms.reduce<Record<string, GlossaryTerm[]>>((acc, term) => {
    const cat = term.category || 'Uncategorized';
    if (!acc[cat]) acc[cat] = [];
    acc[cat].push(term);
    return acc;
  }, {});

  return (
    <div className="space-y-4">
      {Object.entries(categories).sort(([a], [b]) => a.localeCompare(b)).map(([category, catTerms]) => (
        <div key={category}>
          <h3 className="text-xs font-semibold text-gray-500 uppercase mb-2 px-1">{category}</h3>
          <div className="space-y-1">
            {catTerms.map((term) => (
              <div
                key={term.id}
                onClick={() => onSelect(term.id)}
                className={`bg-white rounded-lg border p-3 cursor-pointer transition-all ${
                  selectedId === term.id
                    ? 'border-blue-500 ring-2 ring-blue-100'
                    : 'border-gray-200 hover:border-gray-300 hover:shadow-sm'
                }`}
              >
                <h4 className="font-semibold text-gray-900">{term.term}</h4>
                <p className="text-sm text-gray-600 mt-0.5 line-clamp-2">{term.definition}</p>
                {term.synonyms && term.synonyms.length > 0 && (
                  <div className="flex flex-wrap gap-1 mt-1.5">
                    {term.synonyms.map((s) => (
                      <span key={s} className="text-xs bg-purple-50 text-purple-700 px-2 py-0.5 rounded-full">
                        {s}
                      </span>
                    ))}
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}


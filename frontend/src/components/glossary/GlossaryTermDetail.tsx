import type { GlossaryTerm } from '../../types';
import { Link } from 'react-router-dom';

interface Props {
  term: GlossaryTerm;
}

export default function GlossaryTermDetail({ term }: Props) {
  return (
    <div className="bg-white rounded-xl border border-gray-200 p-6 sticky top-6">
      <h2 className="text-xl font-bold mb-1">{term.term}</h2>
      {term.category && (
        <span className="inline-block text-xs bg-gray-100 text-gray-600 px-2 py-1 rounded-full mb-3">
          {term.category}
        </span>
      )}

      <p className="text-sm text-gray-700 mb-4 leading-relaxed">{term.definition}</p>

      {term.synonyms && term.synonyms.length > 0 && (
        <div className="mb-4">
          <h4 className="text-xs font-semibold text-gray-500 uppercase mb-2">Synonyms</h4>
          <div className="flex flex-wrap gap-1">
            {term.synonyms.map((s) => (
              <span key={s} className="text-xs bg-purple-50 text-purple-700 px-2 py-1 rounded-full">
                {s}
              </span>
            ))}
          </div>
        </div>
      )}

      {term.relatedDatasets && term.relatedDatasets.length > 0 && (
        <div className="mb-4">
          <h4 className="text-xs font-semibold text-gray-500 uppercase mb-2">
            Related Datasets ({term.relatedDatasets.length})
          </h4>
          <ul className="space-y-1">
            {term.relatedDatasets.map((ds) => (
              <li key={ds.id} className="text-sm text-gray-700 flex items-center gap-2">
                <span className="w-1.5 h-1.5 bg-blue-500 rounded-full" />
                <Link to="/catalog" className="hover:text-blue-600">
                  {ds.name}
                </Link>
                <span className="text-xs text-gray-400 font-mono">{ds.qualifiedName}</span>
              </li>
            ))}
          </ul>
        </div>
      )}

      <div className="mt-4 pt-4 border-t border-gray-100 text-xs text-gray-400">
        <p>Created: {new Date(term.createdAt).toLocaleString()}</p>
        <p>Updated: {new Date(term.updatedAt).toLocaleString()}</p>
      </div>
    </div>
  );
}


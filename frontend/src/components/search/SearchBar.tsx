import { useState, useEffect } from 'react';
import { Search } from 'lucide-react';

interface Props {
  onSearch: (query: string) => void;
  isLoading?: boolean;
  initialValue?: string;
}

export default function SearchBar({ onSearch, isLoading, initialValue = '' }: Props) {
  const [query, setQuery] = useState(initialValue);

  useEffect(() => {
    setQuery(initialValue);
  }, [initialValue]);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSearch(query);
  };

  return (
    <form onSubmit={handleSubmit} className="flex gap-2">
      <div className="relative flex-1">
        <Search size={18} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
        <input
          type="text"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="Search datasets by name, description, or column..."
          className="w-full pl-10 pr-4 py-2.5 rounded-lg border border-gray-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-100 outline-none text-sm"
        />
      </div>
      <button
        type="submit"
        disabled={isLoading}
        className="px-5 py-2.5 bg-blue-600 text-white rounded-lg text-sm font-medium hover:bg-blue-700 disabled:opacity-50 transition-colors"
      >
        {isLoading ? 'Searching...' : 'Search'}
      </button>
    </form>
  );
}


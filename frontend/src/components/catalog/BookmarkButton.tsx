import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { isBookmarked, addBookmark, removeBookmark } from '../../api/bookmarks';
import { Bookmark, BookmarkCheck } from 'lucide-react';

// Default user ID for dev mode (admin user from seed data)
const DEFAULT_USER_ID = 'a1b2c3d4-0001-0001-0001-000000000001';

interface Props {
  datasetId: string;
  size?: number;
}

export default function BookmarkButton({ datasetId, size = 18 }: Props) {
  const queryClient = useQueryClient();

  const { data } = useQuery({
    queryKey: ['bookmark-check', DEFAULT_USER_ID, datasetId],
    queryFn: () => isBookmarked(DEFAULT_USER_ID, datasetId),
  });

  const bookmarked = data?.data?.data ?? false;

  const addMutation = useMutation({
    mutationFn: () => addBookmark(DEFAULT_USER_ID, datasetId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['bookmark-check', DEFAULT_USER_ID, datasetId] });
      queryClient.invalidateQueries({ queryKey: ['bookmarks'] });
    },
  });

  const removeMutation = useMutation({
    mutationFn: () => removeBookmark(DEFAULT_USER_ID, datasetId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['bookmark-check', DEFAULT_USER_ID, datasetId] });
      queryClient.invalidateQueries({ queryKey: ['bookmarks'] });
    },
  });

  const toggle = (e: React.MouseEvent) => {
    e.stopPropagation();
    if (bookmarked) {
      removeMutation.mutate();
    } else {
      addMutation.mutate();
    }
  };

  return (
    <button
      onClick={toggle}
      className={`p-1 rounded-md transition-colors ${
        bookmarked
          ? 'text-yellow-500 hover:text-yellow-600'
          : 'text-gray-300 hover:text-gray-400'
      }`}
      title={bookmarked ? 'Remove bookmark' : 'Add bookmark'}
    >
      {bookmarked ? <BookmarkCheck size={size} /> : <Bookmark size={size} />}
    </button>
  );
}


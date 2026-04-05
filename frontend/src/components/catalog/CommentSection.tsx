import { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { getComments, addComment, deleteComment } from '../../api/comments';
import { Send, Trash2 } from 'lucide-react';

// Default user ID for dev mode (admin user from seed data)
const DEFAULT_USER_ID = 'a1b2c3d4-0001-0001-0001-000000000001';

interface Props {
  datasetId: string;
}

export default function CommentSection({ datasetId }: Props) {
  const [newComment, setNewComment] = useState('');
  const queryClient = useQueryClient();

  const { data, isLoading } = useQuery({
    queryKey: ['comments', datasetId],
    queryFn: () => getComments(datasetId),
  });

  const addMutation = useMutation({
    mutationFn: (content: string) => addComment(datasetId, DEFAULT_USER_ID, content),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['comments', datasetId] });
      setNewComment('');
    },
  });

  const deleteMutation = useMutation({
    mutationFn: (commentId: string) => deleteComment(datasetId, commentId),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ['comments', datasetId] }),
  });

  const comments = data?.data?.data?.content ?? [];

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (newComment.trim()) {
      addMutation.mutate(newComment.trim());
    }
  };

  return (
    <div>
      <h4 className="text-xs font-semibold text-gray-500 uppercase mb-3">
        Comments ({data?.data?.data?.totalElements ?? 0})
      </h4>

      {/* Add Comment Form */}
      <form onSubmit={handleSubmit} className="flex gap-2 mb-4">
        <input
          type="text"
          value={newComment}
          onChange={(e) => setNewComment(e.target.value)}
          placeholder="Add a comment..."
          className="flex-1 px-3 py-2 rounded-lg border border-gray-300 text-sm focus:border-blue-500 focus:ring-2 focus:ring-blue-100 outline-none"
        />
        <button
          type="submit"
          disabled={addMutation.isPending || !newComment.trim()}
          className="p-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 transition-colors"
        >
          <Send size={16} />
        </button>
      </form>

      {isLoading ? (
        <p className="text-xs text-gray-400">Loading comments...</p>
      ) : comments.length === 0 ? (
        <p className="text-xs text-gray-400 text-center py-4">No comments yet. Be the first to comment!</p>
      ) : (
        <div className="space-y-3 max-h-[300px] overflow-y-auto">
          {comments.map((comment) => (
            <div key={comment.id} className="bg-gray-50 rounded-lg p-3">
              <div className="flex items-start justify-between">
                <div className="flex items-center gap-2">
                  <div className="w-6 h-6 rounded-full bg-blue-500 flex items-center justify-center text-white text-xs font-bold">
                    {(comment.authorName || '?')[0].toUpperCase()}
                  </div>
                  <span className="text-xs font-medium text-gray-700">{comment.authorName}</span>
                  <span className="text-xs text-gray-400">
                    {new Date(comment.createdAt).toLocaleDateString()}
                  </span>
                </div>
                <button
                  onClick={() => deleteMutation.mutate(comment.id)}
                  className="text-gray-300 hover:text-red-500 transition-colors"
                >
                  <Trash2 size={12} />
                </button>
              </div>
              <p className="text-sm text-gray-700 mt-1.5 ml-8">{comment.content}</p>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}


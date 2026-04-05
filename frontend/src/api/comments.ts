import client from './client';
import type { ApiResponse, Comment, PagedResponse } from '../types';

export const getComments = (datasetId: string, page = 0, size = 50) =>
  client.get<ApiResponse<PagedResponse<Comment>>>(`/datasets/${datasetId}/comments`, {
    params: { page, size },
  });

export const addComment = (datasetId: string, authorId: string, content: string) =>
  client.post<ApiResponse<Comment>>(`/datasets/${datasetId}/comments`, {
    authorId,
    content,
  });

export const deleteComment = (datasetId: string, commentId: string) =>
  client.delete<ApiResponse<void>>(`/datasets/${datasetId}/comments/${commentId}`);


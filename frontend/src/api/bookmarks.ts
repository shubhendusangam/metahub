import client from './client';
import type { ApiResponse, Bookmark, PagedResponse } from '../types';

export const getBookmarks = (userId: string, page = 0, size = 20) =>
  client.get<ApiResponse<PagedResponse<Bookmark>>>('/bookmarks', {
    params: { userId, page, size },
  });

export const addBookmark = (userId: string, datasetId: string) =>
  client.post<ApiResponse<Bookmark>>('/bookmarks', { userId, datasetId });

export const removeBookmark = (userId: string, datasetId: string) =>
  client.delete<ApiResponse<void>>('/bookmarks', {
    params: { userId, datasetId },
  });

export const isBookmarked = (userId: string, datasetId: string) =>
  client.get<ApiResponse<boolean>>('/bookmarks/check', {
    params: { userId, datasetId },
  });


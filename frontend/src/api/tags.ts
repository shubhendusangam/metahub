import client from './client';
import type { ApiResponse, Tag } from '../types';

export const getTags = () =>
  client.get<ApiResponse<Tag[]>>('/tags');

export const createTag = (data: {
  name: string;
  category?: string;
  description?: string;
}) => client.post<ApiResponse<Tag>>('/tags', data);

export const deleteTag = (id: string) =>
  client.delete<ApiResponse<void>>(`/tags/${id}`);


import client from './client';
import type { ApiResponse, Dataset, PagedResponse } from '../types';

export const getDatasets = (page = 0, size = 20) =>
  client.get<ApiResponse<PagedResponse<Dataset>>>('/datasets', { params: { page, size } });

export const getDataset = (id: string) =>
  client.get<ApiResponse<Dataset>>(`/datasets/${id}`);

export const createDataset = (data: {
  name: string;
  qualifiedName: string;
  description?: string;
  dataSourceId?: string;
  ownerId?: string;
  tagNames?: string[];
}) => client.post<ApiResponse<Dataset>>('/datasets', data);

export const deleteDataset = (id: string) =>
  client.delete<ApiResponse<void>>(`/datasets/${id}`);

export const addTags = (id: string, tagNames: string[]) =>
  client.post<ApiResponse<Dataset>>(`/datasets/${id}/tags`, tagNames);


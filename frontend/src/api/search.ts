import client from './client';
import type { ApiResponse, SearchResponse } from '../types';

export const search = (q: string, page = 0, size = 20) =>
  client.get<ApiResponse<SearchResponse>>('/search', { params: { q, page, size } });


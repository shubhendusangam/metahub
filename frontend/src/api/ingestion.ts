import client from './client';
import type { ApiResponse } from '../types';

export const runIngestion = (dataSourceId: string) =>
  client.post<ApiResponse<number>>(`/ingestion/run/${dataSourceId}`);


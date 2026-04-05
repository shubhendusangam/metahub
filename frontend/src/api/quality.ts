import client from './client';
import type { ApiResponse, DataQualityScore } from '../types';

export const getQualityScores = () =>
  client.get<ApiResponse<DataQualityScore[]>>('/quality/scores');

export const getQualityScore = (datasetId: string) =>
  client.get<ApiResponse<DataQualityScore>>(`/quality/scores/${datasetId}`);

export const computeQualityScores = () =>
  client.post<ApiResponse<string>>('/quality/compute');


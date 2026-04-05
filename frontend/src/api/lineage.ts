import client from './client';
import type { ApiResponse, LineageGraph } from '../types';

export const getLineageGraph = (datasetId: string) =>
  client.get<ApiResponse<LineageGraph>>(`/lineage/${datasetId}/graph`);

export const addLineageEdge = (data: {
  sourceDatasetId: string;
  targetDatasetId: string;
  transformationDescription?: string;
  jobName?: string;
}) => client.post('/lineage', data);


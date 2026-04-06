import client from './client';
import type { ApiResponse, DataSource } from '../types';

export const getDataSources = () =>
  client.get<ApiResponse<DataSource[]>>('/datasources');

export const getDataSource = (id: string) =>
  client.get<ApiResponse<DataSource>>(`/datasources/${id}`);

export const createDataSource = (data: {
  name: string;
  type: string;
  connectionUrl?: string;
  description?: string;
}) => client.post<ApiResponse<DataSource>>('/datasources', data);

export const updateDataSource = (id: string, data: {
  name: string;
  type: string;
  connectionUrl?: string;
  description?: string;
}) => client.put<ApiResponse<DataSource>>(`/datasources/${id}`, data);

export const deleteDataSource = (id: string) =>
  client.delete<ApiResponse<void>>(`/datasources/${id}`);

export const testConnection = (id: string) =>
  client.post<ApiResponse<boolean>>(`/datasources/${id}/test-connection`);


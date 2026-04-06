import client from './client';
import type { ApiResponse, GovernancePolicy } from '../types';

export const getPolicies = () =>
  client.get<ApiResponse<GovernancePolicy[]>>('/governance/policies');

export const getPolicy = (id: string) =>
  client.get<ApiResponse<GovernancePolicy>>(`/governance/policies/${id}`);

export const createPolicy = (data: {
  name: string;
  description: string;
  rules: string;
  status?: string;
}) => client.post<ApiResponse<GovernancePolicy>>('/governance/policies', data);

export const updatePolicy = (id: string, data: {
  name: string;
  description: string;
  rules: string;
  status?: string;
}) => client.put<ApiResponse<GovernancePolicy>>(`/governance/policies/${id}`, data);

export const deletePolicy = (id: string) =>
  client.delete<ApiResponse<void>>(`/governance/policies/${id}`);

export const attachDatasets = (policyId: string, datasetIds: string[]) =>
  client.post<ApiResponse<GovernancePolicy>>(`/governance/policies/${policyId}/attach`, datasetIds);

export const detachDatasets = (policyId: string, datasetIds: string[]) =>
  client.post<ApiResponse<GovernancePolicy>>(`/governance/policies/${policyId}/detach`, datasetIds);


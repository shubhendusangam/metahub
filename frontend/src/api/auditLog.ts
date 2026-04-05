import client from './client';
import type { ApiResponse, AuditLog, PagedResponse } from '../types';

export const getAuditLogs = (entityType?: string, page = 0, size = 20) =>
  client.get<ApiResponse<PagedResponse<AuditLog>>>('/audit-logs', {
    params: { entityType, page, size },
  });


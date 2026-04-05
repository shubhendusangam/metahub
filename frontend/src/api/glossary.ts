import client from './client';
import type { ApiResponse, GlossaryTerm, PagedResponse } from '../types';

export const getGlossaryTerms = (category?: string, q?: string, page = 0, size = 20) =>
  client.get<ApiResponse<PagedResponse<GlossaryTerm>>>('/glossary', {
    params: { category, q, page, size },
  });

export const getGlossaryTerm = (id: string) =>
  client.get<ApiResponse<GlossaryTerm>>(`/glossary/${id}`);

export const createGlossaryTerm = (data: {
  term: string;
  definition: string;
  category?: string;
  synonyms?: string[];
  relatedDatasetIds?: string[];
}) => client.post<ApiResponse<GlossaryTerm>>('/glossary', data);

export const updateGlossaryTerm = (id: string, data: {
  term: string;
  definition: string;
  category?: string;
  synonyms?: string[];
  relatedDatasetIds?: string[];
}) => client.put<ApiResponse<GlossaryTerm>>(`/glossary/${id}`, data);

export const deleteGlossaryTerm = (id: string) =>
  client.delete<ApiResponse<void>>(`/glossary/${id}`);


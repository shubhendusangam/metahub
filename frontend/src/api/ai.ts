import client from './client';
import type { ApiResponse } from '../types';

// --- Types for AI features ---
export interface NLQueryResult {
  intent: string;
  searchTerms: string[];
  entities: Record<string, string>;
  filters: Record<string, string[]>;
  suggestedResponse: string;
}

export interface AIInsight {
  type: string;
  title: string;
  content: string;
  severity: 'INFO' | 'WARNING' | 'CRITICAL';
  confidence: number;
}

export interface TagSuggestion {
  tagName: string;
  category: string;
  confidence: number;
  reason: string;
}

export interface ChatResponse {
  intent: string;
  message: string;
  searchTerms: string[];
  entities: Record<string, string>;
  suggestions: string[];
}

// --- API functions ---

/**
 * Process a natural language query about metadata.
 */
export const processNLQuery = (query: string) =>
  client.post<ApiResponse<NLQueryResult>>('/ai/query', { query });

/**
 * Get AI-powered insights for a dataset.
 */
export const getAIInsights = (datasetId: string) =>
  client.get<ApiResponse<AIInsight[]>>(`/ai/insights/${datasetId}`);

/**
 * Get AI-suggested tags for a dataset.
 */
export const suggestTags = (datasetId: string) =>
  client.get<ApiResponse<TagSuggestion[]>>(`/ai/suggest-tags/${datasetId}`);

/**
 * Generate an AI description for a dataset.
 */
export const generateDescription = (datasetId: string) =>
  client.get<ApiResponse<{ description: string }>>(`/ai/generate-description/${datasetId}`);

/**
 * Get AI-suggested column descriptions for a dataset.
 */
export const suggestColumnDescriptions = (datasetId: string) =>
  client.get<ApiResponse<Record<string, string>>>(`/ai/suggest-column-descriptions/${datasetId}`);

/**
 * Send a chat message to the AI assistant.
 */
export const chat = (message: string, conversationId?: string) =>
  client.post<ApiResponse<ChatResponse>>('/ai/chat', { message, conversationId });


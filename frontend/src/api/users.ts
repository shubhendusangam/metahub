import client from './client';
import type { ApiResponse, User } from '../types';

export const getUsers = () =>
  client.get<ApiResponse<User[]>>('/users');

export const getUser = (id: string) =>
  client.get<ApiResponse<User>>(`/users/${id}`);

export const createUser = (data: {
  username: string;
  email: string;
  displayName?: string;
  role: string;
}) => client.post<ApiResponse<User>>('/users', data);

export const updateUser = (id: string, data: {
  username: string;
  email: string;
  displayName?: string;
  role: string;
}) => client.put<ApiResponse<User>>(`/users/${id}`, data);

export const deleteUser = (id: string) =>
  client.delete<ApiResponse<void>>(`/users/${id}`);


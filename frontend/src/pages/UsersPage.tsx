import { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Users as UsersIcon, Plus, Pencil, Trash2, X } from 'lucide-react';
import { getUsers, createUser, updateUser, deleteUser } from '../api/users';
import type { User } from '../types';
import { LoadingSpinner } from '../components/common';

const ROLES = ['ADMIN', 'DATA_STEWARD', 'VIEWER'] as const;

interface FormData {
  username: string;
  email: string;
  displayName: string;
  role: string;
}

const emptyForm: FormData = { username: '', email: '', displayName: '', role: 'VIEWER' };

export default function UsersPage() {
  const queryClient = useQueryClient();
  const [showModal, setShowModal] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [form, setForm] = useState<FormData>(emptyForm);

  const { data, isLoading } = useQuery({
    queryKey: ['users'],
    queryFn: () => getUsers().then(r => r.data.data),
  });

  const createMut = useMutation({
    mutationFn: createUser,
    onSuccess: () => { queryClient.invalidateQueries({ queryKey: ['users'] }); closeModal(); },
  });

  const updateMut = useMutation({
    mutationFn: ({ id, data }: { id: string; data: FormData }) => updateUser(id, data),
    onSuccess: () => { queryClient.invalidateQueries({ queryKey: ['users'] }); closeModal(); },
  });

  const deleteMut = useMutation({
    mutationFn: deleteUser,
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ['users'] }),
  });

  const closeModal = () => { setShowModal(false); setEditingId(null); setForm(emptyForm); };

  const openCreate = () => { setForm(emptyForm); setEditingId(null); setShowModal(true); };

  const openEdit = (user: User) => {
    setForm({ username: user.username, email: user.email, displayName: user.displayName || '', role: user.role });
    setEditingId(user.id);
    setShowModal(true);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (editingId) {
      updateMut.mutate({ id: editingId, data: form });
    } else {
      createMut.mutate(form);
    }
  };

  const roleBadge = (role: string) => {
    const colors: Record<string, string> = {
      ADMIN: 'bg-red-100 text-red-700',
      DATA_STEWARD: 'bg-blue-100 text-blue-700',
      VIEWER: 'bg-gray-100 text-gray-700',
    };
    return <span className={`text-xs font-medium px-2 py-0.5 rounded ${colors[role] || colors.VIEWER}`}>{role.replace('_', ' ')}</span>;
  };

  if (isLoading) return <LoadingSpinner />;

  const users: User[] = data || [];

  return (
    <div className="p-6">
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-3">
          <UsersIcon className="text-blue-500" size={28} />
          <h1 className="text-2xl font-bold text-gray-800">Users</h1>
          <span className="bg-blue-100 text-blue-700 text-xs font-medium px-2 py-0.5 rounded-full">
            {users.length}
          </span>
        </div>
        <button onClick={openCreate} className="flex items-center gap-2 bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors">
          <Plus size={16} /> Add User
        </button>
      </div>

      <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
        <table className="w-full text-sm">
          <thead className="bg-gray-50 border-b">
            <tr>
              <th className="text-left px-4 py-3 font-medium text-gray-600">Username</th>
              <th className="text-left px-4 py-3 font-medium text-gray-600">Display Name</th>
              <th className="text-left px-4 py-3 font-medium text-gray-600">Email</th>
              <th className="text-left px-4 py-3 font-medium text-gray-600">Role</th>
              <th className="text-right px-4 py-3 font-medium text-gray-600">Actions</th>
            </tr>
          </thead>
          <tbody className="divide-y">
            {users.map(user => (
              <tr key={user.id} className="hover:bg-gray-50">
                <td className="px-4 py-3 font-medium text-gray-900">{user.username}</td>
                <td className="px-4 py-3 text-gray-700">{user.displayName || '—'}</td>
                <td className="px-4 py-3 text-gray-500">{user.email}</td>
                <td className="px-4 py-3">{roleBadge(user.role)}</td>
                <td className="px-4 py-3 text-right">
                  <div className="flex items-center justify-end gap-1">
                    <button onClick={() => openEdit(user)} className="p-1.5 rounded hover:bg-gray-100 text-gray-500">
                      <Pencil size={15} />
                    </button>
                    <button onClick={() => { if (confirm(`Delete user "${user.username}"?`)) deleteMut.mutate(user.id); }}
                      className="p-1.5 rounded hover:bg-red-50 text-red-500">
                      <Trash2 size={15} />
                    </button>
                  </div>
                </td>
              </tr>
            ))}
            {users.length === 0 && (
              <tr><td colSpan={5} className="px-4 py-8 text-center text-gray-400">No users found.</td></tr>
            )}
          </tbody>
        </table>
      </div>

      {showModal && (
        <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50">
          <div className="bg-white rounded-xl shadow-xl w-full max-w-lg p-6">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-lg font-semibold">{editingId ? 'Edit User' : 'Add User'}</h2>
              <button onClick={closeModal} className="text-gray-400 hover:text-gray-600"><X size={20} /></button>
            </div>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Username *</label>
                <input required value={form.username} onChange={e => setForm({ ...form, username: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Email *</label>
                <input required type="email" value={form.email} onChange={e => setForm({ ...form, email: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Display Name</label>
                <input value={form.displayName} onChange={e => setForm({ ...form, displayName: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Role *</label>
                <select value={form.role} onChange={e => setForm({ ...form, role: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                  {ROLES.map(r => <option key={r} value={r}>{r.replace('_', ' ')}</option>)}
                </select>
              </div>
              <div className="flex justify-end gap-2 pt-2">
                <button type="button" onClick={closeModal} className="px-4 py-2 border rounded-lg text-sm text-gray-600 hover:bg-gray-50">Cancel</button>
                <button type="submit" className="px-4 py-2 bg-blue-600 text-white rounded-lg text-sm hover:bg-blue-700">
                  {editingId ? 'Update' : 'Create'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}


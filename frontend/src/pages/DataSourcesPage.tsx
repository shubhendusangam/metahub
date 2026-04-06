import { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Server, Plus, Pencil, Trash2, Plug, X } from 'lucide-react';
import { getDataSources, createDataSource, updateDataSource, deleteDataSource, testConnection } from '../api/datasources';
import { runIngestion } from '../api/ingestion';
import type { DataSource } from '../types';
import { LoadingSpinner } from '../components/common';

const DS_TYPES = ['JDBC', 'API', 'FILE_SYSTEM', 'CLOUD_STORAGE'] as const;

interface FormData {
  name: string;
  type: string;
  connectionUrl: string;
  description: string;
}

const emptyForm: FormData = { name: '', type: 'JDBC', connectionUrl: '', description: '' };

export default function DataSourcesPage() {
  const queryClient = useQueryClient();
  const [showModal, setShowModal] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [form, setForm] = useState<FormData>(emptyForm);
  const [testResults, setTestResults] = useState<Record<string, boolean | null>>({});

  const { data, isLoading } = useQuery({
    queryKey: ['datasources'],
    queryFn: () => getDataSources().then(r => r.data.data),
  });

  const createMut = useMutation({
    mutationFn: createDataSource,
    onSuccess: () => { queryClient.invalidateQueries({ queryKey: ['datasources'] }); closeModal(); },
  });

  const updateMut = useMutation({
    mutationFn: ({ id, data }: { id: string; data: FormData }) => updateDataSource(id, data),
    onSuccess: () => { queryClient.invalidateQueries({ queryKey: ['datasources'] }); closeModal(); },
  });

  const deleteMut = useMutation({
    mutationFn: deleteDataSource,
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ['datasources'] }),
  });

  const testMut = useMutation({
    mutationFn: testConnection,
    onSuccess: (res, id) => setTestResults(prev => ({ ...prev, [id]: res.data.data })),
  });

  const ingestMut = useMutation({
    mutationFn: runIngestion,
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ['datasources'] }),
  });

  const closeModal = () => { setShowModal(false); setEditingId(null); setForm(emptyForm); };

  const openCreate = () => { setForm(emptyForm); setEditingId(null); setShowModal(true); };

  const openEdit = (ds: DataSource) => {
    setForm({ name: ds.name, type: ds.type, connectionUrl: ds.connectionUrl || '', description: ds.description || '' });
    setEditingId(ds.id);
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

  if (isLoading) return <LoadingSpinner />;

  const dataSources: DataSource[] = data || [];

  return (
    <div className="p-6">
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-3">
          <Server className="text-blue-500" size={28} />
          <h1 className="text-2xl font-bold text-gray-800">Data Sources</h1>
          <span className="bg-blue-100 text-blue-700 text-xs font-medium px-2 py-0.5 rounded-full">
            {dataSources.length}
          </span>
        </div>
        <button onClick={openCreate} className="flex items-center gap-2 bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors">
          <Plus size={16} /> Add Data Source
        </button>
      </div>

      <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
        <table className="w-full text-sm">
          <thead className="bg-gray-50 border-b">
            <tr>
              <th className="text-left px-4 py-3 font-medium text-gray-600">Name</th>
              <th className="text-left px-4 py-3 font-medium text-gray-600">Type</th>
              <th className="text-left px-4 py-3 font-medium text-gray-600">Connection URL</th>
              <th className="text-left px-4 py-3 font-medium text-gray-600">Description</th>
              <th className="text-right px-4 py-3 font-medium text-gray-600">Actions</th>
            </tr>
          </thead>
          <tbody className="divide-y">
            {dataSources.map(ds => (
              <tr key={ds.id} className="hover:bg-gray-50">
                <td className="px-4 py-3 font-medium text-gray-900">{ds.name}</td>
                <td className="px-4 py-3">
                  <span className="bg-purple-100 text-purple-700 text-xs font-medium px-2 py-0.5 rounded">{ds.type}</span>
                </td>
                <td className="px-4 py-3 text-gray-500 font-mono text-xs max-w-xs truncate">{ds.connectionUrl}</td>
                <td className="px-4 py-3 text-gray-500 max-w-xs truncate">{ds.description}</td>
                <td className="px-4 py-3 text-right">
                  <div className="flex items-center justify-end gap-1">
                    <button onClick={() => testMut.mutate(ds.id)} title="Test Connection"
                      className="p-1.5 rounded hover:bg-green-50 text-green-600">
                      <Plug size={15} />
                    </button>
                    {testResults[ds.id] !== undefined && (
                      <span className={`text-xs font-medium ${testResults[ds.id] ? 'text-green-600' : 'text-red-600'}`}>
                        {testResults[ds.id] ? '✓' : '✗'}
                      </span>
                    )}
                    <button onClick={() => ingestMut.mutate(ds.id)} title="Run Ingestion"
                      className="p-1.5 rounded hover:bg-blue-50 text-blue-600 text-xs font-medium">
                      Ingest
                    </button>
                    <button onClick={() => openEdit(ds)} className="p-1.5 rounded hover:bg-gray-100 text-gray-500">
                      <Pencil size={15} />
                    </button>
                    <button onClick={() => { if (confirm(`Delete "${ds.name}"?`)) deleteMut.mutate(ds.id); }}
                      className="p-1.5 rounded hover:bg-red-50 text-red-500">
                      <Trash2 size={15} />
                    </button>
                  </div>
                </td>
              </tr>
            ))}
            {dataSources.length === 0 && (
              <tr><td colSpan={5} className="px-4 py-8 text-center text-gray-400">No data sources registered yet.</td></tr>
            )}
          </tbody>
        </table>
      </div>

      {showModal && (
        <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50">
          <div className="bg-white rounded-xl shadow-xl w-full max-w-lg p-6">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-lg font-semibold">{editingId ? 'Edit Data Source' : 'Add Data Source'}</h2>
              <button onClick={closeModal} className="text-gray-400 hover:text-gray-600"><X size={20} /></button>
            </div>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Name *</label>
                <input required value={form.name} onChange={e => setForm({ ...form, name: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Type *</label>
                <select value={form.type} onChange={e => setForm({ ...form, type: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                  {DS_TYPES.map(t => <option key={t} value={t}>{t}</option>)}
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Connection URL</label>
                <input value={form.connectionUrl} onChange={e => setForm({ ...form, connectionUrl: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 text-sm font-mono focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Description</label>
                <textarea rows={2} value={form.description} onChange={e => setForm({ ...form, description: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
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


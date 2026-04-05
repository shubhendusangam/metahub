import { useState } from 'react';
import { useParams } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { getLineageGraph } from '../api/lineage';
import { getDatasets } from '../api/datasets';
import LineageGraphView from '../components/lineage/LineageGraph';

export default function LineagePage() {
  const { datasetId: paramId } = useParams<{ datasetId: string }>();
  const [selectedId, setSelectedId] = useState(paramId || '');

  const { data: datasetsData } = useQuery({
    queryKey: ['datasets-for-lineage'],
    queryFn: () => getDatasets(0, 100),
  });

  const { data: graphData, isLoading } = useQuery({
    queryKey: ['lineage', selectedId],
    queryFn: () => getLineageGraph(selectedId),
    enabled: !!selectedId,
  });

  const datasets = datasetsData?.data?.data?.content ?? [];
  const graph = graphData?.data?.data;

  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Data Lineage</h1>

      <div className="mb-6">
        <label className="block text-sm font-medium text-gray-700 mb-1">
          Select a dataset to view its lineage graph
        </label>
        <select
          value={selectedId}
          onChange={(e) => setSelectedId(e.target.value)}
          className="w-full max-w-md px-3 py-2 rounded-lg border border-gray-300 text-sm focus:border-blue-500 focus:ring-2 focus:ring-blue-100 outline-none"
        >
          <option value="">-- Choose a dataset --</option>
          {datasets.map((ds) => (
            <option key={ds.id} value={ds.id}>
              {ds.name} ({ds.qualifiedName})
            </option>
          ))}
        </select>
      </div>

      {isLoading && <p className="text-gray-500">Loading lineage graph...</p>}

      {graph && <LineageGraphView graph={graph} />}

      {!selectedId && (
        <div className="text-center py-16 text-gray-400">
          <p className="text-lg mb-2">🔗</p>
          <p>Select a dataset above to visualize its data lineage</p>
        </div>
      )}
    </div>
  );
}


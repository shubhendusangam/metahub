import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import client from '../api/client';
import type { ApiResponse, GovernancePolicy } from '../types';
import PolicyList from '../components/governance/PolicyList';
import PolicyDetail from '../components/governance/PolicyDetail';

export default function GovernancePage() {
  const [selectedId, setSelectedId] = useState<string | null>(null);

  const { data, isLoading } = useQuery({
    queryKey: ['governance-policies'],
    queryFn: () => client.get<ApiResponse<GovernancePolicy[]>>('/governance/policies'),
  });

  const policies = data?.data?.data ?? [];
  const selectedPolicy = policies.find((p) => p.id === selectedId) || null;

  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Data Governance</h1>

      <div className="flex gap-6">
        <div className="flex-1">
          {isLoading ? (
            <p className="text-gray-500">Loading policies...</p>
          ) : (
            <PolicyList
              policies={policies}
              selectedId={selectedId}
              onSelect={setSelectedId}
            />
          )}
        </div>

        {selectedPolicy && (
          <div className="w-[480px]">
            <PolicyDetail policy={selectedPolicy} />
          </div>
        )}
      </div>
    </div>
  );
}


import { useQuery } from '@tanstack/react-query';
import { useState } from 'react';
import { getDatasets, getDataset } from '../api/datasets';
import DatasetList from '../components/catalog/DatasetList';
import DatasetDetail from '../components/catalog/DatasetDetail';
import Pagination from '../components/common/Pagination';
import { LoadingState } from '../components/common/LoadingSpinner';

const PAGE_SIZE = 20;

export default function CatalogPage() {
  const [page, setPage] = useState(0);
  const [selectedId, setSelectedId] = useState<string | null>(null);

  const { data, isLoading } = useQuery({
    queryKey: ['datasets', page],
    queryFn: () => getDatasets(page, PAGE_SIZE),
  });

  const { data: detailData } = useQuery({
    queryKey: ['dataset', selectedId],
    queryFn: () => getDataset(selectedId!),
    enabled: !!selectedId,
  });

  const pagedData = data?.data?.data;
  const selectedDataset = detailData?.data?.data;

  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Dataset Catalog</h1>

      <div className="flex gap-6">
        <div className="flex-1">
          {isLoading ? (
            <LoadingState message="Loading datasets..." />
          ) : (
            <>
              <DatasetList
                datasets={pagedData?.content ?? []}
                selectedId={selectedId}
                onSelect={setSelectedId}
              />
              {pagedData && (
                <Pagination
                  page={page}
                  totalPages={pagedData.totalPages}
                  isLastPage={pagedData.last}
                  onPageChange={setPage}
                  className="mt-4"
                />
              )}
            </>
          )}
        </div>

        {selectedDataset && (
          <div className="w-[480px]">
            <DatasetDetail dataset={selectedDataset} />
          </div>
        )}
      </div>
    </div>
  );
}


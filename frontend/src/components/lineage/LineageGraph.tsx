import { useCallback, useMemo } from 'react';
import ReactFlow, {
  Background,
  Controls,
  MiniMap,
  type Node,
  type Edge,
  MarkerType,
  Position,
} from 'reactflow';
import 'reactflow/dist/style.css';
import type { LineageGraph } from '../../types';

interface Props {
  graph: LineageGraph;
}

// Custom node component for better text handling
const DatasetNode = ({ name, qualifiedName, isRoot }: { name: string; qualifiedName: string; isRoot: boolean }) => (
  <div
    className={`px-4 py-3 rounded-xl border-2 shadow-sm ${
      isRoot
        ? 'bg-blue-600 border-blue-700 text-white'
        : 'bg-white border-gray-300 text-gray-900'
    }`}
    style={{ minWidth: 200, maxWidth: 280 }}
  >
    <div
      className={`font-semibold text-sm truncate ${isRoot ? 'text-white' : 'text-gray-900'}`}
      title={name}
    >
      {name}
    </div>
    <div
      className={`text-xs font-mono mt-1 truncate ${isRoot ? 'text-blue-100' : 'text-gray-500'}`}
      title={qualifiedName}
    >
      {qualifiedName}
    </div>
  </div>
);

export default function LineageGraphView({ graph }: Props) {
  // Calculate positions using a hierarchical layout
  const { nodes, edges } = useMemo(() => {
    // Build adjacency map
    const children = new Map<string, string[]>();
    const parents = new Map<string, string[]>();

    graph.edges.forEach(e => {
      if (!children.has(e.sourceId)) children.set(e.sourceId, []);
      children.get(e.sourceId)!.push(e.targetId);

      if (!parents.has(e.targetId)) parents.set(e.targetId, []);
      parents.get(e.targetId)!.push(e.sourceId);
    });

    // Find root nodes (no parents) and assign levels
    const levels = new Map<string, number>();
    const nodeIds = new Set(graph.nodes.map(n => n.id));

    // BFS to assign levels
    const roots = graph.nodes.filter(n => !parents.has(n.id) || parents.get(n.id)!.length === 0);
    const queue: { id: string; level: number }[] = roots.map(r => ({ id: r.id, level: 0 }));

    while (queue.length > 0) {
      const { id, level } = queue.shift()!;
      if (levels.has(id)) continue;
      levels.set(id, level);

      const childNodes = children.get(id) || [];
      childNodes.forEach(childId => {
        if (!levels.has(childId)) {
          queue.push({ id: childId, level: level + 1 });
        }
      });
    }

    // Assign levels to any unvisited nodes
    graph.nodes.forEach(n => {
      if (!levels.has(n.id)) {
        levels.set(n.id, 0);
      }
    });

    // Group nodes by level
    const nodesByLevel = new Map<number, typeof graph.nodes>();
    graph.nodes.forEach(n => {
      const level = levels.get(n.id) || 0;
      if (!nodesByLevel.has(level)) nodesByLevel.set(level, []);
      nodesByLevel.get(level)!.push(n);
    });

    // Calculate positions with proper spacing
    const nodeWidth = 280;
    const nodeHeight = 80;
    const horizontalGap = 100;
    const verticalGap = 120;

    const reactFlowNodes: Node[] = [];

    nodesByLevel.forEach((nodesAtLevel, level) => {
      const totalWidth = nodesAtLevel.length * nodeWidth + (nodesAtLevel.length - 1) * horizontalGap;
      const startX = -totalWidth / 2;

      nodesAtLevel.forEach((n, idx) => {
        const isRoot = n.type === 'root';
        reactFlowNodes.push({
          id: n.id,
          type: 'default',
          data: {
            label: <DatasetNode name={n.name} qualifiedName={n.qualifiedName} isRoot={isRoot} />,
          },
          position: {
            x: startX + idx * (nodeWidth + horizontalGap),
            y: level * (nodeHeight + verticalGap)
          },
          sourcePosition: Position.Bottom,
          targetPosition: Position.Top,
          style: {
            background: 'transparent',
            border: 'none',
            padding: 0,
            width: 'auto',
          },
        });
      });
    });

    const reactFlowEdges: Edge[] = graph.edges.map((e) => ({
      id: e.id,
      source: e.sourceId,
      target: e.targetId,
      animated: true,
      label: e.jobName || undefined,
      labelBgPadding: [8, 4] as [number, number],
      labelBgBorderRadius: 4,
      labelBgStyle: { fill: '#f3f4f6', fillOpacity: 0.9 },
      labelStyle: { fontSize: 11, fontWeight: 500, fill: '#374151' },
      markerEnd: { type: MarkerType.ArrowClosed, color: '#6b7280', width: 20, height: 20 },
      style: { stroke: '#9ca3af', strokeWidth: 2 },
      type: 'smoothstep',
    }));

    return { nodes: reactFlowNodes, edges: reactFlowEdges };
  }, [graph]);

  if (graph.nodes.length === 0) {
    return (
      <div className="text-center py-12 text-gray-500">
        No lineage data available for this dataset.
      </div>
    );
  }

  return (
    <div className="h-[600px] bg-gradient-to-br from-gray-50 to-white rounded-xl border border-gray-200 shadow-sm">
      <ReactFlow
        nodes={nodes}
        edges={edges}
        fitView
        fitViewOptions={{ padding: 0.3, minZoom: 0.5, maxZoom: 1.5 }}
        minZoom={0.2}
        maxZoom={2}
        attributionPosition="bottom-left"
        proOptions={{ hideAttribution: true }}
      >
        <Background color="#e5e7eb" gap={20} />
        <Controls
          className="bg-white rounded-lg shadow-md border border-gray-200"
          showInteractive={false}
        />
        <MiniMap
          style={{ background: '#f9fafb', borderRadius: 8 }}
          nodeColor={(n) => {
            const label = n.data?.label;
            if (label?.props?.isRoot) return '#3b82f6';
            return '#d1d5db';
          }}
          maskColor="rgba(0, 0, 0, 0.1)"
        />
      </ReactFlow>
    </div>
  );
}


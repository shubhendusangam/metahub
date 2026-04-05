export interface Dataset {
  id: string;
  name: string;
  description: string;
  qualifiedName: string;
  dataSourceName?: string;
  dataSourceId?: string;
  ownerName?: string;
  ownerId?: string;
  tags: string[];
  schemas: Schema[];
  createdAt: string;
  updatedAt: string;
}

export interface Schema {
  id: string;
  name: string;
  version: number;
  columns: Column[];
}

export interface Column {
  id: string;
  name: string;
  dataType: string;
  nullable: boolean;
  isPrimaryKey: boolean;
  description: string;
  ordinalPosition: number;
}

export interface DataSource {
  id: string;
  name: string;
  type: 'JDBC' | 'API' | 'FILE_SYSTEM' | 'CLOUD_STORAGE';
  connectionUrl: string;
  description: string;
  createdAt: string;
  updatedAt: string;
}

export interface Tag {
  id: string;
  name: string;
  category?: string;
  description?: string;
}

export interface GovernancePolicy {
  id: string;
  name: string;
  description: string;
  rules: string;
  status: 'DRAFT' | 'ACTIVE' | 'ARCHIVED';
  applicableDatasets: Dataset[];
  createdAt: string;
  updatedAt: string;
}

export interface LineageNode {
  id: string;
  name: string;
  qualifiedName: string;
  type: string;
}

export interface LineageEdge {
  id: string;
  sourceId: string;
  targetId: string;
  transformationDescription: string;
  jobName: string;
}

export interface LineageGraph {
  nodes: LineageNode[];
  edges: LineageEdge[];
}

export interface SearchHit {
  id: string;
  name: string;
  qualifiedName: string;
  description: string;
  dataSourceName: string;
  tags: string[];
  score: number;
}

export interface SearchResponse {
  hits: SearchHit[];
  totalHits: number;
  page: number;
  size: number;
}

export interface ApiResponse<T> {
  success: boolean;
  message?: string;
  data: T;
}

export interface PagedResponse<T> {
  content: T[];
  page: number;
  size: number;
  totalElements: number;
  totalPages: number;
  last: boolean;
}

// --- Data Quality ---
export interface DataQualityScore {
  id: string;
  datasetId: string;
  datasetName: string;
  qualifiedName: string;
  overallScore: number;
  completenessScore: number;
  freshnessScore: number;
  schemaCoverageScore: number;
  computedAt: string;
}

// --- Audit Log ---
export interface AuditLog {
  id: string;
  entityType: string;
  entityId: string;
  action: string;
  changedBy: string;
  changeDetails: string;
  createdAt: string;
}

// --- Bookmarks ---
export interface Bookmark {
  id: string;
  datasetId: string;
  datasetName: string;
  datasetQualifiedName: string;
  datasetDescription: string;
  userId: string;
  createdAt: string;
}

// --- Glossary ---
export interface GlossaryTerm {
  id: string;
  term: string;
  definition: string;
  category: string;
  synonyms: string[];
  relatedDatasets: { id: string; name: string; qualifiedName: string }[];
  createdAt: string;
  updatedAt: string;
}

// --- Comments ---
export interface Comment {
  id: string;
  content: string;
  datasetId: string;
  authorId: string;
  authorName: string;
  createdAt: string;
  updatedAt: string;
}


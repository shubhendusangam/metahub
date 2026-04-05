# ⬡ MetaHub — Unified Metadata Platform

> A customizable, cloud‑native metadata management platform built with **Spring Boot 3.2** and **React 18 + TypeScript**. MetaHub demonstrates production-grade backend engineering with scalable metadata management — supporting dataset cataloging, data lineage visualization, governance enforcement, full-text search, metadata ingestion from heterogeneous sources, **AI-powered natural language search, smart tag suggestions, and intelligent metadata insights**.

![Java](https://img.shields.io/badge/Java-17%2B-ED8B00?logo=openjdk&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.5-6DB33F?logo=springboot&logoColor=white)
![React](https://img.shields.io/badge/React-18-61DAFB?logo=react&logoColor=black)
![TypeScript](https://img.shields.io/badge/TypeScript-5.4-3178C6?logo=typescript&logoColor=white)
![Tailwind CSS](https://img.shields.io/badge/Tailwind%20CSS-3.4-06B6D4?logo=tailwindcss&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-4169E1?logo=postgresql&logoColor=white)
![Elasticsearch](https://img.shields.io/badge/Elasticsearch-8.13-005571?logo=elasticsearch&logoColor=white)
![AI Powered](https://img.shields.io/badge/AI-Powered-8B5CF6?logo=openai&logoColor=white)
![H2](https://img.shields.io/badge/H2-Dev%20DB-0000BB)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## Table of Contents

- [Architecture](#-architecture)
- [Features](#-features)
- [AI Features](#-ai-features)
- [Tech Stack](#-tech-stack)
- [Prerequisites](#-prerequisites)
- [Quick Start — Development](#-quick-start--development)
- [Production Deployment](#-production-deployment)
- [API Reference](#-api-reference)
- [Project Structure](#-project-structure)
- [Domain Model](#-domain-model)
- [Metadata Ingestion](#-metadata-ingestion)
- [AI/ML Extension Points](#-aiml-extension-points)
- [Testing](#-testing)
- [Configuration Reference](#-configuration-reference)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🏗 Architecture

```
                          ┌──────────────────┐
                          │   React Frontend │
                          │  Vite + TS + TW  │
                          │  (port 5173)     │
                          │                  │
                          │  ┌────────────┐  │
                          │  │AI Assistant│  │
                          │  │  (Chat UI) │  │
                          │  └────────────┘  │
                          └────────┬─────────┘
                                   │  /api/v1/*
                                   ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    Spring Boot 3.2 Backend (port 8080)              │
│                                                                     │
│  ┌─────────────┐ ┌─────────────┐ ┌───────────┐ ┌──────────────────┐ │
│  │  Dataset    │ │  Lineage    │ │  Search   │ │  Governance      │ │
│  │  Controller │ │  Controller │ │ Controller│ │  Controller      │ │
│  └──────┬──────┘ └──────┬──────┘ └─────┬─────┘ └───────┬──────────┘ │
│         │               │              │               │            │
│  ┌──────┴───────────────┴──────────────┴───────────────┴──────────┐ │
│  │                      AI Controller                             │ │
│  │  ├── /ai/query        (Natural Language Processing)            │ │
│  │  ├── /ai/chat         (Conversational AI)                      │ │
│  │  ├── /ai/insights     (Dataset Analysis)                       │ │
│  │  └── /ai/suggest-tags (Smart Tag Suggestions)                  │ │
│  └──────┬─────────────────────────────────────────────────────────┘ │
│         │                                                           │
│  ┌──────▼───────┐ ┌─────────────┐ ┌─────────────┐ ┌───────────────┐ │
│  │  Dataset     │ │ Lineage     │ │  Search     │ │  Governance   │ │
│  │  Service     │ │ Service     │ │  Service    │ │  Service      │ │
│  └──────┬───────┘ └─────┬───────┘ └─────┬───────┘ └───────┬───────┘ │
│         │               │               │                 │         │
│  ┌──────▼───────────────▼───────────────▼─────────────────▼───────┐ │
│  │                     JPA Repositories                           │ │
│  └────────────────────────┬───────────────────────────────────────┘ │
│                           │                                         │
│  ┌────────────────────────┼────────────────┐                        │
│  │  Event Bus (Spring ApplicationEvents)   │──▶ ES Index Sync       │
│  └─────────────────────────────────────────┘                        │
│                                                                     │
│  ┌──────────────────────────────────────────┐                       │
│  │  AI/ML Extensions                        │                       │
│  │  ├── AIAssistantService    ◀── NEW       │                       │
│  │  │   ├── NL Query Processing             │                       │
│  │  │   ├── Smart Tag Suggestions           │                       │
│  │  │   ├── Sensitivity Detection           │                       │
│  │  │   └── Auto Description Generation     │                       │
│  │  ├── AutoTaggingService (rule-based)     │                       │
│  │  └── AnomalyDetectionService (stub)      │                       │
│  └──────────────────────────────────────────┘                       │
│                                                                     │
│  ┌──────────────────────────────────────────┐                       │
│  │  Ingestion Orchestrator                  │                       │
│  │  ├── JdbcIngestionStrategy               │                       │
│  │  ├── ApiIngestionStrategy                │                       │
│  │  ├── FileSystemIngestionStrategy         │                       │
│  │  └── CloudStorageIngestionStrategy       │                       │
│  └──────────────────────────────────────────┘                       │
└──────────────────────────┬──────────────────────────────────────────┘
                           │
            ┌──────────────┼──────────────────────┐
            │              │                      │
      ┌─────▼─────┐ ┌──────▼─────┐   ┌────────────▼──────┐
      │    H2     │ │ PostgreSQL │   │  Elasticsearch    │
      │  (dev)    │ │  (prod)    │   │    (prod)         │
      └───────────┘ └────────────┘   └───────────────────┘
```

### Design Principles

- **Profile-based infrastructure** — Zero-config switching between H2 (dev) and PostgreSQL + Elasticsearch (prod)
- **Strategy pattern** for ingestion — Add new data source types without modifying existing code
- **Event-driven ES sync** — Metadata changes automatically propagate to Elasticsearch via Spring Application Events
- **DTO-first API layer** — Clean separation between JPA entities and API contracts
- **AI-powered discovery** — Natural language search, smart suggestions, and intelligent insights
- **Extension points** — AI/ML interfaces for auto-tagging and anomaly detection, ready for real ML integrations

---

## ✨ Features

### Core Metadata Management

| Feature | Description | Status |
|---------|-------------|--------|
| 📊 **Dataset Catalog** | Browse, create, update, and delete datasets with nested schemas and column definitions | ✅ Complete |
| 🔍 **Full-Text Search** | JPA LIKE queries in dev; Elasticsearch-powered full-text search in production | ✅ Complete |
| 🔗 **Data Lineage** | DAG-based lineage with BFS traversal, upstream/downstream views, and interactive React Flow graph | ✅ Complete |
| 🛡 **Data Governance** | Policy lifecycle management (Draft → Active → Archived), attach/detach policies to datasets | ✅ Complete |
| 📥 **Metadata Ingestion** | Strategy-based ingestion from JDBC databases (real), REST APIs, file systems, and cloud storage | ✅ Complete |
| 📈 **Data Quality Scores** | Automated quality scoring (completeness, freshness, schema coverage) with scheduled recomputation | ✅ Complete |
| 📝 **Audit Log / Activity Feed** | Tracks all metadata CRUD events with entity type, action, user, and timestamp | ✅ Complete |
| ⭐ **Dataset Bookmarks** | Users can bookmark/favorite datasets for quick access from the dashboard | ✅ Complete |
| 📖 **Data Dictionary / Glossary** | Standalone glossary of business terms with definitions, categories, synonyms, and related datasets | ✅ Complete |
| 💬 **Dataset Comments** | Users can add, view, and delete comments/annotations on datasets | ✅ Complete |
| 👤 **User Management** | CRUD operations for users with role support (Admin, Data Steward, Viewer) | ✅ Complete |
| 🏷 **Tag Management** | Create, list, and delete tags; find-or-create semantics on dataset tagging | ✅ Complete |

### AI-Powered Features

| Feature | Description | Status |
|---------|-------------|--------|
| 🤖 **AI Chat Assistant** | Floating conversational assistant for natural language queries about metadata | ✅ Complete |
| 🧠 **Natural Language Search** | Understand user intent (SEARCH, LINEAGE, QUALITY, COMPLIANCE) from plain English queries | ✅ Complete |
| ✨ **Smart Tag Suggestions** | AI analyzes schemas to suggest appropriate tags (PII, Financial, Healthcare) with confidence scores | ✅ Complete |
| 🔮 **AI Insights & Recommendations** | Automatic analysis of datasets for sensitivity detection, quality issues, and governance risks | ✅ Complete |
| 📝 **Auto Description Generation** | AI generates dataset and column descriptions based on schema patterns and naming conventions | ✅ Complete |
| 🎯 **Sensitivity Detection** | Identifies PII (High/Medium/Low), Financial, and Healthcare data using pattern matching | ✅ Complete |
| 🏷 **Auto-Tagging (Rule-Based)** | Rule-based auto-tagging using regex/keyword matching on column names and descriptions | ✅ Complete |
| 🔬 **Anomaly Detection** | Extensible interface with stub implementation, ready for ML model integration | ✅ Extensible |

### Developer & Platform Features

| Feature | Description | Status |
|---------|-------------|--------|
| 📝 **OpenAPI / Swagger** | Interactive API documentation auto-generated from controllers | ✅ Complete |
| 📚 **User Guide** | Comprehensive in-app user guide with expandable sections for all features | ✅ Complete |
| 🖥 **React Frontend** | Modern SPA with dashboard, catalog browser, search, lineage graph, governance, quality, activity, glossary views | ✅ Complete |
| 🐳 **Docker Compose** | One-command production infrastructure (PostgreSQL 15 + Elasticsearch 8 + Kibana) | ✅ Complete |
| 🎨 **Modern UI/UX** | Tailwind CSS styling with responsive design, dark sidebar, and intuitive navigation | ✅ Complete |

---

## 🤖 AI Features

MetaHub includes a comprehensive AI layer that enhances metadata discovery and governance.

### AI Chat Assistant

A floating chat assistant (bottom-right corner) that understands natural language:

```
User: "Find customer datasets with PII"
AI: Intent detected: SEARCH
    I'll search for datasets matching: customer, datasets, PII
    [Go to Search →]
```

**Supported intents:**
- **SEARCH** — "Find", "Show", "List" queries → Routes to Search
- **LINEAGE** — "Upstream/downstream of X" → Routes to Lineage
- **QUALITY** — "Which datasets have low quality?" → Routes to Quality
- **COMPLIANCE** — "Show PII data", "GDPR datasets" → Filters by compliance tags
- **OWNERSHIP** — "Who owns the orders table?" → Shows owner info
- **EXPLAIN** — "What is CLV?" → Searches Glossary

### Smart Tag Suggestions

AI analyzes dataset content and recommends tags:

| Detection Type | Patterns | Suggested Tags |
|---------------|----------|----------------|
| **PII High** | `ssn`, `credit_card`, `password`, `api_key` | Restricted, Confidential |
| **PII Medium** | `email`, `phone`, `address`, `name`, `dob` | PII, GDPR |
| **PII Low** | `age`, `gender`, `ip_address`, `device_id` | Internal |
| **Financial** | `salary`, `revenue`, `price`, `payment` | Financial |
| **Healthcare** | `patient`, `diagnosis`, `prescription` | PHI, Healthcare |
| **Domain** | `customer`, `order`, `employee`, `product` | Customer, Financial, HR, Product |

### AI Insights Panel

Click the ✨ sparkle icon on any dataset to see:

- **Governance Risks** — Missing owner, no tags, sensitive data detected
- **Quality Issues** — Missing descriptions, undocumented columns, no primary key
- **Lineage Tips** — Missing audit timestamps, schema recommendations
- **Sensitivity Analysis** — High/Medium/Low sensitivity column detection

### Auto Description Generation

AI generates descriptions based on naming patterns:

| Pattern | Generated Description |
|---------|----------------------|
| `fact_*` | "Fact table containing quantitative business metrics." |
| `dim_*` | "Dimension table providing descriptive attributes for analysis." |
| `raw_*` | "Raw data table containing unprocessed source data." |
| `*_log` | "Log table capturing system or application events." |
| `created_at` | "Timestamp when the record was created" |
| `*_id` | "Foreign key reference" (or "Primary key identifier" if PK) |

### AI API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/ai/query` | Process a natural language query |
| `POST` | `/ai/chat` | Conversational AI chat with suggestions |
| `GET` | `/ai/insights/{datasetId}` | Get AI-generated insights for a dataset |
| `GET` | `/ai/suggest-tags/{datasetId}` | Get smart tag suggestions with confidence |
| `GET` | `/ai/generate-description/{datasetId}` | Generate AI description |
| `GET` | `/ai/suggest-column-descriptions/{datasetId}` | Get column description suggestions |

---

## 🛠 Tech Stack

### Backend

| Technology | Purpose |
|-----------|---------|
| **Java 17+** | Language (tested with OpenJDK 21) |
| **Spring Boot 3.2.5** | Application framework |
| **Spring Data JPA** | ORM and repository abstraction |
| **Spring Data Elasticsearch** | ES integration (prod profile) |
| **Spring Security** | Security framework (permit-all in dev, extensible for JWT/OAuth2) |
| **H2 Database** | In-memory database for development |
| **PostgreSQL 15** | Production relational database |
| **Elasticsearch 8.13** | Production search and indexing engine |
| **Lombok** | Boilerplate reduction |
| **MapStruct** | Entity ↔ DTO mapping (processor configured) |
| **SpringDoc OpenAPI 2.5** | Swagger UI and API documentation |
| **Maven** | Build tool and dependency management |

### Frontend

| Technology | Purpose |
|-----------|---------|
| **React 18** | UI framework |
| **TypeScript 5.4** | Type-safe JavaScript |
| **Vite 5** | Build tool and dev server |
| **Tailwind CSS 3.4** | Utility-first CSS framework |
| **React Router 6** | Client-side routing |
| **TanStack React Query 5** | Server state management and caching |
| **React Flow 11** | Interactive lineage graph visualization |
| **Axios** | HTTP client |
| **Lucide React** | Icon library |

### Infrastructure

| Technology | Purpose |
|-----------|---------|
| **Docker Compose** | Container orchestration for prod services |
| **PostgreSQL 15** | Persistent relational storage |
| **Elasticsearch 8.13** | Full-text search and indexing |
| **Kibana 8.13** | Elasticsearch monitoring and visualization |

---

## 📋 Prerequisites

| Tool | Version | Required For |
|------|---------|-------------|
| **JDK** | 17+ | Backend compilation and runtime |
| **Maven** | 3.9+ | Build and dependency management |
| **Node.js** | 18+ | Frontend development |
| **npm** | 9+ | Frontend package management |
| **Docker** | 20+ | Production infrastructure |
| **Docker Compose** | 2.0+ | Orchestrating PostgreSQL, ES, Kibana |

---

## 🚀 Quick Start — Development

### 1. Clone and build

```bash
git clone <repository-url>
cd metahub
mvn clean compile
```

### 2. Start the backend

```bash
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

The backend starts at **http://localhost:8080** with:
- **H2 in-memory database** — zero setup required
- **Seed data** — 3 users, 4 datasets, 4 tags, 3 data sources, schemas with columns, 3 lineage edges, 2 governance policies (all loaded from `data-dev.sql`)
- **Swagger UI** — http://localhost:8080/swagger-ui.html
- **H2 Console** — http://localhost:8080/h2-console
  - JDBC URL: `jdbc:h2:mem:metahub`
  - Username: `sa` / Password: *(empty)*

### 3. Start the frontend

```bash
cd frontend
npm install
npm run dev
```

The React app starts at **http://localhost:5173** and auto-proxies `/api` requests to the backend.

### 4. Verify

```bash
# Datasets API
curl http://localhost:8080/api/v1/datasets | python3 -m json.tool

# Search
curl "http://localhost:8080/api/v1/search?q=customer" | python3 -m json.tool

# Lineage graph
curl http://localhost:8080/api/v1/lineage/d1b2c3d4-0001-0001-0001-000000000002/graph | python3 -m json.tool

# Governance policies
curl http://localhost:8080/api/v1/governance/policies | python3 -m json.tool
```

---

## 🏭 Production Deployment

### 1. Start infrastructure services

```bash
docker-compose up -d
```

This launches:
- **PostgreSQL 15** on port `5432` (credentials: `metahub`/`metahub`)
- **Elasticsearch 8.13** on port `9200` (single-node, security disabled)
- **Kibana 8.13** on port `5601`

### 2. Start the backend with prod profile

```bash
mvn spring-boot:run -Dspring-boot.run.profiles=prod
```

Or with custom environment variables:

```bash
DB_HOST=localhost DB_PORT=5432 DB_NAME=metahub \
DB_USER=metahub DB_PASSWORD=metahub \
ES_URIS=http://localhost:9200 \
mvn spring-boot:run -Dspring-boot.run.profiles=prod
```

### 3. Build the frontend for production

```bash
cd frontend
npm run build
# Serve the dist/ folder with nginx or embed in Spring Boot's static resources
```

---

## 📡 API Reference

All endpoints are prefixed with `/api/v1`. Interactive documentation is available at `/swagger-ui.html`.

### Datasets

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/datasets` | List all datasets (paginated: `?page=0&size=20`) |
| `GET` | `/datasets/{id}` | Get dataset with schemas, columns, tags, and owner |
| `POST` | `/datasets` | Create a new dataset |
| `PUT` | `/datasets/{id}` | Update an existing dataset |
| `DELETE` | `/datasets/{id}` | Delete a dataset |
| `POST` | `/datasets/{id}/tags` | Add tags to a dataset |

### Search

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/search?q={query}&page=0&size=20` | Full-text search across dataset names, descriptions, and qualified names |

### Data Lineage

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/lineage` | Create a lineage edge (source → target) |
| `GET` | `/lineage/{datasetId}/graph` | Get full lineage DAG (BFS traversal in both directions) |
| `GET` | `/lineage/{datasetId}/upstream` | Get upstream lineage edges |
| `GET` | `/lineage/{datasetId}/downstream` | Get downstream lineage edges |
| `DELETE` | `/lineage/{id}` | Delete a lineage edge |

### Data Governance

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/governance/policies` | List all governance policies |
| `GET` | `/governance/policies/{id}` | Get policy details with attached datasets |
| `POST` | `/governance/policies` | Create a governance policy |
| `PUT` | `/governance/policies/{id}` | Update a governance policy |
| `POST` | `/governance/policies/{id}/attach` | Attach datasets to a policy |
| `POST` | `/governance/policies/{id}/detach` | Detach datasets from a policy |
| `DELETE` | `/governance/policies/{id}` | Delete a policy |

### Data Sources

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/datasources` | List all data sources |
| `GET` | `/datasources/{id}` | Get data source details |
| `POST` | `/datasources` | Register a new data source |
| `PUT` | `/datasources/{id}` | Update a data source |
| `DELETE` | `/datasources/{id}` | Delete a data source |
| `POST` | `/datasources/{id}/test-connection` | Test connectivity to a data source |

### Metadata Ingestion

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/ingestion/run/{dataSourceId}` | Trigger metadata ingestion for a data source |

### Tags

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/tags` | List all tags |
| `POST` | `/tags` | Create a tag |
| `DELETE` | `/tags/{id}` | Delete a tag |

### Users

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/users` | List all users |
| `GET` | `/users/{id}` | Get user details |
| `POST` | `/users` | Create a user |
| `PUT` | `/users/{id}` | Update a user |
| `DELETE` | `/users/{id}` | Delete a user |

### Data Quality

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/quality/scores` | List all quality scores (sorted by overall score) |
| `GET` | `/quality/scores/{datasetId}` | Get quality score for a specific dataset |
| `POST` | `/quality/compute` | Trigger manual recomputation of all quality scores |

### Audit Logs

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/audit-logs?entityType=Dataset&page=0&size=20` | List audit log entries (filterable by entity type) |

### Bookmarks

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/bookmarks?userId={uuid}&page=0&size=20` | List user's bookmarked datasets |
| `POST` | `/bookmarks` | Add a bookmark (body: `{userId, datasetId}`) |
| `DELETE` | `/bookmarks?userId={uuid}&datasetId={uuid}` | Remove a bookmark |
| `GET` | `/bookmarks/check?userId={uuid}&datasetId={uuid}` | Check if a dataset is bookmarked |

### Glossary

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/glossary?category={cat}&q={search}&page=0&size=20` | List glossary terms (filterable/searchable) |
| `GET` | `/glossary/{id}` | Get glossary term details with synonyms and related datasets |
| `POST` | `/glossary` | Create a glossary term |
| `PUT` | `/glossary/{id}` | Update a glossary term |
| `DELETE` | `/glossary/{id}` | Delete a glossary term |

### Dataset Comments

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/datasets/{datasetId}/comments?page=0&size=20` | List comments for a dataset |
| `POST` | `/datasets/{datasetId}/comments` | Add a comment (body: `{authorId, content}`) |
| `PUT` | `/datasets/{datasetId}/comments/{commentId}` | Update a comment |
| `DELETE` | `/datasets/{datasetId}/comments/{commentId}` | Delete a comment |

### AI Assistant

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/ai/query` | Process a natural language query and detect intent |
| `POST` | `/ai/chat` | Conversational AI chat with suggestions |
| `GET` | `/ai/insights/{datasetId}` | Get AI-generated insights (quality, governance, sensitivity) |
| `GET` | `/ai/suggest-tags/{datasetId}` | Get smart tag suggestions with confidence scores |
| `GET` | `/ai/generate-description/{datasetId}` | Generate AI description for a dataset |
| `GET` | `/ai/suggest-column-descriptions/{datasetId}` | Get AI-suggested column descriptions |

### Example: Create a Dataset

```bash
curl -X POST http://localhost:8080/api/v1/datasets \
  -H "Content-Type: application/json" \
  -d '{
    "name": "user_profiles",
    "qualifiedName": "warehouse.public.user_profiles",
    "description": "User profile data with email and preferences",
    "tagNames": ["PII", "Production"]
  }'
```

### Example: Add a Lineage Edge

```bash
curl -X POST http://localhost:8080/api/v1/lineage \
  -H "Content-Type: application/json" \
  -d '{
    "sourceDatasetId": "d1b2c3d4-0001-0001-0001-000000000001",
    "targetDatasetId": "d1b2c3d4-0001-0001-0001-000000000002",
    "transformationDescription": "Join on customer_id",
    "jobName": "etl-daily-pipeline"
  }'
```

---

## 🗂 Project Structure

```
metahub/
├── pom.xml                             # Maven build config (Spring Boot 3.2.5 parent)
├── docker-compose.yml                  # PostgreSQL + Elasticsearch + Kibana
├── README.md
├── .gitignore
│
├── src/main/java/com/metahub/
│   ├── MetahubApplication.java         # Entry point (ES auto-config excluded)
│   │
│   ├── config/                         # ── Configuration ──────────────────
│   │   ├── AuditingConfig.java         #    JPA auditing (createdAt/updatedAt)
│   │   ├── SecurityConfig.java         #    CORS, permit-all, H2 console support
│   │   ├── OpenApiConfig.java          #    Swagger/OpenAPI metadata
│   │   └── ElasticsearchConfig.java    #    ES repo scan (prod profile only)
│   │
│   ├── model/                          # ── Domain Entities ────────────────
│   │   ├── BaseEntity.java             #    UUID id, createdAt, updatedAt
│   │   ├── Dataset.java                #    Central entity (→ DataSource, User, Tags, Schemas)
│   │   ├── SchemaDefinition.java       #    Schema version (→ Dataset, Columns)
│   │   ├── ColumnDefinition.java       #    Column metadata (name, type, PK, nullable)
│   │   ├── DataSource.java             #    Connection config (JDBC/API/FS/Cloud)
│   │   ├── DataLineage.java            #    Lineage edge (source → target dataset)
│   │   ├── GovernancePolicy.java       #    Policy rules and status lifecycle
│   │   ├── Tag.java                    #    Classification labels
│   │   ├── User.java                   #    Platform users with roles
│   │   └── enums/
│   │       ├── DataSourceType.java     #    JDBC, API, FILE_SYSTEM, CLOUD_STORAGE
│   │       ├── PolicyStatus.java       #    DRAFT, ACTIVE, ARCHIVED
│   │       └── ColumnDataType.java     #    STRING, INTEGER, LONG, FLOAT, etc.
│   │
│   ├── document/
│   │   └── DatasetDocument.java        # ── Elasticsearch document ─────────
│   │
│   ├── dto/                            # ── Data Transfer Objects ──────────
│   │   ├── request/
│   │   │   ├── DatasetRequest.java
│   │   │   ├── DataSourceRequest.java
│   │   │   ├── GovernancePolicyRequest.java
│   │   │   ├── LineageRequest.java
│   │   │   └── SearchRequest.java
│   │   └── response/
│   │       ├── ApiResponse.java        #    Generic {success, message, data} wrapper
│   │       ├── PagedResponse.java      #    Paginated list response
│   │       ├── DatasetResponse.java    #    Dataset + nested Schema/Column DTOs
│   │       ├── GovernancePolicyResponse.java
│   │       ├── LineageGraphResponse.java   # Nodes + edges for DAG visualization
│   │       └── SearchResponse.java     #    Search hits with scores
│   │
│   ├── repository/                     # ── Data Access ────────────────────
│   │   ├── DatasetRepository.java      #    Custom: findByQualifiedName, searchByQuery
│   │   ├── SchemaRepository.java
│   │   ├── ColumnRepository.java
│   │   ├── DataSourceRepository.java
│   │   ├── DataLineageRepository.java  #    Custom: findBySource/Target, bidirectional
│   │   ├── GovernancePolicyRepository.java
│   │   ├── TagRepository.java          #    Custom: findByName, findByNameIn
│   │   ├── UserRepository.java
│   │   └── search/
│   │       └── DatasetSearchRepository.java  # ES repo (conditional on prod)
│   │
│   ├── mapper/
│   │   └── DatasetMapper.java          # ── Entity ↔ DTO Mapping ──────────
│   │
│   ├── service/                        # ── Business Logic ─────────────────
│   │   ├── DatasetService.java         #    CRUD, tag resolution, event publishing
│   │   ├── DataSourceService.java      #    CRUD + connection testing
│   │   ├── LineageService.java         #    BFS graph traversal, upstream/downstream
│   │   ├── GovernanceService.java      #    Policy CRUD, dataset attach/detach
│   │   ├── SearchService.java          #    JPA fallback search (dev), ES-ready
│   │   ├── TagService.java             #    Find-or-create semantics
│   │   ├── UserService.java            #    User CRUD
│   │   └── ingestion/                  # ── Metadata Ingestion ─────────────
│   │       ├── IngestionStrategy.java  #    Strategy interface
│   │       ├── IngestionOrchestrator.java  # Dispatches to correct strategy
│   │       ├── JdbcIngestionStrategy.java  # Real JDBC DatabaseMetaData extraction
│   │       ├── ApiIngestionStrategy.java   # Stub for REST API ingestion
│   │       ├── FileSystemIngestionStrategy.java  # Directory scanning
│   │       └── CloudStorageIngestionStrategy.java  # Stub for S3/GCS/Azure
│   │
│   ├── ai/                             # ── AI/ML Extensions ──────────────
│   │   ├── AutoTaggingService.java     #    Interface for tag suggestion
│   │   ├── RuleBasedAutoTaggingService.java  # Regex/keyword-based impl
│   │   ├── AnomalyDetectionService.java     # Interface for anomaly detection
│   │   ├── StubAnomalyDetectionService.java # No-op placeholder
│   │   ├── AIAssistantService.java     #    ◀── NEW: Core AI service
│   │   │   ├── NL Query Processing     #    Intent detection, entity extraction
│   │   │   ├── Smart Tag Suggestions   #    Confidence-scored recommendations
│   │   │   ├── Sensitivity Detection   #    PII/Financial/Healthcare patterns
│   │   │   └── Auto Descriptions       #    Schema-based generation
│   │   └── AIInsight.java              #    ◀── NEW: Insight data model
│   │
│   ├── event/                          # ── Event-Driven Sync ──────────────
│   │   ├── MetadataChangeEvent.java    #    CREATED/UPDATED/DELETED events
│   │   └── MetadataEventListener.java  #    Syncs Dataset → ES index (prod only)
│   │
│   ├── controller/                     # ── REST API Layer ─────────────────
│   │   ├── DatasetController.java      #    /api/v1/datasets
│   │   ├── DataSourceController.java   #    /api/v1/datasources
│   │   ├── IngestionController.java    #    /api/v1/ingestion
│   │   ├── LineageController.java      #    /api/v1/lineage
│   │   ├── GovernanceController.java   #    /api/v1/governance/policies
│   │   ├── SearchController.java       #    /api/v1/search
│   │   ├── TagController.java          #    /api/v1/tags
│   │   ├── UserController.java         #    /api/v1/users
│   │   └── AIController.java           #    /api/v1/ai ◀── NEW
│   │
│   └── exception/                      # ── Error Handling ─────────────────
│       ├── GlobalExceptionHandler.java #    @RestControllerAdvice
│       ├── ResourceNotFoundException.java
│       └── IngestionException.java
│
├── src/main/resources/
│   ├── application.yml                 # Common: port 8080, Jackson, logging
│   ├── application-dev.yml             # H2, ddl-auto:create-drop, seed SQL
│   ├── application-prod.yml            # PostgreSQL + ES (env-var driven)
│   └── data-dev.sql                    # Seed data (users, tags, sources, datasets, lineage, policies)
│
├── src/test/
│   ├── java/com/metahub/
│   │   ├── MetahubApplicationTests.java          # Context load test
│   │   ├── controller/DatasetControllerTest.java  # MockMvc integration tests
│   │   ├── service/DatasetServiceTest.java        # Service layer tests
│   │   └── repository/DatasetRepositoryTest.java  # @DataJpaTest repository tests
│   └── resources/
│       └── application-test.yml                   # H2 test config
│
└── frontend/                           # ── React Frontend ─────────────────
    ├── package.json                    #    Dependencies and scripts
    ├── tsconfig.json                   #    TypeScript configuration
    ├── vite.config.ts                  #    Vite + API proxy to :8080
    ├── tailwind.config.js              #    Tailwind CSS setup
    ├── postcss.config.js
    ├── index.html                      #    HTML entry point
    └── src/
        ├── main.tsx                    #    App bootstrap (React Query, Router)
        ├── App.tsx                     #    Route definitions
        ├── styles/global.css           #    Tailwind directives
        ├── types/index.ts              #    TypeScript interfaces (mirrors DTOs)
        ├── api/                        # ── API Client Layer ───────────────
        │   ├── client.ts              #    Axios instance with interceptors
        │   ├── datasets.ts            #    Dataset API calls
        │   ├── search.ts             #    Search API calls
        │   ├── lineage.ts            #    Lineage API calls
        │   └── ai.ts                 #    AI API calls ◀── NEW
        ├── components/                 # ── Reusable Components ────────────
        │   ├── Layout.tsx             #    Sidebar + main content + AI Assistant
        │   ├── Navbar.tsx             #    Navigation sidebar with icons
        │   ├── ai/                    #    ◀── NEW AI Components
        │   │   ├── AIAssistant.tsx    #    Floating chat assistant
        │   │   └── AIInsightsPanel.tsx #   Dataset insights panel
        │   ├── catalog/
        │   │   ├── DatasetList.tsx     #    Paginated dataset cards
        │   │   ├── DatasetDetail.tsx   #    Dataset detail panel + AI toggle
        │   │   └── SchemaViewer.tsx    #    Column table viewer
        │   ├── search/
        │   │   ├── SearchBar.tsx       #    Search input with submit
        │   │   └── SearchResults.tsx   #    Search hit cards
        │   ├── lineage/
        │   │   └── LineageGraph.tsx    #    React Flow DAG visualization
        │   └── governance/
        │       ├── PolicyList.tsx      #    Policy cards with status badges
        │       └── PolicyDetail.tsx    #    Policy detail with rules viewer
        └── pages/                      # ── Page Components ────────────────
            ├── DashboardPage.tsx       #    Stats cards + AI banner + guide
            ├── CatalogPage.tsx         #    Dataset list + detail panel
            ├── SearchPage.tsx          #    AI-enhanced search + results
            ├── LineagePage.tsx         #    Dataset selector + React Flow graph
            ├── GovernancePage.tsx      #    Policy list + detail panel
            └── GuidePage.tsx           #    User guide ◀── NEW
```

**File counts**: 75 Java source files · 4 test files · 28 TypeScript/TSX files · 125 total files

---

## 📐 Domain Model

```
<img width="641" height="573" alt="image" src="https://github.com/user-attachments/assets/a85b8ad8-147b-4ab5-bf04-9cc9af8c3aa7" />

```

### Enumerations

| Enum | Values |
|------|--------|
| `DataSourceType` | `JDBC`, `API`, `FILE_SYSTEM`, `CLOUD_STORAGE` |
| `PolicyStatus` | `DRAFT`, `ACTIVE`, `ARCHIVED` |
| `ColumnDataType` | `STRING`, `INTEGER`, `LONG`, `FLOAT`, `DOUBLE`, `BOOLEAN`, `DATE`, `TIMESTAMP`, `BINARY`, `JSON`, `UNKNOWN` |

---

## 📥 Metadata Ingestion

MetaHub uses the **Strategy pattern** to ingest metadata from heterogeneous data sources:

| Strategy | Type | Implementation |
|----------|------|----------------|
| `JdbcIngestionStrategy` | `JDBC` | **Fully implemented** — Uses `java.sql.DatabaseMetaData` to extract tables, columns, primary keys, and data types |
| `FileSystemIngestionStrategy` | `FILE_SYSTEM` | **Implemented** — Walks directory trees (depth 2) and creates dataset entries for each file |
| `ApiIngestionStrategy` | `API` | **Stub** — Ready for external metadata API integration |
| `CloudStorageIngestionStrategy` | `CLOUD_STORAGE` | **Stub** — Ready for AWS S3 / GCS / Azure Blob SDK integration |

### How It Works

1. Register a `DataSource` with type and connection URL
2. Call `POST /api/v1/ingestion/run/{dataSourceId}`
3. The `IngestionOrchestrator` selects the matching strategy
4. Metadata is extracted, mapped to `Dataset` → `SchemaDefinition` → `ColumnDefinition`
5. Results are persisted (upserted by `qualifiedName`)
6. `MetadataChangeEvent` is published for Elasticsearch synchronization

```bash
# Example: Register a JDBC data source and ingest
curl -X POST http://localhost:8080/api/v1/datasources \
  -H "Content-Type: application/json" \
  -d '{"name":"My DB","type":"JDBC","connectionUrl":"jdbc:h2:mem:metahub","description":"Dev database"}'

# Then trigger ingestion with the returned ID
curl -X POST http://localhost:8080/api/v1/ingestion/run/{dataSourceId}
```

---

## 🤖 AI/ML Extension Points

MetaHub provides a comprehensive AI layer with built-in implementations and extension points for custom ML models.

### AI Assistant Service

The `AIAssistantService` is the core AI engine providing:

```java
@Service
public class AIAssistantService {
    // Natural Language Query Processing
    public NLQueryResult processNaturalLanguageQuery(String query);
    
    // Smart Tag Suggestions with confidence scores
    public List<TagSuggestion> suggestTags(Dataset dataset);
    
    // AI-generated descriptions from schema patterns
    public String generateDescription(Dataset dataset);
    
    // Column description suggestions
    public Map<String, String> suggestColumnDescriptions(Dataset dataset);
    
    // Dataset analysis for insights
    public List<AIInsight> analyzeDataset(Dataset dataset);
}
```

### Sensitivity Detection

Built-in pattern matching for sensitive data:

| Sensitivity Level | Patterns | Example Columns |
|-------------------|----------|-----------------|
| **PII_HIGH** | `ssn`, `credit_card`, `password`, `api_key`, `passport` | `social_security_num`, `card_number` |
| **PII_MEDIUM** | `email`, `phone`, `address`, `name`, `dob`, `birth` | `customer_email`, `billing_address` |
| **PII_LOW** | `age`, `gender`, `ip_address`, `device_id` | `user_age`, `visitor_ip` |
| **FINANCIAL** | `salary`, `revenue`, `price`, `balance`, `tax` | `gross_salary`, `account_balance` |
| **HEALTHCARE** | `patient`, `diagnosis`, `prescription`, `medical` | `patient_id`, `diagnosis_code` |

### Auto-Tagging

The `AutoTaggingService` interface provides an extension point for intelligent tag suggestion:

```java
public interface AutoTaggingService {
    List<Tag> suggestTags(Dataset dataset);
}
```

**Built-in implementation**: `RuleBasedAutoTaggingService` applies regex patterns to column names and descriptions:

| Tag | Pattern | Example Matches |
|-----|---------|-----------------|
| PII | `email`, `phone`, `ssn`, `address`, `dob` | `customer_email`, `phone_number` |
| Financial | `price`, `amount`, `balance`, `salary` | `order_amount`, `account_balance` |
| Temporal | `date`, `time`, `timestamp`, `created_at` | `updated_at`, `expire_date` |
| Geographic | `country`, `city`, `state`, `latitude` | `shipping_country`, `zip_code` |
| Healthcare | `patient`, `diagnosis`, `prescription` | `patient_id`, `treatment_code` |

**To integrate a real ML model**: Create a new implementation of `AutoTaggingService` that calls your model (e.g., a Python microservice via REST, or a local ONNX model).

### Anomaly Detection

```java
public interface AnomalyDetectionService {
    List<Anomaly> detect(Dataset dataset);
}
```

The `Anomaly` record contains `type`, `description`, `severity` (LOW/MEDIUM/HIGH), and `detectedAt`. A no-op `StubAnomalyDetectionService` is provided. Replace it with integrations to:

- **Schema drift detection** — Compare schema versions over time
- **Data quality monitoring** — Connect to profiling tools
- **Usage anomalies** — Track unusual query patterns via external services

### LLM Integration Points

The AI architecture is designed for easy LLM integration:

```java
// Example: Extend AIAssistantService for LLM-based features
@Service
@Profile("llm")
public class LLMAssistantService extends AIAssistantService {
    
    @Value("${openai.api.key}")
    private String apiKey;
    
    @Override
    public String generateDescription(Dataset dataset) {
        // Call OpenAI/Claude/Llama API
        return callLLM(buildPrompt(dataset));
    }
}
```

**Suggested integrations:**
- **OpenAI GPT-4** — Advanced description generation, SQL query explanation
- **Sentence Transformers** — Semantic search via embeddings
- **Hugging Face Models** — Custom NER for entity extraction
- **LangChain** — Complex agentic workflows for metadata discovery

---

## 🧪 Testing

```bash
# Run all tests
mvn test

# Run a specific test class
mvn test -Dtest=DatasetControllerTest

# Run with verbose output
mvn test -e
```

### Test Suite (8 tests — all passing ✅)

| Test Class | Tests | Type | Description |
|-----------|-------|------|-------------|
| `MetahubApplicationTests` | 1 | Integration | Verifies Spring context loads successfully |
| `DatasetControllerTest` | 3 | MockMvc | CRUD operations, pagination, 404 handling |
| `DatasetServiceTest` | 2 | Service | Tag resolution, pagination logic |
| `DatasetRepositoryTest` | 2 | @DataJpaTest | `findByQualifiedName`, `searchByQuery` |

### Test Configuration

Tests use the `test` profile (`application-test.yml`) with:
- H2 in-memory database
- JPA `ddl-auto: create-drop`
- Elasticsearch disabled
- SQL init disabled (no seed data)

---

## ⚙ Configuration Reference

### Profiles

| Profile | Database | Search | ES Sync | SQL Seed |
|---------|----------|--------|---------|----------|
| `dev` | H2 (in-memory) | JPA LIKE queries | Disabled | `data-dev.sql` loaded |
| `prod` | PostgreSQL | Elasticsearch | Enabled via events | Not loaded |
| `test` | H2 (in-memory) | JPA LIKE queries | Disabled | Not loaded |

### Environment Variables (prod)

| Variable | Default | Description |
|----------|---------|-------------|
| `DB_HOST` | `localhost` | PostgreSQL host |
| `DB_PORT` | `5432` | PostgreSQL port |
| `DB_NAME` | `metahub` | Database name |
| `DB_USER` | `metahub` | Database username |
| `DB_PASSWORD` | `metahub` | Database password |
| `ES_URIS` | `http://localhost:9200` | Elasticsearch cluster URIs |

### Key Properties

| Property | Dev | Prod | Description |
|----------|-----|------|-------------|
| `server.port` | `8080` | `8080` | HTTP server port |
| `spring.jpa.hibernate.ddl-auto` | `create-drop` | `validate` | DDL strategy |
| `spring.jpa.show-sql` | `true` | `false` | SQL logging |
| `metahub.search.engine` | `jpa` | `elasticsearch` | Search backend |
| `spring.h2.console.enabled` | `true` | N/A | H2 web console |

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m "feat: add new ingestion strategy"`
4. Push to the branch: `git push origin feature/my-feature`
5. Open a Pull Request

### Code Conventions

- **Java** — Follow standard Spring Boot conventions; use Lombok `@Builder` for entities and DTOs
- **Frontend** — TypeScript strict mode; functional components with hooks
- **API** — All responses wrapped in `ApiResponse<T>`; use proper HTTP status codes
- **Tests** — Every new feature should include at least one integration test

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

<p align="center">
  Built with ☕ Java + ⚛ React · <strong>MetaHub v0.1.0</strong>
</p>

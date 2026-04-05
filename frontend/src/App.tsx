import { Routes, Route } from 'react-router-dom';
import Layout from './components/Layout';
import DashboardPage from './pages/DashboardPage';
import CatalogPage from './pages/CatalogPage';
import SearchPage from './pages/SearchPage';
import LineagePage from './pages/LineagePage';
import GovernancePage from './pages/GovernancePage';
import QualityPage from './pages/QualityPage';
import ActivityPage from './pages/ActivityPage';
import GlossaryPage from './pages/GlossaryPage';
import GuidePage from './pages/GuidePage';

export default function App() {
  return (
    <Layout>
      <Routes>
        <Route path="/" element={<DashboardPage />} />
        <Route path="/catalog" element={<CatalogPage />} />
        <Route path="/search" element={<SearchPage />} />
        <Route path="/lineage" element={<LineagePage />} />
        <Route path="/lineage/:datasetId" element={<LineagePage />} />
        <Route path="/governance" element={<GovernancePage />} />
        <Route path="/quality" element={<QualityPage />} />
        <Route path="/activity" element={<ActivityPage />} />
        <Route path="/glossary" element={<GlossaryPage />} />
        <Route path="/guide" element={<GuidePage />} />
      </Routes>
    </Layout>
  );
}


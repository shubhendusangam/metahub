import { NavLink } from 'react-router-dom';
import {
  LayoutDashboard,
  Database,
  Search,
  GitBranch,
  Shield,
  BarChart3,
  Activity,
  BookOpen,
  HelpCircle,
} from 'lucide-react';

const navItems = [
  { to: '/', label: 'Dashboard', icon: LayoutDashboard },
  { to: '/catalog', label: 'Catalog', icon: Database },
  { to: '/search', label: 'Search', icon: Search },
  { to: '/lineage', label: 'Lineage', icon: GitBranch },
  { to: '/governance', label: 'Governance', icon: Shield },
  { to: '/quality', label: 'Quality', icon: BarChart3 },
  { to: '/activity', label: 'Activity', icon: Activity },
  { to: '/glossary', label: 'Glossary', icon: BookOpen },
  { to: '/guide', label: 'User Guide', icon: HelpCircle },
];

export default function Navbar() {
  return (
    <nav className="bg-gray-900 text-white w-64 min-h-screen p-4 flex flex-col">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-blue-400">⬡ MetaHub</h1>
        <p className="text-xs text-gray-400 mt-1">Unified Metadata Platform</p>
      </div>

      <ul className="space-y-1 flex-1">
        {navItems.map(({ to, label, icon: Icon }) => (
          <li key={to}>
            <NavLink
              to={to}
              end={to === '/'}
              className={({ isActive }) =>
                `flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors ${
                  isActive
                    ? 'bg-blue-600 text-white'
                    : 'text-gray-300 hover:bg-gray-800 hover:text-white'
                }`
              }
            >
              <Icon size={18} />
              {label}
            </NavLink>
          </li>
        ))}
      </ul>

      <div className="text-xs text-gray-500 mt-4">v0.1.0</div>
    </nav>
  );
}


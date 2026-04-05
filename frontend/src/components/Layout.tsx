import { ReactNode } from 'react';
import Navbar from './Navbar';
import AIAssistant from './ai/AIAssistant';

export default function Layout({ children }: { children: ReactNode }) {
  return (
    <div className="flex min-h-screen">
      <Navbar />
      <main className="flex-1 p-6 overflow-auto">{children}</main>
      <AIAssistant />
    </div>
  );
}


import { useState, useRef, useEffect } from 'react';
import { useMutation } from '@tanstack/react-query';
import { chat, ChatResponse } from '../../api/ai';
import { search } from '../../api/search';
import type { SearchHit } from '../../types';
import {
  MessageSquare,
  Send,
  X,
  Bot,
  User,
  Sparkles,
  Search,
  GitBranch,
  Shield,
  BarChart3,
  Loader2,
  Database,
} from 'lucide-react';
import { Link } from 'react-router-dom';

interface Message {
  id: string;
  role: 'user' | 'assistant';
  content: string;
  suggestions?: string[];
  intent?: string;
  searchTerms?: string[];
  searchResults?: SearchHit[];
}

export default function AIAssistant() {
  const [isOpen, setIsOpen] = useState(false);
  const [messages, setMessages] = useState<Message[]>([
    {
      id: '0',
      role: 'assistant',
      content: "Hi! I'm your MetaHub AI assistant. Ask me about datasets, lineage, data quality, or compliance. Try:\n\n• \"Find customer datasets\"\n• \"Show PII data\"\n• \"What is the lineage of orders?\"\n• \"Which datasets have low quality?\"",
      suggestions: ['Find customer datasets', 'Show PII data', 'Data quality issues'],
    },
  ]);
  const [input, setInput] = useState('');
  const messagesEndRef = useRef<HTMLDivElement>(null);

  const chatMutation = useMutation({
    mutationFn: async (message: string) => {
      const chatResponse = await chat(message);
      const data = chatResponse.data.data as ChatResponse;

      // If the intent is SEARCH, automatically perform the search
      let searchResults: SearchHit[] | undefined;
      if (data.intent === 'SEARCH' && data.searchTerms && data.searchTerms.length > 0) {
        try {
          const query = data.searchTerms.join(' ');
          const searchResponse = await search(query);
          if (searchResponse.data.success && searchResponse.data.data.hits) {
            searchResults = searchResponse.data.data.hits.slice(0, 5); // Show top 5 results
          }
        } catch (e) {
          console.error('Search failed:', e);
        }
      }

      return { chatData: data, searchResults };
    },
    onSuccess: ({ chatData, searchResults }) => {
      let content = chatData.message;
      if (searchResults && searchResults.length > 0) {
        content = `Found ${searchResults.length} relevant datasets:`;
      } else if (chatData.intent === 'SEARCH' && (!searchResults || searchResults.length === 0)) {
        content = `No datasets found matching your query. Try different keywords.`;
      }

      setMessages((prev) => [
        ...prev,
        {
          id: Date.now().toString(),
          role: 'assistant',
          content,
          suggestions: chatData.suggestions,
          intent: chatData.intent,
          searchTerms: chatData.searchTerms,
          searchResults,
        },
      ]);
    },
    onError: () => {
      setMessages((prev) => [
        ...prev,
        {
          id: Date.now().toString(),
          role: 'assistant',
          content: "Sorry, I couldn't process that request. Please try again.",
        },
      ]);
    },
  });

  const handleSend = () => {
    if (!input.trim() || chatMutation.isPending) return;

    const userMessage: Message = {
      id: Date.now().toString(),
      role: 'user',
      content: input.trim(),
    };

    setMessages((prev) => [...prev, userMessage]);
    chatMutation.mutate(input.trim());
    setInput('');
  };

  const handleSuggestionClick = (suggestion: string) => {
    setInput(suggestion);
    // Auto-send after a brief delay
    setTimeout(() => {
      const userMessage: Message = {
        id: Date.now().toString(),
        role: 'user',
        content: suggestion,
      };
      setMessages((prev) => [...prev, userMessage]);
      chatMutation.mutate(suggestion);
      setInput('');
    }, 100);
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      handleSend();
    }
  };

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  const getIntentIcon = (intent?: string) => {
    switch (intent) {
      case 'SEARCH':
        return <Search size={14} className="text-purple-500" />;
      case 'LINEAGE':
        return <GitBranch size={14} className="text-indigo-500" />;
      case 'COMPLIANCE':
        return <Shield size={14} className="text-orange-500" />;
      case 'QUALITY':
        return <BarChart3 size={14} className="text-emerald-500" />;
      default:
        return <Sparkles size={14} className="text-blue-500" />;
    }
  };

  const getIntentAction = (intent?: string, searchTerms?: string[]) => {
    const query = searchTerms?.join(' ') || '';
    switch (intent) {
      case 'SEARCH':
        return { to: `/search?q=${encodeURIComponent(query)}`, label: 'Go to Search' };
      case 'LINEAGE':
        return { to: '/lineage', label: 'View Lineage' };
      case 'COMPLIANCE':
        return { to: '/governance', label: 'View Governance' };
      case 'QUALITY':
        return { to: '/quality', label: 'View Quality' };
      default:
        return null;
    }
  };

  return (
    <>
      {/* Floating Button */}
      <button
        onClick={() => setIsOpen(true)}
        className={`fixed bottom-6 right-6 z-50 p-4 rounded-full shadow-lg transition-all duration-300 ${
          isOpen ? 'scale-0 opacity-0' : 'scale-100 opacity-100'
        } bg-gradient-to-r from-blue-600 to-indigo-600 text-white hover:shadow-xl hover:scale-110`}
        title="AI Assistant"
      >
        <Bot size={24} />
      </button>

      {/* Chat Panel */}
      <div
        className={`fixed bottom-6 right-6 z-50 w-96 bg-white rounded-2xl shadow-2xl border border-gray-200 transition-all duration-300 ${
          isOpen ? 'scale-100 opacity-100' : 'scale-0 opacity-0 pointer-events-none'
        }`}
        style={{ maxHeight: 'calc(100vh - 100px)' }}
      >
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-t-2xl">
          <div className="flex items-center gap-2">
            <div className="p-1.5 bg-white/20 rounded-lg">
              <Bot size={20} />
            </div>
            <div>
              <h3 className="font-semibold text-sm">MetaHub AI</h3>
              <p className="text-xs text-blue-100">Ask me anything about your data</p>
            </div>
          </div>
          <button
            onClick={() => setIsOpen(false)}
            className="p-1 hover:bg-white/20 rounded-lg transition-colors"
          >
            <X size={18} />
          </button>
        </div>

        {/* Messages */}
        <div className="h-80 overflow-y-auto p-4 space-y-4 bg-gray-50">
          {messages.map((msg) => (
            <div
              key={msg.id}
              className={`flex gap-2 ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}
            >
              {msg.role === 'assistant' && (
                <div className="w-7 h-7 rounded-full bg-gradient-to-r from-blue-500 to-indigo-500 flex items-center justify-center flex-shrink-0">
                  <Bot size={14} className="text-white" />
                </div>
              )}
              <div
                className={`max-w-[80%] rounded-2xl px-4 py-2.5 ${
                  msg.role === 'user'
                    ? 'bg-blue-600 text-white rounded-br-md'
                    : 'bg-white border border-gray-200 text-gray-800 rounded-bl-md shadow-sm'
                }`}
              >
                <p className="text-sm whitespace-pre-wrap">{msg.content}</p>

                {/* Search Results */}
                {msg.searchResults && msg.searchResults.length > 0 && (
                  <div className="mt-3 space-y-2">
                    {msg.searchResults.map((hit) => (
                      <Link
                        key={hit.id}
                        to={`/catalog?dataset=${hit.id}`}
                        className="block p-2 bg-gray-50 rounded-lg hover:bg-blue-50 border border-gray-200 hover:border-blue-300 transition-colors"
                      >
                        <div className="flex items-start gap-2">
                          <Database size={14} className="text-blue-500 mt-0.5 flex-shrink-0" />
                          <div className="min-w-0">
                            <p className="text-sm font-medium text-gray-900 truncate">{hit.name}</p>
                            <p className="text-xs text-gray-500 truncate">{hit.qualifiedName}</p>
                            {hit.tags && hit.tags.length > 0 && (
                              <div className="flex flex-wrap gap-1 mt-1">
                                {hit.tags.slice(0, 3).map((tag) => (
                                  <span key={tag} className="text-xs bg-blue-100 text-blue-700 px-1.5 py-0.5 rounded">
                                    {tag}
                                  </span>
                                ))}
                              </div>
                            )}
                          </div>
                        </div>
                      </Link>
                    ))}
                  </div>
                )}

                {/* Intent badge */}
                {msg.intent && msg.role === 'assistant' && (
                  <div className="mt-2 flex items-center gap-1 text-xs text-gray-500">
                    {getIntentIcon(msg.intent)}
                    <span>Intent: {msg.intent}</span>
                    {(() => {
                      const action = getIntentAction(msg.intent, msg.searchTerms);
                      return action ? (
                        <Link
                          to={action.to}
                          className="ml-2 text-blue-600 hover:text-blue-800 underline"
                        >
                          {action.label} →
                        </Link>
                      ) : null;
                    })()}
                  </div>
                )}

                {/* Suggestions */}
                {msg.suggestions && msg.suggestions.length > 0 && (
                  <div className="mt-3 flex flex-wrap gap-1.5">
                    {msg.suggestions.map((suggestion, idx) => (
                      <button
                        key={idx}
                        onClick={() => handleSuggestionClick(suggestion)}
                        className="text-xs bg-blue-50 text-blue-700 px-2.5 py-1 rounded-full hover:bg-blue-100 transition-colors border border-blue-200"
                      >
                        {suggestion}
                      </button>
                    ))}
                  </div>
                )}
              </div>
              {msg.role === 'user' && (
                <div className="w-7 h-7 rounded-full bg-gray-300 flex items-center justify-center flex-shrink-0">
                  <User size={14} className="text-gray-600" />
                </div>
              )}
            </div>
          ))}

          {chatMutation.isPending && (
            <div className="flex gap-2 justify-start">
              <div className="w-7 h-7 rounded-full bg-gradient-to-r from-blue-500 to-indigo-500 flex items-center justify-center">
                <Bot size={14} className="text-white" />
              </div>
              <div className="bg-white border border-gray-200 rounded-2xl rounded-bl-md px-4 py-3 shadow-sm">
                <Loader2 size={16} className="animate-spin text-blue-500" />
              </div>
            </div>
          )}

          <div ref={messagesEndRef} />
        </div>

        {/* Input */}
        <div className="p-4 border-t bg-white rounded-b-2xl">
          <div className="flex items-center gap-2">
            <input
              type="text"
              value={input}
              onChange={(e) => setInput(e.target.value)}
              onKeyDown={handleKeyDown}
              placeholder="Ask about your data..."
              className="flex-1 px-4 py-2.5 border border-gray-300 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              disabled={chatMutation.isPending}
            />
            <button
              onClick={handleSend}
              disabled={!input.trim() || chatMutation.isPending}
              className="p-2.5 bg-blue-600 text-white rounded-xl hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            >
              <Send size={18} />
            </button>
          </div>
          <p className="text-xs text-gray-400 mt-2 text-center">
            Powered by MetaHub AI • <MessageSquare size={10} className="inline" /> Natural language search
          </p>
        </div>
      </div>
    </>
  );
}


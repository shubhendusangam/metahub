interface TagBadgeProps {
  tag: string;
  variant?: 'default' | 'primary' | 'success' | 'warning' | 'danger';
  size?: 'sm' | 'md';
  onClick?: () => void;
  removable?: boolean;
  onRemove?: () => void;
}

const variantStyles = {
  default: 'bg-gray-100 text-gray-700',
  primary: 'bg-blue-50 text-blue-700',
  success: 'bg-green-50 text-green-700',
  warning: 'bg-yellow-50 text-yellow-700',
  danger: 'bg-red-50 text-red-700',
};

const sizeStyles = {
  sm: 'text-xs px-2 py-0.5',
  md: 'text-sm px-2.5 py-1',
};

export default function TagBadge({
  tag,
  variant = 'primary',
  size = 'sm',
  onClick,
  removable,
  onRemove,
}: TagBadgeProps) {
  const baseClasses = `inline-flex items-center gap-1 rounded-full font-medium ${variantStyles[variant]} ${sizeStyles[size]}`;

  return (
    <span
      className={`${baseClasses} ${onClick ? 'cursor-pointer hover:opacity-80' : ''}`}
      onClick={onClick}
    >
      {tag}
      {removable && (
        <button
          onClick={(e) => {
            e.stopPropagation();
            onRemove?.();
          }}
          className="ml-0.5 hover:text-red-500 transition-colors"
          aria-label={`Remove ${tag}`}
        >
          ×
        </button>
      )}
    </span>
  );
}

interface TagListProps {
  tags: string[];
  variant?: TagBadgeProps['variant'];
  size?: TagBadgeProps['size'];
  maxVisible?: number;
  className?: string;
}

export function TagList({
  tags,
  variant = 'primary',
  size = 'sm',
  maxVisible,
  className = '',
}: TagListProps) {
  const displayTags = maxVisible ? tags.slice(0, maxVisible) : tags;
  const hiddenCount = maxVisible ? Math.max(0, tags.length - maxVisible) : 0;

  if (tags.length === 0) return null;

  return (
    <div className={`flex flex-wrap gap-1 ${className}`}>
      {displayTags.map((tag) => (
        <TagBadge key={tag} tag={tag} variant={variant} size={size} />
      ))}
      {hiddenCount > 0 && (
        <span className="text-xs text-gray-500 px-2 py-0.5">
          +{hiddenCount} more
        </span>
      )}
    </div>
  );
}


---
paths:
  - "**/*.tsx"
  - "**/*.jsx"
---
# React Coding Style

> This file extends [common/coding-style.md](../common/coding-style.md) with React-specific content.

## Component Structure

### Split Component + Styles + Utilities

```tsx
// user-profile.tsx
import { useState } from 'react'
import type { User } from '../types/user'
import { formatUser } from '../utils/string-utils'
import './user-profile.scss'

interface UserProfileProps {
  user: User
  onEdit: (id: string) => void
}

export function UserProfile({ user, onEdit }: UserProfileProps) {
  return (
    <div className="user-profile">
      <h1>{formatUser(user)}</h1>
      <button onClick={() => onEdit(user.id)}>Edit</button>
    </div>
  )
}
```

### File Splitting

- Component logic in `.tsx`
- Styles in `.scss` (co-located, same directory)
- Component-specific utilities in separate `.ts` file
- Tests in `__tests__/` at project root

## Hooks Usage

### Custom Hooks

- Always use `use` prefix: `useAuth`, `useDebounce`
- Keep hooks focused on a single concern
- Return consistent shape: data + actions

```tsx
// WRONG: Hook does too much
function useUserProfile(id: string) {
  const [user, setUser] = useState()
  const [posts, setPosts] = useState()
  const [comments, setComments] = useState()
  const [settings, setSettings] = useState()
  // fetches all in one hook
  return { user, posts, comments, settings, ...actions }
}

// CORRECT: Focused hooks
function useUser(id: string) { ... }
function useUserPosts(userId: string) { ... }
```

### Rules

- Only call hooks at the top level
- Only call hooks from React function components or other hooks
- Do not use hooks for side effects that should be in event handlers

## Error Boundary

Every React application must have an Error Boundary:

```tsx
class ErrorBoundary extends React.Component<
  { children: React.ReactNode; fallback?: React.ReactNode },
  { hasError: boolean; error: Error | null }
> {
  constructor(props: { children: React.ReactNode; fallback?: React.ReactNode }) {
    super(props)
    this.state = { hasError: false, error: null }
  }

  static getDerivedStateFromError(error: Error) {
    return { hasError: true, error }
  }

  render() {
    if (this.state.hasError) {
      return (
        this.props.fallback ?? (
          <div role="alert">
            <h2>Something went wrong</h2>
            <p>Please try refreshing the page. If the problem persists, contact support.</p>
          </div>
        )
      )
    }
    return this.props.children
  }
}

// Usage
<ErrorBoundary>
  <App />
</ErrorBoundary>
```

## Props

- Define props with a named `interface` or `type`
- Type callback props explicitly
- Do not use `React.FC` unless there is a specific reason

```tsx
interface UserCardProps {
  user: User
  onSelect: (id: string) => void
}

function UserCard({ user, onSelect }: UserCardProps) {
  return <button onClick={() => onSelect(user.id)}>{user.email}</button>
}
```

## State Management

- Use `useState` for local component state
- Use React Context for shared state across the component tree
- Use React Query/SWR for server state (data fetching)
- Do not duplicate server state into local stores

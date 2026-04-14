---
paths:
  - "**/*.ts"
  - "**/*.tsx"
  - "**/*.js"
  - "**/*.jsx"
---
# TypeScript Coding Style

> This file extends [common/coding-style.md](../common/coding-style.md) with TypeScript-specific content.

## Import Order

Imports MUST follow this exact order, separated by blank lines:

1. **Core framework libraries** (react, vue, etc.)
2. **Third-party libraries** (lodash, axios, etc.)
3. **Internal modules** — sorted by path distance (nearest first):
   - Sibling directory imports (`./`)
   - Parent directory imports (`../`)
   - Deeper parent directory (`../../`, etc.)
4. **Type imports** (if using `import type`)
5. **CSS/SCSS imports**

```typescript
// CORRECT: Proper import order
import React, { useState, useMemo } from 'react'
import { Route } from 'react-router-dom'

import { format, parseISO } from 'date-fns'
import axios from 'axios'

import { UserCard } from './user-card'
import { formatDate } from '../utils/date-utils'
import { api } from '../../api/client'

import type { User, UserProfile } from '../types/user'

import './user-profile.scss'
```

```typescript
// WRONG: Random order
import { UserCard } from './user-card'
import React from 'react'
import './user-profile.scss'
import axios from 'axios'
import type { User } from '../types/user'
import { formatDate } from '../utils/date-utils'
```

## Types and Interfaces

### Public APIs

Add explicit types to exported functions, shared utilities, and public methods. Let TypeScript infer local variable types.

```typescript
// WRONG: No types on exported function
export function formatUser(user) {
  return `${user.firstName} ${user.lastName}`
}

// CORRECT: Explicit types on public APIs
interface User {
  firstName: string
  lastName: string
}

export function formatUser(user: User): string {
  return `${user.firstName} ${user.lastName}`
}
```

### Interfaces vs Type Aliases

- Use `interface` for object shapes that may be extended
- Use `type` for unions, intersections, tuples, mapped types
- Prefer string literal unions over `enum`

```typescript
interface User {
  id: string
  email: string
}

type UserRole = 'admin' | 'member'
type UserWithRole = User & { role: UserRole }
```

### Avoid `any`

- Avoid `any` in application code
- Use `unknown` for external input, then narrow safely
- Use generics when type depends on caller

```typescript
// WRONG: any removes type safety
function getErrorMessage(error: any) {
  return error.message
}

// CORRECT: unknown forces safe narrowing
function getErrorMessage(error: unknown): string {
  if (error instanceof Error) {
    return error.message
  }
  return 'Unexpected error'
}
```

## JavaScript Files

In `.js`/`.jsx` files, use JSDoc for type clarity:

```javascript
/**
 * @param {{ firstName: string, lastName: string }} user
 * @returns {string}
 */
export function formatUser(user) {
  return `${user.firstName} ${user.lastName}`
}
```

## File Structure

### Directory Organization

Split by type, not by feature:

```
src/
├── components/
│   ├── user-card.tsx
│   └── user-profile.tsx
├── hooks/
│   └── use-auth.ts
├── utils/
│   ├── string-utils.ts
│   ├── date-utils.ts
│   └── api-utils.ts
├── types/
│   └── user.ts
├── api/
│   └── client.ts
└── styles/
    └── globals.scss
```

### Utility Files

Split `utils/` by feature/domain:

```
utils/
├── string-utils.ts     # String manipulation helpers
├── date-utils.ts       # Date formatting helpers
├── api-utils.ts        # API request helpers
└── validation-utils.ts # Form validation helpers
```

### Test Location

Tests go in `__tests__/` at the project root:

```
project/
├── src/
│   ├── components/
│   └── utils/
└── __tests__/
    ├── user-card.test.tsx
    └── string-utils.test.ts
```

## Immutability

Use spread operator for immutable updates:

```typescript
// WRONG: Mutation
function updateUser(user: User, name: string): User {
  user.name = name
  return user
}

// CORRECT: Spread creates new object
function updateUser(user: Readonly<User>, name: string): User {
  return { ...user, name }
}
```

## Error Handling

### Error Types

- **Web projects**: Use native `Error`
- **CLI/Tool projects**: Use custom Error types

```typescript
// CLI project: custom error
class AppError extends Error {
  constructor(
    public code: string,
    message: string,
    public context?: Record<string, unknown>,
    public cause?: Error,
  ) {
    super(message)
    this.name = 'AppError'
  }
}

// Usage
throw new AppError(
  'FILE_NOT_FOUND',
  `The file "${filePath}" does not exist. Check the path and try again.`,
  { filePath, operation: 'read' },
  originalError
)
```

### Logger Usage

```typescript
// Web frontend: console is sufficient
console.error('Failed to load user profile:', error)

// Node.js backend: structured logger (pino)
import pino from 'pino'
const logger = pino()

logger.error({
  level: 'error',
  errCode: 'DB_QUERY_FAILED',
  table: 'users',
  err: error
}, 'Database query failed')
```

## Console

- No `console.log` in production code
- Use proper logging libraries instead

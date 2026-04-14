---
name: "code-style-principles"
description: "Enforce personal coding style conventions when generating or modifying code. Provides naming standards, file organization rules, comment guidelines, and error handling best practices across TypeScript, React, Vue, and SCSS."
trigger: "Write or modify code in TypeScript, React, Vue, or SCSS"
allowed-tools: ["Read", "Grep", "Glob"]
---

# Code Style Principles

This skill enforces personal coding style conventions for AI-generated code. It activates when writing or modifying code. The rules are strict — violations are style errors.

## When to Activate

- Writing new TypeScript/JavaScript code
- Modifying existing `.ts`, `.tsx`, `.js`, `.jsx` files
- Writing React components
- Writing Vue components
- Writing SCSS/Sass styles
- Any code generation or refactoring task

## Core Style Rules

These rules are always enforced. Reference the detailed language-specific rules in `~/.claude/rules/code-style/`.

### Naming Rules

| Element | Convention | Correct Example | Wrong Example |
|---------|-----------|----------------|---------------|
| Variables | `camelCase` | `getUserData`, `isLoading` | `get_user_data`, `Loading` |
| Functions | `camelCase` | `fetchUserProfile` | `FetchUserProfile`, `fetch_user_profile` |
| Components | `PascalCase` | `UserProfile`, `Sidebar` | `userProfile`, `user_profile` |
| Constants | `UPPER_SNAKE_CASE` | `MAX_RETRY_COUNT` | `maxRetry`, `max_retry` |
| Booleans | `is`/`has`/`should` prefix | `isVisible`, `hasPermission` | `visible`, `permission` |
| Event callbacks | `handle`/`on` prefix | `handleClick`, `onSubmit` | `click`, `submit` |
| Files/folders | `kebab-case` | `user-profile.ts`, `api-utils/` | `UserProfile.ts`, `apiUtils/` |

### File Organization Rules

1. **Import order** (in this exact order, separated by blank lines):
   - Core framework libraries (react, vue)
   - Third-party libraries (lodash, axios)
   - Internal modules (nearest first: `./` → `../` → `../../`)
   - Type imports (`import type`)
   - CSS/SCSS imports

2. **Directory structure**: Split by type (`components/`, `hooks/`, `utils/`, `types/`)
3. **Utils split by feature**: `utils/string-utils.ts`, `utils/date-utils.ts`
4. **Tests**: In `__tests__/` at project root

### Comment Rules

- **Functions**: JSDoc only for public APIs and complex logic
- **Components**: No comments — use TypeScript types instead
- **Inline**: Add comments for important/complex blocks, explain WHY not WHAT
- **Tags**: `TODO:`, `FIXME:`, `HACK:`, `NOTE:`, `WARN:` — always with description

### Error Handling Rules

- **Position**: Top-level unified handling preferred, local try/catch as fallback
- **Types**: Native `Error` for web, custom Error for CLI/tools
- **Message format**: Error code + readable message + context + stack
- **System errors**: Generic message to user, full details logged internally
- **User errors**: Specific, actionable message with next steps
- **Error boundaries**: Required for React/Vue applications

## How to Apply

1. When generating code, follow these rules strictly
2. When reviewing existing code, flag violations
3. Reference the detailed rules files for specific language conventions:
   - `~/.claude/rules/code-style/common/coding-style.md` — universal principles
   - `~/.claude/rules/code-style/typescript/coding-style.md` — TypeScript rules
   - `~/.claude/rules/code-style/react/coding-style.md` — React rules
   - `~/.claude/rules/code-style/vue/coding-style.md` — Vue rules
   - `~/.claude/rules/code-style/scss/coding-style.md` — SCSS rules

## Violation Examples

### Naming Violations

```typescript
// WRONG
let loading = true
const max = 100
function user_profile() { ... }
class sidebar { ... }

// CORRECT
let isLoading = true
const MAX_RETRY = 100
function userProfile() { ... }
class Sidebar { ... }
```

### Import Order Violations

```typescript
// WRONG: Random order
import { UserCard } from './user-card'
import React from 'react'
import './user-profile.scss'
import axios from 'axios'
import type { User } from '../types/user'

// CORRECT: Proper order
import React from 'react'

import axios from 'axios'

import { UserCard } from './user-card'

import type { User } from '../types/user'

import './user-profile.scss'
```

### Comment Violations

```typescript
// WRONG: JSDoc on trivial function
/**
 * Adds two numbers
 * @param a - First number
 * @param b - Second number
 * @returns Sum
 */
function add(a: number, b: number): number {
  return a + b
}

// WRONG: No comment on complex logic
const result = data.filter(x => x.status === 'active')
  .map(x => ({ ...x, score: calculateScore(x) }))
  .sort((a, b) => b.score - a.score)
  .slice(0, 10)

// CORRECT: Comment explains WHY
// Top 10 active items by score — used for the dashboard leaderboard
// We filter, calculate scores, sort descending, then slice
const result = data.filter(x => x.status === 'active')
  .map(x => ({ ...x, score: calculateScore(x) }))
  .sort((a, b) => b.score - a.score)
  .slice(0, 10)
```

### Error Handling Violations

```typescript
// WRONG: Vague error message
throw new Error("Something went wrong")

// WRONG: Exposes internal details
throw new Error("SQL error: ECONNREFUSED 127.0.0.1:5432")

// CORRECT: Specific, actionable, safe
throw new AppError({
  code: "DB_CONNECTION_FAILED",
  message: "Unable to connect to the database. Check your connection string and ensure the database server is running.",
  context: { host: process.env.DB_HOST, port: process.env.DB_PORT },
  cause: originalError
})
```

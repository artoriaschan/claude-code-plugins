# Common Coding Style

Personal coding style principles that apply across all languages and frameworks. These rules are always enforced when AI generates or modifies code.

## Naming Conventions

Follow these naming rules consistently. Violating them is a style error.

| Element | Convention | Example |
|---------|-----------|---------|
| Variables | `camelCase` | `getUserData`, `isLoading` |
| Functions | `camelCase` | `fetchUserProfile`, `validateInput` |
| Components | `PascalCase` | `UserProfile`, `Sidebar` |
| Constants | `UPPER_SNAKE_CASE` | `MAX_RETRY_COUNT`, `API_BASE_URL` |
| Boolean variables | `is`/`has`/`should` prefix | `isVisible`, `hasPermission`, `shouldRetry` |
| Event callbacks | `handle`/`on` prefix | `handleClick`, `onSubmit`, `handleError` |
| Custom hooks | `use` prefix + `camelCase` | `useAuth`, `useDebounce` |
| Files | `kebab-case` | `user-profile.ts`, `auth-utils.ts` |
| Folders | `kebab-case` | `auth-components`, `api-utils` |

### Naming Anti-Patterns

```typescript
// WRONG: Generic names, no prefix for booleans
let loading = true
function get(u) { ... }
const max = 100
function click() { ... }

// CORRECT: Descriptive, proper prefixes
let isLoading = true
function getUser(user: User) { ... }
const MAX_RETRY = 100
function handleClick() { ... }
```

```typescript
// WRONG: PascalCase for variables
const UserProfile = fetchUser()

// CORRECT: camelCase for variables
const userProfile = fetchUser()
```

```typescript
// WRONG: camelCase for components
function userProfile() { return <div /> }

// CORRECT: PascalCase for components
function UserProfile() { return <div /> }
```

## Immutability

**ALWAYS create new objects, NEVER mutate existing ones.**

```typescript
// WRONG: Mutation
function updateUser(user: User, name: string): User {
  user.name = name
  return user
}

// CORRECT: Return new copy
function updateUser(user: Readonly<User>, name: string): User {
  return { ...user, name }
}
```

Rationale: Immutable data prevents hidden side effects and makes debugging easier.

## Comments

### Function Comments

- Add JSDoc **only** for public APIs and complex logic
- Simple functions do not need comments
- JSDoc should document parameters, return value, and behavior

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

// CORRECT: JSDoc on public API
/**
 * Fetches user profile with cached preferences.
 * Falls back to default preferences if none are set.
 *
 * @param userId - The user's unique identifier
 * @returns User profile with merged preferences
 * @throws {NotFoundError} If user does not exist
 */
async function fetchUserProfile(userId: string): Promise<UserProfile> {
  // ...
}
```

### Component Comments

- Do **not** add comments for components whose props are typed with TypeScript
- The type definition is the documentation

```typescript
// WRONG: Redundant comment
// UserProfile component displays user information
interface UserCardProps { user: User; onSelect: (id: string) => void }
function UserCard({ user }: UserCardProps) { ... }

// CORRECT: Just the types
interface UserCardProps { user: User; onSelect: (id: string) => void }
function UserCard({ user }: UserCardProps) { ... }
```

### Inline Comments

- Add inline comments for important/complex code blocks
- Explain **why** and **context**, not **what** the code does

```typescript
// CORRECT: Explains the "why"
// Debounce search requests because the API has rate limits
// and we don't want to fire a request on every keystroke
const debouncedSearch = useMemo(
  () => debounce(searchQuery, 300),
  [searchQuery]
)
```

### Special Tags

Use standardized tags for TODOs and known issues:

```typescript
// TODO: Implement pagination for user list endpoint
// FIXME: Race condition when switching tabs rapidly
// HACK: Workaround for SSR hydration mismatch on Next.js 13
// NOTE: This behavior is intentional for accessibility
// WARN: Changing this will affect all downstream consumers
```

Format: `// TAG: description` — always include a description.

## Error Handling

### Position

- Prefer **top-level unified** error handling when possible
- For errors that cannot be handled centrally, handle **at the call site** with try/catch

```typescript
// CORRECT: Top-level unified handling
async function loadUser(userId: string): Promise<User> {
  const user = await fetchUser(userId)
  return user
}

// In the caller / top-level handler:
try {
  const user = await loadUser(id)
} catch (error) {
  // Unified handling: log, show toast, track error
  handleError(error)
}
```

### Error Types

- **Web projects**: Use native `Error`
- **Tool/CLI projects**: Use custom Error types (e.g., `AppError`, `ValidationError`)

### Error Message Format

Error messages must include complete disclosure:

- **Error code/identifier** — for consistent programmatic handling
- **Human-readable message** — specific and actionable
- **Context** — what was being attempted, relevant parameters
- **Stack trace** — preserve for debugging

```typescript
// WRONG: Vague message
throw new Error("Something went wrong")

// WRONG: Exposes sensitive info
throw new Error("SQL error: 'users' table does not exist, connection string: postgres://admin:secret@...")

// CORRECT: Specific, actionable, safe
throw new AppError({
  code: "DB_TABLE_MISSING",
  message: "The users table does not exist. Please run the database migrations before starting the server.",
  context: { table: "users", operation: "SELECT" },
  cause: originalError
})
```

### System vs. User Errors

- **System errors** (disk full, DB down): Show "Service temporarily unavailable" to users, log full details internally
- **User errors** (invalid input): Tell the user exactly what to fix

```typescript
// WRONG: Exposes internal error to user
catch (error) {
  return res.json({ error: "Connection refused: ECONNREFUSED 127.0.0.1:5432" })
}

// CORRECT: User-friendly for user errors, internal for system errors
catch (error) {
  if (error.code === "INVALID_INPUT") {
    return res.json({ error: "The email address format is invalid. Example: user@example.com" })
  }
  // System error: log internally, show generic message
  logger.error("Database connection failed", error)
  return res.json({ error: "Service temporarily unavailable. Please try again later." })
}
```

### Actionable Suggestions

Error messages should tell the user **what to do next**:

```typescript
// WRONG: No action
throw new Error("Permission denied")

// CORRECT: Actionable
throw new Error("You do not have permission to view this report. Contact your team admin to request the 'Report Viewer' role.")
```

### Consistent Error Codes

Use a consistent error code system across the project:

```typescript
// Prefix by domain
const ErrorCodes = {
  AUTH_INVALID_TOKEN: "AUTH_INVALID_TOKEN",
  AUTH_TOKEN_EXPIRED: "AUTH_TOKEN_EXPIRED",
  DB_QUERY_FAILED: "DB_QUERY_FAILED",
  VALIDATION_EMAIL_INVALID: "VALIDATION_EMAIL_INVALID",
} as const
```

## Logging

- Use **structured** log data
- **Frontend web**: No logging library needed (console is sufficient)
- **Node.js/Backend**: Use a structured logger like `pino` or `winston`

```typescript
// Node.js: Structured logging
logger.error({
  level: "error",
  errCode: "DB_QUERY_FAILED",
  table: "users",
  userId: request.userId,
  err: error
}, "Database query failed")
```

## File Organization Principles

- **High cohesion, low coupling** — each file should have a single purpose
- **200-400 lines typical, 800 max** — extract utilities from large modules
- **Organize by type** — `components/`, `hooks/`, `utils/`, `types/`
- **`utils/` splits by feature** — `utils/string-utils.ts`, `utils/date-utils.ts`
- **Many small files > few large files**

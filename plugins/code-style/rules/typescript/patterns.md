# TypeScript Patterns

> Common patterns for TypeScript projects.

## Repository Pattern

Encapsulate data access behind a consistent interface:

```typescript
interface UserRepository {
  findById(id: string): Promise<User | null>
  findAll(filter?: UserFilter): Promise<User[]>
  create(data: CreateUserInput): Promise<User>
  update(id: string, data: UpdateUserInput): Promise<User>
  delete(id: string): Promise<void>
}

class HttpUserRepository implements UserRepository {
  async findById(id: string): Promise<User | null> {
    const res = await fetch(`/api/users/${id}`)
    if (!res.ok) return null
    return res.json()
  }
  // ...
}
```

## API Response Envelope

Use consistent response format for all API responses:

```typescript
interface ApiResponse<T> {
  success: boolean
  data: T | null
  error: string | null
  meta?: {
    total: number
    page: number
    limit: number
  }
}
```

## Result Type

Use Result type for operations that can fail:

```typescript
type Result<T, E = Error> =
  | { ok: true; value: T }
  | { ok: false; error: E }

async function loadUser(id: string): Promise<Result<User>> {
  try {
    const user = await fetchUser(id)
    return { ok: true, value: user }
  } catch (error) {
    return { ok: false, error: error as Error }
  }
}
```

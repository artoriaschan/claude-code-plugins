# Common Patterns

> Design patterns and architectural principles used across all projects.

## Component Composition

### Container / Presentational Split

- Container components own data loading and side effects
- Presentational components receive props and render UI
- Presentational components should stay pure

```tsx
// WRONG: Mixed concerns
function UserList() {
  const [users, setUsers] = useState([])
  useEffect(() => { fetch('/api/users').then(r => r.json()).then(setUsers) }, [])
  return users.map(u => <div key={u.id}>{u.name}</div>)
}

// CORRECT: Split container and presentational
function UserListContainer() {
  const [users, setUsers] = useState([])
  useEffect(() => { fetch('/api/users').then(r => r.json()).then(setUsers) }, [])
  return <UserList items={users} />
}

function UserList({ items }: { items: User[] }) {
  return items.map(u => <div key={u.id}>{u.name}</div>)
}
```

## State Management

Separate concerns by state type:

| Concern | Tooling |
|---------|---------|
| Server state | React Query, SWR, tRPC |
| Client state | Zustand, Jotai, Context |
| URL state | Search params, route segments |
| Form state | React Hook Form, Formik |

- Do not duplicate server state into client stores
- Derive values instead of storing redundant computed state

## URL As State

Persist shareable state in the URL:
- Filters, sort order, pagination
- Active tab, search query

## Immutability

See [coding-style.md](./coding-style.md) — immutability is a core principle.

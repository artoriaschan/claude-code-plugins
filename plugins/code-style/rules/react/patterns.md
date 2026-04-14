# React Patterns

> Common patterns for React projects.

## Compound Components

Use compound components when related UI shares state:

```tsx
<Tabs defaultValue="overview">
  <Tabs.List>
    <Tabs.Trigger value="overview">Overview</Tabs.Trigger>
    <Tabs.Trigger value="settings">Settings</Tabs.Trigger>
  </Tabs.List>
  <Tabs.Content value="overview">...</Tabs.Content>
  <Tabs.Content value="settings">...</Tabs.Content>
</Tabs>
```

## Container / Presentational Split

```tsx
// Container: owns data fetching
function UserListContainer() {
  const { data: users } = useQuery({ queryKey: ['users'], queryFn: fetchUsers })
  return <UserList items={users ?? []} />
}

// Presentational: pure render
function UserList({ items }: { items: User[] }) {
  return items.map(u => <UserCard key={u.id} user={u} />)
}
```

## Render Props / Slots

Use render props when behavior is shared but markup must vary:

```tsx
function MouseTracker({ render }: { render: (pos: { x: number; y: number }) => React.ReactNode }) {
  const [pos, setPos] = useState({ x: 0, y: 0 })
  // ... mouse tracking
  return <>{render(pos)}</>
}
```

## Optimistic Updates

```tsx
function useOptimisticUpdate<T>(key: string[], data: T) {
  const queryClient = useQueryClient()

  return {
    onMutate: async () => {
      await queryClient.cancelQueries({ queryKey: key })
      const previous = queryClient.getQueryData(key)
      queryClient.setQueryData(key, data)
      return { previous }
    },
    onError: (_err, _vars, context: { previous: T | undefined }) => {
      queryClient.setQueryData(key, context.previous)
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: key })
    }
  }
}
```

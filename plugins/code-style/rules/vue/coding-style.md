---
paths:
  - "**/*.vue"
---
# Vue Coding Style

> This file extends [common/coding-style.md](../common/coding-style.md) with Vue-specific content.

## Component Structure

### Use Composition API (`<script setup>`)

Always use `<script setup>` with Composition API for new components:

```vue
<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import type { User } from '../types/user'
import { formatUser } from '../utils/string-utils'
import './user-profile.scss'

interface Props {
  user: User
}

interface Emits {
  (e: 'edit', id: string): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

const isLoading = ref(false)

const displayName = computed(() => formatUser(props.user))

function handleEdit() {
  emit('edit', props.user.id)
}
</script>

<template>
  <div class="user-profile">
    <h1>{{ displayName }}</h1>
    <button @click="handleEdit">Edit</button>
  </div>
</template>
```

### File Splitting

- Component in `.vue` (single file component)
- Styles in `<style lang="scss" scoped>` or co-located `.scss`
- Component-specific utilities in separate `.ts` files
- Tests in `__tests__/` at project root

## Composition API Rules

### Ref vs Reactive

- Use `ref()` for primitive values and single objects
- Use `reactive()` for grouped state that always updates together
- Always use `.value` to access ref values in script

```vue
<script setup lang="ts">
// CORRECT: ref for primitives
const count = ref(0)
const user = ref<User | null>(null)

// CORRECT: reactive for grouped state
const formState = reactive({
  name: '',
  email: '',
  password: ''
})
</script>
```

### Computed Properties

- Use `computed()` for derived state
- Do not mutate computed values

```vue
<script setup lang="ts">
const filteredUsers = computed(() =>
  users.value.filter(u => u.isActive)
)
</script>
```

### Watch Usage

- Use `watch()` for side effects based on state changes
- Use `watchEffect()` when tracking multiple reactive sources

```vue
<script setup lang="ts">
watch(
  () => props.userId,
  async (newId) => {
    user.value = await fetchUser(newId)
  },
  { immediate: true }
)
</script>
```

## Props and Emits

### Type-Safe Props

Always define props with TypeScript interfaces:

```vue
<script setup lang="ts">
interface Props {
  user: User
  isActive: boolean
  maxItems?: number
}

const props = defineProps<Props>()
</script>
```

### Type-Safe Emits

Always define emits with TypeScript interfaces:

```vue
<script setup lang="ts">
interface Emits {
  (e: 'select', id: string): void
  (e: 'update', data: UpdatePayload): void
  (e: 'delete', id: string): void
}

const emit = defineEmits<Emits>()
</script>
```

## Error Boundary

Vue 3 requires error handling via `errorCaptured` hook or app-level error handler:

```ts
// In main.ts
const app = createApp(App)

app.config.errorHandler = (error, instance, info) => {
  // Log error
  console.error('Vue error:', error)
  // Show user-friendly message
  // Track error analytics
}
```

Or component-level:

```vue
<script setup lang="ts">
import { onErrorCaptured } from 'vue'

onErrorCaptured((error) => {
  // Handle child component error
  console.error('Child component error:', error)
  return false // prevent error propagation
})
</script>
```

## Component Naming

- Component names: PascalCase (`UserProfile`, `Sidebar`)
- Custom events: kebab-case (`@user-select`, `@item-delete`)
- Composables: `use` prefix (`useAuth`, `useDebounce`)
- Files: kebab-case (`user-profile.vue`, `auth-composable.ts`)

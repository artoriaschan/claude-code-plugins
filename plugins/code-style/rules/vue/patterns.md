# Vue Patterns

> Common patterns for Vue projects.

## Composables

Encapsulate reusable logic with composables:

```ts
// composables/use-fetch.ts
import { ref } from 'vue'

export function useFetch<T>(url: string) {
  const data = ref<T | null>(null)
  const error = ref<Error | null>(null)
  const isLoading = ref(false)

  async function execute() {
    isLoading.value = true
    try {
      const response = await fetch(url)
      data.value = await response.json()
    } catch (err) {
      error.value = err as Error
    } finally {
      isLoading.value = false
    }
  }

  return { data, error, isLoading, execute }
}
```

## Provide / Inject

Use provide/inject for deep component tree communication:

```vue
<!-- Parent -->
<script setup lang="ts">
import { provide, ref } from 'vue'

const theme = ref('light')
provide('theme', theme)
</script>

<!-- Child (deep) -->
<script setup lang="ts">
import { inject } from 'vue'

const theme = inject<Ref<string>>('theme')
</script>
```

## Slots

Use slots for flexible component composition:

```vue
<!-- Card.vue -->
<template>
  <div class="card">
    <header class="card-header">
      <slot name="header" />
    </header>
    <main class="card-body">
      <slot />
    </main>
    <footer class="card-footer">
      <slot name="footer" />
    </footer>
  </div>
</template>
```

## URL As State

Persist shareable state in the URL via router:

```ts
// Use router query params for filters, pagination, etc.
const route = useRoute()
const router = useRouter()

const page = computed({
  get: () => Number(route.query.page) || 1,
  set: (val) => router.push({ query: { ...route.query, page: val } })
})
```

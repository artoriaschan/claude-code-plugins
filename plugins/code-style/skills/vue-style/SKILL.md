---
description: "Vue style guide for composition API, component patterns, props/emits typing, and error handling. Triggers when editing .vue files."
trigger: "Edit .vue files, Vue components"
argument-hint: "[optional: specific topic like 'composables', 'props', 'error-handling']"
allowed-tools: ["Read", "Grep", "Glob"]
---

# Vue Style

Enforces strict Vue coding conventions for AI-generated code.

## When to Activate

- Editing `.vue` files
- User calls `/vue-style`
- Generating Vue components

## Rules

See [rules/vue/coding-style.md](../../rules/vue/coding-style.md) for full details including:

- **Composition API**: Always use `<script setup lang="ts">`
- **Props/Emits**: Type-safe with `defineProps<Interface>()` and `defineEmits<Interface>()`
- **Naming**: Components PascalCase, events kebab-case, composables `use` prefix
- **Error Boundary**: `app.config.errorHandler` or `onErrorCaptured`

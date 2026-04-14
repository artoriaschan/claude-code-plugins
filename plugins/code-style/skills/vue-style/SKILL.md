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

## Composition API

- Always use `<script setup lang="ts">`
- Type-safe props with `defineProps<Interface>()`
- Type-safe emits with `defineEmits<Interface>()`

## Naming

- Components: PascalCase
- Events: kebab-case
- Composables: `use` prefix
- Files: kebab-case

## Error Boundary

Required via `app.config.errorHandler` or `onErrorCaptured`.

See [rules/vue/coding-style.md](../../rules/vue/coding-style.md) for full details.

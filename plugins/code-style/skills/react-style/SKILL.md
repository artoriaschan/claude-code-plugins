---
description: "React style guide for component patterns, hooks usage, error boundaries, and prop typing. Triggers when editing .tsx/.jsx files."
trigger: "Edit .tsx .jsx files, React components"
argument-hint: "[optional: specific topic like 'hooks', 'error-boundary', 'props']"
allowed-tools: ["Read", "Grep", "Glob"]
---

# React Style

Enforces strict React coding conventions for AI-generated code.

## When to Activate

- Editing `.tsx`, `.jsx` files
- User calls `/react-style`
- Generating React components

## Rules

See [rules/react/coding-style.md](../../rules/react/coding-style.md) for full details including:

- **Component structure**: Split component logic + styles + utilities
- **Hooks**: `use` prefix, single concern, top-level only
- **Props**: Typed with `interface`, no `React.FC` unless necessary
- **Error Boundary**: Required for all React apps

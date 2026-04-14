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

## Component Structure

- Split: component logic + styles + utilities
- Props typed with `interface`
- No `React.FC` unless necessary

## Hooks Rules

- `use` prefix always required
- One concern per hook
- Top-level calls only

## Error Boundary

Required for all React apps.

See [rules/react/coding-style.md](../../rules/react/coding-style.md) for full details.

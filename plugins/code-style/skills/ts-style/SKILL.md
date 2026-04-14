---
description: "TypeScript style guide with strict enforcement for types, import order, file structure, and error handling. Triggers when editing .ts/.js/.tsx/.jsx files."
trigger: "Edit .ts .tsx .js .jsx files"
argument-hint: "[optional: specific topic like 'types', 'imports', 'error-handling']"
allowed-tools: ["Read", "Grep", "Glob"]
---

# TypeScript Style

Enforces strict TypeScript coding conventions for AI-generated code.

## When to Activate

- Editing `.ts`, `.tsx`, `.js`, `.jsx` files
- User calls `/ts-style`
- Generating new TypeScript code

## Import Order

Strict order, separated by blank lines:

1. Core framework (react, vue)
2. Third-party (lodash, axios)
3. Internal modules — nearest first
4. Type imports
5. CSS/SCSS

See [rules/typescript/coding-style.md](../../rules/typescript/coding-style.md) for full details.

## Types and Interfaces

- Explicit types on all exported functions
- Use `interface` for object shapes, `type` for unions
- Avoid `any` — use `unknown` and narrow

## File Structure

- Split by type: `components/`, `hooks/`, `utils/`, `types/`
- Utils split by feature: `utils/string-utils.ts`
- Tests in `__tests__/` at project root

## Error Handling

- Top-level unified, local fallback
- Native `Error` for web, custom for CLI
- Structured logging with pino for Node.js

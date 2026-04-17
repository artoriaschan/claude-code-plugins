---
description: "TypeScript style guide. Triggers when editing .ts/.js/.tsx/.jsx files."
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

## Rules

See [rules/typescript/coding-style.md](../../rules/typescript/coding-style.md) for full details including:

- **Import order**: Core framework → Third-party → Internal → Types → CSS/SCSS
- **Types**: Explicit types on exports, `interface` for shapes, `type` for unions, avoid `any`
- **File structure**: Split by type (`components/`, `hooks/`, `utils/`, `types/`)
- **Error handling**: Top-level unified, native `Error` for web, custom for CLI
- **Immutability**: Spread operator for updates

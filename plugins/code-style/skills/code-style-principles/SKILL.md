---
name: "code-style-principles"
description: "Enforce personal coding style conventions when generating or modifying code. Activates on any TypeScript, React, Vue, or SCSS code changes."
trigger: "Write or modify code in TypeScript, React, Vue, or SCSS"
allowed-tools: ["Read", "Grep", "Glob"]
---

# Code Style Principles

Activates when writing or modifying code. Follow the detailed rules in `rules/` — this skill provides quick reference and triggers.

## Quick Reference

### Naming
| Element | Convention | Example |
|---------|-----------|---------|
| Variables/functions | `camelCase` | `fetchUserProfile` |
| Components | `PascalCase` | `UserProfile` |
| Constants | `UPPER_SNAKE_CASE` | `MAX_RETRY_COUNT` |
| Booleans | `is`/`has`/`should` prefix | `isVisible`, `hasPermission` |
| Event callbacks | `handle`/`on` prefix | `handleClick`, `onSubmit` |
| Files/folders | `kebab-case` | `user-profile.ts` |

### Import Order
1. Core framework (react, vue)
2. Third-party (lodash, axios)
3. Internal modules (nearest first)
4. Type imports
5. CSS/SCSS

### File Organization
- Organize by type: `components/`, `hooks/`, `utils/`, `types/`
- Utils split by feature: `utils/string-utils.ts`
- Max 800 lines per file, 50 lines per function

### Error Handling
- Top-level unified handling preferred
- Web: native `Error`; CLI/tools: custom `AppError`
- Error messages: specific, actionable, no sensitive info
- React/Vue: Error Boundary required

## Detailed Rules

For full rules with examples, reference these files:

- **Universal**: `rules/common/coding-style.md` — naming, immutability, comments, error handling
- **TypeScript**: `rules/typescript/coding-style.md` — types, imports, file structure
- **React**: `rules/react/coding-style.md` — components, hooks, error boundaries
- **Vue**: `rules/vue/coding-style.md` — Composition API, props/emits
- **SCSS**: `rules/scss/coding-style.md` — naming, nesting, tokens
- **Patterns**: `rules/common/patterns.md`, `rules/typescript/patterns.md`, `rules/react/patterns.md`, `rules/vue/patterns.md`
- **Testing**: `rules/common/testing.md`
- **Git Commit**: `rules/common/git-commit.md`

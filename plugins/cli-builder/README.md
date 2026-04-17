# cli-builder

CLI tool builder plugin for Claude Code — TypeScript CLI project scaffolding and command template generation following modern ESM conventions.

## Components

### Skills

| Skill | Trigger | Purpose |
|-------|---------|---------|
| `cli-create` | "create a CLI", "scaffold a CLI project" | Interactive CLI project creation with TypeScript |
| `cli-add-command` | "add a command", "create a new CLI command" | Generate command template files |

## Tech Stack

Generated projects use:
- TypeScript ESM + Commander + Zod + Chalk 5.x + tsup + Vitest + @clack/prompts
- pnpm workspace + ESLint + Sheriff + Prettier + Husky + Changesets

**Simple mode**: Use `simple: true` flag to skip complex tooling (ESLint, Sheriff, Changesets) for lightweight projects.

# Code Style Plugin

Enforce personal coding style conventions for AI-generated code across TypeScript, React, Vue, and SCSS projects.

## Features

- **Rules** - Always-loaded coding style rules for naming, file organization, comments, and error handling
- **Skills** - Lightweight trigger definitions; detailed rules live in `rules/` to avoid content duplication
- **Agent** - Code style reviewer for deep review before commits

## Installation

### 1. Install Rules

Rules are copied to `~/.claude/rules/code-style/` for Claude Code to auto-load them:

**Remote install (recommended, no clone needed):**

```bash
curl -fsSL https://raw.githubusercontent.com/artoriaschan/claude-code-dev-plugins/main/plugins/code-style/install.sh | bash
```

**Local install (from plugin directory):**

```bash
./install.sh
```

The install script:
- Automatically removes existing rules before installing fresh copy
- Detects local vs remote mode automatically

### 2. Auto-Discovery

Skills and Agents are auto-discovered by Claude Code from the plugin directory. No manual setup needed.

## Rules Structure

```
rules/
├── common/              # Cross-language principles
│   ├── coding-style.md  # Naming, immutability, errors, comments
│   ├── patterns.md      # Design patterns
│   ├── testing.md       # Testing conventions
│   └── git-commit.md    # Conventional Commits, AI commit rules
├── typescript/          # TypeScript/JavaScript rules
│   ├── coding-style.md  # Types, imports, file structure
│   └── patterns.md      # TS patterns
├── react/               # React rules
│   ├── coding-style.md  # Components, error boundaries
│   └── patterns.md      # React patterns
├── vue/                 # Vue rules
│   ├── coding-style.md  # Components, composition API
│   └── patterns.md      # Vue patterns
└── scss/                # SCSS rules
    └── coding-style.md  # Naming, organization
```

## Skills

| Skill | Auto-trigger | Manual |
|-------|-------------|--------|
| `code-style-principles` | Writing/modifying code | `/code-style-principles` |
| `ts-style` | Editing `.ts`/`.js` files | `/ts-style` |
| `react-style` | Editing `.tsx`/`.jsx` files | `/react-style` |
| `vue-style` | Editing `.vue` files | `/vue-style` |
| `scss-style` | Editing `.scss`/`.sass` files | `/scss-style` |

## Style Rules Summary

### Naming
- Variables/functions: `camelCase`
- Components: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- Booleans: `is`/`has`/`should` prefix
- Event callbacks: `handle`/`on` prefix
- Files/folders: `kebab-case`

### File Organization
- Import order: Core libs → Third-party → Internal (near to far) → Types → CSS
- Directory: Split by type, `utils/` split by feature
- React: Component + styles + utilities split, tests in `__tests__/`

### Comments
- Functions: JSDoc only for public APIs and complex logic
- Components: Via TypeScript types, no extra comments
- Inline: Important code blocks need context comments
- Tags: `TODO`/`FIXME`/`HACK`

### Error Handling
- Position: Top-level unified, local fallback for non-unifiable
- Type: Native `Error` for web, custom Error for CLI/tools
- Message: Full disclosure (error code + readable message + context + stack)
- Distinguish system vs user errors, never expose sensitive info
- React/Vue: Error Boundary required
- Logging: Structured, pino for Node.js, none for frontend

### Git Commit
- Format: Conventional Commits — `type(scope): description`
- Types: `feat`, `fix`, `refactor`, `docs`, `test`, `style`, `perf`, `ci`, `chore`
- Description: imperative mood, no capitalization, no trailing period, max 72 chars
- AI rules: do not invent features, do not overstate scope, one logical change per commit

## Testing

```bash
# Test with this plugin
cc --plugin-dir /home/artorias/workspaces/person/claude-code-plugins/plugins/code-style
```

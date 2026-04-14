# Claude Code Plugin Management

## Project Purpose

This project manages Claude Code plugins for personal development workflows. Each plugin under `plugins/` is independently maintained with its own manifest and components.

## Installation

```bash
# Install via /plugin command in Claude Code
/plugin install --plugin-dir /home/artorias/workspaces/person/claude-code-plugins

# Or symlink rules manually
cd plugins/code-style && ./install.sh
```

## Quick Navigation

| Task | Reference |
|------|-----------|
| What is this project and why does it exist | `docs/project-overview.md` |
| Plugin directory layout and manifest format | `docs/plugin-structure.md` |
| How to create plugins, skills, agents, hooks | `docs/development-workflow.md` |
| How to install and use plugins | `docs/installation.md` |
| Coding conventions enforced by plugins | `docs/coding-conventions.md` |

## Active Plugins

| Plugin | Components | Purpose |
|--------|-----------|---------|
| `cli-builder` | 3 skills, 1 agent, 1 hook | TypeScript CLI project scaffolding and code style checking |
| `code-style` | 5 skills, 1 agent, 4 hooks, 11 rules | Enforce personal coding style conventions for AI-generated code |

## Key Conventions

- Each plugin has its own `.claude-plugin/plugin.json` manifest
- Plugin files under `plugins/<name>/` — self-contained and independently deployable
- Skills, agents, hooks auto-discovered from standard directories
- Code conventions follow coding-plans-statusline project patterns (TypeScript ESM, single quotes, 4-space indent)

# Plugin Structure & Manifest Format

## Directory Layout

Each plugin lives under `plugins/<name>/`:

```
plugins/<name>/
├── .claude-plugin/
│   └── plugin.json        # Plugin manifest (per-plugin)
├── README.md              # Plugin documentation
├── skills/                # Auto-activating skills
│   └── <skill-name>/
│       ├── SKILL.md       # Required
│       ├── references/    # Detailed docs loaded on demand
│       ├── examples/      # Working examples
│       └── scripts/       # Utility scripts
├── agents/                # Subagent definitions
│   └── <agent-name>.md    # Agent with frontmatter + system prompt
└── rules/                 # Coding style rules (optional)
    └── <language>/
        └── *.md           # Rules files
```

## Manifest (.claude-plugin/plugin.json)

Each plugin has its own manifest at `plugins/<name>/.claude-plugin/plugin.json`:

```json
{
  "name": "code-style",
  "version": "0.1.0",
  "description": "Enforce personal coding style conventions.",
  "author": { "name": "artorias" }
}
```

Skills and agents are **auto-discovered** from standard directories:

| Component | Auto-discovery path |
|-----------|---------------------|
| Skills | `plugins/<name>/skills/<skill-name>/SKILL.md` |
| Agents | `plugins/<name>/agents/<agent-name>.md` |

### Manifest Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Unique kebab-case identifier |
| `version` | No | Semver version |
| `description` | No | One-line purpose summary |
| `author` | No | Author info |
| `skills` | No | Relative path to skills directory (overrides auto-discovery) |
| `agents` | No | Relative path or array of agent paths (overrides auto-discovery) |

### Path Rules

- Paths are relative to the `.claude-plugin/` directory (parent of plugin.json)
- Must start with `./`
- Cannot be absolute

## Skill Frontmatter (SKILL.md)

```yaml
---
name: skill-name
description: Third-person description with specific trigger phrases like "do X", "create Y"
version: 0.1.0
---
```

### Description Requirements

- Use third person: "This skill should be used when..."
- Include specific trigger phrases in quotes
- Be concrete, not vague

## Agent Frontmatter (.md)

```yaml
---
description: What this agent does and when it triggers
capabilities:
  - Specific task 1
  - Specific task 2
---
```

## Rules (Optional)

Plugins can ship coding style rules under `plugins/<name>/rules/`. These must be symlinked to `~/.claude/rules/` for Claude Code to auto-load them:

```bash
# Symlink all rules from a plugin
./install.sh
```

Rules follow a layered structure:

```
rules/
├── common/              # Cross-language principles
│   ├── coding-style.md  # Naming, immutability, errors, comments
│   ├── patterns.md      # Design patterns
│   └── testing.md       # Testing conventions
├── <language>/          # Language-specific rules
│   ├── coding-style.md  # Language conventions
│   ├── patterns.md      # Language patterns
└── <framework>/         # Framework-specific rules
    ├── coding-style.md
    └── patterns.md
```

Rules use relative path references (`../common/xxx.md`) to cross-reference shared principles.

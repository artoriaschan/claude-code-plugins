# Installation & Usage

## Installing Plugins

### Via Claude Code /plugin Command

```bash
/plugin install --plugin-dir /home/artorias/workspaces/person/claude-code-plugins
```

This loads all plugins from this project into your Claude Code instance.

### Manual Rule Installation

Some plugins (like `code-style`) ship coding style rules that must be symlinked to `~/.claude/rules/` for auto-loading:

```bash
cd plugins/code-style && ./install.sh
```

Skills, agents, and hooks are auto-discovered — no manual setup required.

## Available Plugins

### cli-builder

TypeScript CLI project scaffolding and code style checking.

See [`plugins/cli-builder/README.md`](../plugins/cli-builder/README.md) for details.

### code-style

Enforce personal coding style conventions for AI-generated code across TypeScript, React, Vue, and SCSS.

See [`plugins/code-style/README.md`](../plugins/code-style/README.md) for details.

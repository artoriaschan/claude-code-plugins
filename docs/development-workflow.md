# Plugin Development Workflow

## Creating a New Plugin

1. Create directory under `plugins/<name>/`
2. Add skills, agents as needed
3. If shipping rules, create `install.sh` to copy rules to `~/.claude/rules/`

## Creating a New Skill

1. Create `plugins/<plugin>/skills/<skill-name>/SKILL.md`
2. Write frontmatter with third-person description and trigger phrases
3. Write lean body in imperative form
4. Move detailed content to `references/` for progressive disclosure
5. Add examples in `examples/`

## Creating a New Agent

1. Create `plugins/<plugin>/agents/<agent-name>.md`
2. Write frontmatter with description and capabilities
3. Write system prompt with trigger conditions and output format

## Local Development & Debugging

### Add Local Marketplace

Add the project directory as a local marketplace source:

```bash
/plugin marketplace add ./my-marketplace
```

Or add via GitHub repository for team collaboration:

```bash
/plugin marketplace add artoriaschan/claude-code-dev-plugins
```

### Install Plugins

After adding the marketplace, install plugins individually:

```bash
/plugin install cli-builder
/plugin install code-style
```

Or with explicit marketplace qualifier:

```bash
/plugin install cli-builder@artoriaschan-claude-code-dev-plugins
```

For `code-style` plugin, also run the install script to copy rules:

```bash
bash plugins/code-style/install.sh
```

### Activate Changes

After installing, enabling, or disabling plugins during a session, activate without restart:

```bash
/reload-plugins
```

### Remove Local Marketplace

After testing, remove the local marketplace source:

```bash
/plugin marketplace remove ./my-marketplace
```

### Clear Plugin Cache

If skills are not appearing after updates:

```bash
rm -rf ~/.claude/plugins/cache
```

Then restart Claude Code and reinstall the plugin.

## Documentation Maintenance

**When modifying plugin files, update corresponding docs:**

| Change Location | Docs to Update |
|-----------------|----------------|
| `plugins/<name>/skills/`, `agents/`, `rules/`, `install.sh` | `plugins/<name>/README.md` |
| `plugins/<name>/README.md` | `README.md` (root) if the plugin's purpose/components changed |
| `README.md` (root) | `CLAUDE.md` if install commands or plugin list changed |

**Rules:**
- Document **only existing features** — never reference removed or deleted functionality
- Keep component counts accurate (skills, agents, rules)
- Install commands must match current behavior
- Update descriptions to reflect current behavior, not legacy behavior

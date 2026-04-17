# Plugin Development Workflow

## 1. Creating a New Plugin

1. Create directory under `plugins/<name>/`
2. Create `.claude-plugin/plugin.json` with `name`, `version`, `description`
3. Add skills, agents as needed
4. If shipping rules, create `install.sh` to copy rules to `~/.claude/rules/`
5. Register in `.claude-plugin/marketplace.json`

## 2. Registering a Plugin

After creating or modifying a plugin, ensure it's registered in the marketplace manifest:

```json
{
  "plugins": {
    "plugin-name": {
      "path": "./plugins/plugin-name"
    }
  }
}
```

## 3. Versioning

Bump the `version` field in `.claude-plugin/plugin.json` after each meaningful change. Use [semantic versioning](https://semver.org/):

- **patch** — bug fixes, docs, minor tweaks
- **minor** — new skills, agents, or features
- **major** — breaking changes to existing components

```json
{
  "name": "plugin-name",
  "version": "0.1.0"
}
```

## 4. Creating Components

### Skills

1. Create `plugins/<plugin>/skills/<skill-name>/SKILL.md`
2. Write frontmatter with third-person description and trigger phrases
3. Write lean body in imperative form
4. Move detailed content to `references/` for progressive disclosure
5. Add examples in `examples/`

### Agents

1. Create `plugins/<plugin>/agents/<agent-name>.md`
2. Write frontmatter with description and capabilities
3. Write system prompt with trigger conditions and output format

## 5. Local Development & Debugging

### Setup

```bash
# Add local marketplace
/plugin marketplace add ./my-marketplace

# Install plugins
/plugin install cli-builder
/plugin install code-style

# For code-style plugin, also copy rules
bash plugins/code-style/install.sh
```

### Verify

Run `/plugin` and check the **Installed** tab. For skills, perform the expected action (e.g., edit a `.ts` file to verify `ts-style` auto-triggers).

### Iterate

After modifying skills or agents:

1. Clear cache: `rm -rf ~/.claude/plugins/cache`
2. Run `/reload-plugins` (or restart Claude Code)
3. Re-test the trigger

### Cleanup

```bash
/plugin marketplace remove ./my-marketplace
```

## 6. Pre-Commit Checklist

Before committing plugin changes:

- [ ] Version bumped in `.claude-plugin/plugin.json`
- [ ] `.claude-plugin/marketplace.json` updated if metadata changed
- [ ] Plugin README.md reflects current components
- [ ] Root `README.md` updated if plugin purpose/components changed
- [ ] `CLAUDE.md` updated if plugin list or install commands changed
- [ ] No documentation references removed or stale features

## 7. Documentation Maintenance

### Cross-Reference Rules

| When modifying | Also check/update |
|----------------|-------------------|
| `docs/*.md` | Root `README.md` — remove or update any link pointing to the changed file |
| `plugins/<name>/skills/`, `agents/`, `rules/`, `install.sh` | `plugins/<name>/README.md` — update component counts and descriptions |
| `plugins/<name>/README.md` | Root `README.md` — sync if plugin purpose or components changed |
| Root `README.md` | `CLAUDE.md` — sync if install commands or plugin list changed |

### Content Rules

- Document **only existing features** — never reference removed or deleted functionality
- Keep component counts accurate (skills, agents, rules)
- Install commands must match current behavior
- Update descriptions to reflect current behavior, not legacy behavior

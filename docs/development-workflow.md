# Plugin Development Workflow

## Creating a New Plugin

1. Create directory under `plugins/<name>/`
2. Add skills, agents as needed
3. Register component paths in `.claude-plugin/plugin.json`
4. If shipping rules, create `install.sh` with safety checks (idempotent symlink creation)
5. Test with `cc --plugin-dir /home/artorias/workspaces/person/claude-code-plugins`

## Creating a New Skill

1. Create `plugins/<plugin>/skills/<skill-name>/SKILL.md`
2. Write frontmatter with third-person description and trigger phrases
3. Write lean body (~1,500-2,000 words) in imperative form
4. Move detailed content to `references/` for progressive disclosure
5. Add examples in `examples/`

## Creating a New Agent

1. Create `plugins/<plugin>/agents/<agent-name>.md`
2. Write frontmatter with description and capabilities
3. Write system prompt with trigger conditions and output format

## Documentation Maintenance

**When modifying plugin files, update corresponding docs:**

| Change Location | Docs to Update |
|-----------------|----------------|
| `plugins/<name>/skills/`, `agents/`, `rules/`, `install.sh` | `plugins/<name>/README.md` |
| `plugins/<name>/README.md` | `README.md` (root) if the plugin's purpose/components changed |
| `README.md` (root) | `CLAUDE.md` and `docs/installation.md` if install commands or plugin list changed |

**Rules:**
- Document **only existing features** — never reference removed or deleted functionality
- Keep component counts accurate (skills, agents, rules)
- Install commands must match current `install.sh` behavior
- Update descriptions to reflect current behavior, not legacy behavior

## Testing

```bash
# Load all plugins from this project
cc --plugin-dir /home/artorias/workspaces/person/claude-code-plugins

# Test a skill by asking something that should trigger it
```

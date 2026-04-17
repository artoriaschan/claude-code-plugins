# Plugin Development Workflow

## Creating a New Plugin

1. Create directory under `plugins/<name>/`
2. Add skills, agents as needed
3. Register component paths in `.claude-plugin/plugin.json`
4. Test with `cc --plugin-dir /home/artorias/workspaces/person/claude-code-plugins`

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

## Testing

```bash
# Load all plugins from this project
cc --plugin-dir /home/artorias/workspaces/person/claude-code-plugins

# Test a skill by asking something that should trigger it
```

# Example: Generated `init` Command

## Input Collected from User

| Field | Value |
|-------|-------|
| Command name | `init` |
| Description | Initialize a new project configuration |
| Arguments | None |
| Options | `--name, -n` (project name), `--template, -t` (template preset) |
| Interactive prompts | Yes |

## Generated File: `packages/cli/src/commands/init.ts`

```typescript
import { Command } from 'commander'
import chalk from 'chalk'
import { z } from 'zod'
import { text, select, spinner } from '@clack/prompts'

const schema = z.object({
  name: z.string().min(1, 'Project name is required'),
  template: z.enum(['basic', 'full', 'custom']).default('basic'),
})

export function registerInit(program: Command) {
  const cmd = program
    .command('init')
    .description('Initialize a new project configuration')
    .option('--name <name>, -n <name>', 'Project name')
    .option('--template <type>, -t <type>', 'Template preset', 'basic')

  cmd.action(async (opts) => {
    const projectName = opts.name || await text({
      message: 'Enter project name',
      placeholder: 'my-project',
      validate: (value) => value.length > 0 ? undefined : 'Name is required',
    })

    const template = opts.template || await select({
      message: 'Select a template',
      options: [
        { value: 'basic', label: 'Basic' },
        { value: 'full', label: 'Full' },
        { value: 'custom', label: 'Custom' },
      ],
    })

    const parsed = schema.safeParse({ name: projectName, template })

    if (!parsed.success) {
      console.error(chalk.red('Invalid configuration:'), parsed.error.message)
      process.exit(1)
    }

    const s = spinner()
    s.start('Initializing project...')
    s.stop('Project initialized successfully')
    console.log(chalk.green(`Created ${projectName} with ${template} template`))
  })
}
```

## Barrel Export: `packages/cli/src/commands/index.ts`

```typescript
export { registerInit } from './init.js'
```

## Test Stub: `packages/cli/tests/init.spec.ts`

```typescript
import { describe, it, expect } from 'vitest'
import { Command } from 'commander'
import { registerInit } from '../src/commands/init.js'

describe('init', () => {
  it('should register without error', () => {
    const program = new Command()
    registerInit(program)
    expect(program.commands).toHaveProperty('init')
  })
})
```

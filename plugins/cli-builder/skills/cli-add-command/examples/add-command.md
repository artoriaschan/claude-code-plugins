# Example: Generated `add` Command with Arguments and Options

## Input Collected from User

| Field | Value |
|-------|-------|
| Command name | `add` |
| Description | Add a new resource to the project |
| Arguments | `name` (resource name), `type` (resource type) |
| Options | `--dry-run` (preview only), `--output` (output directory) |
| Interactive prompts | No |

## Generated File: `packages/cli/src/commands/add.ts`

```typescript
import { Command } from 'commander'
import chalk from 'chalk'
import { z } from 'zod'

const schema = z.object({
  dryRun: z.boolean().default(false),
  output: z.string().default('./resources'),
})

export function registerAdd(program: Command) {
  const cmd = program
    .command('add <name> <type>')
    .description('Add a new resource to the project')
    .option('--dry-run', 'Preview changes without applying them', false)
    .option('--output <dir>', 'Output directory', './resources')

  cmd.action(async (name, type, opts) => {
    const parsed = schema.safeParse(opts)

    if (!parsed.success) {
      console.error(chalk.red('Invalid options:'), parsed.error.message)
      process.exit(1)
    }

    if (parsed.data.dryRun) {
      console.log(chalk.yellow('[dry-run] Would create:'))
      console.log(chalk.yellow(`  ${parsed.data.output}/${name}.${type}`))
      return
    }

    console.log(chalk.green(`Added ${name} (${type}) to ${parsed.data.output}`))
  })
}
```

## Barrel Export: `packages/cli/src/commands/index.ts`

```typescript
export { registerAdd } from './add.js'
```

## Test Stub: `packages/cli/tests/add.spec.ts`

```typescript
import { describe, it, expect } from 'vitest'
import { Command } from 'commander'
import { registerAdd } from '../src/commands/add.js'

describe('add', () => {
  it('should register without error', () => {
    const program = new Command()
    registerAdd(program)
    expect(program.commands).toHaveProperty('add')
  })

  it('should accept two positional arguments', () => {
    const program = new Command()
    registerAdd(program)
    const cmd = program.commands.find((c) => c.name() === 'add')
    expect(cmd).toBeDefined()
  })
})
```

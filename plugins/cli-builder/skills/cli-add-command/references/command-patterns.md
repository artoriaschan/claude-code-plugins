# Command Patterns

Different command generation patterns based on user requirements.

## Pattern A: Simple Command (No Arguments, No Options)

Minimal command with only a name and description.

**Use when:** User says "add a command called X" without mentioning arguments or flags.

**Key elements:**
- Commander `.command()` and `.description()` only
- No `.argument()` or `.option()` calls
- Action body: log completion message

## Pattern B: Command with Arguments

Command that accepts positional arguments.

**Use when:** User specifies positional inputs (e.g., "takes a file path", "requires a project name").

**Key elements:**
- `.argument('<name>', '<description>')` for each argument
- Optional arguments use `<>` for required, `[]` for optional
- Validate argument count in action body

## Pattern C: Command with Options

Command that accepts named flags/options.

**Use when:** User mentions flags (e.g., "--verbose", "--output", "-f", "with a dry-run option").

**Key elements:**
- `.option('<flag>, <shorthand>', '<description>')`
- Options may have default values via third parameter
- Parse options from action callback parameter

## Pattern D: Command with Arguments and Options

Combines both positional and named inputs.

**Use when:** User specifies both arguments and flags.

**Key elements:**
- `.argument()` calls before `.option()` calls
- Action callback receives arguments first, then options object
- Zod schema validates options

## Pattern E: Interactive Command

Uses @clack/prompts for guided input during execution.

**Use when:** User mentions "interactive", "prompts", "asks the user", or "wizard-style".

**Key elements:**
- Import `text`, `confirm`, `select`, or `spinner` from `@clack/prompts`
- Collect input via prompts in action body
- Still validate collected data with Zod schema

## Pattern F: Non-Interactive with External Input

Reads from stdin, file, or environment for input.

**Use when:** User mentions "piped input", "reads from file", "CI-friendly", or "non-interactive".

**Key elements:**
- No @clack/prompts import
- Read from `process.stdin` or `fs.readFileSync`
- Fail fast with clear error if input is missing

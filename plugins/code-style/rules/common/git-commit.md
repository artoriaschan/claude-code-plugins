# Git Commit Conventions

> Commit message standards applied when AI generates or modifies git commits.

## Format

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

## Types

| Type | When to use |
|------|-------------|
| `feat` | New feature for the user |
| `fix` | Bug fix for the user |
| `refactor` | Code change that is neither a fix nor a feature |
| `docs` | Documentation only |
| `test` | Adding or fixing tests |
| `style` | Code style changes (formatting, whitespace, etc.) |
| `perf` | Performance improvement |
| `ci` | CI/CD configuration changes |
| `chore` | Build process, dependencies, or other maintenance |

## Rules

### Description

- Use imperative mood: "add" not "added" or "adds"
- No capitalization at the start
- No period at the end
- Max 72 characters for the header line

### Body

- Optional, but **required** for breaking changes and significant refactors
- Explain **what changed** and **why**, not **how**
- Wrap at 80 characters
- Use blank line to separate from header

### Breaking Changes

- Mark with `!` after type: `feat!: ...`
- Footer: `BREAKING CHANGE: <description>`

### Scope

- Optional but recommended for multi-module projects
- Use lowercase kebab-case: `auth`, `user-card`, `api-client`

### Footer Tags

- `Closes #N` / `Fixes #N` — link to issue
- `Refs #N` — related issue
- `Co-authored-by: Name <email>` — multiple authors

## AI-Specific Rules

When AI generates commit messages:

- **Do not invent features** — only describe actual code changes
- **Do not overstate scope** — if only one function changed, say so
- **Do not use `feat` for refactors** — use `refactor` even if the code looks nicer
- **One logical change per commit** — prefer multiple small commits
- **Never commit unrelated changes** — e.g. formatting + logic in one commit
- **If unsure about type** — use `chore` rather than guessing

## Examples

```
# GOOD: Simple fix
fix: resolve race condition when switching user profiles

# GOOD: Feature with scope
feat(auth): add JWT token refresh on 401 response

# GOOD: Refactor with body
refactor: extract user validation into separate module

Split validation logic out of the auth handler so it can be
reused by the registration and profile-update flows.

# GOOD: Test addition
test: add edge cases for date formatting utility

# GOOD: Docs
docs: update API endpoint reference in README

# GOOD: Breaking change
feat(api)!: change user search to return paginated results

BREAKING CHANGE: user search now returns { data, meta } instead
of a flat array. Update all call sites accordingly.

# WRONG: Past tense
WRONG: fixed the bug with user login

# WRONG: Capitalized, period at end
WRONG: Add new endpoint.

# WRONG: Vague
WRONG: update code

# WRONG: Overstated
WRONG: feat: complete user management system
(actual: only added one input validation function)
```

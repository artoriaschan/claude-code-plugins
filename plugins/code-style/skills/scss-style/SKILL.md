---
description: "SCSS style guide for naming conventions, nesting limits, variable tokens, and file organization. Triggers when editing .scss/.sass files."
trigger: "Edit .scss .sass files, SCSS styles"
argument-hint: "[optional: specific topic like 'naming', 'nesting', 'tokens']"
allowed-tools: ["Read", "Grep", "Glob"]
---

# SCSS Style

Enforces strict SCSS coding conventions for AI-generated code.

## When to Activate

- Editing `.scss`, `.sass` files
- User calls `/scss-style`
- Generating SCSS styles

## Naming

- CSS classes: kebab-case
- Variables: kebab-case with `$` prefix
- Mixins: kebab-case
- Files: kebab-case

## Nesting

- Maximum 3 levels deep
- Use `&` for BEM modifiers

## Organization

- Tokens → Mixins → Component styles
- Use CSS custom properties for design tokens
- Consistent breakpoint system for media queries

See [rules/scss/coding-style.md](../../rules/scss/coding-style.md) for full details.

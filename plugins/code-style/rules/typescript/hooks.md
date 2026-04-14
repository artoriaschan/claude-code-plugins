# TypeScript Hooks

> PostToolUse hooks for TypeScript projects.

## Recommended Hooks

### Format on Save

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "npx prettier --write \"$FILE_PATH\"",
        "description": "Format edited TypeScript files"
      }
    ]
  }
}
```

### Lint Check

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "npx eslint --fix \"$FILE_PATH\"",
        "description": "Run ESLint on edited TypeScript files"
      }
    ]
  }
}
```

### Type Check

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "npx tsc --noEmit --pretty false",
        "description": "Type-check after TypeScript edits"
      }
    ]
  }
}
```

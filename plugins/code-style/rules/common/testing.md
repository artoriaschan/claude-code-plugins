# Common Testing Standards

> Testing principles applicable to all projects.

## Minimum Test Coverage: 80%

All projects should maintain at least 80% code coverage.

## Test Structure (AAA Pattern)

Use Arrange-Act-Assert structure:

```typescript
test('returns empty array when no markets match query', () => {
  // Arrange
  const query = 'nonexistent'
  const markets = createMockMarkets()

  // Act
  const results = filterMarkets(markets, query)

  // Assert
  expect(results).toEqual([])
})
```

## Test Naming

Use descriptive names that explain the behavior:

```typescript
// GOOD: Describes the scenario
test('throws error when API key is missing', () => {})
test('falls back to substring search when Redis is unavailable', () => {})

// BAD: Vague
test('test 1', () => {})
test('should work', () => {})
```

## Test Types

- **Unit tests**: Single functions, utilities, components
- **Integration tests**: API endpoints, database operations
- **E2E tests**: Critical user flows

## Test Location

- Tests go in `__tests__/` at project root level
- Or co-located with source file as `file.test.ts`

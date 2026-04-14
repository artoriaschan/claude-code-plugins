---
paths:
  - "**/*.scss"
  - "**/*.sass"
---
# SCSS Coding Style

> This file extends [common/coding-style.md](../common/coding-style.md) with SCSS-specific content.

## Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| CSS classes | `kebab-case` | `.user-profile`, `.sidebar-item` |
| Variables | `kebab-case` with `$` prefix | `$color-primary`, `$space-md` |
| Mixins | `kebab-case` with `mixin-` prefix | `@mixin flex-center` |
| Functions | `kebab-case` | `@function rem()` |
| Placeholders | `kebab-case` with `%` prefix | `%card-base` |

```scss
// WRONG: camelCase classes
.userProfile { ... }
.user_card { ... }

// CORRECT: kebab-case classes
.user-profile { ... }
.sidebar-item { ... }
```

```scss
// WRONG: Generic variable names
$blue: #3b82f6
$gray: #6b7280

// CORRECT: Semantic variable names
$color-primary: #3b82f6
$color-text-secondary: #6b7280
$space-md: 1rem
$radius-lg: 8px
```

## Organization

### File Structure

```
styles/
├── tokens/
│   ├── colors.scss         # Color palette
│   ├── spacing.scss        # Spacing scale
│   └── typography.scss     # Font sizes, weights
├── mixins/
│   ├── responsive.scss     # Media query mixins
│   └── utilities.scss      # Utility mixins
├── globals/
│   ├── reset.scss          # CSS reset
│   └── base.scss           # Base element styles
└── components/
    ├── user-profile.scss
    └── sidebar.scss
```

### Import Order in SCSS Files

1. Variables/tokens
2. Mixins
3. Component styles

```scss
// Component SCSS file
@use '../tokens/colors' as *;
@use '../tokens/spacing' as *;
@use '../mixins/responsive' as *;

.user-profile {
  color: $color-primary;
  padding: $space-md;
}
```

## Nesting

- Limit nesting to **3 levels deep**
- Use `&` for BEM-like modifiers

```scss
// WRONG: Deep nesting (4+ levels)
.page {
  .content {
    .user-list {
      .user {
        .avatar {
          img { ... }
        }
      }
    }
  }
}

// CORRECT: Flat structure with &
.user-profile {
  padding: $space-md;

  &__header { ... }
  &__body { ... }
  &__footer { ... }

  &--active {
    border-color: $color-primary;
  }
}
```

## Variables and Tokens

Define design tokens, don't hardcode values:

```scss
:root {
  --color-surface: #ffffff;
  --color-text: #1a1a1a;
  --color-primary: #3b82f6;
  --space-sm: 0.5rem;
  --space-md: 1rem;
  --space-lg: 2rem;
  --text-base: 1rem;
  --text-lg: 1.25rem;
}
```

Use them via CSS custom properties:

```scss
.card {
  background: var(--color-surface);
  padding: var(--space-md);
  font-size: var(--text-base);
}
```

## Media Queries

Use a consistent breakpoint system:

```scss
$breakpoints: (
  'sm': 640px,
  'md': 768px,
  'lg': 1024px,
  'xl': 1280px,
);

@mixin respond-to($breakpoint) {
  @media (min-width: map-get($breakpoints, $breakpoint)) {
    @content;
  }
}

// Usage
.user-grid {
  display: grid;
  gap: $space-md;
  grid-template-columns: 1fr;

  @include respond-to('md') {
    grid-template-columns: repeat(2, 1fr);
  }

  @include respond-to('lg') {
    grid-template-columns: repeat(3, 1fr);
  }
}
```

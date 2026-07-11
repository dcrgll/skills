# React and Next.js defaults

Use this guidance for React, Next.js, and full-stack TypeScript apps. Project-local conventions still take precedence.

## React defaults

- Prefer functional components and hooks.
- Keep components focused on one responsibility.
- Prefer composition over large prop APIs.
- Use `children` or slots when that keeps the component simpler.
- Extract complex JSX into smaller components or helper render functions.
- Use PascalCase for React component names.
- Prefer named exports for components where possible.

## Component folders

- Use one folder per non-trivial component.
- Use kebab-case for component folder names and files.
- Keep component exports in PascalCase.

Preferred structure:

```text
component-name/
├── index.tsx
├── types.ts
├── strings.ts
└── helpers.ts
```

## Next.js defaults

- Prefer server components by default when using the App Router.
- Add `"use client"` only when the component needs browser-only APIs, state, effects, event handlers, or client-side libraries.
- Keep route-level code in `src/app`.
- Keep reusable UI outside route folders unless it is only used by that route.
- Keep server-only code out of client components.

## Naming conventions

Match the existing repository naming conventions first.

When no convention exists:

- Use kebab-case for file and folder names.
- Components: `kebab-case.tsx`
- Hooks: `use-kebab-case.ts`
- Utilities: `kebab-case.ts`
- Types: `kebab-case.ts`

Examples:

```text
user-profile.tsx
use-discussions.ts
format-date.ts
api-types.ts
```

## Imports

- Prefer absolute imports using the project alias, usually `~/`.
- Use relative imports for files in the same directory.
- Do not introduce an alias if the project does not already support one.

## Strings

- Put reusable UI copy and shared strings in a `strings.ts` file when the same copy is reused.
- Keep one-off local labels inline when extraction would make the code harder to read.
- Export grouped strings as objects when useful.

## Architecture

Prefer feature-based architecture when creating new structure.

- Keep related code close to where it is used.
- Avoid cross-feature imports where practical.
- Shared code should be genuinely reusable.
- Avoid premature abstraction.
- Keep code flow broadly unidirectional: `shared` -> `features` -> `app`.

For new projects or new large areas, use this structure by default:

```text
src/
├── app/              # Application layer: routes, providers, router
├── components/       # Shared UI components
├── config/           # Global configuration and env parsing
├── features/         # Feature-based modules
├── hooks/            # Shared React hooks
├── lib/              # Preconfigured libraries and clients
├── testing/          # Test utilities and mocks
├── types/            # Shared TypeScript types
└── utils/            # Shared utility functions
```

## Feature structure

For feature modules, prefer:

```text
src/features/feature-name/
├── api/              # Feature API calls and API hooks
├── components/       # Feature-specific components
├── hooks/            # Feature-specific hooks
├── stores/           # Feature-specific state
├── types/            # Feature-specific types
└── utils/            # Feature-specific utilities
```

Only create folders that are actually needed.

## TypeScript standards

- Prefer strict TypeScript.
- Prefer explicit types at module boundaries.
- Avoid `any`, broad casts, disabled lint rules, and ignored errors unless justified.
- Validate untrusted external input at API boundaries.

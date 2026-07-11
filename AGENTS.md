# AGENTS.md

Global defaults for AI-assisted development work.

Project-local instructions, existing repository conventions, and explicit user instructions take precedence over this file.

## Instruction precedence

Follow instructions in this order:

1. Explicit user request in the current task
2. Project-local `AGENTS.md`, `CLAUDE.md`, `README.md`, or similar repo guidance
3. Existing codebase conventions
4. These global defaults

When instructions conflict, follow the higher-priority source and mention the conflict briefly.

## Working style

- Inspect the existing code before making changes.
- Prefer small, focused diffs.
- Prefer editing existing files over creating new abstractions.
- Match nearby patterns before introducing new ones.
- Do not make unrelated refactors while completing a task.
- Ask before making broad architectural changes.
- Clearly call out assumptions, trade-offs, and any checks that could not be run.

## Package manager & runtime

- Use `pnpm` by default: `pnpm install`, `pnpm add`, `pnpm exec`, `pnpm dlx`.
- Do not use `npm` or `yarn` unless the repository clearly uses them.
- Prefer existing `package.json` scripts over ad-hoc commands.
- Do not add dependencies without asking first.
- Before adding a dependency, check whether an existing dependency or built-in API can solve the problem.

## Dev servers & builds

- Do not start a dev server unless explicitly asked.
- Assume a dev server may already be running.
- Do not run production/app builds unless explicitly asked or clearly required for verification.
- Prefer light verification commands first, such as typecheck, lint, or targeted tests.

## Git

- Only commit when explicitly asked.
- Use Conventional Commits: `type(scope): summary`.
- Keep commit messages concise and descriptive.
- Do not add "Generated with Claude Code", "Generated with Cursor", or AI co-author footers to commits.

  - Example: `feat(auth): add session refresh`

- Use conventional branch names:

  - `feat/session-refresh`
  - `fix/login-redirect`
  - `chore/deps`

- Never force-push to `main` or `master`.
- Never amend commits unless explicitly requested and safe.
- Do not commit secrets, credentials, keys, `.env` files, or local-only config.
- Do not rewrite git history unless explicitly asked.

## Code style

Follow the project formatter and lint rules.

- Prefer readable code over clever or overly optimised code.
- Keep functions small and focused.
- Use early returns instead of deeply nested conditionals.
- Prefer `const` over `let`.
- Avoid reassignment where deriving a new value is clearer.
- Use camelCase for functions and variables.
- Use UPPER_SNAKE_CASE for true constants.
- Prefer named exports for components.
- Prefer regular `function` declarations unless surrounding code uses arrows.
- Prefer absolute imports when the project already supports them; otherwise use relative imports.

## React and Next.js

- When working in React or Next.js apps, also follow [docs/REACT.md](docs/REACT.md).
- For default library choices (styling, animation, schemas, forms, state, data fetching, UI, auth, URL state, icons, dates, charts, fake data, themes, captchas), follow [docs/PREFERRED_LIBRARIES.md](docs/PREFERRED_LIBRARIES.md).

## Testing and verification

After meaningful code changes:

- Run the lightest relevant check available.
- Prefer targeted tests over full test suites when possible.
- Prefer typecheck for TypeScript-only changes.
- Prefer lint for style or import changes.
- Prefer targeted unit tests for logic changes.

If checks fail:

- Fix failures caused by the change.
- Do not fix unrelated failures unless asked.
- Report unrelated existing failures clearly.

If checks cannot be run:

- Explain why.
- State what was changed and what should be verified manually.

## Completion response

When finishing a task, include:

- A brief summary of what changed
- The checks run and their result
- Any follow-up needed from the user

Keep the final response concise.

## PR instructions

- Split work into separate PRs where appropriate.
- Keep each PR as small as possible.
- Title format: `[<ticket_number>] <Title>`.
- Keep descriptions short, and use natural language.
- Do not list every change in the description; explain what changed and why.
- Do not add "Generated with Claude Code", "Generated with Cursor", or AI co-author footers to PR descriptions.
- Do not mark PRs as ready for review with `gh pr ready`; leave PRs in draft mode and let the user decide when to mark them ready.
- Do not add "Generated with Claude Code", "Generated with Cursor", or AI co-author footers to commits.

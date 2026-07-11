---
name: what
description: Answer what this codebase is — purpose, stack, layout, and how to run and test it. Use when joining a repo, exploring an unfamiliar project, or when the user asks what this is, how it works, or how to get started.
disable-model-invocation: true
---

# What

Answer **what** this codebase is before doing work in it.

Build a short, accurate mental model — not an encyclopaedia.

## Process

### 1. Read the front door

Start with root docs and scripts only:

- `README.md`, `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`
- Getting-started docs under `docs/`
- `package.json` / lockfile scripts, `Makefile`, `justfile`, compose files

Prefer the repo's own words over invented ones.

### 2. Detect the stack

From lockfiles and config, name:

- Language and runtime
- Package manager
- Frameworks and major libraries
- Datastores and external services the app actually talks to

Skip speculative dependencies that are unused.

### 3. Find the seams

Locate the load-bearing paths:

- App entrypoints (`src/app`, `app`, `cmd`, `main`, etc.)
- Feature or domain folders
- Shared libs vs app wiring
- Test and CI entrypoints

Read for structure, not every implementation detail. Stop once you can explain where new work would go.

### 4. Capture how to operate it

Extract the real commands for:

- Install
- Run
- Test
- Lint / typecheck

Use existing project scripts. Do not start a long-lived dev server unless asked. Never print secret values — env **names** only.

## Completion criterion

Done when you can answer, without hedging:

1. What this repo is for
2. What stack it runs on
3. Where the main code lives
4. Which commands you would run next

If any of those are unknown, say so under **Unknowns** — do not invent them.

## Output

```markdown
## What
One or two sentences on what this repo is.

## Stack
- Runtime / language:
- Package manager:
- Frameworks:
- Services:

## Layout
- Where entrypoints, features, shared code, and tests live.

## Operate
- Install:
- Run:
- Test:
- Lint / typecheck:

## Conventions
- Only the norms that change how you should work here.

## Unknowns
- Gaps, missing docs, or questions for the user.
```

---
name: ship
description: Ship completed feature work to GitHub with a conventional branch, small precise commits, and short plain-English PR copy. Use when a feature is built and the user wants to get it onto GitHub, open a PR, or prepare work for review.
---

# Ship

Use this skill when a feature is built and the user wants to get it onto GitHub, for work or personal repositories.

## Start Here

Before naming a branch, commits, or PR:

1. Check the current git state, branch, and staged/unstaged/untracked changes.
2. Check for local commits that have not been pushed.
3. Ask for a ticket number if one was not provided or obvious from context.

Do not continue with branch names, commit messages, or PR titles until the ticket question is resolved. If there is no ticket, continue without one.

## Branching

All work should be on a conventional task branch.

If the user is on `main`, `master`, `develop`, or another shared branch, create a new conventional branch before committing and keep the existing working tree changes.

If the user is already on a task branch, keep it if the name is suitable. Suggest a rename if it is unclear or non-conventional. Do not create another branch unless the user asks.

Never overwrite, discard, reset, rebase, or force-push work unless the user explicitly asks.

## Safety Rules

Never use `--no-verify`, `--no-gpg-sign`, or any option that skips hooks, signing, checks, or review safeguards. If a hook, signing step, or check fails, stop and fix the failure or ask the user how to proceed.

Never add `Co-Authored-By: Claude`, any Claude co-author line, or any other agent co-author line.

## Naming

Preferred branch format when there is a ticket:

```text
feat/sot-3998-account-settings
fix/sot-3998-login-redirect
chore/sot-3998-update-ci
```

Use Conventional Commits:

```text
feat(settings): add account preferences
fix(auth): preserve login redirect
chore(ci): update release workflow
```

Default commit types:

- `feat` for new user-facing behaviour
- `fix` for bug fixes
- `chore` for tooling, config, or maintenance
- `refactor` for internal code changes with no behaviour change
- `test` for test-only changes
- `docs` for documentation-only changes

Other common types include `perf`, `build`, `ci`, `style`, and `revert`. Use them only when they clearly fit or the repository already uses them.

## GitHub CLI

Use `gh` for GitHub work such as checking PR state, creating PRs, viewing checks, and reading comments.

```sh
gh auth status
gh repo view --web
gh pr status
gh pr list --state open
gh pr view --web
gh pr checks
gh pr checks --watch
```

## Pull Requests

Before writing a PR description, check for a GitHub PR template in:

```text
.github/pull_request_template.md
.github/PULL_REQUEST_TEMPLATE.md
.github/PULL_REQUEST_TEMPLATE/*.md
docs/pull_request_template.md
```

If a template exists, fill its sections with the PR body guidance below. Always pass the final filled content to `gh pr create` with `--body`.

### PR Body

Use this PR body format:

```markdown
## Summary

<what changed and why>

## Verification

- `<command that passed>`
- Not run: `<command>` (`<reason>`)

<!-- NEXT_JS_LLM -->
```

Explain the "what" from the end-user or developer perspective. Only include implementation details if they are not obvious from the diff.

Include a "why" unless the change is small and self-explanatory. Omit the "why" sparingly.

Do not include trivial verification commands that CI already covers (e.g. `pnpm run build`), but do include manual verification steps. If the PR changes a test, do not repeat the command to run that test. If you used an existing test to confirm behaviour did not change, include that test.

```sh
gh pr create --draft --title "[SOT-3998] Add account settings" --body "$(cat <<'EOF'
## Summary

Users can now manage account settings without leaving the app. This keeps preference updates closer to where users expect to make them.

## Verification

- `pnpm test account-settings`
- Not run: `pnpm lint` (`unrelated existing lint failures in legacy files`)

<!-- NEXT_JS_LLM -->
EOF
)"
```

---
name: pr-review
description: Review a branch or PR on two axes — Standards and Spec — then report findings side by side. Use when reviewing a PR, reviewing since a commit or branch, or when the user asks for a code review.
disable-model-invocation: true
---

# PR Review

Review the diff between `HEAD` and a fixed point on **two axes**, kept separate on purpose:

- **Standards** — does the code follow this repo's documented conventions and avoid clear design smells?
- **Spec** — does the change do what the issue / PR / request asked for?

A change can pass one axis and fail the other. Do not merge the axes into one ranked list.

For review comments, summaries, and any other human-facing copy, follow [tone-of-voice](../tone-of-voice/SKILL.md).

## Process

### 1. Pin the fixed point

Use the commit, branch, tag, or merge-base the user named. If they did not specify one, ask.

Confirm it resolves and the three-dot diff is non-empty:

```sh
git rev-parse <fixed-point>
git diff <fixed-point>...HEAD
git log <fixed-point>..HEAD --oneline
```

For a GitHub PR:

```sh
gh pr view
gh pr view --json title,body,baseRefName,commits,files,statusCheckRollup
gh pr diff
gh pr checks
```

If reviewing a PR and no fixed point was given, use the PR base branch.

### 2. Find the spec

Look for intent in this order:

1. PR title and body
2. Linked issue / ticket references
3. Spec or PRD files the user points at
4. Commit messages, only as a fallback

If there is no spec, the Spec axis reports `no spec available` and focuses on claimed behaviour in the PR description.

### 3. Find the standards

Read repo standards from, when present:

- `AGENTS.md`
- `CLAUDE.md`
- `CONTRIBUTING.md`
- `CODING_STANDARDS.md`
- similar project guidance

Also watch for common smells in the diff (judgement calls, not hard law; repo docs win):

- Mysterious names
- Duplicated logic
- Feature envy / shotgun surgery
- Speculative generality
- Missing edge-case or security handling on risky paths

Skip anything already owned by formatter, linter, or CI noise.

### 4. Review both axes

Review Standards and Spec independently. For each finding, note:

- Severity: **Blocker**, **Request**, **Nit**, or **Question**
- Where in the diff
- Why it matters
- What would fix it

Prioritise correctness, security, regressions, and missing tests for risky behaviour over style.

### 5. Report side by side

Do not let a strong Standards pass hide a Spec miss, or the reverse.

## Output

```markdown
## Summary
What changed, in one short paragraph, plus overall risk.

## Standards
- **Blocker/Request/Nit/Question:** finding, location, why, fix

## Spec
- **Blocker/Request/Nit/Question:** finding, quote or paraphrase the requirement, why, fix

## Testing gaps
- What remains unverified.

## Verdict
Approve / approve with nits / request changes
```

If an axis is clean, say so explicitly.

## GitHub comments

After the review report, if there are findings worth posting, present a **numbered list of potential comments** before touching GitHub.

For each proposed comment include:

1. Severity
2. Target (file + line/hunk, or summary comment)
3. Exact comment text

Then ask whether to submit them. Do not post anything until the user confirms.

When submitting:

- Put specific issues inline
- Keep the overall verdict in a short summary comment
- Only submit the comments the user approved

Do not approve or request changes via `gh` unless the user explicitly asks.

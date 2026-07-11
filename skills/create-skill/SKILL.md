---
name: create-skill
description: Author a new agent skill in this repo. Use when creating, drafting, or editing a skill, or when the user asks how to structure a SKILL.md.
disable-model-invocation: true
---

# Create Skill

Create or edit skills in this repo under `skills/<name>/SKILL.md`.

After install, that folder is available via the `~/.agents/skills` symlink (and Cursor/Codex/Claude entrypoints).

## Start Here

Gather only what is missing:

1. **Purpose** — what workflow does this skill own?
2. **Name** — short, lowercase, hyphenated. prefer a strong leading word (`ship`, `what`, `debug`).
3. **Triggers** — when should it run? put those in the `description`.
4. **Output** — any required template or format?
5. **Writing** — if it drafts PR copy, comments, or similar, link [tone-of-voice](../tone-of-voice/SKILL.md).

If the user pastes exact wording, use it **verbatim**. do not soften or expand it.

Infer from conversation when enough context already exists. ask only for gaps.

## Layout

```text
skills/<name>/
├── SKILL.md          # required
├── reference.md      # optional, progressive disclosure
├── examples.md       # optional
└── scripts/          # optional helpers
```

Never create skills in `~/.cursor/skills-cursor/` (Cursor-managed).

Default for this repo: `skills/<name>/`. only use `~/.cursor/skills/` or `.cursor/skills/` if the user asks for a location outside this repo.

## SKILL.md shape

```markdown
---
name: skill-name
description: What it does and when to use it. Include trigger phrases.
disable-model-invocation: true
---

# Skill Name

Brief purpose.

## Process
Ordered steps with clear done conditions.

## Output
Template if the skill produces a fixed write-up.
```

### Frontmatter

| Field | Rules |
|-------|--------|
| `name` | max 64 chars, lowercase letters/numbers/hyphens |
| `description` | third person, what + when, include triggers. max 1024 chars |
| `disable-model-invocation` | default `true` in this repo so skills only run when named explicitly |

Do not omit `disable-model-invocation: true` unless the user explicitly asks for ambient auto-invocation.

### Description

- third person ("reviews pull requests…", not "i can review…")
- front-load the leading word / action
- one distinct trigger per idea. no synonym padding
- include both **what** and **when**

## Authoring rules

- keep `SKILL.md` under ~500 lines. push detail to linked files one level deep.
- assume the agent is competent. only add what it would not already know.
- prefer steps with checkable completion criteria over essays.
- one meaning, one place. no duplicated policy across skills.
- match nearby skills in this repo for tone and structure.
- if the skill writes human-facing text (PR bodies, review comments), tell it to follow [tone-of-voice](../tone-of-voice/SKILL.md).
- `what` does not need tone-of-voice. writing-heavy skills do.

## Do not

- invent scripts when a short instruction will do
- use windows-style paths
- bury required steps in linked files the agent may never open
- add time-sensitive "before date X" rules without an old-patterns escape hatch

## Finish

1. write or update `skills/<name>/SKILL.md`
2. update the skills list in `README.md` if it is a new skill
3. show the user the path and a short summary of what the skill does
4. ask whether to ship it (do not commit unless they ask)

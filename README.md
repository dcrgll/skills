# Skills

Personal agent instructions and Cursor/Codex/Claude skills.

This repo holds:

- Global agent defaults (`AGENTS.md`)
- Shared docs referenced by those defaults (`docs/`)
- Reusable agent skills (`skills/`)
- Install scripts that symlink everything into place locally

## Layout

```text
.
├── AGENTS.md          # Global defaults for AI-assisted work
├── docs/              # Topic docs linked from AGENTS.md
├── skills/            # Agent skills (each skill is a folder with SKILL.md)
└── scripts/           # Install, uninstall, and auto-pull helpers
```

## Install

```sh
./scripts/install.sh
```

This will:

1. Symlink `AGENTS.md`, `docs/`, and `skills/` into `~/.agents`
2. Point Cursor, Codex, and Claude entrypoints at those links
3. Install a LaunchAgent that pulls this repo every 10 minutes

| Source | Installs to |
|--------|-------------|
| `AGENTS.md` | `~/.agents/AGENTS.md` → `~/.cursor/AGENTS.md`, `~/.codex/AGENTS.md`, `~/.claude/CLAUDE.md` |
| `docs/` | `~/.agents/docs` → `~/.cursor/docs`, `~/.codex/docs`, `~/.claude/docs` |
| `skills/` | `~/.agents/skills` → `~/.cursor/skills`, `~/.codex/skills`, `~/.claude/skills` |

Existing files are backed up as `*.bak.<timestamp>` before being replaced.

## Uninstall

```sh
./scripts/uninstall.sh
```

Removes the symlinks created by install (only if they still point at this install) and unloads the auto-pull LaunchAgent. Backups are left in place.

## Auto-pull

Install sets up a macOS LaunchAgent (`com.skills.autopull`) that runs `scripts/auto-pull.sh` every 10 minutes.

- Skips when the working tree has local changes
- Uses `git pull --ff-only`
- Logs to `~/Library/Logs/skills-autopull.log`

Manage it on its own:

```sh
./scripts/install-autopull.sh
./scripts/uninstall-autopull.sh
./scripts/auto-pull.sh   # one-shot pull
```

## Skills

Each skill lives in `skills/<name>/SKILL.md`.

Currently:

- **ship** — branch, commit, and open a PR for finished work
- **what** — answer what a codebase is and how to operate it
- **debug** — diagnose bugs with a tight feedback loop before fixing
- **pr-review** — review a branch or PR on Standards and Spec axes
- **tone-of-voice** — writing voice for PR copy, comments, and similar text
- **create-skill** — author a new skill in this repo

`ship`, `debug`, and `pr-review` all defer to **tone-of-voice** for human-facing writing.

Add a new skill by creating `skills/<name>/SKILL.md`, or use **create-skill**. After install, it is available through the `~/.cursor/skills` (and Codex/Claude) symlink.

## Docs

Topic guidance referenced from `AGENTS.md` lives under `docs/`, for example `docs/REACT.md`. Keep `AGENTS.md` short and link out for detail.

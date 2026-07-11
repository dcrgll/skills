#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AGENTS_HOME="$HOME/.agents"

unlink_if_ours() {
  local target="$1"
  local link_path="$2"

  if [[ ! -e "$link_path" && ! -L "$link_path" ]]; then
    echo "skip $link_path (missing)"
    return
  fi

  if [[ ! -L "$link_path" ]]; then
    echo "skip $link_path (not a symlink)"
    return
  fi

  local current
  current="$(readlink "$link_path")"
  if [[ "$current" != "$target" ]]; then
    echo "skip $link_path (points elsewhere: $current)"
    return
  fi

  rm "$link_path"
  echo "removed $link_path"
}

# Tool entry points
unlink_if_ours "$AGENTS_HOME/AGENTS.md" "$HOME/.cursor/AGENTS.md"
unlink_if_ours "$AGENTS_HOME/AGENTS.md" "$HOME/.codex/AGENTS.md"
unlink_if_ours "$AGENTS_HOME/AGENTS.md" "$HOME/.claude/CLAUDE.md"

unlink_if_ours "$AGENTS_HOME/docs" "$HOME/.cursor/docs"
unlink_if_ours "$AGENTS_HOME/docs" "$HOME/.codex/docs"
unlink_if_ours "$AGENTS_HOME/docs" "$HOME/.claude/docs"

unlink_if_ours "$AGENTS_HOME/skills" "$HOME/.cursor/skills"
unlink_if_ours "$AGENTS_HOME/skills" "$HOME/.codex/skills"
unlink_if_ours "$AGENTS_HOME/skills" "$HOME/.claude/skills"

# Canonical ~/.agents install
unlink_if_ours "$ROOT/AGENTS.md" "$AGENTS_HOME/AGENTS.md"
unlink_if_ours "$ROOT/docs" "$AGENTS_HOME/docs"
unlink_if_ours "$ROOT/skills" "$AGENTS_HOME/skills"

"$ROOT/scripts/uninstall-autopull.sh"

echo "uninstall complete"

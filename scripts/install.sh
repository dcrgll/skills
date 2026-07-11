#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AGENTS_HOME="$HOME/.agents"
STAMP="$(date +%Y%m%d-%H%M%S)"

backup_if_needed() {
  local path="$1"

  if [[ ! -e "$path" && ! -L "$path" ]]; then
    return
  fi

  local backup="${path}.bak.${STAMP}"
  mv "$path" "$backup"
  echo "backup $path -> $backup"
}

link() {
  local target="$1"
  local link_path="$2"
  local parent

  parent="$(dirname "$link_path")"
  mkdir -p "$parent"

  if [[ -L "$link_path" ]]; then
    local current
    current="$(readlink "$link_path")"
    if [[ "$current" == "$target" ]]; then
      echo "ok  $link_path"
      return
    fi
  fi

  if [[ -e "$link_path" || -L "$link_path" ]]; then
    backup_if_needed "$link_path"
  fi

  ln -s "$target" "$link_path"
  echo "link $link_path -> $target"
}

mkdir -p "$AGENTS_HOME"

# Canonical install under ~/.agents
link "$ROOT/AGENTS.md" "$AGENTS_HOME/AGENTS.md"
link "$ROOT/docs" "$AGENTS_HOME/docs"
link "$ROOT/skills" "$AGENTS_HOME/skills"

# Tool entry points -> ~/.agents
link "$AGENTS_HOME/AGENTS.md" "$HOME/.cursor/AGENTS.md"
link "$AGENTS_HOME/AGENTS.md" "$HOME/.codex/AGENTS.md"
link "$AGENTS_HOME/AGENTS.md" "$HOME/.claude/CLAUDE.md"

link "$AGENTS_HOME/docs" "$HOME/.cursor/docs"
link "$AGENTS_HOME/docs" "$HOME/.codex/docs"
link "$AGENTS_HOME/docs" "$HOME/.claude/docs"

link "$AGENTS_HOME/skills" "$HOME/.cursor/skills"
link "$AGENTS_HOME/skills" "$HOME/.codex/skills"
link "$AGENTS_HOME/skills" "$HOME/.claude/skills"

"$ROOT/scripts/install-autopull.sh"

echo "install complete"

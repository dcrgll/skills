#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

now="$(date '+%Y-%m-%d %H:%M:%S')"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "[$now] error: $ROOT is not a git repository" >&2
  exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  echo "[$now] skip: local changes present"
  exit 0
fi

git fetch --quiet origin

behind="$(git rev-list --count HEAD..@{upstream} 2>/dev/null || echo 0)"
if [[ "$behind" == "0" ]]; then
  echo "[$now] up to date"
  exit 0
fi

git pull --ff-only --quiet
echo "[$now] pulled $behind commit(s)"

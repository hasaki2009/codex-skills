#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIST_FILE="$REPO_ROOT/config/superpowers.list"
DST_ROOT="${CODEX_HOME:-$HOME/.codex}/skills"

if [ ! -f "$LIST_FILE" ]; then
  echo "missing list: $LIST_FILE" >&2
  exit 1
fi

while IFS= read -r name; do
  [[ -z "$name" || "$name" =~ ^# ]] && continue
  target="$DST_ROOT/$name"
  if [ -L "$target" ] || [ -d "$target" ]; then
    rm -rf "$target"
    echo "disabled: $name"
  else
    echo "skip (not present): $name"
  fi
done < "$LIST_FILE"

echo "done: superpowers disabled"

#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIST_FILE="$REPO_ROOT/config/superpowers.list"
SRC_ROOT="$REPO_ROOT/skills"
PACK_ROOT="$SRC_ROOT/superpowers"
DST_ROOT="${CODEX_HOME:-$HOME/.codex}/skills"

mkdir -p "$DST_ROOT"
if [ ! -f "$LIST_FILE" ]; then
  echo "missing list: $LIST_FILE" >&2
  exit 1
fi

while IFS= read -r name; do
  [[ -z "$name" || "$name" =~ ^# ]] && continue
  src="$PACK_ROOT/$name"
  dst="$DST_ROOT/$name"
  if [ ! -d "$src" ]; then
    echo "skip (missing in repo): $name"
    continue
  fi
  ln -sfn "$src" "$dst"
  echo "enabled: $name"
done < "$LIST_FILE"

echo "done: superpowers enabled"

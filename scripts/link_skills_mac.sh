#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$REPO_ROOT/skills"
TARGET_DIR="${CODEX_HOME:-$HOME/.codex}/skills"

mkdir -p "$SRC_DIR" "$TARGET_DIR"

# Create/update symlink for each top-level custom skill while keeping built-in .system untouched.
for src in "$SRC_DIR"/*; do
  [ -d "$src" ] || continue
  name="$(basename "$src")"
  [[ "$name" == .* ]] && continue
  [[ "$name" == "superpowers" ]] && continue
  ln -sfn "$src" "$TARGET_DIR/$name"
  echo "linked: $name"
done

echo "done: $SRC_DIR -> $TARGET_DIR"

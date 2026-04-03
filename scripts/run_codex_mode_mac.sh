#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-}"
if [[ "$MODE" != "lite" && "$MODE" != "super" ]]; then
  echo "usage: $0 <lite|super> [codex args...]" >&2
  exit 1
fi
shift || true

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEFAULT_CODEX_HOME="${CODEX_BASE_HOME:-$HOME/.codex}"
MODE_HOME="$HOME/.codex-$MODE"
MODE_SKILLS="$MODE_HOME/skills"
SRC_ROOT="$REPO_ROOT/skills"
SUPER_LIST="$REPO_ROOT/config/superpowers.list"

mkdir -p "$MODE_SKILLS"

# Reuse built-in system skills from the default Codex home.
if [[ -d "$DEFAULT_CODEX_HOME/skills/.system" ]]; then
  ln -sfn "$DEFAULT_CODEX_HOME/skills/.system" "$MODE_SKILLS/.system"
fi

# Link regular top-level custom skills, but skip the superpowers container.
for src in "$SRC_ROOT"/*; do
  [[ -d "$src" ]] || continue
  name="$(basename "$src")"
  [[ "$name" == .* ]] && continue
  [[ "$name" == "superpowers" ]] && continue
  ln -sfn "$src" "$MODE_SKILLS/$name"
done

# Toggle superpowers group per mode.
if [[ -f "$SUPER_LIST" ]]; then
  while IFS= read -r name; do
    [[ -z "$name" || "$name" =~ ^# ]] && continue
    src="$SRC_ROOT/superpowers/$name"
    dst="$MODE_SKILLS/$name"
    if [[ "$MODE" == "super" ]]; then
      [[ -d "$src" ]] && ln -sfn "$src" "$dst"
    else
      rm -rf "$dst"
    fi
  done < "$SUPER_LIST"
fi

export CODEX_HOME="$MODE_HOME"
exec codex "$@"

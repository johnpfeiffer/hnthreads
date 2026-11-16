#!/usr/bin/env bash
# Verify that every JSON analysis artifact under threads/ is valid JSON.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIR="$ROOT/threads"

if ! command -v jq >/dev/null 2>&1; then
  echo "Error: jq is required but not installed." >&2
  exit 2
fi

if [ ! -d "$DIR" ]; then
  echo "Error: thread directory not found: $DIR" >&2
  exit 1
fi

fail=0
found=0
while IFS= read -r -d '' f; do
  found=1
  relative="${f#"$ROOT"/}"
  if jq empty "$f" >/dev/null 2>&1; then
    echo "OK      $relative"
  else
    echo "INVALID $relative"
    jq empty "$f" 2>&1 | sed 's/^/        /'
    fail=1
  fi
done < <(find "$DIR" -type f -name '*.json' -print0 | sort -z)

if [ "$found" -eq 0 ]; then
  echo "No JSON files found in $DIR" >&2
  exit 1
fi

if [ "$fail" -ne 0 ]; then
  echo "Some files are invalid." >&2
  exit 1
fi

echo "All JSON files are valid."

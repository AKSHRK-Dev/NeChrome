#!/bin/bash
# NeChrome の改造を Chromium のソースに当てる（ブランドの差し替えと、patches/series のパッチ）。
#   bash scripts/apply.sh [Chromium の src。省略で ~/chromium/src]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${1:-$HOME/chromium/src}"
cd "$SRC"

cp "$ROOT/branding/BRANDING" chrome/app/theme/chromium/BRANDING

grep -v '^\s*#' "$ROOT/patches/series" | sed '/^\s*$/d' | while read -r p; do
  echo "パッチ: $p"
  git apply --3way "$ROOT/patches/$p"
done
echo "当て終わりました。次は scripts/build-linux.sh"

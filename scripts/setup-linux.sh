#!/bin/bash
# Chromium のソースを、chromium_version.txt の版で取ってくる（履歴なし。約 35GB）。
#   bash scripts/setup-linux.sh [作業場所。省略で ~/chromium]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORK="${1:-$HOME/chromium}"
VERSION="$(cat "$ROOT/chromium_version.txt")"

if [ ! -d "$HOME/depot_tools" ]; then
  git clone --depth 1 https://chromium.googlesource.com/chromium/tools/depot_tools.git "$HOME/depot_tools"
fi
export PATH="$HOME/depot_tools:$PATH"

mkdir -p "$WORK" && cd "$WORK"
if [ ! -d src ]; then
  fetch --nohooks --no-history chromium
fi
cd src
git fetch --depth 1 origin "refs/tags/$VERSION:refs/tags/$VERSION"
git checkout -f "tags/$VERSION"
gclient sync -D --force --reset --no-history --with_branch_heads
./build/install-build-deps.sh --no-prompt
gclient runhooks
echo "Chromium $VERSION を $WORK/src に用意しました。次は scripts/apply.sh"

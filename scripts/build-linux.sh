#!/bin/bash
# NeChrome をビルドする（Linux）。6 コアで 10 時間前後かかる。
#   bash scripts/build-linux.sh [Chromium の src。省略で ~/chromium/src]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${1:-$HOME/chromium/src}"
export PATH="$HOME/depot_tools:$PATH"
cd "$SRC"
mkdir -p out/NeChrome
cp "$ROOT/args.gn" out/NeChrome/args.gn
gn gen out/NeChrome
# メモリが 16GB ほどなので、同時に走らせる数を絞る（リンクでメモリが足りなくなるのを防ぐ）
autoninja -C out/NeChrome -j "$(( $(nproc) > 4 ? 4 : $(nproc) ))" chrome chrome_sandbox
echo "できあがり: $SRC/out/NeChrome/chrome"

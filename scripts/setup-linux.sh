#!/bin/bash
# Chromium のソースを、chromium_version.txt の版だけ取ってくる（履歴なし。約 35GB）。
#   bash scripts/setup-linux.sh [作業場所。省略で ~/chromium]
#
# sudo が要る「ビルドに必要な部品を入れる」手順（install-build-deps.sh）は、ここではやらない。
# 終わったあとに表示されるコマンドを、ご自身で一度だけ打ってください。
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORK="${1:-$HOME/chromium}"
VERSION="$(cat "$ROOT/chromium_version.txt")"

if [ ! -d "$HOME/depot_tools" ]; then
  git clone --depth 1 https://chromium.googlesource.com/chromium/tools/depot_tools.git "$HOME/depot_tools"
fi
export PATH="$HOME/depot_tools:$PATH"

mkdir -p "$WORK" && cd "$WORK"
if [ ! -f .gclient ]; then
  gclient config --name src --unmanaged https://chromium.googlesource.com/chromium/src.git
fi
# 目的の版のタグだけを、履歴なしで取る（中で使う部品も、その版に合わせて取る）
gclient sync --nohooks --no-history -D --revision "src@refs/tags/$VERSION"
gclient runhooks

echo
echo "Chromium $VERSION を $WORK/src に用意しました。"
echo "最初の1回だけ、次のコマンドでビルドに必要な部品を入れてください（sudo のパスワードを聞かれます）:"
echo "  $WORK/src/build/install-build-deps.sh --no-prompt"
echo "そのあと: bash scripts/apply.sh → bash scripts/build-linux.sh"

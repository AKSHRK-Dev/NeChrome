# NeChrome

Chromium をもとにした、ASHIKA Group のブラウザです。Chrome と同じエンジン・同じ拡張機能のまま、使いやすさに関わる所を作り直します。

## 入れる予定の機能

| 機能 | 内容 |
|---|---|
| 複数段のブックマークバー | ブックマークが多いとき、隠さずに 2 段・3 段に折り返して並べる |
| 検索エンジンの切り替え | URL バーの横のボタンから、検索エンジンをすぐ選べる |
| ブックマークの並べ替え | ブックマークバーの上で、ドラッグで並べ替えやすくする |
| ASHIKA Group のブランド | 名前・アイコンを NeChrome に |

Chrome ウェブストアの拡張機能は、そのまま入れられます。サイトの安全のための警告（危険なサイト・証明書のエラーなど）は Chromium と同じく残します。

## このリポジトリの作り

Chromium のソースそのものは持たず、**改造点だけをパッチとして**持ちます。Chromium の新しい版が出たら、パッチを当て直してビルドします。

```
chromium_version.txt   もとにする Chromium の版
args.gn                ビルドの設定
branding/BRANDING      名前（NeChrome / ASHIKA Group）
patches/series         当てるパッチの順番
patches/nechrome/      NeChrome のパッチ
scripts/               取得・適用・ビルドの手順
```

## ビルドのしかた（Linux）

空き容量 **70GB 以上**、メモリ 16GB 以上が目安です。6 コアの PC で 10 時間前後かかります。

```bash
bash scripts/setup-linux.sh      # Chromium のソースを取る（約 35GB、初回だけ）
bash scripts/apply.sh            # NeChrome の改造を当てる
bash scripts/build-linux.sh      # ビルド
~/chromium/src/out/NeChrome/chrome
```

Windows 版は、Windows の PC（Visual Studio 2022・空き 100GB 以上）でビルドします。手順は準備中です。

## ライセンス

パッチと scripts は BSD 3-Clause（Chromium と同じ）です。Chromium 自体のライセンスは Chromium に従います。

Developed by ASHIKA Group

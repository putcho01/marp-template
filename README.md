## Getting Started

```bash
pnpm i
```

## コマンド

```bash
# 新しい markdown ファイルを作成
pnpm run new
# markdown を PPTX 形式で export
pnpm run pptx markdown/{ファイル名}.md
# markdown を pdf 形式で export
pnpm run pptx markdown/{ファイル名}.md
# ローカルで起動
pnpm run dev
```

## テーマの編集

1. `/style/scss/*.scss` ファイルを修正
2. `pnpm run css`

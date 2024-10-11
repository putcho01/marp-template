#!/usr/bin/bash

# 引数の数をチェックし、引数が4つ以上場合はエラーメッセージを出力して終了
if [ "$#" -ge 4 ]; then
  echo "Usage: $0 [-h] <file_path> "
  echo "Argument count is not correct."
  exit 1
fi

# -h(html)オプションが指定されているかチェック
d_option_set=false
html_option_set=false
while getopts ":dh" opt; do
  case $opt in
    h)
      html_option_set=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))

# titleを抽出
file_name="${1##*/}"
title="${file_name%.*}"
echo "✨  Extracted Title: $title"

# titleに全角文字が含まれているかチェック
if echo "$title" | perl -C -ne 'exit(1) unless /[^\x00-\x7F｡-ﾟ]/'; then
  blue=$(tput setaf 4)
  reset=$(tput sgr0)
  echo "${blue}info${reset} Full-width characters are included in the title."
  echo "${blue}info${reset} If you want to upload this file to SlideShare, please change the title to half-width characters."
  echo "${blue}info${reset} To assist with this, we recommend using the -d option."
fi

# themeを抽出
while IFS= read -r line; do
  if [[ $line =~ theme:[[:space:]]*[\'\"]([^\'\"]+)[\'\"] ]]; then
    theme="${BASH_REMATCH[1]}"
    echo "✨  Extracted Theme: $theme"
    break
  fi
done < "$1"

if [ "$html_option_set" = true ]; then
  npx marp "$1" -o "output/$title.pdf" --allow-local-files --html --theme "style/css/$theme.css"
else
  npx marp "$1" -o "output/$title.pdf" --allow-local-files --theme "style/css/$theme.css"
fi

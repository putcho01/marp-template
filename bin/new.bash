#!/usr/bin/bash

# 入力ファイルと出力ファイルの指定
input_file="./markdown/template.md"

read -p "Enter slide name : " slide
mkdir -p ./output/$slide
cp -n $input_file "./output/$slide/index.md"

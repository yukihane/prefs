#!/bin/bash
# svgview.sh - SVGファイルをブラウザでズーム・パン可能な状態で表示するスクリプト
#
# 使い方: ./svgview.sh <file.svg>
#
# 概要:
#   指定したSVGファイルをsvg-pan-zoomライブラリを使ったHTMLでラップし、
#   ブラウザで開く。ホイールでズーム、ドラッグでパンができる。
#   mermaidなどで生成した大きな図の確認に便利。

# 引数チェック
if [ -z "$1" ]; then
  echo "Usage: svgview <file.svg>"
  exit 1
fi

SVG_FILE="$1"

# /tmpに一時HTMLファイルを作成（$$はプロセスIDで名前の衝突を避ける）
HTML_FILE="/tmp/svgview_$$.html"

# SVGをインラインで埋め込んだHTMLを生成
# svg-pan-zoomをCDNから読み込み、ズーム・パンを有効にする
cat <<HTML > "$HTML_FILE"
<!DOCTYPE html>
<html style="height:100%">
<head>
<style>
  /* 余白をなくしてSVGを画面全体に表示する */
  * { margin:0; padding:0; box-sizing:border-box; }
  html, body { width:100%; height:100%; overflow:hidden; background:#fff; }
  #container { width:100%; height:100%; }
  #container svg { width:100% !important; height:100% !important; }
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/svg-pan-zoom/dist/svg-pan-zoom.min.js"></script>
<div id="container">
$(cat "$SVG_FILE")
</div>
<script>
  // svg-pan-zoomの初期化: ズーム・コントロールアイコン表示・全体フィット・中央寄せ
  svgPanZoom('svg', {zoomEnabled:true, controlIconsEnabled:true, fit:true, center:true})
</script>
</body>
</html>
HTML

# 生成したHTMLをデフォルトブラウザで開く
open "$HTML_FILE"

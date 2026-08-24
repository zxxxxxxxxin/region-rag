#!/usr/bin/env bash
# Region RAG — 更新 GitHub Pages 跳转目标
#   快速隧道 (trycloudflare) 每次重启 URL 都会变，重启后运行本脚本即可
#   用法:
#     ./update-redirect.sh                    # 自动从 cloudflared.log 提取最新隧道地址
#     ./update-redirect.sh https://xxx.trycloudflare.com   # 手动指定隧道地址
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
DIR="$ROOT/region-rag-redirect"
REPO="git@github.com:zxxxxxxxxin/region-rag.git"

URL="${1:-}"
if [ -z "$URL" ]; then
  URL=$(grep -oE "https://[a-z0-9-]+\.trycloudflare\.com" "$ROOT/cloudflared.log" | tail -1 || true)
fi
if [ -z "$URL" ]; then
  echo "未找到隧道地址，请手动指定: ./update-redirect.sh https://xxx.trycloudflare.com"
  exit 1
fi

cd "$DIR"
sed -i '' "s|url=https://[^\"']*|url=$URL|" index.html
sed -i '' "s|href=\"https://[^\"']*\"|href=\"$URL\"|" index.html

git add index.html
git -c user.name="zhangxin7" -c user.email="zhangxin7@winning.com.cn" \
  commit -q -m "更新跳转目标 -> $URL" || true
git push -q "$REPO" HEAD:gh-pages

echo "已更新跳转页 -> $URL"
echo "访问 https://zxxxxxxxxin.github.io/region-rag/ 验证"

# Region RAG 跳转页

GitHub Pages 静态跳转页，用于把 `https://zxxxxxxxxin.github.io/region-rag/` 自动跳转到 Region RAG 应用当前的外网隧道地址。

## 更新跳转目标

快速隧道 (trycloudflare) 每次重启地址都会变，重启后运行：

```bash
./update-redirect.sh                    # 自动从 cloudflared.log 提取最新隧道地址
./update-redirect.sh https://xxx.trycloudflare.com   # 手动指定隧道地址
```

## 部署

- 仓库: `region-rag`（私有）
- 分支: `gh-pages`
- 页面: `https://zxxxxxxxxin.github.io/region-rag/`

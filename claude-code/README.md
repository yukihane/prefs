Claude Code のステータスライン設定メモです。

## ステータスラインの有効化

`~/.claude/settings.json` に以下を設定して、[ccstatusline](https://github.com/sirmalloc/ccstatusline) を使っています。

```json
"statusLine": {
  "type": "command",
  "command": "npx -y ccstatusline@latest",
  "padding": 0,
  "refreshInterval": 10
}
```

ccstatusline自体の設定（ウィジェット構成）は `~/.config/ccstatusline/settings.json` に保存されます。実体は [ccstatusline-settings.json](./ccstatusline-settings.json) 。
TUIで設定する場合は `npx -y ccstatusline@latest` を実行すると対話画面が開く。

## 使用量制限(5h/1w)をステータスラインに表示する

Claude Code (v2.1.0以降) は statusline コマンド呼び出し時、stdin経由のJSONに `rate_limits` （5時間ウィンドウ・週次ウィンドウ・モデル別の使用率）を含めて渡すようになっている。ccstatuslineはこれを解釈して表示できる。

設定した内容（2行目）:

| ウィジェット (`type`) | 内容 |
|---|---|
| `session-usage` | 5時間ウィンドウの使用率 |
| `weekly-usage` | 週次(1w)の使用率 |
| `weekly-sonnet-usage` | 週次のSonnetモデル使用率 |
| `weekly-opus-usage` | 週次のOpusモデル使用率 |
| `reset-timer` | 5時間ウィンドウのリセットまでの残り時間 |
| `weekly-reset-timer` | 週次ウィンドウのリセットまでの残り時間 |

3行目にはおまけでキャッシュ・セッション情報を追加:

| ウィジェット (`type`) | 内容 |
|---|---|
| `cache-hit-rate` | プロンプトキャッシュのヒット率 |
| `session-clock` | セッション経過時間 |
| `session-cost` | セッションの推定コスト |

ウィジェットの正確な `type` 文字列は、READMEの記載だけでなく実装（[widget-manifest.ts](https://github.com/sirmalloc/ccstatusline/blob/main/src/utils/widget-manifest.ts)）で確認するのが確実。

## モデル別の詳細な使用量集計が欲しい場合

ステータスラインは1行表示のため、日/月/セッション単位の詳細なコスト内訳には向かない。その場合は [ccusage](https://github.com/ryoppippi/ccusage) を使う。

```sh
npx ccusage@latest --breakdown
```

Claude Codeの `~/.claude/projects/` 配下のJSONLログを直接解析して、モデル別コスト内訳やキャッシュトークンの分離集計を出してくれる。

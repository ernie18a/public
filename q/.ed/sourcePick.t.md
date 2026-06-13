# 需求收斂

- 主題只看 `供應鏈 / 產業鏈`
- 只留 `集中且可直接用` 或 `集中但可接受人工看報告` 的來源
- `分散在各家公司各自找` 的來源排除
- 優先 `邊際效益高`、`處理成本低`、`資訊乾淨`

# 符合需求的資料來源

## 第一種：集中且資料乾淨，API / CSV / Feed

| 來源 | 免費 / 付費 | 為什麼符合 |
|---|---|---|
| FactSet Supply Chain Relationships | 付費 | 直接給 key customers / suppliers / competitors，資料結構化，最接近供應鏈圖譜 |
| FactSet Shipping | 付費 | 80M+ shipments，已做 entity linking 與標準化，適合供應鏈追蹤 |
| Panjiva API | 付費 | 有 API，可查 shipper / consignee / HS code，集中且可直接用 |
| Finnhub Supply Chain Relationships | 核心免費，供應鏈端點屬 Premium | 可直接查供應商/客戶關係，但供應鏈模組本身不是免費完整開放 |

## 第二種：集中但沒有 API，可直接看報告或資料庫

| 來源 | 免費 / 付費 | 為什麼符合 |
|---|---|---|
| ImportYeti | 免費 | 公開提單資料已聚合，個人可用性高，處理成本低 |
| SemiAnalysis | 付費 | AI / 半導體供應鏈密度高，適合反推台灣鏈 |
| TrendForce | 付費 | 台灣半導體 / AI / 伺服器供應鏈覆蓋強，訊號密度高 |
| TechInsights | 付費 | teardown / BOM / cost analysis 很接近零件層級 |
| ImportGenius | 付費 | trade data 集中，可直接查，不用自己爬分散資料 |
| Datamyne | 付費 | 集中型海關 / 貿易資料庫，適合找供應鏈流向 |

# 我先排除的

- `OpenBB`、`EODHD`、`TWSE`、`TPEx`、`FRED`：不是供應鏈主資料源，只是市場或宏觀入口
- `Google Trends`、`Reddit`：只適合輔助，不是供應鏈核心
- 各公司各自的 `filings / 法說 / 新聞`：你明確不要分散型來源

# 最有邊際效益的組合

| 組合 | 適用情境 |
|---|---|
| ImportYeti + TrendForce | 免費 / 低成本，適合個人先做反推 |
| SemiAnalysis + TrendForce | 台灣 AI / 半導體供應鏈最實用 |
| FactSet Supply Chain + TechInsights | 最接近專業級供應鏈與 BOM |
| Panjiva + ImportGenius / Datamyne | 想要 trade flow 與 shipment 分析 |

# 最短結論

- `免費且最實用`：`ImportYeti`
- `低處理成本且高訊號`：`SemiAnalysis`、`TrendForce`
- `最接近 BOM / 供應鏈圖譜`：`TechInsights`、`FactSet Supply Chain`
- `最像可直接用的資料 feed / API`：`FactSet`、`Panjiva`、`Finnhub Supply Chain`

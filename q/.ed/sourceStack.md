前提檢查：成立。  
補充條件已納入：原始資料分散不是問題，若已被整合成單一來源、可搜尋、可 API 化、或可批次處理，仍視為可用。

| 排名 | 資料來源 / 方案 | 資料類型 | 成本可負擔 | 自動化/API | 結構化程度 | 處理成本低 | 投資訊號價值 | 供應鏈/BOM 接近度 | 綜合分 | 判斷 |
|---:|---|---|---:|---:|---:|---:|---:|---:|---:|---|
| 1 | OpenBB + Finnhub + EODHD / Twelve Data | 市場資料、基本面、新聞、部分供應鏈 metadata | 5 | 5 | 4 | 4 | 4 | 2 | 4.0 | 最符合低成本、自動化、可擴充 |
| 2 | SEC filings + earnings transcripts 聚合平台 | 10-K、10-Q、8-K、法說會逐字稿 | 4 | 3 | 4 | 4 | 5 | 3 | 3.8 | 若已集中整理，價值很高 |
| 3 | FRED + BLS + IMF + USAspending.gov + OpenSecrets | 宏觀、政府支出、政治/政策資料 | 5 | 5 | 5 | 5 | 3 | 1 | 3.8 | 官方、免費、結構化、穩定 |
| 4 | ETF issuer data / ETF holdings API | ETF 持股、產業配置、資金流 | 5 | 3 | 4 | 4 | 4 | 2 | 3.7 | 追蹤機構配置與產業曝險 |
| 5 | AlphaSense / Tegus / Quartr / Koyfin 類文字聚合平台 | 法說會、研究報告、新聞、管理層語音 | 2 | 3 | 4 | 4 | 5 | 3 | 3.5 | 高成本但降低非結構化處理成本 |
| 6 | Import manifest / shipping data：ImportYeti、Panjiva、ImportGenius、Datamyne | 海關、出貨、供應鏈流向 | 3 | 3 | 3 | 2 | 5 | 4 | 3.3 | 接近供應鏈 intelligence，但清洗成本高 |
| 7 | SemiAnalysis / 產業深度研究 | 半導體、AI infra、產業分析 | 3 | 1 | 3 | 4 | 5 | 4 | 3.3 | 適合作為判斷層，不適合作為資料底層 |
| 8 | TechInsights / teardown reports | 拆機、BOM、零組件 | 1 | 1 | 4 | 4 | 5 | 5 | 3.2 | 最接近 BOM，但個人可負擔性差 |
| 9 | Google Trends / Exploding Topics / Reddit 類情緒趨勢資料 | 搜尋熱度、討論熱度、早期趨勢 | 5 | 3 | 2 | 2 | 3 | 1 | 2.7 | 適合輔助，不適合當核心資料源 |
| 10 | 原始公司官網法說會 / PDF / 新聞稿自行收集 | 分散文字資料 | 5 | 1 | 1 | 1 | 4 | 3 | 2.5 | 免費但隱性成本高 |
| 11 | Bloomberg Terminal / FactSet / Refinitiv | 專業金融終端、供應鏈關係、研究資料 | 1 | 3 | 5 | 5 | 5 | 3 | 2.5 | 功能強，但不符合個人低成本 |
| 12 | Gartner / IDC / Omdia / Counterpoint | 市調、產業報告、出貨量、品牌份額 | 1 | 1 | 4 | 4 | 4 | 3 | 2.3 | 高價、偏報告型，適合驗證 |

| 優先級 | 組合 | 用途 | 為什麼適合 |
|---:|---|---|---|
| 1 | OpenBB + Finnhub + EODHD / Twelve Data | 基礎金融資料層 | 低成本、API 友善、可自動化 |
| 2 | SEC filings + transcripts 聚合源 | 公司敘事、風險、供應鏈線索 | 解決法說會分散問題，訊號價值高 |
| 3 | FRED / BLS / USAspending / OpenSecrets | 宏觀、政策、政府需求 | 官方、免費、結構化、穩定 |
| 4 | ETF holdings / issuer data | 產業曝險與機構配置 | 便宜、可量化、容易納入 pipeline |
| 5 | Shipping / import data | 供應鏈驗證 | 有 edge，但清洗成本高，應放後面 |

最高邊際效益不是買單一昂貴資料庫，而是：

`低成本 API 金融資料 + 集中式 transcript/filing + 官方宏觀/政策資料 + ETF 持股 + 選擇性 shipping data`

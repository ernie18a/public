> From: https://chatgpt.com/c/6a1986a2-89d8-8320-87b8-35e00ec1c55d

# you asked

message time: 2026-05-29 20:31:11

美國這些投資可以利用的資料呢哪一些是資料集中的? 免費的? 資料是否容易量化或是處理? 或者需要額外的 LLM 來分析? 你用表格來呈現 讓我一目了然: 

---

  - SEC filings

  - 10-K / 20-F

  - earnings transcripts

  - FRED

  - BLS / IMF

  - USAspending.gov

  - OpenSecrets

  - ETF issuer data

  - import manifest

  - company supplier disclosures

---

# chatgpt response

| 資料來源 | 免費? | 結構化程度 | 容易量化? | 是否適合做 Alpha / 因子研究 | 是否需要 LLM | 常見用途 | 技術難度 |
|---|---|---|---|---|---|---|---|
| SEC filings | 大部分免費 | 半結構化 (HTML/XBRL/PDF) | 中高 | 很高 | 部分需要 | 財報異常、風險變化、管理層語氣 | 中 |
| 10-K / 20-F | 免費 | 中高（XBRL 可結構化） | 高 | 非常高 | 可選 | 基本面、segment analysis、risk factor drift | 中 |
| earnings transcripts | 部分免費 | 非結構化文字 | 中 | 高 | 很需要 | 管理層語氣、guidance、Q&A 情緒 | 中高 |
| FRED | 免費 | 高度結構化 | 非常高 | 高 | 不需要 | macro regime、利率、流動性模型 | 低 |
| BLS / IMF | 免費 | 高度結構化 | 高 | 高 | 不需要 | 通膨、就業、全球 macro | 低 |
| USAspending.gov | 免費 | 半結構化 | 中高 | 中高 | 有幫助 | 政府承包商、國防支出追蹤 | 中 |
| OpenSecrets | 大部分免費 | 半結構化 | 中 | 中 | 有幫助 | 政治資金流向、監管風險 | 中 |
| ETF issuer data | 大部分免費 | 高結構化 | 非常高 | 很高 | 不需要 | holdings flow、sector rotation | 低 |
| import manifest | 部分付費 | 半結構化 | 中 | 很高 | 有幫助 | 供應鏈、庫存、需求追蹤 | 高 |
| company supplier disclosures | 免費但分散 | 非結構化 | 中低 | 很高 | 很需要 | supplier dependency、hidden exposure | 高 |

---

更實際的拆解如下：

### 1. SEC filings
包含：
- 8-K
- 10-K
- 10-Q
- S-1
- insider filings

最核心的是：
- XBRL 財務欄位 → 可直接量化
- MD&A → 要 NLP
- risk factors → 要 NLP/LLM

資料來源：
- 

適合：
- systematic fundamental
- fraud detection
- accounting anomaly

不適合：
- 超短線交易

LLM 角色：
- 摘要
- risk factor diff
- 管理層語氣變化
- segment extraction

---

### 2. 10-K / 20-F
20-F 是外國公司版 10-K。

其實是 SEC filings 的子集合，但投資上權重極高。

優勢：
- XBRL 極容易結構化
- 幾乎所有 quant fundamental fund 都會吃

容易提取：
- revenue growth
- margins
- capex
- debt
- segment revenue

難提取：
- 競爭風險
- 地緣風險
- AI exposure
- China exposure

LLM 很適合：
- semantic comparison
- 風險變化偵測
- “新增了哪些風險敘述”

---

### 3. earnings transcripts
來源：
- Seeking Alpha
- AlphaSense
- FactSet
- Bloomberg
- company IR pages

問題：
- 很多不是官方免費 API
- 法律限制較多

真正 alpha 在：
- analyst Q&A
- management hesitation
- guidance wording

這類資料：
傳統 NLP 效果有限，
LLM 效果通常顯著更好。

例如：
- evasiveness
- confidence score
- hidden downgrade tone

量化難度：
中高。

---

### 4. FRED
官方來源：
- 

極度乾淨。

最容易做：
- macro regime model
- yield curve
- recession probability
- liquidity indicators

幾乎：
- 不需要 LLM
- 不需要 NLP

非常適合：
- time-series factor
- macro overlay

---

### 5. BLS / IMF
來源：
- 
- 

高度結構化。

常用：
- CPI
- PPI
- payroll
- wage growth
- global debt

問題：
alpha 容易被套利掉。

真正有價值的是：
- cross-country relative change
- surprise vs expectation

LLM 幾乎沒必要。

---

### 6. USAspending.gov
來源：
- 

用途：
追蹤：
- 國防訂單
- 政府 IT
- infrastructure spending

典型 alpha：
- contract wins before earnings impact
- budget trend detection

問題：
entity matching 很煩。

例如：
- Lockheed Martin
- LMT
- subsidiary names

LLM 可幫：
- entity resolution
- contract classification

---

### 7. OpenSecrets
來源：
- 

適合：
- regulatory forecasting
- lobbying intensity
- political exposure

可做：
- pharma
- defense
- crypto
- energy

限制：
真正 predictive alpha 不穩定。

比較偏：
- risk overlay
- event analysis

LLM 用途：
- lobbying topic extraction
- bill linkage

---

### 8. ETF issuer data
來源：
- BlackRock
- Vanguard
- State Street
- Ark
- issuer CSVs

例如：
- holdings
- rebalance
- flow

非常容易量化。

尤其：
- passive flow pressure
- crowding
- thematic exposure

這類：
幾乎不用 LLM。

是最容易做 production 的資料之一。

---

### 9. import manifest
例如：
- Panjiva
- ImportGenius
- Datamyne

核心：
海運資料。

可看到：
- shipment volume
- supplier activity
- inventory trend

極強 alpha：
尤其：
- retail
- semis
- industrials

但問題：
- 很貴
- 清洗困難
- entity mapping 地獄

LLM 可幫：
- supplier normalization
- product categorization

但：
真正困難是 data engineering。

---

### 10. company supplier disclosures
來源非常分散：
- Apple supplier list
- Tesla supplier leaks
- ESG reports
- customs data
- lawsuits
- procurement docs

這類是：
最有 alpha 潛力，
也是最難 industrialize。

原因：
- 非標準化
- 很多 PDF
- entity ambiguity
- tier-2/tier-3 supplier 關係難追

LLM 在這裡價值非常高：
- graph extraction
- relationship extraction
- supply-chain mapping

這類通常會變成：
knowledge graph 系統。

---

如果用「投資資料的實戰價值 / 難度」來排序：

| 類型 | Alpha 潛力 | 工程難度 | LLM 價值 |
|---|---|---|---|
| ETF flows | 中高 | 低 | 低 |
| FRED/BLS | 中 | 低 | 很低 |
| 10-K XBRL | 高 | 中 | 中 |
| earnings transcripts | 高 | 中高 | 高 |
| import manifest | 非常高 | 非常高 | 中 |
| supplier disclosures | 非常高 | 極高 | 非常高 |
| OpenSecrets | 中 | 中 | 中 |
| USAspending | 中高 | 中 | 中 |

最容易快速做出有效策略：
1. ETF holdings + flows
2. FRED macro regime
3. SEC XBRL fundamentals

最容易形成護城河：
1. supplier graph
2. import manifest
3. transcript semantic models

最依賴 LLM：
1. earnings transcripts
2. supplier disclosures
3. SEC risk-factor analysis

---

# you asked

message time: 2026-05-29 20:58:06

這些也用同樣的表格來做分析我要知道哪些表格邊際效益比較高哪些表格編輯效益比較低根據我的需求:
---
  - OpenBB
  - Finnhub / EODHD / Twelve Data
  - SEC / FRED / USAspending / OpenSecrets
  - ETF issuer data
  - import / shipping data
  - teardown / industry reports
  - earnings transcripts

---

# chatgpt response

| 資料來源 | 免費程度 | 資料型態 | 結構化程度 | 量化難度 | LLM 需求 | 工程成本 | Alpha 潛力 | 邊際效益（對小團隊/個人） | 容易被市場套利? | 核心問題 |
|---|---|---|---|---|---|---|---|---|---|---|
|  | 免費核心 | 聚合 API / SDK | 高 | 低 | 幾乎不用 | 低 | 中 | 高 | 高 | 沒有獨家資料 |
|  /  /  | freemium | 市場資料 API | 高 | 低 | 不需要 | 低 | 中 | 中高 | 很高 | commoditized |
|  /  /  /  | 免費 | 官方資料 | 中高 | 中 | 部分需要 | 中 | 高 | 很高 | 中 | 清洗與 entity mapping |
| ETF issuer data | 大部分免費 | holdings / flows | 非常高 | 很低 | 不需要 | 很低 | 中高 | 非常高 | 高 | alpha decay 快 |
| import / shipping data | 多數昂貴 | 海關 / shipment | 中 | 高 | 中 | 非常高 | 非常高 | 高 | 中低 | data cleaning 地獄 |
| teardown / industry reports | 多數付費 | PDF / research | 低 | 高 | 很需要 | 高 | 很高 | 中高 | 低 | extraction 困難 |
| earnings transcripts | 部分免費 | 非結構化文字 | 中低 | 中高 | 非常需要 | 中高 | 高 | 高 | 中 | tone/context 很難傳統量化 |

---

如果你的目標是：

- 「個人或小團隊」
- 「有限資金」
- 「建立長期可擴展 alpha」
- 「不想跟 Citadel 拼 ultra-low latency」

那邊際效益最高的其實不是最貴資料。

真正高 ROI 的是：

| 類型 | ROI |
|---|---|
| SEC + FRED + ETF flows | 非常高 |
| earnings transcripts + LLM | 高 |
| supplier / shipping graph | 長期極高 |
| teardown reports | niche 高 |
| 純 market data API | 低 |

---

更細的分析：

# 1. OpenBB

本質：
是 aggregation layer。

它不是 alpha source。

它是：
「降低 data engineering 成本」。

適合：
- prototype
- research stack
- 快速回測

不適合：
- 護城河

因為：
所有人都能 access 同樣 datasource。

邊際效益高原因：
- 節省時間
- 快速驗證 idea

邊際效益低原因：
- 不產生獨家 insight

適合你目前階段：
非常適合。

---

# 2. Finnhub / EODHD / Twelve Data

這類：
本質是 commodity data pipe。

包括：
- OHLCV
- fundamentals
- insider
- forex
- crypto
- websocket

問題：

市場上：
任何人都能拿到。

所以：

你不能靠：
「資料本身」

賺錢。

只能靠：
- feature engineering
- strategy
- execution

真正問題：
edge 非常薄。

除非：
你做的是：
- execution infra
- HFT
- alt-feature fusion

否則：
單靠這類 API 很難建立 moat。

---

# 3. SEC / FRED / USAspending / OpenSecrets

這是最被低估的一組。

原因：

它們：
- 免費
- 官方
- 長期存在
- 法律穩定

而且：

真正 alpha 不在 raw data。

而在：
cross-linking。

例如：

```text
SEC risk disclosure
+
government contract
+
lobbying increase
+
ETF ownership crowding
```

這種：
cross-domain graph

反而是小團隊能打大型基金的地方。

因為：

大機構常常：
資料太多、
流程太重。

小團隊：
更容易快速建立 semantic layer。

這裡：
LLM 很有價值。

尤其：
- entity linking
- topic extraction
- risk classification
- relationship graph

---

# 4. ETF issuer data

這是：
最容易產生可交易 signal 的資料之一。

原因：

被動資金：
真的會影響價格。

尤其：
- rebalance
- thematic ETF
- concentration
- crowded trades

你可以做：

```text
ETF inflow
→ constituent pressure
→ delayed price effect
```

這種 strategy。

優點：
- 超容易量化
- CSV 通常直接能吃
- 幾乎不需要 NLP

缺點：
edge decay 很快。

但：
對個人最友善。

---

# 5. import / shipping data

這是真正 institutional-grade alpha。

因為：

它直接反映：
- demand
- inventory
- supplier activity

問題：

工程難度爆炸。

真正困難不是模型。

而是：

```text
company normalization
supplier matching
shipment deduplication
product taxonomy
```

這些。

這種資料：
80% 成本在 cleaning。

不是 AI。

很多人誤判：
LLM 能解決。

其實：
LLM 只能解決 20%。

真正問題是：
dirty data infra。

但一旦做起來：
moat 很深。

---

# 6. teardown / industry reports

這類常被忽略。

例如：
- TechInsights
- Yole
- Gartner
- Canalys
- Counterpoint

價值極高原因：

它們提供：
industry structure。

例如：
- iPhone BOM
- NVIDIA supply chain
- HBM content
- wafer capacity
- AI server mix

這種：
是市場常沒有 fully priced 的資訊。

但：

問題是：
PDF hell。

所以：

LLM 在這裡：
效果非常好。

尤其：
- table extraction
- relationship extraction
- trend summarization

但：
你仍然需要人工 validation。

---

# 7. earnings transcripts

這是：
目前 LLM 最有實戰價值的地方之一。

因為：

管理層語言：
有大量 latent signal。

例如：
- confidence
- hedging
- evasion
- wording shift
- guidance downgrade

傳統 NLP：
抓不到 context。

LLM：
開始有能力。

但真正問題：

不是「分析一次 transcript」。

而是：

```text
跨季度比較
跨公司比較
跨產業比較
```

這需要：
- vector DB
- semantic diff
- retrieval infra

所以：
不是單純 prompt engineering。

---

如果用「你投入 1 單位工程成本，能得到多少 alpha」來排名：

| 類型 | 邊際效益 |
|---|---|
| ETF issuer data | 非常高 |
| SEC XBRL | 非常高 |
| FRED macro | 高 |
| earnings transcripts + LLM | 高 |
| USAspending + OpenSecrets graph | 高 |
| teardown reports | 中高 |
| shipping/import data | 長期極高，但前期極差 |
| commodity price APIs | 低 |

---

如果用「最容易形成護城河」來排名：

| 類型 | 護城河 |
|---|---|
| supplier graph | 極高 |
| shipping normalization | 極高 |
| transcript semantic history | 高 |
| teardown extraction system | 高 |
| ETF flow model | 中 |
| SEC factor model | 中 |
| OpenBB / market APIs | 很低 |

---

如果用「LLM 真正有價值的地方」來排名：

| 類型 | LLM 價值 |
|---|---|
| earnings transcripts | 極高 |
| supplier disclosures | 極高 |
| teardown reports | 極高 |
| SEC risk factors | 高 |
| OpenSecrets lobbying text | 中 |
| ETF holdings | 幾乎沒有 |
| FRED/BLS | 幾乎沒有 |
| OHLCV market data | 沒有 |
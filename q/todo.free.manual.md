# todo.free.manual

## 本文件目標

取得「免費或 free tier、簡單、但需要人工註冊/API key/帳戶」的資料來源。

需求範圍：

```text
Regime Detection
Change Point Detection
Matrix Profile + Pattern Class
Vectorized Backtesting
timeframe >= 30m；1h / 2h / 4h 更可接受
非 HFT；不需要 tick、order book、低延遲
```

本文件是資料申請與下載工具規劃，不是系統整合設計。

## Status Tracking

本文件只定義來源與下載邊界，不追蹤執行狀態。

執行狀態記錄於：

```text
STATUS.free.manual.md
```

使用規則：

```text
1. 每次處理 manual 線任務，先讀 STATUS.free.manual.md 的 Next。
2. 若 Next 已完成或不成立，再回讀本文件找下一個 pending source。
3. Completed / Blocked / Skipped / Pending Credential / Last Raw Capture 只更新 STATUS.free.manual.md。
4. 不在本文件追蹤每日執行狀態。
```

## 下載邊界

本文件只處理 access probe 與 raw data 取得。

做：

```text
註冊/API key/帳戶需求記錄
access token 是否可用
sample raw download
raw response 保存
source metadata 保存
volume availability 確認
```

不做：

```text
缺漏補值
資料清理
resample
adjusted price 校正
feature engineering
backtest sanity check
matrix profile / regime / change point 驗證
```

## Manual Credential Rule

AI 不得假設或硬編 token。

遇到需要帳號、API key、token、券商權限時：

```text
[ ] 標註 manual_required: yes
[ ] 標註需要使用者提供的 credential 名稱
[ ] 不把缺 token 當作來源失敗
[ ] 不嘗試繞過登入或權限
[ ] token 僅能從使用者提供的 env var / secret 設定讀取
[ ] 不把 token 寫入文件、log、OUTPUT、TMP
```

建議 credential 形態：

```text
ITICK_API_KEY
FUBON_NEO_ACCOUNT / FUBON_NEO_TOKEN
TWELVE_DATA_API_KEY
EODHD_API_KEY
FINNHUB_API_KEY
FMP_API_KEY
ALPHA_VANTAGE_API_KEY
POLYGON_API_KEY
ALPACA_API_KEY / ALPACA_SECRET
```

## Raw Download Contract

每個 manual 來源先做 access probe，再決定是否開 downloader。

```text
[ ] signup/API key requirement documented
[ ] credential env var name documented
[ ] access token works
[ ] sample raw download works
[ ] raw response saved
[ ] source metadata saved
[ ] writes only OUTPUT/ and TMP/
[ ] volume availability checked
```

metadata 至少記錄：

```text
source
url
retrieved_at
request_params
manual_required
credential_env_names
raw_files
expected_use
expected_frequency
volume_status
volume_fields_found
```

## Volume Availability Gate

volume 是確認項，不是硬性完成條件。

```text
volume_status:
  unknown      尚未驗證，不准假設有 volume
  available    確認有 volume-like 欄位
  unavailable  確認沒有 volume-like 欄位
  partial      有 turnover / amount / contracts / open_interest 等近似欄位

volume_required_for_current_stage: no

volume-like fields:
  volume
  turnover
  成交股數
  成交金額
  contracts
  open_interest
```

決策規則：

```text
[ ] volume availability checked
[ ] if unavailable, mark source as price_only / regime_only
[ ] if partial, save raw fields without interpretation
[ ] if available, save raw volume-like fields without cleaning
```

## 篩選規則

保留：

```text
免費或 free tier
簡單
需要人工註冊、API key、券商帳戶、或資料權限
可用 API / SDK / download 取得資料
可能支援 intraday historical OHLCV 或能輔助 regime
```

排除：

```text
純付費且沒有 free tier
中等爬蟲來源
純 dashboard 且無法穩定匯出
和 >=30m 回測主線無關的 disclosure / supply chain / BOM 資料
```

## 決策

這份是 `>=30m / 1h / 4h` 主資料的主要候選。

不用人工註冊的免費來源多數偏 daily / macro。  
若要穩定 hourly-based OHLCV，實務上大概率要從本文件來源選一個或多個。

## Layer 1: Intraday OHLCV 主候選

### iTick

```text
source: iTick
url: https://docs.itick.org/en/rest-api/stocks/stock-ticks
source_family: market_data
access: api
pricing: inferred free;paid
difficulty: 簡單
manual_required: yes
manual_action: 註冊 / API key / 權限確認
market_fit: Taiwan
historical: described as intraday and basic historical quote
timeframe_fit: high for >=30m if historical depth is sufficient
fit: Vectorized Backtesting / Change Point / Matrix Profile / Regime
```

用途：

```text
台灣市場 intraday 主候選
若能取得足夠歷史，後續流程再評估 timeframe 處理
```

需人工確認：

```text
free tier 是否可用
歷史深度
bar 或 tick 欄位
台股 symbol 格式
rate limit
是否允許批次下載
```

### Fubon Neo API

```text
source: Fubon Neo API
url: https://www.fbs.com.tw/TradeAPI/en/docs/market-data/http-api/getting-started
source_family: market_data
access: api / websocket
pricing: inferred free;paid
difficulty: 簡單
manual_required: yes
manual_action: 券商帳戶 / API 權限
market_fit: Taiwan TWSE / TPEx / TAIFEX
historical: needs confirmation
timeframe_fit: high if historical endpoint exists；otherwise realtime only
fit: 台灣 intraday / futures / market state
```

用途：

```text
台灣股票、櫃買、期貨行情
若有歷史 bar endpoint，可作主資料
若只有即時資料，則不適合直接做歷史回測
```

需人工確認：

```text
是否支援歷史 K 線
是否直接支援 30m/1h/4h；否則只標註 raw lower timeframe
帳戶條件
API 使用限制
```

### Twelve Data

```text
source: Twelve Data
url: https://twelvedata.com/
source_family: market_data
access: api
pricing: inferred free;paid
difficulty: 簡單
manual_required: yes
manual_action: 註冊 / API key
market_fit: global
historical: global historical and real-time market data
timeframe_fit: high for >=30m if free tier allows enough history
fit: global intraday OHLCV main candidate
```

用途：

```text
全球股票/ETF/FX/crypto 等市場資料候選
適合先用 1h/4h 降低 API 壓力
```

需人工確認：

```text
free tier 歷史長度
每分鐘/每日 call limit
支援市場
raw 欄位與 provider metadata
```

### EODHD

```text
source: EODHD
url: https://eodhd.com/
source_family: market_data
access: api
pricing: inferred free;paid
difficulty: 簡單
manual_required: yes
manual_action: 註冊 / API key
market_fit: global；含 Taiwan coverage claim
historical: EOD / intraday / fundamental
timeframe_fit: medium-high for >=30m if plan allows intraday history
fit: OHLCV / baseline / fundamentals auxiliary
```

用途：

```text
低價 API 候選
可作 Twelve Data 備援或對照源
```

需人工確認：

```text
free tier 是否含 intraday historical
台灣市場覆蓋深度
資料調整方式
rate limit
```

### Finnhub

```text
source: Finnhub
url: https://www.finnhub.io/
source_family: market_data
access: api
pricing: inferred free;paid
difficulty: 簡單
manual_required: yes
manual_action: 註冊 / API key
market_fit: global
historical: real-time/news/fundamental；intraday availability needs plan check
timeframe_fit: medium for >=30m
fit: OHLCV candidate / news regime / fundamentals auxiliary
```

用途：

```text
市場資料 + 新聞 + 基本面 API
可同時支援價格與事件/新聞 regime
```

需人工確認：

```text
free tier 是否足夠下載歷史 bar
symbol coverage
rate limit
新聞資料是否可批次歷史回補
```

## Layer 2: 備援市場資料

### FMP

```text
source: FMP
url: https://site.financialmodelingprep.com/developer/docs/stable
source_family: market_data
access: api
pricing: inferred free;paid
difficulty: 簡單
manual_required: yes
manual_action: API key
market_fit: global / US stronger
historical: fundamentals, options, ETF, market data
timeframe_fit: medium；intraday free limit needs confirmation
fit: market/fundamental backup
```

用途：

```text
備援資料源
若 Twelve Data / EODHD 已覆蓋，優先度下降
```

### Alpha Vantage

```text
source: Alpha Vantage
url: https://www.alphavantage.co/
source_family: market_data
access: api
pricing: inferred free;paid
difficulty: 簡單
manual_required: yes
manual_action: API key
market_fit: global / US stronger
historical: market data API
timeframe_fit: medium-low；free quota pressure
fit: fallback only
```

用途：

```text
小規模測試或備援
```

限制：

```text
免費額度通常是瓶頸。
不適合大量 universe 的 vectorized backtesting。
```

### Polygon

```text
source: Polygon
url: https://polygon.io/docs/rest/quickstart
source_family: market_data
access: api
pricing: inferred free;paid
difficulty: 簡單
manual_required: yes
manual_action: API key / plan
market_fit: US market
historical: market data API
timeframe_fit: medium；free tier restrictions likely
fit: US intraday candidate if plan allows
```

用途：

```text
美股 intraday 備選
```

限制：

```text
免費層限制需確認。
若成本不優，排在 Twelve Data / EODHD 後面。
```

### Alpaca

```text
source: Alpaca
url: https://alpaca.markets/data
source_family: market_data
access: api
pricing: inferred free;paid
difficulty: 簡單
manual_required: yes
manual_action: brokerage/account-linked access
market_fit: US market
historical: brokerage-linked market data
timeframe_fit: medium
fit: US OHLCV candidate
```

用途：

```text
美股資料與交易帳戶整合候選
```

限制：

```text
帳戶條件與資料方案需人工確認。
```

## 高風險節點

```text
1. free;paid 不等於免費可用；必須逐一驗證 free tier。
2. intraday endpoint 不等於長歷史 intraday endpoint。
3. 30m/1h/4h 不可假設可得；只能記錄 provider 原始支援狀態。
4. API rate limit 會直接限制 vectorized backtesting 的 universe 大小。
5. 台灣市場交易時段、午盤、假日、除權息只記錄 metadata，不在本階段處理。
```

## Manual Application Checklist

```text
[ ] iTick
    [ ] 完成註冊 / API key
    [ ] credential env var name documented
    [ ] 確認 free tier 是否可用
    [ ] 確認台股 intraday historical 支援
    [ ] 確認 30m / 1h / 4h 可直接取得；否則標註 raw lower timeframe only
    [ ] 記錄 rate limit / daily quota
    [ ] 記錄歷史深度
    [ ] 記錄 symbol format
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked

[ ] Fubon Neo API
    [ ] 確認券商帳戶條件
    [ ] 確認 market data 權限
    [ ] credential env var name documented
    [ ] 確認是否有歷史 K 線 endpoint
    [ ] 確認 TWSE / TPEx / TAIFEX coverage
    [ ] 確認是否只能 realtime
    [ ] 記錄 API 限制
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked

[ ] Twelve Data
    [ ] 完成註冊 / API key
    [ ] credential env var name documented
    [ ] 確認 free tier intraday historical
    [ ] 確認 30m / 1h / 4h 支援
    [ ] 確認目標市場 coverage
    [ ] 記錄 rate limit
    [ ] 記錄歷史深度
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked

[ ] EODHD
    [ ] 完成註冊 / API key
    [ ] credential env var name documented
    [ ] 確認 free tier 是否含 intraday
    [ ] 確認台灣/美股 coverage
    [ ] 記錄 intraday 歷史深度
    [ ] 記錄 rate limit
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked

[ ] Finnhub
    [ ] 完成註冊 / API key
    [ ] credential env var name documented
    [ ] 確認 free tier historical candle 限制
    [ ] 確認 30m / 1h / 4h 支援
    [ ] 確認 news historical access
    [ ] 記錄 rate limit
    [ ] 記錄 market coverage
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked

[ ] FMP
    [ ] 完成註冊 / API key
    [ ] credential env var name documented
    [ ] 確認 free tier intraday 限制
    [ ] 確認是否只作備援
    [ ] 記錄 rate limit
    [ ] 記錄 market coverage
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked

[ ] Alpha Vantage
    [ ] 完成註冊 / API key
    [ ] credential env var name documented
    [ ] 確認 free quota
    [ ] 確認 intraday historical depth
    [ ] 確認是否只作小規模備援
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked

[ ] Polygon
    [ ] 完成註冊 / API key
    [ ] credential env var name documented
    [ ] 確認 free tier 是否足夠
    [ ] 確認 US intraday historical access
    [ ] 記錄 plan 限制
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked

[ ] Alpaca
    [ ] 確認帳戶條件
    [ ] credential env var name documented
    [ ] 確認 market data plan
    [ ] 確認 historical bars endpoint
    [ ] 記錄 coverage / limit
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked

```

## Validation Checklist

```text
[ ] free tier 條件已截圖或文字記錄
[ ] API key 申請流程已記錄
[ ] endpoint 文件已保存連結
[ ] 目標 timeframe >=30m 已確認
[ ] 可取得至少 1 年歷史；不足則標註 prototype only
[ ] sample raw download works
[ ] raw response 已保存
[ ] source metadata 已保存
[ ] volume availability 已標註
[ ] rate limit 對 universe 大小的影響已估算
[ ] license / redistribution restriction 已記錄
[ ] token 未寫入文件、log、OUTPUT、TMP
[ ] no cleaning / resample / feature engineering
```

## Decision Checklist

```text
[ ] 保留為主 intraday 資料源
[ ] 保留為備援資料源
[ ] 保留為 news / regime auxiliary
[ ] 移除
[ ] 移到 todo.crawler.md
```

## 下一步驗證

```text
1. 優先人工確認 iTick：free tier、歷史深度、台股 intraday 支援。
2. 優先人工確認 Twelve Data：1h/4h 歷史長度與免費額度。
3. 對照 EODHD：台灣市場與 intraday 是否需要付費。
4. 若做台灣期貨，確認 Fubon Neo API 是否提供歷史 K 線。
5. 最終只保留 1-2 個主資料源，避免維護成本過高。
```

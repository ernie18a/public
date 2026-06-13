# todo.free.auto

## 本文件目標

取得「不用人工註冊、免費、簡單、可直接用代碼下載」的資料來源。

需求範圍：

```text
Regime Detection
Change Point Detection
Matrix Profile + Pattern Class
Vectorized Backtesting
timeframe >= 30m；1h / 2h / 4h / daily 都可接受
非 HFT；不需要 tick、order book、低延遲
```

本文件是下載工具規劃，不是交易系統架構。

## Status Tracking

本文件只定義來源與下載邊界，不追蹤執行狀態。

執行狀態記錄於：

```text
STATUS.free.auto.md
```

使用規則：

```text
1. 每次處理 auto 線任務，先讀 STATUS.free.auto.md 的 Next。
2. 若 Next 已完成或不成立，再回讀本文件找下一個 pending source。
3. Completed / Blocked / Skipped / Last Raw Capture 只更新 STATUS.free.auto.md。
4. 不在本文件追蹤每日執行狀態。
```

## 下載邊界

本文件只處理 raw data 取得。

做：

```text
endpoint/access 驗證
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

## Raw Download Contract

每個來源的下載工具只需完成：

```text
[ ] endpoint/access verified
[ ] sample raw download works
[ ] raw response saved
[ ] source metadata saved
[ ] no manual step hidden
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
免費
簡單
不用人工註冊
不用 API key 申請
不用券商帳戶
可由腳本直接下載或呼叫公開端點
能形成價格序列、macro regime 序列、事件序列、或 baseline 回測資料
```

移除：

```text
需要登入
需要人工申請 API key
需要券商權限
只提供 terminal / dashboard
純文字研究報告
供應鏈/BOM/政治人物交易等難以直接對齊 >=30m 回測主線的資料
```

## 決策

不用人工註冊的免費來源足夠做：

```text
daily baseline
macro regime
event shock feature
台灣市場官方資料 baseline
vectorized backtesting pipeline sanity check
```

不用人工註冊的免費來源不保證足夠做：

```text
長期 30m historical OHLCV
穩定 1h / 4h intraday OHLCV
多市場批次 intraday 回測
```

因此本文件的資料源分成三層：

```text
Layer 1: 主價格 / 市場序列
Layer 2: Regime 輔助序列
Layer 3: Baseline / sanity check
```

## Layer 1: 主價格 / 市場序列

### Stooq

```text
source: Stooq
url: https://stooq.com/db/h/
source_family: market_data
access: download
pricing: verified_free
difficulty: 簡單
manual_required: no
historical: yes
timeframe_fit: daily baseline；不當 intraday 主資料
fit: Vectorized Backtesting / Change Point / Matrix Profile pipeline baseline
```

用途：

```text
免費歷史價格下載
先取得 raw historical price data，供後續流程驗證
```

限制：

```text
主要價值在 daily historical。
不符合 30m/1h/4h 主資料需求。
```

### TWSE

```text
source: TWSE
url: https://www.twse.com.tw/en/products/dataeshop.html
source_family: market_data
access: api / csv partial
pricing: verified_free
difficulty: 簡單
manual_required: no
historical: partial
timeframe_fit: 多數偏日頻；盤中可用性需逐端點驗證
fit: 台股 baseline / market regime / vectorized backtesting sanity check
```

用途：

```text
台股官方市場資料
台股 universe、日線 baseline、成交量/市場狀態特徵
```

限制：

```text
不先假設可穩定取得長期 30m/1h OHLCV。
```

### TPEx

```text
source: TPEx
url: https://www.tpex.org.tw/en-us/service/data/overview.html
source_family: market_data
access: api / csv partial
pricing: verified_free
difficulty: 簡單
manual_required: no
historical: partial
timeframe_fit: 多數偏日頻；盤中可用性需逐端點驗證
fit: 櫃買 baseline / market regime / vectorized backtesting sanity check
```

用途：

```text
補足櫃買市場資料
台股市場寬度與不同板塊 regime 特徵
```

限制：

```text
不當作 hourly intraday 主來源。
```

### TAIFEX

```text
source: TAIFEX
url: https://openapi.taifex.com.tw/
source_family: market_data
access: api
pricing: verified_free
difficulty: 簡單
manual_required: no
historical: partial
timeframe_fit: 期貨/選擇權資料；盤中與歷史深度需逐端點驗證
fit: Regime Detection / Change Point / volatility regime
```

用途：

```text
期貨、選擇權、市場避險狀態
台指期與選擇權可作台股 regime 特徵
```

限制：

```text
需驗證端點是否能直接組出 30m/1h/4h OHLCV。
即使不能，也可作 daily / session-level regime feature。
```

## Layer 2: Regime 輔助序列

### FRED

```text
source: FRED
url: https://fred.stlouisfed.org/docs/api/fred/overview.html
source_family: macro_policy
access: api
pricing: verified_free
difficulty: 簡單
manual_required: no for public/no-key usage；正式高額度可能需 API key
historical: yes
timeframe_fit: daily / weekly / monthly / quarterly macro
fit: Regime Detection
```

用途：

```text
利率、通膨、信用利差、景氣、美元流動性
作為低頻 regime feature，不作交易 bar 主資料
```

限制：

```text
頻率低於 30m/1h。
只記錄資料頻率與 release metadata；不做對齊處理。
```

### CBC API

```text
source: CBC API
url: https://cpx.cbc.gov.tw/Data/ExportToEnAPIInfo
source_family: macro_policy
access: api
pricing: verified_free
difficulty: 簡單
manual_required: no
historical: yes
timeframe_fit: 依資料集；多為 macro 低頻
fit: Taiwan Regime Detection
```

用途：

```text
台灣央行統計
利率、匯率、金融統計、台灣 macro regime
```

限制：

```text
低頻資料。
不作 intraday OHLCV 主來源。
```

### data.gov.tw

```text
source: data.gov.tw
url: https://data.gov.tw/en/datasets/172824
source_family: macro_policy
access: api
pricing: verified_free
difficulty: 簡單
manual_required: no for public datasets
historical: dataset-dependent
timeframe_fit: dataset-dependent
fit: Taiwan regime auxiliary
```

用途：

```text
台灣開放資料入口
補充景氣、產業、政府統計、政策相關 feature
```

限制：

```text
每個資料集格式與歷史深度不同。
只能逐項驗證，不當作單一穩定資料源。
```

### GDELT

```text
source: GDELT
url: http://data.gdeltproject.org/documentation/GDELT-Visual_Global_Knowledge_Graph-V1.0Alpha.pdf
source_family: news_signal
access: api
pricing: verified_free
difficulty: 簡單
manual_required: no
historical: yes
timeframe_fit: event time series；可聚合到 30m/1h/4h/daily
fit: Regime Detection / event shock filter
```

用途：

```text
新聞事件、跨境事件、情緒/注意力衝擊
可聚合成 event count / tone / topic feature
```

限制：

```text
雜訊高。
不作交易價格主資料。
```

## Layer 3: Baseline / Sanity Check / 工具層

### OpenBB

```text
source: OpenBB
url: https://openbb.co/products/odp
source_family: market_data
access: api / wrapper
pricing: verified_free
difficulty: 簡單
manual_required: depends on backend provider
historical: provider-dependent
timeframe_fit: provider-dependent
fit: download orchestration / quick prototype
```

用途：

```text
資料整合入口
快速測 provider、raw download、metadata 記錄流程
```

限制：

```text
OpenBB 不是資料源本身。
最終仍要記錄底層 provider。
```

## 高風險節點

```text
1. 不用註冊的來源多數不是 intraday 主資料。
2. 30m/1h/4h 主資料可能仍需 manual/API key 來源。
3. macro/event source 只記錄 raw timestamp / release metadata，不做對齊處理。
4. daily baseline 只作 raw download 起點，不代表 hourly 資料可得。
5. 官方 API 端點格式可能變動；下載工具需 fail fast。
```

## Source Checklist

```text
[ ] Stooq
    [ ] endpoint 可連
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked
    [ ] 標註 timeframe: daily baseline

[ ] TWSE
    [ ] endpoint / CSV 入口可連
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked
    [ ] 確認是否只有日頻
    [ ] 標註用途: 台股 baseline / regime auxiliary

[ ] TPEx
    [ ] endpoint / CSV 入口可連
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked
    [ ] 確認是否只有日頻
    [ ] 標註用途: 櫃買 baseline / regime auxiliary

[ ] TAIFEX
    [ ] openapi endpoint 可連
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] 確認期貨/選擇權歷史深度
    [ ] 確認是否可組 30m / 1h / 4h
    [ ] volume / open_interest availability checked
    [ ] 若不可，標註 session-level / daily regime feature
    [ ] 標註用途: volatility / hedge / futures regime

[ ] FRED
    [ ] endpoint 可連
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] 記錄 series frequency
    [ ] volume_status 標註 unavailable / not_applicable
    [ ] 標註用途: macro regime

[ ] CBC API
    [ ] endpoint 可連
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] 記錄 frequency / update lag
    [ ] volume_status 標註 unavailable / not_applicable
    [ ] 標註用途: Taiwan macro regime

[ ] data.gov.tw
    [ ] 找到明確資料集 endpoint
    [ ] 確認是否免 API key
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked
    [ ] 標註 dataset-level 用途
    [ ] 不合格資料集移除

[ ] GDELT
    [ ] endpoint 可連
    [ ] sample raw download works
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume_status 標註 unavailable / not_applicable
    [ ] 標註用途: event regime auxiliary

[ ] OpenBB
    [ ] 確認使用的底層 provider
    [ ] 不把 OpenBB 當資料源本身
    [ ] 記錄 provider name / endpoint / 權限
    [ ] 確認是否需要 API key
    [ ] 若需 API key，移到 todo.free.manual.md
```

## Validation Checklist

```text
[ ] 所有下載都可在不登入、不手動申請的條件下完成
[ ] INPUT / OUTPUT / TMP 邊界已定義
[ ] 不寫入 home / /tmp / cache outside project
[ ] raw response 已保存
[ ] source metadata 已保存
[ ] volume availability 已標註
[ ] no cleaning / resample / feature engineering
[ ] 每個來源都有保留/移除決策
```

## Decision Checklist

```text
[ ] 保留為主價格資料
[ ] 保留為 regime auxiliary
[ ] 保留為 baseline only
[ ] 移除
[ ] 移到 todo.free.manual.md
[ ] 移到 todo.crawler.md
```

## 下一步驗證

```text
1. 先驗證 Stooq 是否可下載目標市場 daily OHLCV。
2. 驗證 TWSE / TPEx 可取得哪些歷史欄位與日期範圍。
3. 驗證 TAIFEX 是否可組出 30m/1h/4h 或只能作 session-level feature。
4. 驗證 FRED / CBC API 的 release date 與資料頻率。
5. 驗證 GDELT 是否能聚合成固定 bar feature。
```

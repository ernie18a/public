# todo.crawler

## 本文件目標

取得「中等難度、免費或公開可讀、需要 crawler / Playwright / HTML parsing」的資料來源。

需求範圍：

```text
Regime Detection
Change Point Detection
Matrix Profile + Pattern Class
Vectorized Backtesting
timeframe >= 30m；1h / 2h / 4h / daily 都可接受
非 HFT
```

本文件只規劃資料下載/擷取，不規劃完整系統。

## Status Tracking

本文件只定義來源與下載邊界，不追蹤執行狀態。

執行狀態記錄於：

```text
STATUS.crawler.md
```

使用規則：

```text
1. 每次處理 crawler 線任務，先讀 STATUS.crawler.md 的 Next。
2. 若 Next 已完成或不成立，再回讀本文件找下一個 pending source。
3. Completed / Blocked / Skipped / Last Raw Capture 只更新 STATUS.crawler.md。
4. 不在本文件追蹤每日執行狀態。
```

## 下載邊界

本文件只處理 public page access 與 raw capture。

做：

```text
public page access 驗證
sample raw HTML/JSON/CSV capture
crawler / Playwright 是否必要的記錄
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

## 篩選規則

保留：

```text
中等難度
免費或公開頁面可讀
需要 crawler / Playwright / HTML parsing
能形成價格序列、事件序列、趨勢序列、或 regime auxiliary feature
```

排除：

```text
純付費研究報告
供應鏈/BOM 主題但難對齊交易 bar
政治人物交易 disclosure
純低頻 filing 長文本
沒有明確資料匯出或 crawler 價值過低的來源
```

## 決策

crawler 來源不是第一優先。

原因：

```text
1. 維護成本高於 API/download。
2. 容易被前端改版影響。
3. 授權與 robots/ToS 需逐站檢查。
4. 對 >=30m OHLCV 主資料幫助有限。
```

使用定位：

```text
Layer 1: 價格資料 fallback
Layer 2: 趨勢 / event regime 輔助
Layer 3: 人工驗證 / 補缺
```

## Raw Capture Contract

每個 crawler 來源只需完成：

```text
[ ] public page access verified
[ ] raw HTML/JSON/CSV saved
[ ] crawler requirement documented
[ ] no login bypass
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
crawler_required
playwright_required
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

## Layer 1: 價格資料 fallback

### Yahoo Finance

```text
source: Yahoo Finance
url: https://tw.finance.yahoo.com/
source_family: market_data
access: http / web
pricing: verified_free
difficulty: 中等
manual_required: no account for public pages
crawler_required: yes
historical: partial / unofficial
timeframe_fit: fallback only；不當穩定 intraday 主資料
fit: baseline / sanity check / missing data fallback
```

用途：

```text
快速補價格資料
交叉檢查 Stooq / TWSE / TPEx / API provider
```

限制：

```text
非官方資料取得路徑。
穩定性與授權風險高。
不當第一層主資料。
```

### yfinance

```text
source: yfinance
url: https://github.com/ranaroussi/yfinance
source_family: market_data
access: web-derived package
pricing: free
difficulty: 中等
manual_required: no
crawler_required: indirect
historical: partial / unofficial
timeframe_fit: prototype only
fit: baseline / quick experiment
```

用途：

```text
快速原型
raw access prototype
```

限制：

```text
底層仍是 Yahoo 風格非官方存取。
不當穩定資料來源。
```

## Layer 2: 趨勢 / Event Regime 輔助

### Google Trends

```text
source: Google Trends
url: https://trends.google.com/trends/?geo=US
source_family: market_data / attention signal
access: playwright
pricing: verified_free
difficulty: 中等
manual_required: no account for public exploration；automation may need browser handling
crawler_required: yes
historical: trend history
timeframe_fit: low-frequency attention regime；not OHLCV
fit: Regime Detection / event attention filter
```

用途：

```text
關鍵字熱度
產業/標的注意力 regime
事件前後 attention shock
```

限制：

```text
沒有穩定官方 public API。
數值是 normalized index，不是原始搜尋量。
不可單獨作交易訊號主資料。
```

### National Statistics ROC

```text
source: National Statistics ROC
url: https://eng.stat.gov.tw/
source_family: macro_policy
access: http
pricing: verified_free
difficulty: 中等
manual_required: no for public pages
crawler_required: likely yes unless dataset endpoint found
historical: yes, dataset-dependent
timeframe_fit: macro low-frequency
fit: Taiwan Regime Detection
```

用途：

```text
台灣官方統計補充
景氣、產業、人口、物價等 regime feature
```

限制：

```text
API / download 明確性未確認。
若 data.gov.tw 或 CBC API 已覆蓋，優先度下降。
```

## 高風險節點

```text
1. crawler 維護成本高，必須排在 API/download 後面。
2. 非官方市場資料不能作單一 truth source。
3. Playwright 自動化需隔離 TMP，不寫入 home/cache。
4. 網頁來源需檢查授權、robots、rate limit。
5. crawler 只補缺，不應阻塞主資料取得。
```

## Crawler Source Checklist

```text
[ ] Yahoo Finance
    [ ] public page 可讀
    [ ] 確認是否需要 Playwright
    [ ] 確認歷史資料入口
    [ ] 確認 30m / 1h / 4h 是否可得
    [ ] raw HTML/JSON/CSV saved
    [ ] source metadata saved
    [ ] volume availability checked
    [ ] 若不可，標註 baseline / fallback only
    [ ] 記錄 ToS / robots 風險

[ ] yfinance
    [ ] 確認 package 可取得目標 symbols
    [ ] 確認 intraday 歷史深度
    [ ] raw response saved
    [ ] source metadata saved
    [ ] volume availability checked
    [ ] 標註 unofficial / prototype only

[ ] Google Trends
    [ ] public UI 可讀
    [ ] 確認是否需要 Playwright
    [ ] 確認查詢 keyword list
    [ ] raw HTML/CSV capture saved
    [ ] source metadata saved
    [ ] volume_status 標註 unavailable / not_applicable
    [ ] 確認 index normalization 風險
    [ ] 標註用途: attention regime only

[ ] National Statistics ROC
    [ ] 找到目標資料集
    [ ] 優先尋找 download/API
    [ ] 若無 API，再評估 crawler
    [ ] raw response / raw page saved
    [ ] source metadata saved
    [ ] volume availability checked
    [ ] 標註與 CBC API / data.gov.tw 是否重疊

```

## Crawler Risk Checklist

```text
[ ] robots / ToS 已檢查
[ ] 不需要登入或繞過存取控制
[ ] rate limit / polite delay 已定義
[ ] 是否需要 Playwright 已確認
[ ] 若用 Playwright，cache / profile / tmp 全部限制在 ./TMP/
[ ] HTML 結構變動時 fail fast
[ ] 不把 crawler 來源當唯一 truth source
[ ] 有 API/download 替代時優先不用 crawler
[ ] no cleaning / resample / feature engineering
```

## Decision Checklist

```text
[ ] 保留為價格 fallback
[ ] 保留為 attention / event regime auxiliary
[ ] 保留為人工驗證來源
[ ] 移除
[ ] 改用官方 API/download 替代
```

## 下一步驗證

```text
1. 只在 auto/manual 資料不足時啟用 crawler。
2. Yahoo/yfinance 只用來補價格缺口或交叉檢查。
3. Google Trends 只驗證 3-5 個關鍵字能否穩定匯出時間序列。
4. National Statistics ROC 先找明確 download/API；找不到才 crawler。
```

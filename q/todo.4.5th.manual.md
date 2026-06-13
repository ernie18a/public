# todo.4.5th.manual

## 本文件目標

集中保存「需要人工註冊、登入、API key、付費權限、或 terminal account，但目前不進下載工具主線」的資料來源。

移出原因：

```text
目前不直接服務這四個目標：

Regime Detection
Change Point Detection
Matrix Profile + Pattern Class
Vectorized Backtesting
```

本文件不是刪除清單。  
這些來源未來若需求變成 supply chain / paid disclosure / research terminal / paid report，可重新評估。

## 移入規則

```text
需要人工註冊
需要 API key
需要帳號登入
需要付費或 premium endpoint
需要 terminal / dashboard account
且目前不適合作為 >=30m / 1h / 4h 下載工具主線
```

## 從 todo.free.manual.md 移出

### Finnhub Supply Chain Relationships

```text
reason: 資料訊號高，但 supply chain endpoint is premium。不是免費主線。
```

### Congress / politician trading APIs

```text
reason: 有些 free tier 或 API key，但 disclosure delay 與資料頻率不符合 >=30m OHLCV 回測主線。
```

### Koyfin

```text
source: Koyfin
url: https://www.koyfin.com/features/market-dashboards/
source_family: terminal
access: terminal
pricing: inferred free;paid
difficulty: 簡單
manual_required: yes
manual_action: account signup
market_fit: broad research
historical: dashboard-dependent
timeframe_fit: low for automated download
fit: manual research only
reason: 偏人工 terminal / dashboard，不是目前下載工具主線。
```

## 從 todo.crawler.md 移出

### Seeking Alpha

```text
reason: access/legal constraints 高，且文本資料不是第一階段目標。
```

### 產業研究報告來源

```text
reason: 多數 paid/report，難自動化，且不是價格/事件序列主資料。
```

## Decision Checklist

```text
[ ] 保留在第五類，不進目前下載工具
[ ] 未來 paid supply chain feature 再評估
[ ] 未來 politician trading / disclosure feature 再評估
[ ] 未來 research terminal 再評估
[ ] 未來 paid report / transcript source 再評估
```


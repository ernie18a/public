# todo.4.5th.crawler

## 本文件目標

集中保存「公開頁面或 web 來源，需要 crawler / Playwright / HTML parsing，但目前不進下載工具主線」的資料來源。

移出原因：

```text
目前不直接服務這四個目標：

Regime Detection
Change Point Detection
Matrix Profile + Pattern Class
Vectorized Backtesting
```

本文件不是刪除清單。  
這些來源未來若需求變成 exposure / disclosure event / supply chain / transcript event study，可重新評估。

## 移入規則

```text
公開頁面或 web 表格
需要 crawler / Playwright / HTML parsing
不屬於目前 >=30m / 1h / 4h 下載工具主線
```

## 從 todo.crawler.md 移出

### ETFDB

```text
source: ETFDB
url: https://etfdb.com/etfs/
source_family: market_data
access: http
pricing: verified_free
difficulty: 中等
manual_required: no account for public pages
crawler_required: yes
historical: partial
timeframe_fit: ETF reference / holdings auxiliary；not OHLCV main
fit: sector exposure / ETF universe / regime grouping
reason: ETF 分類/持股可做 exposure，但不是目前四個目標的必要資料來源。
```

### OpenInsider

```text
source: OpenInsider
url: http://openinsider.com/
source_family: insider_filings
access: web
pricing: free
difficulty: 中等
manual_required: no
crawler_required: yes
historical: event history
timeframe_fit: low-frequency event；not OHLCV
fit: optional event filter only
reason: 內部人交易事件稀疏，不適合目前 >=30m bar 主線。
```

### earningscall.biz

```text
source: earningscall.biz
url: https://earningscall.biz/
source_family: fundamental_filings
access: web
pricing: free
difficulty: 中等
manual_required: no for public pages
crawler_required: yes
historical: transcripts/audio availability needs validation
timeframe_fit: event / earnings regime；not OHLCV
fit: optional event regime
reason: 財報會議文本解析成本高，且不是目前下載工具主線。
```

### ImportYeti

```text
reason: 免費且訊號可能高，但主題是 supply chain / shipping manifest。與 >=30m OHLCV 回測主線距離過遠。
```

### Senate / House disclosure 類來源

```text
reason: disclosure delay 與資料稀疏，不適合 30m/1h/4h 回測主資料。
```

## Decision Checklist

```text
[ ] 保留在第五類，不進目前下載工具
[ ] 未來 ETF exposure feature 再評估
[ ] 未來 insider event study 再評估
[ ] 未來 earnings transcript event study 再評估
[ ] 未來 supply chain feature 再評估
[ ] 未來 disclosure event study 再評估
```


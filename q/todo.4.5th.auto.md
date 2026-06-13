# todo.4.5th.auto

## 本文件目標

集中保存「不用人工註冊、理論上可直接下載/API，但目前不進下載工具主線」的資料來源。

移出原因：

```text
目前不直接服務這四個目標：

Regime Detection
Change Point Detection
Matrix Profile + Pattern Class
Vectorized Backtesting
```

本文件不是刪除清單。  
這些來源未來若需求變成 fundamental / ownership / exposure / attention feature，可重新評估。

## 移入規則

```text
不用人工註冊
不用 API key 申請
不用券商帳戶
可由公開下載、公開 API、或開放資料取得
但目前不適合作為 >=30m / 1h / 4h 下載工具主線
```

## 從 todo.free.auto.md 移出

### SEC Financial Statement Data Sets

```text
reason: 官方免費且簡單，但頻率是季度財報。可做基本面 regime，不適合目前 >=30m bar 主線。
```

### SEC Form 13F Data Sets

```text
reason: 官方免費且簡單，但季度持倉太低頻。可後續做資金配置 feature。
```

### SEC Insider Transactions Data Sets

```text
reason: 免費且結構化，但事件稀疏。不是第一階段資料取得主線。
```

### iShares / SPDR / TWSE ETFortune

```text
reason: ETF holdings 有用，但不是價格 bar 主資料。可後續做 exposure / rebalance feature。
```

### BLS / IMF / USAspending.gov

```text
reason: 免費 macro / policy 輔助資料，但第一階段 FRED + CBC API 已足夠；避免資料面過寬。
```

## 從 todo.crawler.md 移出

### Hacker News / GitHub / Wikimedia

```text
reason: 可形成 attention signal，但與金融 bar 回測關聯弱。第一階段不放 crawler 主線。
```

## Decision Checklist

```text
[ ] 保留在第五類，不進目前下載工具
[ ] 未來 fundamental feature 再評估
[ ] 未來 ownership / flow feature 再評估
[ ] 未來 ETF exposure feature 再評估
[ ] 未來 broad attention feature 再評估
```


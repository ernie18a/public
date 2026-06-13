如果你的預算上限是 **20~30 USD/月**，那麼最重要的不是資料品質，而是：

> 「每投入 1 小時維護資料，可以換來多少研究產出」

很多人低估了資料工程成本，高估了模型的重要性。

我會把資料源分成：

| 等級     | 特徵                 | 維護成本 |
| ------ | ------------------ | ---- |
| A 簡單資料 | API / CSV / 單一網站取得 | 很低   |
| B 中等資料 | 單一或少數網站爬蟲          | 中等   |
| C 困難資料 | 分散在大量網站            | 極高   |

---

# 對你的7個模組排序

## Tier 1（最值得做）

| 模組                     | 資料難度 | 成本 | 資料來源集中度 | 推薦度   |
| ---------------------- | ---- | -- | ------- | ----- |
| Vectorized Backtesting | A    | 免費 | 非常集中    | ★★★★★ |
| Regime Detection       | A    | 免費 | 非常集中    | ★★★★★ |
| Change Point Detection | A    | 免費 | 非常集中    | ★★★★★ |
| Matrix Profile         | A    | 免費 | 非常集中    | ★★★★★ |

原因：

只需要：

* OHLCV
* Index
* Macro

就能完成。

---

## Tier 2（值得做）

| 模組              | 資料難度 | 成本       | 集中度 | 推薦度  |
| --------------- | ---- | -------- | --- | ---- |
| Cross-sectional | A~B  | 免費~20USD | 高   | ★★★★ |
| Portfolio/Risk  | A    | 免費       | 高   | ★★★★ |

需要額外：

* 財報
* Sector
* Factor

但仍然很集中。

---

## Tier 3（不推薦）

| 模組                         | 資料難度 | 成本 | 集中度 | 推薦度 |
| -------------------------- | ---- | -- | --- | --- |
| Event Candidate Generation | B~C  | 高  | 低   | ★★  |

因為會碰到：

* 新聞
* 社群
* 公告
* 法說會

資料開始碎裂。

---

# 實際資料庫排名

## 第一名：Yahoo Finance

最划算。

取得：

* 股票
* ETF
* 指數
* Volume
* 基本財務資料

支援：

* Cross-sectional
* Backtest
* Regime
* Change Point
* Matrix Profile
* Portfolio

覆蓋：

約 70%

研究需求。

---

## 第二名：FRED

Federal Reserve Bank of St. Louis

取得：

* CPI
* PPI
* GDP
* 利率
* Yield Curve
* Money Supply

支援：

* Regime
* Macro Factor

覆蓋：

約 90%

總體資料需求。

---

## 第三名：SEC EDGAR

SEC EDGAR

取得：

* 10-K
* 10-Q
* 8-K

支援：

* 基本面因子

---

## 第四名：Financial Modeling Prep

[Financial Modeling Prep](https://financialmodelingprep.com?utm_source=chatgpt.com)

便宜。

大約：

* 15~20 USD/月

取得：

* 財報
* 指標
* Insider
* Earnings

資料整合度很高。

---

# 最推薦的組合

## 方案A（0美元）

| 資料源       | 用途    |
| --------- | ----- |
| Yahoo     | 價格資料  |
| FRED      | Macro |
| SEC EDGAR | 財報    |

可完成：

* Backtest
* Regime
* Change Point
* Matrix Profile
* Portfolio
* 基礎 Cross-sectional

---

## 方案B（20美元）

| 資料源   | 用途    |
| ----- | ----- |
| Yahoo | 價格    |
| FRED  | Macro |
| FMP   | 財報與因子 |

可完成：

* Cross-sectional ML
* Portfolio
* Risk
* Regime
* Change Point
* Matrix Profile

我會選這個。

---

# 哪些資料最容易變成維護地獄

這部分很多獨立研究者踩坑。

| 資料類型                     | 難度 |
| ------------------------ | -- |
| OHLCV                    | A  |
| 財報                       | A  |
| Macro                    | A  |
| Options Chain            | B  |
| Insider Trading          | B  |
| Earnings Call Transcript | B  |
| 新聞                       | C  |
| Reddit                   | C  |
| X/Twitter                | C  |
| App Download             | C  |
| Credit Card Data         | C  |
| 衛星資料                     | C  |
| 網站流量資料                   | C  |

---

# 如果目標是建立長期可維護研究平台

最佳順序：

| 順序 | 模組                     |
| -- | ---------------------- |
| 1  | Vectorized Backtesting |
| 2  | Regime Detection       |
| 3  | Change Point Detection |
| 4  | Matrix Profile         |
| 5  | Portfolio              |
| 6  | Cross-sectional ML     |
| 7  | Event Generation       |

因為前 6 個幾乎都能靠同一批資料：

* Yahoo
* FRED
* FMP

解決。

而第 7 個 Event Generation 往往會讓資料工程量暴增 5~20 倍，卻不一定帶來同等幅度的 Alpha 提升。對於月預算 20~30 美元的人來說，通常是最後才碰的領域。


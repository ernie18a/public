# m3 方法方向方案

## 核心判準

方法也有邊際效益。

不是「方法有效」就該做，而是要同時符合：

- 資料可集中取得
- 維護成本低
- CPU / RAM / RTX 4050 6G 可穩定執行
- 不依賴 HFT
- 不依賴企業內部深度資訊
- 可回測、可驗證、可替換
- 能先用低成本資料做基準實驗

不符合現狀的方法，不代表方向錯，只代表目前硬體、人力、資訊條件不划算。

## sourcdRank 對應的資料順序

- Change Point / DTW / Matrix Profile / 時間序列分群：先用 `Stooq / Polygon / Alpaca / Alpha Vantage / FRED / FMP`，次用 `iShares / SPDR / Google Trends / Reddit`
- Regime Detection / 機率預測：先用 `Stooq / Polygon / Alpaca / Alpha Vantage / FRED / FMP`，次用 `Google Trends / OpenSecrets / USAspending.gov`
- Feature Learning / Tree-based / Cross-sectional：先只用 `Stooq / Polygon / Alpaca / Alpha Vantage / FRED / FMP`
- Sequence Model / RL：先只用 `Stooq / Polygon / Alpaca / Alpha Vantage / FRED / FMP`，其他來源先不擴

## 高邊際效益主線

### 1. Cross-sectional / Tree-based / Feature Learning

定位：主線。

核心方法：

- Cross-sectional signals
- Tree-based models
- XGBoost / Random Forest
- tabular feature learning
- factor ranking

適合原因：

- 適合多商品比較，不只預測單一商品方向
- 對 GPU 要求低，RTX 4050 6G 可承受
- 可以用 CPU / RAM 批次處理
- 易做回測與 ablation
- 易擴張到 portfolio
- 易加入 hedge、risk control、exposure constraint
- 不需要 HFT
- 不需要企業內部資料

可吃資料：

- 價格與 OHLCV
- volume / volatility / return features
- `Stooq / Polygon / Alpaca / Alpha Vantage / FRED / FMP` 核心資料
- 少量高價值 ETF / holdings / macro 補充資料

典型訊號：

- relative momentum
- dispersion
- carry
- volatility-adjusted strength
- mean reversion
- factor ranking
- liquidity-adjusted return

結論：

這是目前最符合硬體、人力、資料條件的主方法。

### 2. Regime Detection

定位：輔助核心，不當主 alpha。

核心方法：

- Hidden Markov Model
- volatility regime
- correlation regime
- trend regime
- macro regime

用途：

- 判斷市場狀態
- 避免模型在錯誤 regime 中硬交易
- 決定模型是否啟用
- 調整倉位與風險
- 對商品分群

適合原因：

- 不要求大 GPU
- 可用價格、波動、相關性、宏觀資料完成
- 作為 gating system 邊際效益高
- 可降低策略失效風險

限制：

- 不應單獨當主預測器
- regime 數量不可過度複雜
- 需要回測確認切換規則是否真的改善結果

結論：

適合作為主線模型的 gating layer。

### 3. Change Point Detection

定位：波段切分工具。

核心方法：

- PELT
- Window-based change point
- Kernel change point
- Bayesian online change point detection

用途：

- 找趨勢開始或結束
- 把連續價格切成波段
- 讓後續特徵與模型建立在「段落」而不是任意時間窗口上

適合原因：

- 計算成本可控
- 不依賴深度學習
- 適合 CPU 批次處理
- 能提升後續 pattern matching 與 tree model 的資料品質

可接續：

- Change Point -> 波段特徵
- Change Point -> Matrix Profile / DTW
- Change Point -> XGBoost

結論：

是低成本提高資料結構品質的方法，應放在早期實作。

### 4. Matrix Profile / Shape Pattern Mining

定位：相似波段與重複形狀搜尋。

核心方法：

- Matrix Profile
- STUMPY
- motif discovery
- discord detection

用途：

- 自動找反覆出現的價格形狀
- 找相似歷史波段
- 統計相似段落後續報酬
- 不需要人工定義 pattern

適合原因：

- 比手刻 K 線型態更可驗證
- 可先用單商品或少量商品測試
- 可與 Change Point 結合，降低任意窗口問題
- 維護成本低於大量 alternative data 爬蟲

限制：

- 多商品全量掃描可能吃記憶體
- 需要控制窗口長度與資料規模
- 不應直接假設相似形狀等於可交易訊號

結論：

適合作為 pattern discovery 工具，不宜單獨當策略。

### 5. Vectorized Backtesting / Strategy Scanning

定位：驗證基礎設施。

核心工具方向：

- vectorbt
- pandas / NumPy / Numba pipeline
- rule-based strategy scanner

用途：

- 快速比較大量訊號
- 掃描參數
- 測試進出場規則
- 評估 turnover、drawdown、exposure

適合原因：

- 解決人力不足下的實驗效率問題
- 不需要大 GPU
- 對中頻、日頻、低頻研究足夠
- 能讓方法選擇基於回測結果，而不是直覺

結論：

這不是 alpha 方法，但對整體邊際效益非常高，應早做。

## 中邊際效益 / 延後加入

### 6. DTW / Time Series Clustering

定位：相似段落分析。

適合用途：

- 找歷史相似走勢
- 對波段分群
- 對商品行為分群

適合原因：

- 概念直接
- 可解釋
- 不需要深度模型

限制：

- 大量 pairwise comparison 成本高
- 多商品、多窗口時容易變慢
- 需要先做降維、抽樣或限制候選集合

結論：

可做，但應排在 Change Point / Matrix Profile 之後。

### 7. Probabilistic Forecast

定位：風險分布與倉位輔助。

核心方向：

- quantile regression
- distribution forecast
- uncertainty estimation
- Bayesian model

用途：

- 不只預測方向，而是預測報酬分布
- 協助 position sizing
- 協助風險控制

適合原因：

- 比單純漲跌分類更接近交易需求
- 可與 tree model 結合
- 不必使用大型模型

限制：

- 驗證比方向分類複雜
- 需要校準分布品質
- 初期不應壓過主線

結論：

適合作為第二階段風控升級。

### 8. tsfresh / sktime 類特徵與時間序列框架

定位：特徵工程與實驗標準化。

用途：

- 自動抽取時間序列特徵
- 標準化 forecasting / classification / clustering pipeline
- 減少人工特徵設計成本

適合原因：

- 能把序列轉成 tree model 可吃的 tabular features
- 符合人力不足情境
- 不依賴大 GPU

限制：

- 自動特徵可能產生大量無效特徵
- 需要嚴格做 feature selection
- 不可讓框架複雜度超過研究收益

結論：

可作為輔助工具，不應變成主架構依賴。

### 9. TabPFN / 小樣本 Tabular Foundation Model

定位：實驗對照組。

用途：

- 小樣本 tabular prediction
- 與 XGBoost 做 baseline comparison

適合原因：

- 新方法，可能在小資料上有優勢
- 不必自行訓練大型模型

限制：

- 不適合當主線
- 對資料規模與分布限制較多
- 實務穩定性仍需驗證

結論：

只作為小規模實驗，不作為核心依賴。

## 補充可行方法（去重後）

以下是從 `methods.md`、`reverse.md`、`reverse2.md` 補進來，且尚未被上面主線明確覆蓋的方法。共同前提是：不做 HFT，不吃超大硬體優勢，可由個人用軟體自動化、批次 CPU/GPU、或 API 完成。

### Event Candidate Generation / 市場異常初篩

定位：第一階段 cheap filtering。

核心訊號：

- volume spike
- relative volume
- unusual options activity
- gap
- dispersion
- short interest change
- news spike

適合原因：

- 計算成本低
- 可用日頻、低頻、盤後資料
- 不需要低延遲執行優勢
- 能避免對所有股票做昂貴深度研究
- 很適合作為 cross-sectional universe filter

限制：

- 不是單獨 alpha
- options / short interest / news 資料可能需要付費或延遲
- 不應變成 intraday latency race

結論：

適合作為所有進階研究前的候選清單生成器。

### Event Study / 事件前兆反推

定位：把「大波段」反推成可驗證前兆。

流程：

- 先定義波段事件
- 找事件前的固定 window
- 抽取價格、量、波動、新聞、fundamental 特徵
- 用 walk-forward / out-of-sample 驗證

適合原因：

- CPU 批次即可完成
- 不依賴深度模型
- 能把直覺敘事轉成可測試假說
- 可接 Change Point / Matrix Profile / XGBoost

限制：

- 事件定義會影響結果
- 容易 data snooping
- 必須用樣本外驗證，不可只看漂亮案例

結論：

符合個人研究條件，適合作為「先找大波段，再反推前兆」的研究框架。

### LLM Semantic Feature / AI Analyst Overlay

定位：非結構化資訊轉成結構化 feature，不讓 LLM 直接預測價格。

可抽取特徵：

- catalyst detection
- narrative consistency
- contradiction finding
- regulatory risk
- macro sensitivity
- sentiment / hype intensity
- earnings credibility
- supply chain fragility
- short squeeze probability

適合原因：

- 可用 API 或小模型自動化
- 不需要 HFT 優勢
- 適合處理新聞、財報、transcript、公告
- 最終仍回到 cross-sectional score / ranking

必要控制：

- 先用 cheap filter 縮小股票數
- 不做 `N stocks × M agents × K searches` 全量爆搜
- LLM 只產生 feature，不直接下交易結論
- 需要 consensus extraction 與 hallucination check
- semantic feature 要有 decay，避免 regime drift

結論：

可做，但應放在第二階段深度研究，不應取代 tree-based / backtest 主線。

### Small Representation Learning / 小型表徵學習

定位：feature extractor，不是 end-to-end price predictor。

可接受方法：

- Autoencoder
- 小型 CNN
- sequence embedding
- tabular / time-series representation learning

適合原因：

- RTX 4050 6G 可做小規模實驗
- 可把 K 線、報酬序列、波段壓成 embedding
- embedding 可餵給 XGBoost / Random Forest / ranking model

限制：

- 不做大型 Transformer
- 不做長 sequence end-to-end 預測
- 必須和 tree baseline 比較，沒有提升就停止

結論：

只適合作為特徵抽取與 baseline 對照，不作為核心策略。

### Conservative Causal Discovery / 因果探索

定位：假說生成與 feature pruning，不是因果證明。

用途：

- 找可能的 lead-lag relationship
- 排除明顯無效或洩漏特徵
- 檢查 macro / sector / liquidity 對訊號的干擾

適合原因：

- 可在結構化資料上批次執行
- 不需要大 GPU
- 可輔助解釋與風控

限制：

- 金融資料非平穩，因果方向很容易錯
- 不能把 causal discovery 結果直接當交易規則
- 高維非結構化資料不適合早期使用

結論：

只作為研究輔助工具，不能當主 alpha。

### Portfolio / Risk Layer 明確化

定位：不是 alpha，而是避免好訊號被倉位與暴露摧毀。

核心控制：

- exposure control
- sector neutrality
- factor neutrality
- volatility targeting
- position sizing
- correlation control
- turnover control

適合原因：

- 計算成本低
- 對個人最有邊際效益
- 不需要硬體優勢
- 能把 ranking model 轉成可交易組合

限制：

- 不能過度最佳化
- 約束太多會吃掉 alpha
- 需用回測驗證風控是否真的改善風險報酬

結論：

應作為主線必要配套，而不是最後才補。

## 目前不符合現狀的方法

這一類不是不符合需求，而是不符合目前硬體、人力、資訊深度或維護條件。

### 10. End-to-end Sequence Model

代表：

- LSTM
- Transformer sequence predictor
- large temporal model

不符合現狀原因：

- 資料量要求高
- 調參成本高
- 容易 overfit
- RTX 4050 6G 容易卡在 batch size、sequence length、模型大小
- 輸出不一定比 tree-based baseline 穩

可接受用法：

- 只當 feature extractor
- 只產生 embedding
- 只做小規模 representation learning

結論：

不要做「Transformer 預測明天漲跌」這種主線。

### 11. Reinforcement Learning

不符合現狀原因：

- action space 大
- reward design 困難
- portfolio constraint 複雜
- regime 變化會讓訓練不穩
- 很容易變研究黑洞
- 對人力、驗證、模擬環境要求高

結論：

目前不應作為主線，也不應作為早期實驗。

### 12. HFT / Ultra-low Latency 方法

不符合現狀原因：

- 硬體不匹配
- 網路與 colocated infrastructure 不匹配
- 資料延遲與交易執行條件不匹配
- 個人研究環境無法形成優勢

結論：

直接排除。

### 13. 企業內部深度資訊方法

代表：

- 依賴公司內部訂單
- 依賴未公開供應鏈細節
- 依賴深度專家網絡
- 依賴 procurement leaks

不符合現狀原因：

- 資訊不可穩定取得
- 驗證困難
- 合規與可靠性風險高
- 無法形成可重複 pipeline

結論：

不納入主方法。

### 14. 高維護 Alternative Data 深挖

代表：

- 分散社群爬蟲
- 原始海關資料深挖
- 拆機報告大量整合
- satellite factory expansion
- LinkedIn hiring 大量追蹤
- 多來源 shipping / customs parsing

不符合現狀原因：

- 資料不集中
- 需要維護多個爬蟲
- entity matching 成本高
- 清洗成本高
- 失敗點多
- 邊際效益不確定

可接受用法：

- 只保留已結構化、低維護、高價值來源
- 只用於交叉驗證，不作為主 pipeline

結論：

目前不做分散深挖。

## 建議落地順序

### Phase 1: 建立可驗證基準

- 集中資料源：Stooq / Polygon / Alpaca / FRED / FMP
- 建立 OHLCV + macro + fundamentals 基礎特徵
- 建立 event candidate filter：relative volume / gap / dispersion / news spike
- 建立 vectorized backtesting
- 建立 XGBoost / tree-based baseline
- 評估 cross-sectional ranking 是否有效

### Phase 2: 加入市場狀態與波段結構

- Regime Detection 作 gating
- Change Point 切波段
- 波段特徵餵給 tree model
- 測試不同 regime 下模型是否穩定

### Phase 3: 加入相似形狀與分布預測

- Matrix Profile 找相似波段
- DTW / clustering 做限制範圍實驗
- Probabilistic Forecast 輔助 position sizing
- Event Study 反推大波段前兆

### Phase 4: 小規模新方法對照

- TabPFN 對照 XGBoost
- Sequence embedding 小實驗
- LLM semantic feature 只針對候選清單做深度研究
- Conservative causal discovery 只做假說生成與 feature pruning
- 若無明顯提升，不擴大

## 最小可行主架構

```text
集中資料源
-> Event candidate filter
-> 基礎特徵 / tsfresh 選用
-> Regime gating
-> Change Point 波段切分
-> Cross-sectional Tree-based model
-> LLM semantic feature 選用
-> Vectorized backtest
-> Portfolio risk control
```

## 一句話結論

目前最高邊際效益的方法方向是：

```text
Cross-sectional Tree-based baseline
+ Event candidate filter
+ Regime gating
+ Change Point / Matrix Profile
+ Vectorized backtesting
+ Portfolio risk layer
```

目前應避免的是：

```text
HFT
RL
大型 end-to-end sequence model
企業內部深度資訊方法
高維護分散 alternative data 深挖
```

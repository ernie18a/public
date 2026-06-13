# 後半段

不是在找單一模型，而是在做「先找大波段，再反推前兆」的研究框架。

這一段本質上是：

- 事件驅動的模式挖掘
- 逆向工程市場結構
- 不是傳統回測

## 可行方法

1. Event Study（事件研究）
2. Motif Discovery（時間序列 pattern mining）
3. Classification / ML（分類模型）
4. Representation Learning（表徵學習）
5. Regime Detection（市場狀態）
6. Causal Discovery（因果探索）

## 研究流程

- 先定義波段事件
- 找事件前的 window
- 抽特徵或 pattern
- 用模型判斷哪些前兆真的有效
- 用 walk-forward / out-of-sample 驗證

# 方法架構

## Tier 1: 最適合

### 1. Cross-sectional / Tree-based / Feature Learning

這是你的核心。

- 天然適合多商品
- 不需要強 directional
- 易擴張
- 易 hedge
- 易 portfolio 化
- 中頻非常適合
- 對 GPU 要求低
- 維護成本合理

這應該是你的主線。

### 2. Regime Detection

這是輔助核心。

用途：

- 切換市場環境
- 避免模型失效
- 調整風險
- 分群商品

這非常適合你。

但：

- 不要讓它變主 alpha
- 它是 gating system

## Tier 2: 可以後面加

### 3. Sequence Model

可以，但只能當：

- feature extractor
- embedding
- representation learning

不是 end-to-end 預測器。

例如：

- temporal embedding
- transformer encoder
- latent regime vector

而不是：

- 「Transformer 預測明天漲跌」

那條路太容易死。

## Tier 3: 現在不適合

### 4. RL

現在非常不適合當主線。

因為你：

- 商品多
- regime 多
- action space 大
- portfolio constraint 多
- reward 很難定義

RL 在這種問題會變超級不穩。

而且：

- 你真正要的是穩定 portfolio system
- 不是學會神奇 policy

RL 非常容易研究黑洞化。

## 你現在可以收斂成的架構

### Layer 1: 資料層

- Polygon
- Alpaca
- FRED
- FMP
- Stooq

夠了。真的夠了。

先不要亂加 alternative data。

### Layer 2: Regime layer

- volatility state
- correlation state
- trend state
- macro state

### Layer 3: Cross-sectional signals

- relative momentum
- dispersion
- carry
- volatility-adjusted strength
- mean reversion
- factor ranking

### Layer 4: Portfolio optimization

- beta neutral
- vol targeting
- risk parity
- max exposure constraints

### Layer 5: Optional options overlay

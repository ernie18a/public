> Source: https://chatgpt.com/c/6a16fa2c-c4b8-83a5-b2a5-f8e26e8241ca

# 需求評估

## 原始問題摘要

- 先有一個清單，例如股票清單
- 清單可能限定在北美市場，並用成交量異常做初步篩選
- 針對每個 `symbol` 呼叫 AI API
- 每個 AI 透過工具進行網路搜尋
- 從不同面向研究同一檔股票
- 把多個面向的結果整理成分數或排名
- 再根據研究結果與量價異常判斷多空方向

## 核心結論

這不是完全新的體系，而是：

- 傳統 cross-sectional quant framework
- LLM research overlay
- event-driven catalyst engine

它最接近：

- Cross-sectional / feature learning
- Regime gating
- Event / catalyst ranking system

而不是：

- RL
- 純 sequence model

## 你的真正流程

### Step 1: 市場異常偵測

例如：

- volume spike
- relative volume
- unusual options activity
- gap
- dispersion
- short interest change
- news spike

這是 event candidate generation。

也就是：

- 市場正在告訴你某些東西開始不正常

### Step 2: AI agents 做多面向研究

研究面向可能包含：

- fundamental
- narrative
- macro
- positioning
- sentiment

重點不是叫 AI 預測，而是叫 AI 抽取 feature。

LLM 特別適合：

- 非結構化資訊整理
- narrative extraction
- risk decomposition
- contradiction finding
- catalyst detection
- cross-source synthesis

這部分可視為 semantic feature generation。

### Step 3: 把輸出轉成 score / ranking / weighting

這一步會把整個系統拉回：

- cross-sectional model

所以你的核心仍然是：

- cross-sectional ranking system

只是 feature 不再只是傳統數值因子，而是：

- LLM-derived latent features

例如：

- management quality
- regulatory risk
- hype intensity
- narrative consistency
- AI bubble exposure
- macro sensitivity
- supply chain fragility
- earnings credibility
- institutional positioning
- short squeeze probability

## 對應到既有架構

### 1. Cross-sectional / feature learning

高度接近。

差別是：

- feature engineering 從 structured numeric features
- 變成 LLM-generated semantic features

本質仍然是：

- ranking problem

不是 prediction problem。

### 2. Regime detection

你非常需要。

因為不同 regime 下，LLM narrative 的有效性差很多：

- risk-on 時，story 有效
- risk-off 時，liquidity > story
- panic regime 時，macro dominates
- squeeze regime 時，positioning dominates

Regime layer 會變成 gating system。

### 3. Sequence model

目前還不是你的主體。

你現在是：

- event-triggered research architecture

除非之後要把長期 narrative evolution 做 temporal embedding，否則還不算 sequence system。

### 4. RL

幾乎無關。

你現在做的是：

- ranking
- filtering
- discretionary allocation

不是 continuous action optimization。

## 你比較像什麼

你更像：

- Point72 / Millennium / Citadel 的研究流程自動化

而不是：

- 純 deep learning quant

你是在做：

- analyst scaling system

也就是讓多個 AI analyst 同時研究股票，再把結果結構化。

## 會遇到的問題

### 1. LLM hallucination consistency problem

不同 agent 可能產生不同結論。

所以不能直接相信單一結論，只能看：

- 跨來源一致性

也就是 consensus extraction。

### 2. feature stationarity 很差

LLM semantic features 很容易 regime drift。

所以需要：

- feature decay system

### 3. 搜尋成本會爆炸

你的成本會變成：

- N stocks × M perspectives × K searches

所以通常要做成兩階段系統：

- 第一階段 cheap filtering
- 第二階段 deep agent research

### 4. 仍然需要 portfolio / risk layer

不能只停在「找到好股票」。

還要有：

- exposure control
- sector neutrality
- factor neutrality
- vol targeting
- position sizing
- correlation control

## 最終定位

這不是完全新方向。

它本質上是：

- cross-sectional quant framework 的下一代 feature engineering layer

更精準地說：

- LLM-enhanced event-driven multi-factor system

它和傳統框架的關係大約是：

- 70% 有關
- 差別在 feature generation

也就是：

- 從傳統數值因子
- 升級成 AI semantic research agents

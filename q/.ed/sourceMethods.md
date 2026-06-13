# 資料來源

## 台灣市場與官方資料
- `TWSE`：台灣證交所歷史資料、部分 API。
- `TPEx`：櫃買中心歷史資料、部分 API。
- `TAIFEX`：期貨與選擇權相關資料。
- `CBC API`：中央銀行統計資料。
- `data.gov.tw`：加權指數、Put/Call Ratio 等開放資料。
- `TEJ`：台灣較完整的專業金融資料庫，涵蓋歷史、基本面等。
- `TWSE ETFortune`：ETF 持股與統計資料。
- `iTick`：台股即時報價與基本歷史資料。
- `Fubon Neo API`：台灣市場即時、盤中、歷史資料。
- `yfinance`：可抓部分台股資料，但穩定性有限。
- `PTT`、`Dcard`：台灣討論熱度與情緒觀察來源。

## 國際與補充資料
- `OpenBB`：整合多來源的入口，不是單一資料庫。
- `EODHD`：全球股價、基本面、期權、經濟資料。
- `Finnhub`：即時、歷史、新聞、情緒、供應鏈關聯資料。
- `Twelve Data`：歷史與即時資料。
- `FMP`：基本面與 ETF 資料。
- `FRED`：宏觀經濟資料。
- `Stooq`：歷史股價資料。
- `Polygon`、`Alpaca`、`Alpha Vantage`：補充型市場資料來源。
- `iShares`、`SPDR`、`ETFDB`、`Yahoo Finance`：ETF 持股與歷史資料。
- `Google Trends`、`Reddit`、`OpenSecrets`、`USAspending.gov`：趨勢、情緒、政治與政府支出資料。

## 供應鏈與產業研究資料
- `SemiAnalysis`
- `TrendForce`
- `TechInsights`
- `Omdia`
- `Counterpoint`
- `Gartner`
- `IDC`
- `US import manifest`
- `ImportYeti`
- `Panjiva`
- `ImportGenius`
- `Datamyne`
- `Bloomberg`
- `SEC filings`
- `earnings transcripts`
- `teardown reports`
- `customs data`
- `shipping data`
- `LinkedIn hiring`
- `satellite factory expansion`
- `capex tracking`
- `procurement leaks`

# 分析預測方案方法方向

## 台灣金融商品
- `歷史價格 + 量價結構`：先看 OHLCV、趨勢、區間、波動。
- `基本面分析`：營收、毛利率、獲利能力、財務結構。
- `ETF 持股分析`：看成分股、持股變化、資金流向。
- `宏觀指標連動`：利率、匯率、CPI、景氣指標、央行資料。
- `新聞與情緒觀察`：公司新聞、產業新聞、社群熱度。
- `事件驅動`：法說會、月營收、政策、財報公告。
- `回測`：用歷史資料驗證策略，不直接靠直覺判斷。

## 供應鏈與台灣產業
- `反向推導`：從美國大型公司反推台灣供應商。
- `供應鏈映射`：整理 customer / supplier / ODM / OEM 關係。
- `重要性推估`：看 revenue concentration、毛利率、capacity constraint。
- `關鍵字訊號`：追蹤 earnings call、新聞、法說會中的關鍵詞。
- `entity matching`：把不同資料源的公司名稱對齊。
- `HS code / shipper / consignee 解析`：用海關資料找出實際交易鏈。
- `capex 與產能變化`：用擴產、設備支出推估需求強度。
- `拆機與報告交叉驗證`：用 teardown、研究報告、財報互相驗證。

## 實務排序
- 先用 `OpenBB`、`Finnhub`、`EODHD`、`TWSE/TPEx` 這類可快速取得的資料。
- 再用 `法說會`、`財報`、`新聞`、`月營收` 做交叉驗證。
- 最後才碰 `原始海關資料`、`拆機深挖`、`高價研究報告`。

## 直接結論
- 如果目標是台灣金融商品研究，優先順序通常是：`官方資料` > `結構化 API` > `新聞/法說` > `原始雜訊資料`。
- 如果目標是供應鏈研究，優先順序通常是：`美國終端需求端` > `台灣供應商` > `海關/拆機/研究報告`。

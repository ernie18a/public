---
## 一、 需求與痛點 (Requirement & Pain Points)
*   **權威認證**: 獲取 Google Knowledge Graph (KG) 認證，建立國際媒體實體 (Entity) 身份。
*   **成本控制**: 在不增加高額人力成本的前提下，利用自動化流程產出符合 E-E-A-T 標準的高品質內容。
*   **獲取提及**: 解決新媒體難以獲得外部引用與自然反向連結的痛點。

## 二、 核心目標與戰略定位 (Core Goals & Positioning)
*   **實體化 (Entity)**: 透過政府登記、ISSN、ISNI 與 Schema 閉環，在 6-12 個月內觸發 Google Knowledge Graph  面板。權威指標（如 ISSN）優先於單純的內容數量。
*   **國際化市場**: 以英文/日文切入國際法規（北約、歐盟、白宮）利基市場，避免地域流量限制。
*   **原創化與防禦**: 將「官方資訊」轉化為具備「深度分析」（如賽局理論、影響評估、數據視覺化）的內容，對抗 AI 清算與 AI Slop 標籤。

## 三、 身分與權威認證機制 (Identity & Authority Mechanisms)
*   **身份掩護與錨點**: 建立「穩定且唯一」的機構或筆名數位身分，為自動化內容提供信任背書。
    *   **唯一臉孔與防匿名**: 避免使用空泛的「編輯部」。採用 AI 生成世界上不存在、但視覺高度一致的專業臉孔（作為 Persona），或直接招募實體外包。每個作者需有獨立 Schema 與 LinkedIn 連結。 甚至去 upwork 僱用 員工.
*   **技術閉環 (SameAs 陣列)**: 埋設 `NewsMediaOrganization` JSON-LD，主動餵養 Google 演算法。
    *   形成完整的實體鏈路：`Website ↔ Wikidata ↔ ISSN ↔ ISNI ↔ LinkedIn ↔ Crunchbase`。
*   **認證訊號獲取**: 獲取流量並非首要，初期專注於「算法認可訊號」（如 Google News 抓取、焦點新聞、知識圖譜面板）。

## 四、 E-E-A-T 內容與機器可讀化策略 (E-E-A-T & Content Strategy)
*   **機器可讀化**: 將網站政策頁面 (Editorial/Fact-Checking) 轉化為機器可讀的 `CreativeWork` 標記。
*   **實質視覺增益**: 2026 年純文字易被判為 AI Slop。影片或文章畫面需有 40% 以上採用程式生成的自製視覺證據（功能性圖表、數據圖、時間軸），輔以專業分析旁白，實現「實質轉化」。
*   **真實互動邏輯**: 留言板非絕對必要；重點在於提升「跳出率」與「停留時間」等真實流量表現。

## 五、 執行優先序 (Priority Matrix & Roadmap)
1.  **第一階段 (極速建立)**: 
    *   部署網站 `NewsMediaOrganization` Schema。
    *   申請低成本、高信任的「身分證」：ISSN (國圖) 與 ISNI。
    *   建立 Wikidata 條目。
2.  **第二階段 (身分布署)**: 
    *   建立 LinkedIn Company Page、個人作者 LinkedIn 與 Crunchbase Profile，強化專業媒體形象。
    *   確立 AI Face 或真人筆名的視覺一致性。
3.  **第三階段 (內容累積與延遲申請)**(不在前端專案的範圍中): 
    *   開始 YouTube 穩定上傳（低頻高品質），加入原創視覺分析元素（圖表）。
    *   **戰略延遲**: 先累積歷史數據與 Entity 信號，不急於申請 YPP，降低被拒風險。
4.  **第四階段 (收割變現)**: 
    *   監測 Knowledge Graph (KG) 面板出現情形。
    *   同步啟動 HARO 外部引用獲取策略。
    *   在具備強大 Entity 護城河後，正式申請 YPP。

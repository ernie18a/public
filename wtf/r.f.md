
# 主題選型需求（已更新認知）

## 硬性條件（不符合直接排除）
- GitHub Stars > 1000
- 活躍維護：近12各月有維護紀錄 
- 純靜態輸出，可部署至任意靜態平台（GitHub Pages / Firebase Hosting / Cloudflare Pages 等）

## Schema / SEO 策略
- **要求可控性**：主題的 `layouts/partials/head.html` 結構乾淨，可自行停用 or 覆蓋原有 repo 預設google knowledge graph 相關欄位或插入完整的 NewsArticle JSON-LD（含 `sameAs`、Author Entity、`datePublished` 等欄位）
- Schema 由自動化流水線負責注入
- 可以單獨文章更新而不是 當 更新失敗之后整個網站 壞掉 

## 功能需求
- 發布新聞文章，文章可附加public(for reader) or private(for 內部分析 ) 標籤或是分類 
- 支援自訂靜態頁面（About Us、Staff、法律聲明、隱私政策等）
- 作者資料管理：文章搭配內部作者 ，可透過 Data Files 或 Front Matter 掛載作者實體
- 自動化流水線：自動產文、自動附加圖片、自動標注作者與標籤，本地 Linux 建置

## 可移植性
- 主題本身不綁定特定 CI/CD 或雲平台
- 搬家時只需更換 `baseURL`，不需重寫建置邏輯

## 維護哲學
- 低維護成本：選定主題後不依賴上游持續更新 Schema 邏輯
- 免費開源
- 本地 Linux 編譯（`hugo build`），不依賴 GitHub Actions
---
## 
- 免費 不需額外付費版本或是 API 

# Hugo 主題選型分析報告

> 核心目標：建立自動化新聞發布流水線 → 取得 Google Knowledge Graph 認證 → YouTube YPP 獲利

---

## 第一步：硬性條件篩選（原清單）

根據 `r.f.md` 硬性條件逐項檢驗：

| 主題 | Stars | 活躍維護 | 零外部依賴 | 結果 |
|:---|:---:|:---:|:---:|:---:|
| **PaperMod** | ~9.7k | ✅ | ✅ 純 CSS | ✅ 通過 |
| **Stack** | ~4.8k | ✅ | ✅ SCSS via Hugo Pipes | ✅ 通過 |
| **Blowfish** | ~1.6k | ✅ | ⚠️ 需 Tailwind（預編譯） | ⚠️ 條件邊緣 |
| **Congo** | ~1.8k | ✅ | ⚠️ 需 Tailwind（預編譯） | ⚠️ 條件邊緣 |
| **FixIt** | ~1.1k | ✅ | ✅ SCSS via Hugo Pipes | ✅ 通過 |
| **MemE** | ~1.1k | ⚠️ 低頻 | ✅ SCSS via Hugo Pipes | ⚠️ 勉強 |
| **Beautiful Hugo** | ~1.2k | ❌ 116 open issues / 31 PRs | ✅ 靜態 CSS | ❌ 淘汰 |
| **LoveIt** | ~3.4k | ❌ 已停止維護 | ✅ | ❌ 淘汰（FixIt 為其後繼） |
| **Ananke** | ~1.1k | ✅ | ⚠️ PostCSS 管線 | ⚠️ 條件邊緣 |
| **Clarity** | **647** | ✅ | ✅ SCSS | ❌ **Stars 不符** |

### 淘汰名單
- **LoveIt** → 已死，FixIt 是直系後繼
- **Beautiful Hugo** → 長期無人維護，大量未處理 issues
- **Clarity** → Stars 647，未達 >1000 門檻

---

## 第二步：清單外的新增候選

| 主題 | Stars | 外部依賴 | 獨特定位 |
|:---|:---:|:---:|:---|
| **Mainroad** | ~1k | ⚠️ 有 `package.json`（PostCSS lint 用，非建置必須） | **唯一的 Magazine 風格**，原生側邊欄 Widget 系統 |
| **Coder** | ~3.1k | ✅ 純 SCSS | 極簡個人品牌，乾淨到可做「機構首頁」 |
| **Blox (Academic)** | ~3.8k | ⚠️ 需 Go Modules | **最強學術/智庫權威感**，工業級作者實體與 Schema，針對 Knowledge Graph 最佳化 |

> **為何只加 2 個？** 能同時滿足 Stars >1000 + 活躍維護 + 零/低外部依賴的 Hugo 主題，在 Hugo 生態中總共就這些。其餘要麼是文件主題（Docsy、Book）、要麼 Stars 不足、要麼需要完整 Node 建置鏈。

---

## 第三步：存活候選多維度比較

### 3.1 一覽表

| 維度 | PaperMod | Stack | FixIt | Blowfish | Congo | MemE | Mainroad | Coder |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **Schema 可控性** | 高（extend_head.html hook） | 高（覆蓋 head partial） | ✅ **內建 JSON-LD** | 高（extend-head.html） | 高（extend-head.html） | 中（需覆蓋） | 中（Hugo internal templates） | 高（覆蓋 partial） |
| **作者實體管理** | Front Matter | Front Matter + Data | Front Matter | Front Matter + Params | Front Matter + Params | Front Matter | ✅ **Author Box 原生** | Front Matter |
| **自動化友善度** | ✅ 最佳 | 好 | 好 | 好 | 好 | 中 | 好 | 中 |
| **新聞版面適性** | 中（blog 為主） | 中（blog 為主） | 中（blog 為主） | 中（blog 為主） | 中（blog 為主） | 低（個人博客） | ✅ **最佳**（Magazine） | ❌ 不適合 |
| **i18n（日/英）** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅（含繁中） | ✅ | ✅ |
| **可移植性** | ✅ 極佳 | ✅ 極佳 | ✅ 極佳 | ⚠️ Tailwind 包袱 | ⚠️ Tailwind 包袱 | ✅ 極佳 | ⚠️ PostCSS | ✅ 極佳 |
| **社區規模** | ✅ 最大 | 大 | 中 | 中 | 中 | 小 | 中 | 大 |
| **學習曲線** | 低 | 中 | 中 | 中 | 中 | 高 | 低 | 低 |

### 3.1.1 新增符合條件之候選 (依 `r.f.md` 與 `r.md` 篩選)

| 維度 | Blox (Academic) |
|:---|:---:|
| **Schema 可控性** | ✅ **最強**（支援詳細個人簡介、多社交連結、職稱與所屬機構） |
| **作者實體管理** | ✅ 最細緻（Person 結構定義最完整） |
| **自動化友善度** | 好 |
| **新聞版面適性** | 中（偏學術/智庫感） |
| **i18n（日/英）** | ✅ |
| **可移植性** | ✅ 極佳 |
| **社區規模** | 大（~3.8k Stars） |
| **學習曲線** | 高（功能複雜） |

### 3.2 各候選的獨特優點與缺點

#### ✅ PaperMod
- **獨特優點**：Hugo 生態最大社群 → 問題幾乎都有現成解答；`extend_head.html` 設計允許注入任意 JSON-LD **不碰主題原始碼**；極簡架構讓自動化流水線 `hugo new` 的摩擦最低
- **獨特缺點**：視覺上偏「個人部落格」，需要自訂 CSS 才能看起來像新聞機構；沒有原生側邊欄 widget

#### Stack
- **獨特優點**：卡片式佈局最現代化，開箱即有分類/標籤頁、搜尋功能、Dark mode
- **獨特缺點**：head partial 覆蓋需手動複製檔案（非 hook 注入），上游更新時需手動同步

#### FixIt
- **獨特優點**：**唯一內建 JSON-LD Schema 的候選**；LoveIt 的精神後繼，功能最豐富
- **獨特缺點**：Stars 僅 ~1.1k（門檻邊緣）；功能太多導致 config 參數龐大，自動化腳本需處理更多 front matter 欄位

#### Blowfish
- **獨特優點**：視覺最華麗（動畫、漸層）；`extend-head.html` + `extend-head-uncached.html` 雙 hook 設計最彈性
- **獨特缺點**：底層使用 Tailwind CSS（雖已預編譯），長期搬遷有隱性風險

#### Congo
- **獨特優點**：Tailwind 系中最輕量的，檔案結構乾淨
- **獨特缺點**：與 Blowfish 同源同病（Tailwind 依賴），功能少於 Blowfish

#### MemE
- **獨特優點**：繁體中文 README 最友善；配置極度靈活（300+ 參數）
- **獨特缺點**：維護頻率低、社群小；配置過於複雜，自動化腳本的維護成本高

#### Mainroad（清單外 #1）
- **獨特優點**：**唯一 Magazine 版面**，側邊欄 Widget（搜尋/最新文章/分類/社群連結）開箱即用；Hugo internal templates 直接啟用 Schema/OG/Twitter Cards（`schema = true`）；Author Box 原生支援
- **獨特缺點**：repo 含 `package.json`（PostCSS/ESLint 用，非建置必須但存在）；視覺設計較老派；GPL-2.0 授權（而非 MIT）

#### Coder（清單外 #2）
- **獨特優點**：3.1k Stars，極簡到**不可能壞**；非常適合作為「機構身分首頁」（About/Staff/法律頁面）
- **獨特缺點**：**完全不適合新聞列表頁**，設計為個人 Portfolio 用途

#### Blox (Academic)（清單外 #3）
- **獨特優點**：為「實體識別」而生，具備工業級作者實體欄位（sameAs, WorksFor 等），是觸發 Google Knowledge Graph 認證的最強靜態主題。
- **獨特缺點**：架構龐大，預設視覺偏向智庫/學術機構，而非傳統新聞報紙。

---

## 第四步：決策矩陣（依核心需求加權）

權重分配依據 `r.md` + `r.f.md`：
- Schema 可控性 → 30%（Knowledge Graph 是核心目標）
- 自動化友善度 → 25%（零人力流水線）
- 可移植性 → 20%（低維護哲學）
- 新聞版面適性 → 15%（機構形象）
- 社區規模 → 10%（問題解決速度）

| 主題 | Schema (30%) | 自動化 (25%) | 可移植 (20%) | 版面 (15%) | 社區 (10%) | **加權分** |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| **PaperMod** | 8 | 10 | 10 | 6 | 10 | **8.6** |
| **FixIt** | 10 | 8 | 10 | 6 | 6 | **8.4** |
| **Mainroad** | 7 | 8 | 7 | 10 | 7 | **7.8** |
| **Stack** | 8 | 8 | 10 | 6 | 8 | **8.0** |
| **Blowfish** | 9 | 8 | 6 | 6 | 7 | **7.6** |
| **Congo** | 8 | 8 | 6 | 6 | 7 | **7.2** |
| **MemE** | 7 | 6 | 10 | 4 | 5 | **6.7** |
| **Coder** | 7 | 5 | 10 | 2 | 8 | **6.3** |
| **Blox (Academic)** | 10 | 8 | 9 | 8 | 9 | **8.9** |

---

## 第五步：最終推薦

### 🥇 首選：PaperMod
**理由**：自動化流水線摩擦最低 + 社群最大（踩坑成本最低） + `extend_head.html` 讓 Schema 注入腳本完全與主題解耦。Schema 由流水線產生 JSON-LD，直接寫入 `extend_head.html` partial 即可，**主題更新永遠不會破壞 Schema 邏輯**。

### 🥈 備選：FixIt
**理由**：如果希望「開箱即有基本 Schema」而不是從零建立 JSON-LD partial，FixIt 是唯一內建的選項。但代價是 config 複雜度高，且社群較小。

### ⚠️ 不推薦的常見誤區
- **Blowfish/Congo**：看起來很漂亮，但 Tailwind 是「看不見的技術債」
- **Mainroad**：Magazine 版面最好看，但 PostCSS + GPL 授權 + 老派設計 = 未來搬遷痛苦
- **Coder**：適合「關於我們」首頁，但不適合新聞發布主站

---

## 關鍵結論

> **清單中所有主題「看起來都 80 分」是因為：Hugo 主題本身不決定 Schema 品質。**
>
> NewsArticle JSON-LD 是流水線注入的，主題只需提供一個乾淨的 `<head>` hook。
> 因此，**選擇的真正差異點是「自動化摩擦」和「搬遷成本」，不是 Schema 功能。**
>
> PaperMod 在這兩個維度都是最優解。

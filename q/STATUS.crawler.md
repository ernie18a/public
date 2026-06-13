# STATUS.crawler

## Source Of Plan

```text
todo.crawler.md
```

## Rule

本文件只追蹤 `todo.crawler.md` 這條線。

每次處理 crawler 線任務：

```text
1. 先讀本文件的 Next。
2. 若 Next 已完成或不成立，再回讀 todo.crawler.md 找下一個 pending source。
3. 若需要登入、繞過存取控制、或 ToS/robots 風險不可接受，移入 Blocked 或 Skipped。
4. Completed / Blocked / Skipped / Last Raw Capture 只更新本文件。
5. 不在 todo.crawler.md 追蹤每日執行狀態。
```

任務邊界：

```text
只做 public page access 與 raw capture。
不做清理、resample、feature engineering、backtest sanity check。
Playwright cache / profile / tmp 必須限制在 ./TMP/。
```

## Access / ToS Risk

```text
[ ]
```

## Completed

```text
[ ]
```

## Blocked

```text
[ ]
```

## Skipped

```text
[ ]
```

## Next

```text
[ ] Yahoo Finance raw capture probe
```

來源：

```text
todo.crawler.md
```

理由：

```text
價格資料 fallback
可用來補價格缺口或交叉檢查
但非官方來源，需先確認 public access 與 raw capture 可行
```

done_when:

```text
[ ] public page access verified
[ ] raw HTML/JSON/CSV saved
[ ] crawler requirement documented
[ ] no login bypass
[ ] source metadata saved
[ ] volume availability checked
[ ] writes only OUTPUT/ and TMP/
```

## Last Raw Capture

```text
none
```


# STATUS.free.manual

## Source Of Plan

```text
todo.free.manual.md
```

## Rule

本文件只追蹤 `todo.free.manual.md` 這條線。

每次處理 manual 線任務：

```text
1. 先讀本文件的 Next。
2. 若 Next 已完成或不成立，再回讀 todo.free.manual.md 找下一個 pending source。
3. 缺 credential 時，移入 Pending Credential，不算來源失敗。
4. Completed / Blocked / Skipped / Pending Credential / Last Raw Capture 只更新本文件。
5. 不在 todo.free.manual.md 追蹤每日執行狀態。
```

任務邊界：

```text
只做 access probe 與 raw data 取得。
不做清理、resample、feature engineering、backtest sanity check。
token 不得寫入文件、log、OUTPUT、TMP。
```

## Pending Credential

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
[ ] iTick access probe
```

來源：

```text
todo.free.manual.md
```

理由：

```text
台灣市場 intraday 主候選
可能支援 >=30m raw data
但需先確認 free tier / API key / historical depth
```

需要使用者提供：

```text
ITICK_API_KEY
```

done_when:

```text
[ ] signup/API key requirement documented
[ ] credential env var name documented
[ ] access token works
[ ] sample raw download works
[ ] raw response saved
[ ] source metadata saved
[ ] volume availability checked
[ ] writes only OUTPUT/ and TMP/
```

## Last Raw Capture

```text
none
```


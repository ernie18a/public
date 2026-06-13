# STATUS.free.auto

## Source Of Plan

```text
todo.free.auto.md
```

## Rule

本文件只追蹤 `todo.free.auto.md` 這條線。

每次處理 auto 線任務：

```text
1. 先讀本文件的 Next。
2. 若 Next 已完成或不成立，再回讀 todo.free.auto.md 找下一個 pending source。
3. Completed / Blocked / Skipped / Last Raw Capture 只更新本文件。
4. 不在 todo.free.auto.md 追蹤每日執行狀態。
```

任務邊界：

```text
只做 raw data 取得。
不做清理、resample、feature engineering、backtest sanity check。
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
[ ] Stooq raw download probe
```

來源：

```text
todo.free.auto.md
```

理由：

```text
不用人工註冊
免費
下載成本低
可先取得 historical raw price baseline
```

done_when:

```text
[ ] endpoint/access verified
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


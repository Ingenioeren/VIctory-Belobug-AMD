# Mid-range AMD branch (`midrange-amd`)

This branch is Belobug's [`rx9070xt`](https://github.com/Belobug/VIctory-Belobug-AMD/tree/rx9070xt) plus a few
changes that make it run on a **mid-range AMD card with 32 GB of RAM**. All credit for the renderer work goes to
[Belobug](https://github.com/Belobug/VIctory-Belobug-AMD), [avatarmanz](https://github.com/avatarmanz/VIctory-7900XTX),
[DexNom](https://github.com/DexNom/VIctory) and [Marvisak/VIctory](https://github.com/Marvisak/VIctory). You need
your own copy of the game; nothing from it is in this repository.

**Tested on one PC only:** RX 6750 XT 12 GB (RDNA2), i7-12700KF, 32 GB RAM, Windows 11.
The changes here were found and written with AI assistance (Claude Code and OpenAI Codex) and checked by test runs on
that PC.

## Results on the RX 6750 XT

| Setup | In the world | Frame rate in play |
|---|---|---|
| `rx9070xt` with `scripts\play.ps1` | GPU lost about 50 s after start | - |
| `rx9070xt`, plain settings | GPU lost after about 2.5 min | 1-2 fps |
| this branch, `scripts\play-midrange.ps1` | stable for whole 10-minute runs | **about 7 fps** (149 ms a frame) |

Work continues; the table is updated as runs improve.

## What this branch adds

- `VICTORY_LOW_MEMORY=1`: host-memory budgets for 32 GB PCs (the GPU was lost when free RAM ran out as the world streamed in).
- `VICTORY_SPLIT_SUBMIT=N`: splits submissions into one `ExecuteCommandLists` per N runs. On RDNA2 this took the
  card's time per frame from about 1.8 s to about 0.1 s.
- `scripts\play-midrange.ps1`: the settings above with the subset of `play.ps1` switches that stay stable on this card.

## How to run it

Build as in `README.md`, close other heavy programs (the game uses about 25 GB of RAM), then:

```
scripts\play-midrange.ps1 -Exe <path of your own copy's executable>
```

## Help wanted: test reports from other cards

If you have a mid-range AMD card (RX 6600 to 7800 class), please open an issue with the **Test report** template:
card, RAM, driver, settings, how long it stayed in the world and the fps. Reports without game content only:
no screenshots, videos or game files.

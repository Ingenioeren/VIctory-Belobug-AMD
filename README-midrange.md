# VIctory for mid-range AMD cards (`midrange-foxhound`)

This branch is [foxhound](https://github.com/readmet3xt-lab/foxhound) (`3d52ac8`, a VIctory fork) plus two changes
that make it run on a **mid-range AMD card**. You need your own copy of the game; nothing from it is in this
repository. All credit for the layer goes to readmet3xt-lab (foxhound), [Marvisak/VIctory](https://github.com/Marvisak/VIctory)
and the forks they build on (fxceless, avatarmanz, codec-d/cool_fox, DexNom, Belobug and others).

**Tested on one PC only:** RX 6750 XT 12 GB (RDNA2), i7-12700KF, 48 GB RAM, Windows 11. The changes were found and
written with AI assistance (Claude Code and OpenAI Codex) and checked by test runs on that PC.

## Results on the RX 6750 XT (Series S profile, 10-minute runs, walking and turning)

| Setup | In the world | Frame rate in play |
|---|---|---|
| foxhound as it is | GPU lost about 4 s after entering the world | - |
| our earlier Belobug-based branch | stable for whole 10-minute runs | about 6-7 fps |
| **this branch, `scripts\play-midrange.ps1`** | **stable for whole 10-minute runs** | **about 12-15 fps** (64-86 ms a frame) |

## What this branch adds

- `VICTORY_SPLIT_SUBMIT=N`: one `ExecuteCommandLists` per N runs instead of very large submissions. On RDNA2 the
  device was lost without it.
- `VICTORY_RESIDENCY_LIMITED=1`: forces the smaller-PC host-memory budgets (RAM-pressure handling).
- `scripts\play-midrange.ps1`: foxhound's own launcher with the Series S profile, no DLSS and the two switches above.

## How to run it

Build as in foxhound's README below (`cargo build --release --locked -p victory`), close other heavy programs, then:

```
scripts\play-midrange.ps1 -Exe <path of your own copy's executable>
```

The first start translates the title's shaders (minutes) and stutters while pipelines are made.

## Test reports

If you try it on another card, a short report is welcome as an issue (there is a template): card, RAM, driver,
settings, how long it stayed in the world and the fps. No screenshots, videos or game files, please.

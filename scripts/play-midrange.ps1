# Starts the title with the settings measured best on a mid-range AMD card (README-midrange.md):
# RX 6750 XT 12 GB (RDNA2), 32 GB RAM, Windows 11. Stable in the world for whole 10-minute test runs.
#   scripts\play-midrange.ps1 -Exe <path of your own copy's executable>
# -Build        target\diag (the default, the build all measurements are of) or target\release
# -More         other settings: -More @{VICTORY_OUTPUT='1280x720'}
# Close other heavy programs first: on 32 GB the game itself uses about 25 GB.
param(
    [Parameter(Mandatory)][string]$Exe,
    [ValidateSet('diag', 'release')][string]$Build = 'diag',
    [hashtable]$More = @{}
)
$settings = @{
    VICTORY_LOW_MEMORY = '1'         # host-memory budgets for 32 GB PCs (this branch)
    VICTORY_SPLIT_SUBMIT = '1'       # smaller submissions; the biggest single gain on RDNA2 (this branch)
    VICTORY_RELAY_COPY = '1'         # read-backs over the copy queue (from scripts\play.ps1)
    VICTORY_TEXTURE_NO_WAIT = '1'    # (from scripts\play.ps1)
    VICTORY_CARD_STEPS = '2'         # (from scripts\play.ps1)
    VICTORY_OUTPUT = '1920x1080'     # the title renders to 1080p itself (its own upscaler below that)
    VICTORY_PRESENT_TARGET = '1x1:1'
    VICTORY_HAIR = '1'
}
foreach ($k in $More.Keys) { $settings[$k] = $More[$k] }

$victory = Join-Path $PSScriptRoot "..\target\$Build\victory.exe"
if (-not (Test-Path $victory)) { Write-Host "No $victory. Build it first (README.md)."; exit 1 }
if (-not (Test-Path $Exe)) { Write-Host "No $Exe."; exit 1 }
$paths = 'VICTORY_CONFIG', 'VICTORY_GAME_DIR', 'VICTORY_CACHE_DIR', 'VICTORY_DATA_DIR', 'VICTORY_FIDELITYFX_DIR'
foreach ($entry in @(Get-ChildItem Env:VICTORY_* | Where-Object { $_.Name -notin $paths })) { Remove-Item "Env:$($entry.Name)" }
foreach ($k in $settings.Keys) { Set-Item "Env:$k" $settings[$k] }
$Exe = (Resolve-Path $Exe).Path
Push-Location (Join-Path $PSScriptRoot '..')
try { & $victory run $Exe --execute } finally { Pop-Location }

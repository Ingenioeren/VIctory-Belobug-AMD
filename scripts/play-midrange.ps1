# Starts the title with the settings measured best on a mid-range AMD card (README-midrange.md):
# RX 6750 XT 12 GB (RDNA2), 48 GB RAM, Windows 11: stable for whole 10-minute runs at about 12-15 fps.
# It is foxhound's own launcher with the Series S profile, no DLSS and this branch's two switches.
#   scripts\play-midrange.ps1 -Exe <path of your own copy's executable>
#   -More @{VICTORY_X='1'}   add or override switches
param(
    [Parameter(Mandatory)][string]$Exe,
    [ValidateSet('diag', 'release')][string]$Build = 'release',
    [hashtable]$More = @{}
)
$switches = @{ VICTORY_SPLIT_SUBMIT = '1'; VICTORY_RESIDENCY_LIMITED = '1' }
foreach ($k in $More.Keys) { $switches[$k] = $More[$k] }
& (Join-Path $PSScriptRoot 'play-foxhound.ps1') -Exe $Exe -Build $Build -SeriesS -Dlss off -More $switches

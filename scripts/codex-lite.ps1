$ErrorActionPreference = 'Stop'
$repoRoot = (Resolve-Path "$PSScriptRoot\..").Path
& "$repoRoot\scripts\run_codex_mode_windows.ps1" lite @args

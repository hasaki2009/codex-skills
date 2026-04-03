$ErrorActionPreference = 'Stop'
$repoRoot = (Resolve-Path "$PSScriptRoot\..").Path
$srcDir = Join-Path $repoRoot 'skills'
$targetRoot = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $env:USERPROFILE '.codex' }
$targetDir = Join-Path $targetRoot 'skills'

New-Item -ItemType Directory -Force -Path $srcDir | Out-Null
New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

Get-ChildItem -Path $srcDir -Directory | ForEach-Object {
  $name = $_.Name
  if ($name.StartsWith('.')) { return }
  $dest = Join-Path $targetDir $name
  if (Test-Path $dest) {
    Remove-Item -Recurse -Force $dest
  }
  New-Item -ItemType Junction -Path $dest -Target $_.FullName | Out-Null
  Write-Output "linked: $name"
}

Write-Output "done: $srcDir -> $targetDir"

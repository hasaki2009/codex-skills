$ErrorActionPreference = 'Stop'
$repoRoot = (Resolve-Path "$PSScriptRoot\..").Path
$listFile = Join-Path $repoRoot 'config\superpowers.list'
$dstRoot = if ($env:CODEX_HOME) { Join-Path $env:CODEX_HOME 'skills' } else { Join-Path $env:USERPROFILE '.codex\skills' }

if (!(Test-Path $listFile)) { throw "missing list: $listFile" }

Get-Content $listFile | ForEach-Object {
  $name = $_.Trim()
  if ($name -eq '' -or $name.StartsWith('#')) { return }
  $target = Join-Path $dstRoot $name
  if (Test-Path $target) {
    Remove-Item -Recurse -Force $target
    Write-Output "disabled: $name"
  } else {
    Write-Output "skip (not present): $name"
  }
}
Write-Output "done: superpowers disabled"

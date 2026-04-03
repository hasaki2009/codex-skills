$ErrorActionPreference = 'Stop'
$repoRoot = (Resolve-Path "$PSScriptRoot\..").Path
$listFile = Join-Path $repoRoot 'config\superpowers.list'
$srcRoot = Join-Path $repoRoot 'skills'
$dstRoot = if ($env:CODEX_HOME) { Join-Path $env:CODEX_HOME 'skills' } else { Join-Path $env:USERPROFILE '.codex\skills' }

if (!(Test-Path $listFile)) { throw "missing list: $listFile" }
New-Item -ItemType Directory -Force -Path $dstRoot | Out-Null

Get-Content $listFile | ForEach-Object {
  $name = $_.Trim()
  if ($name -eq '' -or $name.StartsWith('#')) { return }
  $src = Join-Path $srcRoot $name
  $dst = Join-Path $dstRoot $name
  if (!(Test-Path $src)) {
    Write-Output "skip (missing in repo): $name"
    return
  }
  if (Test-Path $dst) { Remove-Item -Recurse -Force $dst }
  New-Item -ItemType Junction -Path $dst -Target $src | Out-Null
  Write-Output "enabled: $name"
}
Write-Output "done: superpowers enabled"

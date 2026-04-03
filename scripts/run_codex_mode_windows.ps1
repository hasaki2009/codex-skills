param(
  [Parameter(Mandatory = $true)][ValidateSet('lite','super')] [string]$Mode,
  [Parameter(ValueFromRemainingArguments = $true)] [string[]]$CodexArgs
)

$ErrorActionPreference = 'Stop'
$repoRoot = (Resolve-Path "$PSScriptRoot\..").Path
$srcRoot = Join-Path $repoRoot 'skills'
$superList = Join-Path $repoRoot 'config\superpowers.list'
$defaultCodexHome = if ($env:CODEX_BASE_HOME) { $env:CODEX_BASE_HOME } else { Join-Path $env:USERPROFILE '.codex' }
$modeHome = Join-Path $env:USERPROFILE ".codex-$Mode"
$modeSkills = Join-Path $modeHome 'skills'

New-Item -ItemType Directory -Force -Path $modeSkills | Out-Null

$systemSrc = Join-Path $defaultCodexHome 'skills\.system'
$systemDst = Join-Path $modeSkills '.system'
if (Test-Path $systemSrc) {
  if (Test-Path $systemDst) { Remove-Item -Recurse -Force $systemDst }
  New-Item -ItemType Junction -Path $systemDst -Target $systemSrc | Out-Null
}

Get-ChildItem -Path $srcRoot -Directory | ForEach-Object {
  $name = $_.Name
  if ($name.StartsWith('.')) { return }
  if ($name -eq 'superpowers') { return }
  $dest = Join-Path $modeSkills $name
  if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
  New-Item -ItemType Junction -Path $dest -Target $_.FullName | Out-Null
}

if (Test-Path $superList) {
  Get-Content $superList | ForEach-Object {
    $name = $_.Trim()
    if ($name -eq '' -or $name.StartsWith('#')) { return }
    $src = Join-Path $srcRoot "superpowers\$name"
    $dst = Join-Path $modeSkills $name
    if ($Mode -eq 'super') {
      if (Test-Path $src) {
        if (Test-Path $dst) { Remove-Item -Recurse -Force $dst }
        New-Item -ItemType Junction -Path $dst -Target $src | Out-Null
      }
    } else {
      if (Test-Path $dst) { Remove-Item -Recurse -Force $dst }
    }
  }
}

$env:CODEX_HOME = $modeHome
& codex @CodexArgs

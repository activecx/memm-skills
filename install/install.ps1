#requires -Version 5.1
<#
.SYNOPSIS
  Installs, checks, updates or removes the official Memm skills for Claude Code and Codex.

.DESCRIPTION
  Claude Code: installs the "memm" plugin from a local Memm marketplace (claude plugin ...).
  Codex: copies the Memm skills into ~/.agents/skills (read by the Codex app, CLI and IDE extension).
  Connection: adds an MCP server named "memm" (https://memm.ai/api/mcp) only when no connection to that address exists.
  Settings are changed only through each client's own commands; config files are backed up first and never edited by hand.
  Nothing here generates anything or spends Memm credits.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File install.ps1              # install or update for every client found
  powershell -ExecutionPolicy Bypass -File install.ps1 -Check       # report the setup, change nothing
  powershell -ExecutionPolicy Bypass -File install.ps1 -Uninstall   # remove what this installer added
  powershell -ExecutionPolicy Bypass -File install.ps1 -ApiKeyEnvVar MEMM_API_KEY   # connect with an API key instead of sign-in
#>
[CmdletBinding()]
param(
  [ValidateSet('auto', 'claude', 'codex', 'both')] [string] $Client = 'auto',
  [switch] $Check,
  [switch] $Uninstall,
  [switch] $SkipConnect,
  [switch] $Login,
  [switch] $Force,
  [string] $ApiKeyEnvVar = '',
  [string] $Source = '',
  [string] $McpUrl = 'https://memm.ai/api/mcp'
)

$ErrorActionPreference = 'Stop'
$McpMatch = [regex]::Escape(($McpUrl -replace '^https?://', ''))
$UserHome = [Environment]::GetFolderPath('UserProfile')
if ($env:USERPROFILE) { $UserHome = $env:USERPROFILE }
$KitHome = Join-Path $UserHome '.memm\skills'
$StateFile = Join-Path $KitHome 'install-state.json'
$CodexSkillsDir = Join-Path $UserHome '.agents\skills'
$Marker = '.memm-skill'

function Say([string] $text) { Write-Host $text }
function Ok([string] $text) { Write-Host ("  [ok] " + $text) -ForegroundColor Green }
function Warn([string] $text) { Write-Host ("  [!]  " + $text) -ForegroundColor Yellow }
function Step([string] $text) { Write-Host ""; Write-Host $text -ForegroundColor Cyan }

if (-not $Source) { $Source = Split-Path -Parent $PSScriptRoot }
$SourceMarket = Join-Path $Source 'marketplace'
# The published package (memm.ai download, GitHub) has the marketplace at its root.
if (-not (Test-Path -LiteralPath (Join-Path $SourceMarket '.claude-plugin\marketplace.json'))) { $SourceMarket = $Source }

function Read-State {
  if (Test-Path -LiteralPath $StateFile) { return (Get-Content -LiteralPath $StateFile -Raw | ConvertFrom-Json) }
  return [pscustomobject]@{ version = ''; claudeConnectionAdded = $false; codexConnectionAdded = $false; codexSkills = @() }
}
function Save-State($state) {
  New-Item -ItemType Directory -Force -Path $KitHome | Out-Null
  $state | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $StateFile -Encoding UTF8
}

function Find-Claude {
  $cmd = Get-Command claude -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }
  return $null
}
function Find-Codex {
  $cmd = Get-Command codex -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }
  $ext = Join-Path $UserHome '.vscode\extensions'
  if (Test-Path -LiteralPath $ext) {
    $found = Get-ChildItem -LiteralPath $ext -Directory -Filter 'openai.chatgpt-*' -ErrorAction SilentlyContinue |
      Sort-Object Name -Descending |
      ForEach-Object { Join-Path $_.FullName 'bin\windows-x86_64\codex.exe' } |
      Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
    if ($found) { return $found }
  }
  return $null
}

# Runs a client command, returns @{ code; out }. Never throws on a non-zero exit.
function Run([string] $exe, [string[]] $arguments) {
  $prev = $ErrorActionPreference
  $ErrorActionPreference = 'Continue'
  try {
    $out = & $exe @arguments 2>&1 | Out-String
    $code = $LASTEXITCODE
  } finally { $ErrorActionPreference = $prev }
  return @{ code = $code; out = $out }
}

function Backup-File([string] $path) {
  if (-not (Test-Path -LiteralPath $path)) { return }
  $dir = Join-Path $KitHome 'backup'
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
  $name = (Split-Path -Leaf $path) + '.' + $stamp + '.bak'
  Copy-Item -LiteralPath $path -Destination (Join-Path $dir $name)
  Get-ChildItem -LiteralPath $dir -Filter ((Split-Path -Leaf $path) + '.*.bak') | Sort-Object Name -Descending | Select-Object -Skip 3 | Remove-Item -Force
}

function Get-Version([string] $market) {
  $p = Join-Path $market 'plugins\memm\.claude-plugin\plugin.json'
  if (Test-Path -LiteralPath $p) { return (Get-Content -LiteralPath $p -Raw | ConvertFrom-Json).version }
  return ''
}

$claude = Find-Claude
$codex = Find-Codex
$codexHome = Join-Path $UserHome '.codex'
if ($env:CODEX_HOME) { $codexHome = $env:CODEX_HOME }
$codexPresent = ($codex -ne $null) -or (Test-Path -LiteralPath $codexHome)
$wantClaude = ($Client -eq 'claude' -or $Client -eq 'both' -or ($Client -eq 'auto' -and $claude))
$wantCodex = ($Client -eq 'codex' -or $Client -eq 'both' -or ($Client -eq 'auto' -and $codexPresent))

Say "Memm skills installer"
if ($claude) { Ok "Claude Code found: $claude" } else { Say "  Claude Code: not found" }
if ($codex) { Ok "Codex found: $codex" } elseif ($codexPresent) { Say "  Codex settings found (no codex command; skills will still be installed)" } else { Say "  Codex: not found" }
if (-not $wantClaude -and -not $wantCodex) { Warn "Neither Claude Code nor Codex was found. Install one, then run this again."; exit 1 }

# ---------------------------------------------------------------- CHECK (read-only)
if ($Check) {
  $state = Read-State
  Step "Installed Memm skills"
  if ($state.version) { Ok "version $($state.version) in $KitHome" } else { Say "  not installed by this installer" }
  if ($wantClaude -and $claude) {
    Step "Claude Code"
    $r = Run $claude @('plugin', 'list')
    if ($r.out -match 'memm@memm') { Ok "plugin memm@memm installed" } else { Warn "plugin memm@memm not installed" }
    $m = Run $claude @('mcp', 'list')
    $line = ($m.out -split "`r?`n") | Where-Object { $_ -match $McpMatch } | Select-Object -First 1
    if (-not $line) { Warn "no connection to $McpUrl" }
    elseif ($line -match 'Needs authentication') { Warn ("connection needs sign-in: open Claude Code, type /mcp, choose memm, then Authenticate") }
    elseif ($line -match 'Failed') { Warn ("connection failing: " + $line.Trim()) }
    else { Ok ("connection: " + $line.Trim()) }
  }
  if ($wantCodex) {
    Step "Codex"
    $installed = @(Get-ChildItem -LiteralPath $CodexSkillsDir -Directory -ErrorAction SilentlyContinue | Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName $Marker) })
    if ($installed.Count -gt 0) { Ok ("$($installed.Count) Memm skills in $CodexSkillsDir") } else { Warn "no Memm skills in $CodexSkillsDir" }
    if ($codex) {
      $m = Run $codex @('mcp', 'list')
      $line = ($m.out -split "`r?`n") | Where-Object { $_ -match $McpMatch } | Select-Object -First 1
      if (-not $line) { Warn "no connection to $McpUrl in Codex settings (a ChatGPT-app connection may still exist)" }
      elseif ($line -match 'Not logged in|logged out') { Warn "connection needs sign-in: codex mcp login memm" }
      else { Ok ("connection: " + ($line -replace '\s+', ' ').Trim()) }
    }
  }
  Step "Last step, inside your AI client (free)"
  Say "  Ask: 'Check my Memm setup'"
  Say "  Arabic speakers: the phrase is in README.ar.md"
  Say "  The memm-start skill calls two free tools and reports your plan and balance. Nothing is charged."
  exit 0
}

# ---------------------------------------------------------------- UNINSTALL
if ($Uninstall) {
  $state = Read-State
  if ($wantClaude -and $claude) {
    Step "Claude Code"
    Backup-File (Join-Path $UserHome '.claude.json')
    $r = Run $claude @('plugin', 'uninstall', 'memm@memm', '--scope', 'user')
    if ($r.code -eq 0) { Ok "plugin removed" } else { Say "  plugin was not installed" }
    $r = Run $claude @('plugin', 'marketplace', 'remove', 'memm')
    if ($r.code -eq 0) { Ok "marketplace removed" } else { Say "  marketplace was not configured" }
    if ($state.claudeConnectionAdded) {
      $r = Run $claude @('mcp', 'remove', 'memm', '--scope', 'user')
      if ($r.code -eq 0) { Ok "connection 'memm' removed (it was added by this installer)" }
    } else { Say "  connection left as it was (not added by this installer)" }
  }
  if ($wantCodex) {
    Step "Codex"
    foreach ($dir in @(Get-ChildItem -LiteralPath $CodexSkillsDir -Directory -ErrorAction SilentlyContinue)) {
      if (Test-Path -LiteralPath (Join-Path $dir.FullName $Marker)) { Remove-Item -LiteralPath $dir.FullName -Recurse -Force; Ok "removed skill $($dir.Name)" }
    }
    if ($state.codexConnectionAdded -and $codex) {
      Backup-File (Join-Path $codexHome 'config.toml')
      $r = Run $codex @('mcp', 'remove', 'memm')
      if ($r.code -eq 0) { Ok "connection 'memm' removed (it was added by this installer)" }
    } else { Say "  connection left as it was (not added by this installer)" }
  }
  if (Test-Path -LiteralPath (Join-Path $KitHome 'marketplace')) { Remove-Item -LiteralPath (Join-Path $KitHome 'marketplace') -Recurse -Force }
  if (Test-Path -LiteralPath (Join-Path $KitHome 'previous')) { Remove-Item -LiteralPath (Join-Path $KitHome 'previous') -Recurse -Force }
  if (Test-Path -LiteralPath $StateFile) { Remove-Item -LiteralPath $StateFile -Force }
  Step "Done. Your memm/ project folders and your Memm account were not touched. Backups: $KitHome\backup"
  exit 0
}

# ---------------------------------------------------------------- INSTALL / UPDATE
if (-not (Test-Path -LiteralPath (Join-Path $SourceMarket '.claude-plugin\marketplace.json'))) {
  Warn "Package not found at $SourceMarket. Run this script from the unzipped memm-skills folder, or pass -Source."
  exit 1
}
$version = Get-Version $SourceMarket
$state = Read-State
Step "Installing Memm skills $version"

# Stable copy of the package; the previous version is kept for recovery.
$target = Join-Path $KitHome 'marketplace'
$previous = Join-Path $KitHome 'previous'
New-Item -ItemType Directory -Force -Path $KitHome | Out-Null
if ((Resolve-Path -LiteralPath $SourceMarket).Path -ne $target) {
  if (Test-Path -LiteralPath $target) {
    if (Test-Path -LiteralPath $previous) { Remove-Item -LiteralPath $previous -Recurse -Force }
    Move-Item -LiteralPath $target -Destination $previous
  }
  # Only the marketplace itself: never the installer, the docs or a .git folder.
  New-Item -ItemType Directory -Force -Path $target | Out-Null
  foreach ($part in '.claude-plugin', '.agents', 'plugins') {
    Copy-Item -LiteralPath (Join-Path $SourceMarket $part) -Destination $target -Recurse
  }
}
Ok "package copied to $target"

if ($wantClaude) {
  Step "Claude Code"
  if (-not $claude) { Warn "Claude Code not found; skipped. Install it (irm https://claude.ai/install.ps1 | iex), then run this again." }
  else {
    Backup-File (Join-Path $UserHome '.claude.json')
    $r = Run $claude @('plugin', 'marketplace', 'add', $target, '--scope', 'user')
    if ($r.code -ne 0) {
      $u = Run $claude @('plugin', 'marketplace', 'update', 'memm')
      if ($u.code -ne 0) { Warn ("marketplace: " + ($r.out.Trim())) } else { Ok "marketplace 'memm' updated" }
    } else { Ok "marketplace 'memm' added" }
    $r = Run $claude @('plugin', 'install', 'memm@memm', '--scope', 'user')
    if ($r.code -ne 0) {
      $u = Run $claude @('plugin', 'update', 'memm@memm', '--scope', 'user')
      if ($u.code -ne 0) { Warn ("plugin: " + ($r.out.Trim())) } else { Ok "plugin memm@memm updated (restart Claude Code to load it)" }
    } else { Ok "plugin memm@memm installed (start a new Claude Code session to load it)" }

    if (-not $SkipConnect) {
      $m = Run $claude @('mcp', 'list')
      if ($m.out -match $McpMatch) { Ok "Memm connection already present; nothing added" }
      else {
        $args2 = @('mcp', 'add', '--transport', 'http', '--scope', 'user', 'memm', $McpUrl)
        if ($ApiKeyEnvVar) {
          $key = [Environment]::GetEnvironmentVariable($ApiKeyEnvVar)
          if (-not $key) { Warn "Environment variable $ApiKeyEnvVar is empty; connection not added."; $args2 = $null }
          else { $args2 += @('--header', ('Authorization: Bearer ' + $key)) }
        }
        if ($args2) {
          $a = Run $claude $args2
          if ($a.code -eq 0) {
            $state.claudeConnectionAdded = $true
            Ok "connection 'memm' added"
            if (-not $ApiKeyEnvVar) { Say "  Sign in once: open Claude Code, type /mcp, choose memm, then Authenticate." }
          } else { Warn ("connection: " + $a.out.Trim()) }
        }
      }
    }
  }
}

if ($wantCodex) {
  Step "Codex"
  New-Item -ItemType Directory -Force -Path $CodexSkillsDir | Out-Null
  $skillsSrc = Join-Path $target 'plugins\memm\skills'
  $names = @()
  foreach ($skill in @(Get-ChildItem -LiteralPath $skillsSrc -Directory)) {
    $dest = Join-Path $CodexSkillsDir $skill.Name
    if ((Test-Path -LiteralPath $dest) -and -not (Test-Path -LiteralPath (Join-Path $dest $Marker)) -and -not $Force) {
      Warn "$dest exists and was not installed by Memm; left untouched (use -Force to replace it)"
      continue
    }
    if (Test-Path -LiteralPath $dest) { Remove-Item -LiteralPath $dest -Recurse -Force }
    Copy-Item -LiteralPath $skill.FullName -Destination $dest -Recurse
    Set-Content -LiteralPath (Join-Path $dest $Marker) -Value ("memm-skills " + $version) -Encoding UTF8
    $names += $skill.Name
  }
  $state.codexSkills = $names
  Ok ("$($names.Count) skills copied to $CodexSkillsDir (start a new Codex session to load them)")

  if (-not $SkipConnect) {
    if (-not $codex) { Warn "No codex command found; connect Memm from Codex with: codex mcp add memm --url $McpUrl" }
    else {
      $m = Run $codex @('mcp', 'list')
      if ($m.out -match $McpMatch) { Ok "Memm connection already present; nothing added" }
      else {
        Backup-File (Join-Path $codexHome 'config.toml')
        $args3 = @('mcp', 'add', 'memm', '--url', $McpUrl)
        if ($ApiKeyEnvVar) { $args3 += @('--bearer-token-env-var', $ApiKeyEnvVar) }
        $a = Run $codex $args3
        if ($a.code -eq 0) {
          $state.codexConnectionAdded = $true
          Ok "connection 'memm' added"
          if (-not $ApiKeyEnvVar) {
            if ($Login) { Say "  Opening the Memm sign-in page..."; & $codex mcp login memm }
            else { Say "  If a browser window opened, sign in to Memm there. Otherwise sign in once with: codex mcp login memm" }
          }
        } else { Warn ("connection: " + $a.out.Trim()) }
      }
      Say "  If you already use Memm in Codex through the ChatGPT app, you can remove the extra connection: codex mcp remove memm"
    }
  }
}

$state.version = $version
Save-State $state
Step "Installed. Next, inside Claude Code or Codex, ask: 'Check my Memm setup' (free, nothing is charged)."
Say "Update: run this script again from a newer package. Remove: install.ps1 -Uninstall. Backups: $KitHome\backup"

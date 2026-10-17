#!/usr/bin/env bash
# Installs, checks, updates or removes the official Memm skills for Claude Code and Codex (macOS, Linux, WSL, Git Bash).
#
#   bash install.sh                 install or update for every client found
#   bash install.sh --check         report the setup, change nothing
#   bash install.sh --uninstall     remove what this installer added
#   bash install.sh --api-key-env MEMM_API_KEY   connect with an API key instead of sign-in
#   other flags: --client claude|codex|both, --skip-connect, --login, --force, --source <dir>, --mcp-url <url>
#
# Claude Code: installs the "memm" plugin from a local Memm marketplace.
# Codex: copies the Memm skills into ~/.agents/skills (read by the Codex app, CLI and IDE extension).
# Connection: adds an MCP server named "memm" only when no connection to that address exists.
# Settings change only through each client's own commands; config files are backed up first. Nothing spends Memm credits.
set -euo pipefail

CLIENT=auto; CHECK=0; UNINSTALL=0; SKIP_CONNECT=0; LOGIN=0; FORCE=0; API_KEY_ENV=""; SOURCE=""; MCP_URL="https://memm.ai/api/mcp"
while [ $# -gt 0 ]; do
  case "$1" in
    --client) CLIENT="$2"; shift 2 ;;
    --check) CHECK=1; shift ;;
    --uninstall) UNINSTALL=1; shift ;;
    --skip-connect) SKIP_CONNECT=1; shift ;;
    --login) LOGIN=1; shift ;;
    --force) FORCE=1; shift ;;
    --api-key-env) API_KEY_ENV="$2"; shift 2 ;;
    --source) SOURCE="$2"; shift 2 ;;
    --mcp-url) MCP_URL="$2"; shift 2 ;;
    -h|--help) sed -n '2,9p' "$0"; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[ -n "$SOURCE" ] || SOURCE="$(dirname "$HERE")"
SOURCE_MARKET="$SOURCE/marketplace"
# The published package (memm.ai download, GitHub) has the marketplace at its root.
[ -f "$SOURCE_MARKET/.claude-plugin/marketplace.json" ] || SOURCE_MARKET="$SOURCE"
KIT_HOME="$HOME/.memm/skills"
STATE="$KIT_HOME/install-state"
CODEX_SKILLS="$HOME/.agents/skills"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
MARKER=".memm-skill"
MATCH="${MCP_URL#http://}"; MATCH="${MATCH#https://}"

ok()   { printf '  [ok] %s\n' "$1"; }
warn() { printf '  [!]  %s\n' "$1"; }
step() { printf '\n%s\n' "$1"; }
state_get() { [ -f "$STATE" ] && grep -E "^$1=" "$STATE" | head -n1 | cut -d= -f2- || true; }
state_set() { mkdir -p "$KIT_HOME"; touch "$STATE"; grep -vE "^$1=" "$STATE" > "$STATE.tmp" || true; echo "$1=$2" >> "$STATE.tmp"; mv "$STATE.tmp" "$STATE"; }
backup() {
  [ -f "$1" ] || return 0
  mkdir -p "$KIT_HOME/backup"
  cp "$1" "$KIT_HOME/backup/$(basename "$1").$(date +%Y%m%d-%H%M%S).bak"
  ls -1t "$KIT_HOME/backup/$(basename "$1")".*.bak 2>/dev/null | tail -n +4 | while read -r old; do rm -f "$old"; done
}
run() { "$@" 2>&1 || true; }

CLAUDE="$(command -v claude || true)"
CODEX="$(command -v codex || true)"
CODEX_PRESENT=0; { [ -n "$CODEX" ] || [ -d "$CODEX_HOME_DIR" ]; } && CODEX_PRESENT=1
WANT_CLAUDE=0; WANT_CODEX=0
case "$CLIENT" in
  claude) WANT_CLAUDE=1 ;; codex) WANT_CODEX=1 ;; both) WANT_CLAUDE=1; WANT_CODEX=1 ;;
  auto) [ -n "$CLAUDE" ] && WANT_CLAUDE=1; [ "$CODEX_PRESENT" = 1 ] && WANT_CODEX=1 ;;
esac

echo "Memm skills installer"
[ -n "$CLAUDE" ] && ok "Claude Code found: $CLAUDE" || echo "  Claude Code: not found"
if [ -n "$CODEX" ]; then ok "Codex found: $CODEX"; elif [ "$CODEX_PRESENT" = 1 ]; then echo "  Codex settings found (no codex command; skills will still be installed)"; else echo "  Codex: not found"; fi
if [ "$WANT_CLAUDE" = 0 ] && [ "$WANT_CODEX" = 0 ]; then warn "Neither Claude Code nor Codex was found. Install one, then run this again."; exit 1; fi

# ------------------------------------------------------------------ CHECK (read-only)
if [ "$CHECK" = 1 ]; then
  step "Installed Memm skills"
  v="$(state_get version)"; [ -n "$v" ] && ok "version $v in $KIT_HOME" || echo "  not installed by this installer"
  if [ "$WANT_CLAUDE" = 1 ] && [ -n "$CLAUDE" ]; then
    step "Claude Code"
    run "$CLAUDE" plugin list | grep -q 'memm@memm' && ok "plugin memm@memm installed" || warn "plugin memm@memm not installed"
    line="$(run "$CLAUDE" mcp list | grep -F "$MATCH" | head -n1)"
    if [ -z "$line" ]; then warn "no connection to $MCP_URL"
    elif echo "$line" | grep -q 'Needs authentication'; then warn "connection needs sign-in: open Claude Code, type /mcp, choose memm, then Authenticate"
    elif echo "$line" | grep -q 'Failed'; then warn "connection failing: $line"
    else ok "connection: $line"; fi
  fi
  if [ "$WANT_CODEX" = 1 ]; then
    step "Codex"
    n=0; for d in "$CODEX_SKILLS"/*/; do [ -f "$d$MARKER" ] && n=$((n+1)); done
    [ "$n" -gt 0 ] && ok "$n Memm skills in $CODEX_SKILLS" || warn "no Memm skills in $CODEX_SKILLS"
    if [ -n "$CODEX" ]; then
      line="$(run "$CODEX" mcp list | grep -F "$MATCH" | head -n1 | tr -s ' ')"
      if [ -z "$line" ]; then warn "no connection to $MCP_URL in Codex settings (a ChatGPT-app connection may still exist)"
      elif echo "$line" | grep -qE 'Not logged in|logged out'; then warn "connection needs sign-in: codex mcp login memm"
      else ok "connection: $line"; fi
    fi
  fi
  step "Last step, inside your AI client (free)"
  echo "  Ask: 'Check my Memm setup'"
  echo "  In Arabic:"
  echo "  تحقّق من ربط حسابي في ميم"
  echo "  The memm-start skill calls two free tools and reports your plan and balance. Nothing is charged."
  exit 0
fi

# ------------------------------------------------------------------ UNINSTALL
if [ "$UNINSTALL" = 1 ]; then
  if [ "$WANT_CLAUDE" = 1 ] && [ -n "$CLAUDE" ]; then
    step "Claude Code"
    backup "$HOME/.claude.json"
    run "$CLAUDE" plugin uninstall memm@memm --scope user >/dev/null && ok "plugin removed (if it was installed)"
    run "$CLAUDE" plugin marketplace remove memm >/dev/null && ok "marketplace removed (if it was configured)"
    if [ "$(state_get claudeConnectionAdded)" = 1 ]; then run "$CLAUDE" mcp remove memm --scope user >/dev/null; ok "connection 'memm' removed (it was added by this installer)"
    else echo "  connection left as it was (not added by this installer)"; fi
  fi
  if [ "$WANT_CODEX" = 1 ]; then
    step "Codex"
    for d in "$CODEX_SKILLS"/*/; do [ -f "$d$MARKER" ] && rm -rf "${d%/}" && ok "removed skill $(basename "$d")"; done
    if [ "$(state_get codexConnectionAdded)" = 1 ] && [ -n "$CODEX" ]; then backup "$CODEX_HOME_DIR/config.toml"; run "$CODEX" mcp remove memm >/dev/null; ok "connection 'memm' removed (it was added by this installer)"
    else echo "  connection left as it was (not added by this installer)"; fi
  fi
  rm -rf "$KIT_HOME/marketplace" "$KIT_HOME/previous" "$STATE"
  step "Done. Your memm/ project folders and your Memm account were not touched. Backups: $KIT_HOME/backup"
  exit 0
fi

# ------------------------------------------------------------------ INSTALL / UPDATE
[ -f "$SOURCE_MARKET/.claude-plugin/marketplace.json" ] || { warn "Package not found at $SOURCE_MARKET. Run this from the unzipped memm-skills folder, or pass --source."; exit 1; }
VERSION="$(grep -m1 '"version"' "$SOURCE_MARKET/plugins/memm/.claude-plugin/plugin.json" | sed -E 's/.*"version": *"([^"]+)".*/\1/')"
step "Installing Memm skills $VERSION"
TARGET="$KIT_HOME/marketplace"; PREVIOUS="$KIT_HOME/previous"
mkdir -p "$KIT_HOME"
if [ "$(cd "$SOURCE_MARKET" && pwd -P)" != "$( [ -d "$TARGET" ] && cd "$TARGET" && pwd -P || echo none)" ]; then
  if [ -d "$TARGET" ]; then rm -rf "$PREVIOUS"; mv "$TARGET" "$PREVIOUS"; fi
  # Only the marketplace itself: never the installer, the docs or a .git folder.
  mkdir -p "$TARGET"
  cp -R "$SOURCE_MARKET/.claude-plugin" "$SOURCE_MARKET/.agents" "$SOURCE_MARKET/plugins" "$TARGET/"
fi
ok "package copied to $TARGET"

if [ "$WANT_CLAUDE" = 1 ]; then
  step "Claude Code"
  if [ -z "$CLAUDE" ]; then warn "Claude Code not found; skipped. Install it (curl -fsSL https://claude.ai/install.sh | bash), then run this again."
  else
    backup "$HOME/.claude.json"
    if "$CLAUDE" plugin marketplace add "$TARGET" --scope user >/dev/null 2>&1; then ok "marketplace 'memm' added"
    elif "$CLAUDE" plugin marketplace update memm >/dev/null 2>&1; then ok "marketplace 'memm' updated"
    else warn "could not add the marketplace; run: claude plugin marketplace add \"$TARGET\""; fi
    if "$CLAUDE" plugin install memm@memm --scope user >/dev/null 2>&1; then ok "plugin memm@memm installed (start a new Claude Code session to load it)"
    elif "$CLAUDE" plugin update memm@memm --scope user >/dev/null 2>&1; then ok "plugin memm@memm updated (restart Claude Code to load it)"
    else warn "could not install the plugin; run: claude plugin install memm@memm"; fi
    if [ "$SKIP_CONNECT" = 0 ]; then
      if run "$CLAUDE" mcp list | grep -qF "$MATCH"; then ok "Memm connection already present; nothing added"
      else
        if [ -n "$API_KEY_ENV" ]; then
          key="${!API_KEY_ENV:-}"
          if [ -z "$key" ]; then warn "Environment variable $API_KEY_ENV is empty; connection not added."
          elif "$CLAUDE" mcp add --transport http --scope user memm "$MCP_URL" --header "Authorization: Bearer $key" >/dev/null 2>&1; then state_set claudeConnectionAdded 1; ok "connection 'memm' added (API key)"; fi
        elif "$CLAUDE" mcp add --transport http --scope user memm "$MCP_URL" >/dev/null 2>&1; then
          state_set claudeConnectionAdded 1; ok "connection 'memm' added"; echo "  Sign in once: open Claude Code, type /mcp, choose memm, then Authenticate."
        else warn "could not add the connection; run: claude mcp add --transport http --scope user memm $MCP_URL"; fi
      fi
    fi
  fi
fi

if [ "$WANT_CODEX" = 1 ]; then
  step "Codex"
  mkdir -p "$CODEX_SKILLS"; n=0
  for src in "$TARGET"/plugins/memm/skills/*/; do
    name="$(basename "$src")"; dest="$CODEX_SKILLS/$name"
    if [ -d "$dest" ] && [ ! -f "$dest/$MARKER" ] && [ "$FORCE" = 0 ]; then warn "$dest exists and was not installed by Memm; left untouched (use --force to replace it)"; continue; fi
    rm -rf "$dest"; cp -R "${src%/}" "$dest"; echo "memm-skills $VERSION" > "$dest/$MARKER"; n=$((n+1))
  done
  ok "$n skills copied to $CODEX_SKILLS (start a new Codex session to load them)"
  if [ "$SKIP_CONNECT" = 0 ]; then
    if [ -z "$CODEX" ]; then warn "No codex command found; connect Memm from Codex with: codex mcp add memm --url $MCP_URL"
    elif run "$CODEX" mcp list | grep -qF "$MATCH"; then ok "Memm connection already present; nothing added"
    else
      backup "$CODEX_HOME_DIR/config.toml"
      if [ -n "$API_KEY_ENV" ]; then add_ok=0; "$CODEX" mcp add memm --url "$MCP_URL" --bearer-token-env-var "$API_KEY_ENV" >/dev/null 2>&1 && add_ok=1
      else add_ok=0; "$CODEX" mcp add memm --url "$MCP_URL" && add_ok=1; fi
      if [ "$add_ok" = 1 ]; then
        state_set codexConnectionAdded 1; ok "connection 'memm' added"
        if [ -z "$API_KEY_ENV" ]; then
          if [ "$LOGIN" = 1 ]; then "$CODEX" mcp login memm; else echo "  If a browser window opened, sign in to Memm there. Otherwise sign in once with: codex mcp login memm"; fi
        fi
      else warn "could not add the connection; run: codex mcp add memm --url $MCP_URL"; fi
    fi
    echo "  If you already use Memm in Codex through the ChatGPT app, you can remove the extra connection: codex mcp remove memm"
  fi
fi

state_set version "$VERSION"
step "Installed. Next, inside Claude Code or Codex, ask: 'Check my Memm setup' (free, nothing is charged)."
echo "Update: run this script again from a newer package. Remove: bash install.sh --uninstall. Backups: $KIT_HOME/backup"

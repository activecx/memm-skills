# Connect Memm

Memm's tools need a paid Memm plan (Lite or higher) and a one-time sign-in. The connection is named `memm` and points to `https://memm.ai/api/mcp`. Signing in opens memm.ai in the browser; no key is copied by hand.

## Claude Code (terminal or VS Code)

```
claude mcp add --transport http --scope user memm https://memm.ai/api/mcp
```

Then, inside Claude Code, type `/mcp`, choose `memm`, choose Authenticate, and allow access on the Memm page. If the user already added Memm as a claude.ai connector, Claude Code can use that connector and nothing needs adding.

## Codex (app, CLI or IDE extension)

```
codex mcp add memm --url https://memm.ai/api/mcp
codex mcp login memm
```

The login opens the Memm page in the browser. Start a new Codex session afterwards so the tools load.

## With an API key instead of sign-in (teams, automation)

The user creates a key at memm.ai, Settings, Connections, Advanced: API keys. The key is shown once; it never goes into chat or project files.

- Claude Code: `claude mcp add --transport http --scope user memm https://memm.ai/api/mcp --header "Authorization: Bearer <key>"`
- Codex: set an environment variable `MEMM_API_KEY` to the key, then `codex mcp add memm --url https://memm.ai/api/mcp --bearer-token-env-var MEMM_API_KEY`

## The Memm skills installer

`install.ps1` (Windows) or `install.sh` (macOS, Linux) installs these skills and adds the connection only when it is missing. `-Check` / `--check` reports the setup without changing anything.

## Still not working

- "Needs authentication": run the sign-in step again.
- The upgrade message: the plan does not include the connection; see memm.ai/pricing.
- Tools look out of date or a field is missing: reconnect, then start a new session.
- Setup guide: https://memm.ai/docs/en/connect (Arabic: https://memm.ai/docs/ar/connect).

# Memm skills for Claude Code and Codex

Official Memm skills that take your AI assistant from understanding a business to finished, checked ad creatives:

1. **Research** the business, its customers and competitors from its website and public sources.
2. **Plan** growth or a campaign with clear, testable recommendations.
3. **Organise** the work: stages, owners, time, credits, checks.
4. **Develop ad concepts** and explain why each could work and how to test it.
5. **Choose models and control credits**: live prices, cost per acceptable result, one budget approval.
6. **Produce** images, product photos, Arabic ads, video, voice-overs, music, sound effects and 3D through Memm.
7. **Lip-sync**: make a photo speak or sing a recording, copy motion from a video, edit your own video.
8. **Check** every result against the brief before calling it final.

Arabic-first: the assistant answers Arabic requests in semi-formal Arabic, writes Memm as ميم and prices in كريديت.

| Skill | Use it for |
|---|---|
| memm-start | Start here: checks your Memm connection (free), picks the right skills, keeps the project notes |
| memm-research | Understanding a business, customers, competitors, reviews |
| memm-business-plan | A focused growth or marketing plan, offer and channel decisions |
| memm-workflow-plan | Turning a plan into stages with owners, time, credits and checks |
| memm-creative-strategy | Ad concepts, messages, hooks, and the reasoning behind them |
| memm-tool-selection | Which model, what it costs, how to spend fewer credits |
| memm-production | Making the assets, retries, partial results |
| memm-lip-sync | Talking or singing photos, motion copy, editing your own video |
| memm-qa | Reviewing work and fixing mistakes |

You do not need to name a skill. Ask in your own words ("make an ad for my perfume", «أريد إعلانًا لمنتجي») and the assistant picks it. You can also call one directly: `/memm:memm-start` in Claude Code, `$memm-start` in Codex.

## What you need

- **Claude Code** (terminal or VS Code extension) and/or **Codex** (app, CLI or VS Code extension).
- **A paid Memm plan** (Lite or higher) to generate. Research and planning skills work without a Memm plan.
- The skills cost nothing to install. Generations use your Memm credits; the assistant always shows the price and waits for your yes.

## Get the package

- **Download** from memm.ai: https://memm.ai/downloads/skills/memm-skills-2.0.0.zip (guide: https://memm.ai/docs/en/skills), or
- **Clone** this repository: `git clone https://github.com/activecx/memm-skills.git`

## Install

### Windows (PowerShell)

1. Unzip the download (or use the cloned folder). Open PowerShell in the `memm-skills` folder.
2. Run:
   ```powershell
   powershell -ExecutionPolicy Bypass -File install\install.ps1
   ```
3. Sign in to Memm once:
   - Claude Code: type `/mcp`, choose `memm`, choose Authenticate, allow access.
   - Codex: if no browser window opened during install, run `codex mcp login memm`.
4. Start a new Claude Code or Codex session and ask: **"Check my Memm setup"**. It calls two free tools and reports your plan and balance. Nothing is charged.

### macOS, Linux, WSL

```bash
bash install/install.sh
```
Then steps 3 and 4 above.

### Installer options

| Option (PowerShell / shell) | Does |
|---|---|
| `-Check` / `--check` | Reports what is installed and connected. Changes nothing. |
| `-Client claude` / `--client claude` | Only Claude Code (or `codex`, `both`). Default: every client found. |
| `-SkipConnect` / `--skip-connect` | Installs the skills but does not add the Memm connection. |
| `-ApiKeyEnvVar MEMM_API_KEY` / `--api-key-env MEMM_API_KEY` | Connect with an API key from that environment variable instead of signing in. |
| `-Login` / `--login` | Opens the Codex sign-in straight after adding the connection. |
| `-Force` / `--force` | Replace a skill folder of the same name that Memm did not install. |
| `-Uninstall` / `--uninstall` | Removes what the installer added (see below). |

### What the installer changes

- **Claude Code:** adds the `memm` marketplace and installs the `memm@memm` plugin (user scope), using Claude Code's own commands.
- **Codex:** copies the nine skill folders into `~/.agents/skills` (each marked with a `.memm-skill` file). This location works in the Codex app, CLI and IDE extension.
- **Connection:** adds a server named `memm` (`https://memm.ai/api/mcp`) only if no connection to that address exists. If you already use Memm as a claude.ai connector, a ChatGPT app, or your own `claude mcp` / `codex mcp` entry, nothing is added.
- **Safety:** settings change only through each client's own commands; `~/.claude.json` and `~/.codex/config.toml` are backed up first to `~/.memm/skills/backup` (the last three copies are kept). Other settings, servers, skills and credentials are not touched. No keys are stored in the skill files.

### Install straight from GitHub (without the installer)

Claude Code:
```
claude plugin marketplace add activecx/memm-skills
claude plugin install memm@memm
claude mcp add --transport http --scope user memm https://memm.ai/api/mcp
```
Skip the last line if Memm is already connected (for example as a claude.ai connector). Then `/mcp` → `memm` → Authenticate.

Codex app or CLI:
```
codex plugin marketplace add activecx/memm-skills
codex plugin add memm@memm
codex mcp add memm --url https://memm.ai/api/mcp
codex mcp login memm
```
Skip the last two lines if Memm is already connected (for example as a ChatGPT app).

Codex IDE extension (it does not load plugins): copy each folder from `plugins/memm/skills/` into `~/.agents/skills/`, then add the connection as above.

Use one method per client, not both, or each skill appears twice. A local folder works too: replace `activecx/memm-skills` with the path to the unzipped `memm-skills` folder.

## Sign-in options

- **Sign in (recommended):** a browser page on memm.ai asks you to allow access. No key is copied by hand.
- **API key (teams, automation):** create one at memm.ai → Settings → Connections → Advanced: API keys. It is shown once. Keep it in an environment variable, never in chat or project files.

## Update

- **Installed with the installer:** run it again from the newer download (or after `git pull`). The previous package is kept in `~/.memm/skills/previous`.
- **Installed from GitHub:** Claude Code: `claude plugin marketplace update memm`, then `claude plugin update memm@memm`. Codex: `codex plugin marketplace upgrade`.

Then restart Claude Code or start a new Codex session. If Memm's tools look out of date (a field the skills mention is missing), reconnect Memm and start a new session.

## Uninstall

```powershell
powershell -ExecutionPolicy Bypass -File install\install.ps1 -Uninstall
```
or `bash install/install.sh --uninstall`. This removes the plugin, the marketplace, the Codex skill folders marked by Memm, and the `memm` connection **only if the installer added it**. Your `memm/` project folders, your Memm account and your designs are not touched.

## Recovery

- **Something broke after an update:** copy `~/.memm/skills/previous` over `~/.memm/skills/marketplace` and run the installer again, or reinstall the earlier package.
- **A setting was changed by mistake:** the backups of `~/.claude.json` and `~/.codex/config.toml` are in `~/.memm/skills/backup`.
- **"Needs authentication" / not signed in:** repeat the sign-in step.
- **The upgrade message appears:** your Memm plan does not include the connection; see https://memm.ai/pricing.
- **Skills do not appear:** start a new session; in Codex check `~/.agents/skills/memm-start/SKILL.md` exists; in Claude Code run `claude plugin list`.

## Project notes

The skills keep a small `memm/<project>/` folder in your working directory (brief, sources, decisions, budget, job list, reviews), so you never repeat yourself and every credit spent can be traced. You can delete it at any time; nothing in Memm depends on it.

## What these skills cannot do

Post or schedule on social media, run or buy ads, read ad performance, dub an existing video in one step, or listen to audio (pronunciation and lip-sync timing always get a human check). The skills say so instead of pretending, and they cannot guarantee results: every result is checked against your brief, and the assistant tells you what it could not check.

## What was tested

Version 2.0.0 was tested in Claude Code and Codex against a simulated Memm server in 13 situations, including price approval, a retry after a timeout, failed jobs, lip-sync permission and Arabic replies. The installers were tested in throwaway folders on Windows. No paid generations were made in testing.

More: [EXAMPLES.md](EXAMPLES.md) (example workflows), [CHANGELOG.md](CHANGELOG.md), [LICENSE](LICENSE). Questions: https://memm.ai/docs/en/skills

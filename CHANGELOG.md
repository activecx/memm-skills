# Changelog

## 2.1.0 (2026-10-21)

- New skill: **memm-capoeira** (Memm Capoeira). Put your product, character, outfit or face inside an existing video and keep its motion (Objects swap), or rebuild a clip's motion with your character (Motion transfer). It asks who to change in clips with more than one person, writes the instruction in English for the model, confirms the price once and checks the result. Uses the Motion Library (`memm_search_motion_library`) or your own clip.
- Memm Capoeira is for paid plans; takes are 5, 10 or 15 seconds at 720p or 1080p.

## 2.0.0 (2026-10-17)

- First public release: download from https://memm.ai/docs/en/skills or install from https://github.com/activecx/memm-skills (`claude plugin marketplace add activecx/memm-skills`, `codex plugin marketplace add activecx/memm-skills`).
- Same nine skills as 1.0.0-rc.1. Numbered 2.0.0 because it replaces the earlier two-skill pack (Product Images and Product Videos, 1.0.0).
- The package now has the marketplace at its root; the installers accept both layouts and copy only the marketplace into `~/.memm/skills`.

## 1.0.0-rc.1 (2026-10-16) — release candidate, not published

- Nine skills for Claude Code and Codex: memm-start (coordinator), memm-research, memm-business-plan, memm-workflow-plan, memm-creative-strategy, memm-tool-selection, memm-production (images, product photos, Arabic ads, video, voice, music, 3D), memm-lip-sync, memm-qa.
- Eight shared references built into each skill that uses them: project notes, evidence rules, Memm tools and money gate, credits and units, research tools, Arabic rules, reasoning chain, QA rubric.
- One package for both clients: Claude Code plugin and marketplace manifests, Codex plugin and marketplace manifests, Codex skill metadata.
- Installers for Windows PowerShell 5.1+ and macOS/Linux/WSL/Git Bash: install, update, check, uninstall; the Memm connection is added only when missing; backups before any settings change.
- Reviewed by Memm's finance, customer-experience and Arabic-language specialists.
- Supersedes the media-only "Product Images" and "Product Videos" skills (their guidance lives on in memm-production); those downloads were replaced on memm.ai by 2.0.0.

# Changelog

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

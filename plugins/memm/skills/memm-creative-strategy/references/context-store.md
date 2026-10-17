<!-- Copied from memm-skills/shared/context-store.md by scripts/build-memm-plugin.ts. Edit the source, then run: npm run plugin:build -->
# Shared project context: the `memm/` folder

Memm skills keep one small project folder in the user's working directory, so the user never repeats themselves and every fact, decision, cost and job can be traced later. Memm's server cannot store briefs or notes (projects, brands and designs hold files, not text), so this folder is the shared memory between skills and between sessions. Generated files themselves live in Memm (Canvas grid and projects).

## Where it lives

- `memm/<project-slug>/` inside the current working directory. Slug: lowercase Latin letters, digits and hyphens. Transliterate Arabic names (`مطارح الخليج` -> `matareh-al-khaleej`).
- **Before creating anything, look for an existing `memm/` folder** and read `memm/<slug>/brief.md`. Reuse what is there. If several projects could match, ask which one.
- If you cannot write files (read-only workspace, no file tools, or the user declines), keep the same sections in the conversation and tell the user once that nothing will be remembered after this session.
- Never write secrets, API keys, passwords, payment details, or private personal data about other people into these files.
- The first time you create `memm/`, tell the user in one line where their notes are kept and that they can delete the folder at any time.

## Files (create only what the current job needs)

| File | Holds | Main writer |
|---|---|---|
| `brief.md` | business and campaign facts with labels; Memm ids (brandId, productIds, projectId); language; formats | memm-start, memm-research, memm-creative-strategy |
| `evidence.md` | the source log (see evidence rules) | memm-research |
| `research.md` | business profile, audiences, competitors, opportunities, open questions | memm-research |
| `plan.md` | business plan, decision memo or experiment | memm-business-plan |
| `workflow.md` | the stage table | memm-workflow-plan |
| `creative.md` | strategy frame, claims register, concepts, test plan | memm-creative-strategy |
| `budget.md` | authorised budget, quotes, spend so far | memm-tool-selection, memm-production |
| `jobs.md` | the job ledger | memm-production, memm-lip-sync |
| `qa.md` | review results | memm-qa |
| `decisions.md` | dated decisions and who made them | any skill |

## Formats

`brief.md` starts with the block below; a large job adds its job card under `## Current job` (see memm-start), replaced when a new job opens:

```markdown
# <Business or campaign name>
Updated: YYYY-MM-DD · Language: <ar | en | bilingual> · Memm project: <projectId or "main canvas">
## Facts
- <fact> [verified: S3] / [user] / [assumption] / [recommendation]
## Memm library
- brandId: … · productIds: … (names)
## Campaign
- Objective · audience · offer · placements and shapes · deadline · budget
```

`jobs.md`: one row per intended generation. **Write the row before calling a paid tool** (state `sending`), then update it.

```markdown
| when (UTC) | asset | model · option · shape | credits quoted | idempotency_key | jobId | state | result / designId | QA |
|---|---|---|---|---|---|---|---|---|
```

`budget.md`:

```markdown
Authorised: <N> Memm credits on YYYY-MM-DD by <user> for <what it covers>
| when | item | credits | running total |
Remaining: <N> credits. Anything outside "covers" needs a new approval.
```

`decisions.md`: `| date | decision | reason | approved by |`

## Rules

- Every fact carries a label: `[verified: S#]` (a source in `evidence.md`), `[user]` (the user said it), `[assumption]`, `[recommendation]`.
- Update the files at each checkpoint, not only at the end, so an interrupted session can resume.
- Do not overwrite text the user edited. Change the specific section or append.
- Use absolute dates (YYYY-MM-DD) and UTC times in the ledger.
- When a session resumes, read `jobs.md` first: any row in `sending`, `queued` or `running` is checked with `memm_get_job` or `memm_list_jobs` before anything new is generated.

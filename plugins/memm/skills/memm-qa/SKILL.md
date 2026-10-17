---
name: memm-qa
description: Use when any Memm deliverable needs checking before it is called final — research, a plan, a workflow, ad concepts, an image, video, voice-over, music, 3D model or lip-sync clip — or when someone asks to review, check, audit or fix work, find mistakes, or confirm a result matches the brief, the product or the budget. Also Arabic requests such as «راجع العمل قبل التسليم», «افحص الصورة», «هل الكتابة العربية صحيحة؟», «هناك خطأ في الفيديو».
---

# Quality review and gap check

Review work in a separate pass from the one that made it, against the brief rather than against the job status. A job that finished is not a job that passed. The full rubric, severity scale and checklists are in [QA rubric](references/qa-rubric.md).

## Start

1. Identify what is being reviewed and its type (research, plan, workflow, creative, image, video, audio, lip-sync, 3D, a set of assets).
2. Read what it must satisfy: `brief.md`, the claims register in `creative.md`, `workflow.md` done-when conditions, `budget.md` and `jobs.md` ([context store](references/context-store.md)). If there is no brief, ask the user what the work was meant to achieve.
3. Switch to reviewer stance: read as if you did not make it. In Claude Code, an independent reviewer subagent may do this pass when one is available.

## Review

1. **Inspect the real output.** Download and view images; for video read the file with `ffprobe` and view extracted frames with `ffmpeg` when available; read audio length with `ffprobe`. Read dimensions and durations from the file, not from what was requested.
2. **Run the checklist for the type** from the rubric: evidence and labels, claims, brand and product fidelity, Arabic spelling and direction, visual and audio defects, lip-sync binding, specifications, money (one job per key, spend within budget, refunds recorded).
3. **Record each finding** with severity, where it is (file and section, timestamp, frame, URL), the evidence, and the correction you propose.
4. **List what you could not check** and why (for example "could not listen to the audio: pronunciation needs a human check").

**A defect the user reports that you cannot see yourself** (for example you cannot open the image here): record it as a `[user]` finding, say you could not inspect it, and fix it within the approved budget; do not block the fix on your own inspection. Check the new result afterwards and list what remains for the user to confirm.

## Verdict

Always state the verdict word first, including when the user found the problem (in Arabic use the fixed words):


- **PASS**: no blocker or major finding.
- **NEEDS REVISION**: fixable major or blocker findings.
- **BLOCKED**: the fix is outside the authorised scope or budget, or the next step is a decision only the user can make. A check you cannot perform (for example opening the image) is listed as not checked; it does not make the work BLOCKED.

Write it to `qa.md` in the rubric's format and tell the user in plain language: the verdict, the two or three findings that matter most, what you propose, and what it would cost. For a small job, give the verdict in one line inside the result message, including what you could not check («جاهز: الملصق والألوان كما في صورة منتجك، ولا كتابة في الصورة.» or, when something could not be checked, «جاهز: الوجه ثابت ومدة المقطع مطابقة للتسجيل، ولم أستمع إلى الصوت؛ شاهده بالصوت لتتأكد من التزامن والنطق.»); the table stays in `qa.md`. In Arabic use the fixed verdict words «جاهز» / «يحتاج تعديلًا» / «بانتظار قرارك».

## Correct, then re-check

- Fix within the authorised scope and budget only, through the skill that owns the work. A new take is quoted first and uses a new idempotency key.
- Re-check only the outputs affected by the fix, and record the second review.
- After two correction rounds on the same issue, stop and give the user the trade-off (for example "the label keeps changing on this model; options: a text-free shot with the real product photo composited in Canva, or a different model at 3.5 credits").
- Escalate unresolved trade-offs; never hide them in a PASS.

## Never

- Approve because the tool said `done`.
- Call lip-sync, pronunciation or music "perfect" without someone listening.
- Mark a product image as passing when the label, logo or pack differs from the reference.
- Pass a claim that is not in the claims register.

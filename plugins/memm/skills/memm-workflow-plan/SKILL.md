---
name: memm-workflow-plan
description: Use when an approved goal, plan or campaign must become a practical sequence of work — stages, owners, dependencies, time and cost estimates, checks, recovery steps — or when someone asks how long something will take, what it will cost overall, or who does what. Also Arabic requests such as «خطة التنفيذ», «ما خطوات التنفيذ؟», «كم من الوقت يستغرق؟», «كم التكلفة الإجمالية؟».
---

# Workflow planning

Turn an approved objective into work that can actually be done: who does what, in which order, with what checks and what happens when a step fails. Keep it light for small jobs and detailed for campaigns.

## Start

1. Read `brief.md`, `plan.md`, `creative.md` and `budget.md` if they exist ([context store](references/context-store.md)).
2. List the deliverables (for example "3 feed images 4:5, 1 story video 9:16 Arabic voice-over"), the deadline, who is available (the user, a designer, a reviewer), and the budget envelope.
3. Choose the size:
   - **Light** (one to three stages): a single asset or a quick test. A few lines are enough.
   - **Full**: a campaign, several assets, several people, or a deadline with dependencies.

## The stage table

```markdown
| # | stage | input → output | owner (person or tool) | depends on | time (range) | cost (range) | quality check | done when | if it fails |
```

- **Time** as a range ("20 to 40 min, mostly waiting for video").
- **Cost** in Memm credits from live free quotes (`memm_quote_generation_cost`), including the expected extra attempts ([credits and units](references/credits-and-units.md)). External tools in their own units. Label estimates.
- **Quality check**: which memm-qa checklist applies, and who approves.
- **Done when**: a concrete, checkable condition ("client approved the baseline image").
- **If it fails**: the recovery path. Standard ones:
  - generation failed: check refund, change one thing, quote, ask, new key;
  - QA rejected: correct within budget, re-check only that asset, escalate after two rounds;
  - a tool is unavailable: an alternative tool or a manual step, never a silent skip;
  - waiting for the user: pause, record the open question, nothing is spent meanwhile.

## Make it efficient

- **Reuse first:** approved designs (`memm_list_designs`), product photos already in the library (`memm_list_products`), earlier copy. Note what is reused.
- **Bottlenecks:** mark the stage everything waits on (often approvals or the one video slot) and order work around it.
- **Remove duplicated effort and unnecessary tools:** one tool per job unless a second one adds something measurable.
- **Baseline before scale:** one baseline asset, approval, then variations.
- **Parallel where safe:** images and copy can progress while a video renders.

## Checkpoint

Show the table (or the light version) with the total time range and the total credit range. Ask for approval of the workflow and of the budget envelope in one message. Record the authorisation in `budget.md` exactly as approved: amount, what it covers, date.

## Finish

`workflow.md` saved, `budget.md` updated, and the next stage started or handed to its owner. Finish line: every stage has an owner, a done-when and a recovery path, and the user approved the plan and the envelope.

## Common mistakes

| Mistake | Instead |
|---|---|
| Single numbers for time and cost | Ranges with the reason for the spread |
| Prices from memory | Free live quotes |
| A stage with no failure path | Add the recovery step |
| Every asset generated at once on day one | Baseline first, then variations |
| Treating approval of the plan as approval to exceed the envelope | New approval for anything outside it |

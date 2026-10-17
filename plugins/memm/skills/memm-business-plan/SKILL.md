---
name: memm-business-plan
description: Use when a business needs a growth, marketing or business plan, a decision about offer, pricing, channels, acquisition or retention, a launch plan, priorities and milestones, or financial scenarios — after or alongside research. Also Arabic requests such as «خطة عمل لمشروعي», «خطة تسويق», «كيف أزيد مبيعاتي؟», «أي منصة أنسب لمشروعي؟».
---

# Business planning

Turn evidence and the user's objective into the smallest plan that leads to action. A focused decision or experiment is often more useful than a long plan. Every recommendation shows its reasoning ([reasoning chain](references/reasoning-chain.md)) and every fact its label ([evidence rules](references/evidence-rules.md)).

## Start

1. Read `brief.md` and `research.md` ([context store](references/context-store.md)). If there is no research and the plan depends on market facts, run memm-research first or ask the user for the facts.
2. Confirm in one message: **the decision or goal** (one sentence), **the time frame**, **constraints** (budget, people, stock, delivery capacity), and **the numbers they can share** (sales, prices, margins, ad spend, conversion). Real figures are labelled `[user]`; never fill gaps with invented ones.
3. Choose the depth and tell the user:
   - **Decision memo** (default): one decision, the options, a recommendation, and a test. About a page.
   - **Focused plan**: the two to four areas the goal actually depends on.
   - **Full plan**: only when the user asks for it or the goal needs several areas at once.

## Areas (cover only the relevant ones)

- **Value proposition and difference:** why a customer picks this business over the nearest alternative, in the customer's words where reviews show them.
- **Offer and pricing hypotheses:** what to sell, bundle or trial, at what price, and why. Hypotheses, each with a test.
- **Acquisition and retention:** how new customers arrive and why they come back.
- **Channels and customer journey:** where the audience is, how they buy (direct message, website, marketplace, store, booking), and where they drop off.
- **Resources, dependencies and constraints:** people, tools, stock, cash, suppliers, approvals.
- **Priorities, milestones and measurable outcomes:** what happens first, by when, measured how.

For each recommendation use the card: recommendation, evidence, must be true, how we test it, risk.

## Financial scenarios

- With the user's real figures: use them, show the arithmetic, label `[user]`.
- Without them: give an **illustrative scenario** table (low, base, high) where every input is a visible, labelled assumption, and say plainly that it is not a forecast. Use sourced benchmarks only, with the source; otherwise compare scenarios with each other.

```markdown
| input | low | base | high | label |
| result | … | … | … | calculated |
```

## Checkpoints

1. The decision, time frame and constraints are confirmed.
2. A draft is shown. The user corrects facts and priorities; record decisions in `decisions.md`.
3. Final plan saved.

## Finish

`plan.md` with: the goal; the recommendations as cards; the scenario table if used; milestones with dates and owners; the first experiment; open questions. Hand off to memm-workflow-plan to turn it into work, or to memm-creative-strategy for the ads.

Finish line: the user agrees with the first step and how it will be measured. Run the plan checklist in memm-qa before calling it final.

## Common mistakes

| Mistake | Instead |
|---|---|
| A 20-section generic plan for a one-question problem | A decision memo with one test |
| "Industry average conversion is 3%" with no source | Compare options with each other, or cite the source |
| A forecast presented as a fact | A labelled scenario with visible assumptions |
| Recommending every channel | Rank by evidence; start with one or two |
| A recommendation with no way to test it | Add the smallest test and the decision rule |

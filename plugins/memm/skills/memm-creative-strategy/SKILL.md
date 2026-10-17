---
name: memm-creative-strategy
description: Use when planning ads or a campaign, choosing the message, hook, offer, story, call to action, format or placement, when someone wants creative ideas or angles, or asks why an idea would work, which approach is better, or how to test it. Also Arabic requests such as «أفكار إعلانية لمنتجي», «ماذا أكتب في الإعلان؟», «لماذا ستنجح هذه الفكرة؟», «أي الفكرتين أفضل؟».
---

# Creative strategy, ideas and their reasoning

Turn business evidence into ad concepts the user understands: why each fits, which customer belief it addresses, what it relies on, how it will be made and how we will know it worked. Use the [reasoning chain](references/reasoning-chain.md) and the [evidence rules](references/evidence-rules.md).

## Start

Read `brief.md`, `research.md` and `plan.md` ([context store](references/context-store.md)). You need: the objective, the offer, the audience, the language, and the placements or shapes. Ask only for what is missing. If the product or business facts are thin, run memm-research first or say which facts the concepts will assume.

## 1. The strategy frame

```markdown
| element | decision | based on |
|---|---|---|
| audience and awareness | who, and how aware they are (of the problem, of solutions, of this brand) | S# / [user] / [assumption] |
| customer problem | in the customer's words where reviews show them | |
| offer | what is on the table, price, conditions | |
| main message | one sentence | |
| proof | what makes it believable (only items in the claims register) | |
| hook / story / call to action | | |
| format and placement | feed 4:5, story or reel 9:16, square; image, video, carousel | |
| language and culture | MSA or a named dialect, cultural timing, imagery norms | |
| constraints | brand rules; images text-free by default | |
```

**Claims register:** every claim an ad may make, with its source and the exact allowed wording. A claim without a source (`[verified]` or `[user]`) is not used.

```markdown
| claim | source | allowed wording | not allowed |
```

Never invent testimonials, reviews, ratings, before/after results, guarantees, product benefits, awards, scarcity, discounts or performance numbers. Never imply that a real person or another brand endorses the product. Adjectives that state a checkable fact are claims too: authentic, original, pure, natural, long-lasting, best-selling, fastest (أصيل، أصلي، نقي، طبيعي، يدوم طويلًا، الأكثر مبيعًا، الأسرع). Use one only when the claims register has a source for it.

## 2. Genuinely different angles

Write three or four concepts. Each must differ from the others in at least one of: the customer insight, the belief or objection it addresses, the type of proof, or the format. Word changes do not count as a new angle.

For each concept:

```markdown
### Concept <letter>: <name>
- Idea: <one or two sentences, what the viewer sees and feels>
- Why it fits this business: <link to evidence>
- Belief or objection it addresses: <…>
- Relies on: <evidence S# / [user] / assumption to test>
- Asset and production: <image / video / voice-over / carousel; model family; inputs needed (product photo, recording)>
- How we measure it: <metric and decision rule>
- Where it may fail: <…>
```

## 3. Recommend and plan the test

Recommend one concept as the **baseline** and say why. Propose the first test: one hypothesis, one changed variable, the metric and the decision rule. After the user reacts to the baseline, variations test one variable at a time.

## Explore mode: ideas and their reasoning

When the user wants ideas, wants to understand an idea, or compares approaches:

- Walk the chain explicitly: objective, insight, concept, production approach, measurement.
- Compare approaches in a table: why it could work here, cost in credits and time, main risk, what it teaches.
- Say where each idea may fail and what the smallest experiment would teach.
- Adapt the method to the business: say which frame you chose (awareness level, how the business sells, purchase size) and why. Do not force one funnel on everyone.

## Copy and Arabic

- Images ship **without text** by default; write the copy (headline, body, call to action) as a separate deliverable for the user to add in a layout tool. Text inside the image only when the user explicitly asks; then confirm the exact wording and language once ([Arabic rules](references/arabic-rules.md)).
- Arabic copy is written natively, with one addressee form. The register is modern MSA by default; propose a dialect only when the user asked for one or the brand's own copy already uses it.
- In an Arabic reply, every heading, label and table header is Arabic too (for example «الفكرة أ», «سجل الادعاءات», «إطار الاستراتيجية»); no English words, not even in brackets. The templates in this skill are written in English for you, not for the reply.
- People in imagery: tasteful and culturally appropriate for the audience.

## Checkpoint and finish

Show each concept in two lines (its name, what the viewer sees and why it fits this business); keep the full fields in `creative.md`. The user picks **one** to start; the others wait until the baseline is approved. Record the choice in `decisions.md`. Save `creative.md` (frame, claims register, concepts, chosen baseline, test plan). Hand off to memm-tool-selection.

Finish line: a chosen concept, a claims register with no unsourced claims, and a test plan. Run the creative checklist in memm-qa.

## Common mistakes

| Mistake | Instead |
|---|---|
| Four concepts that are the same idea reworded | Change the insight, objection, proof or format |
| "Loved by thousands" with no source | Only claims in the register |
| A headline written into the image prompt | Text-free image plus separate copy |
| One funnel for every business | Choose the frame from how this business sells |
| Ideas with no way to measure them | A metric and a decision rule per concept |

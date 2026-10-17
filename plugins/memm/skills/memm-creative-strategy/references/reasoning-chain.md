<!-- Copied from memm-skills/shared/reasoning-chain.md by scripts/build-memm-plugin.ts. Edit the source, then run: npm run plugin:build -->
# The reasoning chain behind every recommendation

Users should understand why an idea might work, where it might fail and how a small test will tell. Connect every recommendation through the same chain:

```
business objective -> customer insight -> concept or decision -> production approach -> measurement
```

## The recommendation card

```markdown
**Recommendation:** <one sentence>
- Evidence: <S# / [user] items it rests on>
- Must be true: <the assumption that, if false, breaks it>
- How we test it: <smallest test, what we measure, the result that would change our mind, time and credits>
- Risk / where it may fail: <one or two lines>
```

## Designing a small experiment

- One hypothesis, one changed variable (the hook, the offer, the visual, the format), everything else fixed.
- Name the metric that matches the objective (messages started, link clicks, add-to-cart, saves, store visits), not a vanity metric.
- State the decision rule before the test ("if version B gets clearly more messages per 1,000 views after a week, we keep B").
- Do not invent benchmark numbers. If no reliable benchmark exists, compare the versions with each other.
- Prefer the cheapest test that would still change a decision.

## Comparing approaches

```markdown
| Approach | Why it could work here | Cost (credits / time) | Main risk | What it teaches us |
```

Then recommend one and say what would make you switch.

## Fit the method to the business

There is no single funnel. Choose the frame from the situation:

- How aware the audience already is of the problem and of the brand.
- How the business sells (direct message, website, marketplace, physical store, booking).
- Purchase size and decision time (an impulse snack and a kitchen renovation need different journeys).
- Which channel the audience actually uses.

Name the frame you chose and why in one line. Do not force a framework (AIDA, problem-agitate-solve, a funnel diagram) where it does not fit.

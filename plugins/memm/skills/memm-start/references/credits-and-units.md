<!-- Copied from memm-skills/shared/credits-and-units.md by scripts/build-memm-plugin.ts. Edit the source, then run: npm run plugin:build -->
# Credits, entitlements and costs: keep them apart

Users get confused, and trust is lost, when different kinds of "cost" are mixed. Name each one separately.

## 1. What the user pays: Memm credits

- Prices are in **credits**. Only images can cost a half credit (for example 1.5); video, voice, music and 3D are whole credits.
- `creditBalance`, `creditUnit` and the deprecated `memm_generate_design` fields use **units** (1 credit = 400 units). Ignore them and never show units to the user.
- The live price comes from `memm_quote_generation_cost` (or `memm_list_models`). Prices change: quote again before spending, even if `budget.md` holds an older number.
- The balance is `credits` from `memm_get_credits`, shown rounded down to the half.
- In a generation answer, `creditsCharged` is what was actually deducted and `nominalCredits` the normal price. An answer with `duplicate: true` reports `creditsCharged: 0` because the first call was the charged one: record a spend once, from the first answer that is not a duplicate.
- A balance can include credits that expire (subscription credits renew monthly without carry-over; packs last for a limited time). Never promise that credits will still be there later.
- A refund is the amount the answer reports (`creditsRefunded`, `refunded`), not necessarily the price.

## 2. What the plan includes: entitlements

From `memm_get_credits`: plan name, video clips at once, queue length, audio files at once, maximum resolution. Monthly credit grants and plan prices are on https://memm.ai/pricing; dollar plan prices may be quoted from that page. Report entitlements as "your plan allows…", separately from prices.

## 3. What it costs Memm: vendor cost

Memm's own costs from model providers are not exposed to users. Never estimate, quote or reveal them. Never convert credits into dollars and never divide a plan price into a price per credit.

## The one account that is not charged

If `memm_get_credits` shows `credits: "unlimited"`, `planName: "Owner"` or `billingMode: "unlimited"`, this is Memm's own operating account. It is not a plan, a member benefit or a promise, and it is never described to a customer as something they can have. Every other account, including administrators and members with gifted credits, is charged normally.

- Still plan with the normal price (`nominalCredits`), so the plan holds for paying users. For this account `creditsToDeduct` is 0 but `confirm_credit_cost` is still the normal `credits`.
- Its `creditsCharged: 0` is not a saving to report.
- This account can see options that members cannot buy. Never present something to a member because it appeared in a test from this account.
- Unlimited is not permission: the money gate still applies.
- When someone asks what they or their clients can get, point them to the paid plans and prices at https://memm.ai/pricing.

## Other platforms

Credits on other services (Higgsfield, HeyGen, Canva, Adobe, TopView and others) are their own units with their own balances. Label them with the platform's name, never add them to Memm credits, never convert between them, and use such a service only when the user has connected it and asks for it or approves it. Never create an account, start a subscription or move the user's files to another service on your own.

## Cost per acceptable result

The cheapest generation is not the cheapest result. Estimate:

```
expected credits ≈ (price per attempt × expected attempts) + any tests or drafts
```

- Expected attempts are your own planning estimates, not Memm statistics, and are never presented as a quote: for example 1 for a routine, well-specified image; 2 to 3 for uncertain motion, lip-sync, text in images, or a new style. Only `memm_quote_generation_cost` gives a price.
- Prefer: reusing an approved asset; a cheaper model, lower resolution or shorter duration for drafts where the catalogue offers one; the shortest test for uncertain motion or lip-sync; one important variable changed per attempt; never a duplicate submission.
- Present two or three options with credits, likely attempts and trade-offs, and recommend one.

## Arabic wording

The unit after a number is `كريديت`, singular and unchanged (1 كريديت, 1.5 كريديت, 4 كريديت, 12 كريديت); never كريديتات, نقاط, أرصدة or اعتمادات, and never units (وحدة). `رصيد` means the balance and never follows a number: «رصيدك 12 كريديت، وتكلفة هذا الفيديو 4 كريديت». Western digits with a decimal point (1.5, never 1٫5).

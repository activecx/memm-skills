---
name: memm-tool-selection
description: Use when choosing which model, option or tool to use for an image, video, voice-over, music, sound effect, 3D model or lip-sync, when someone asks what something will cost, how to spend fewer credits, which model is best for Arabic or for product accuracy, or whether another platform should be used. Also Arabic requests such as «كم كريديت يحتاج هذا الفيديو؟», «أي نموذج أفضل للنص العربي؟», «كيف أوفر في الكريديت؟», «أريد خيارًا أرخص».
---

# Tool selection and cost control

Choose tools by what the job actually needs, price them with live quotes, and optimise the cost of an **acceptable** result, not the cheapest single generation. Follow [credits and units](references/credits-and-units.md) and the [money gate](references/memm-tools-and-jobs.md).

## 1. Requirements card (per asset)

```markdown
| asset | output (image / video / voice / music / SFX / 3D / lip-sync) | inputs we have (product photo, recording, video) | must stay exact (product, label, face) | language (Arabic text in image? Arabic speech? dialect?) | control needed (edit, start/end frame, motion copy) | shape, resolution, duration | deadline |
```

## 2. Live discovery (free)

Call `memm_list_models`. Keep only candidates that meet the hard requirements: the right kind, a mode that accepts the inputs (`modes`, image counts), the shape, the duration, `promptMaxCharacters`, a voice in the right language or dialect, and `drivenBy` rules for lip-sync, motion control and video edit. The catalogue's `bestFor` notes and its Arabic-lettering recommendation are Memm's guidance; use them, and call them guidance, not test results.

If no available model meets a hard requirement, say so plainly and offer the nearest workable alternative (for example a text-free image plus copy added in Canva instead of guaranteed Arabic lettering). Do not stretch a model beyond what its options say.

## 3. Quote (free)

Call `memm_quote_generation_cost` for each candidate option with the real mode, shape and image count. Lip-sync, motion control and video edit are priced from the uploaded file, so they need the file first (see memm-lip-sync).

## 4. Compare cost per acceptable result

The requirements card and this table are your working notes. Show the user one recommendation with its price and at most one alternative.

```markdown
| option | credits per attempt | likely attempts | expected credits | fit for this brief | risks | notes |
```

- Likely attempts are estimates: label them. Higher for new styles, Arabic lettering, complex motion and lip-sync.
- Mark untested choices **provisional** ("not yet tested on this product"). Never call a model "the best" without evidence from this brief or Memm's catalogue note.
- Recommend one option and say what would make you switch.

## 5. Make it cheaper without making it worse

- Reuse an approved image, an existing product photo or an earlier voice-over when it fits.
- Draft cheap, finish expensive: a lower resolution, shorter duration or cheaper model for exploration; the final quality only for the approved direction.
- Test uncertain things short: a 3 to 5 second motion or lip-sync test before a 15 second final.
- Change one important variable per attempt so each attempt teaches something.
- Never submit the same request twice; recover with the same idempotency key.

## 6. Budget authorisation

- **Small jobs need no envelope:** show the plan and price of one take and ask for a yes per take.
- **Larger jobs:** present the plan in one message (what will be made, how many attempts, credits per item, the total and the realistic range) and ask for one approval of an envelope ("up to 24 credits: 1 baseline video and up to 2 corrected takes"). Record it in `budget.md`: amount, what it covers, date. Check the balance with `memm_get_credits` first; if it is too low, offer a smaller set.
- **An envelope covers only new takes of the same approved plan** (for example a take where the label came out changed). A new direction, a variation or more assets always needs a new yes.
- **Say each time you spend from it:** "The label came out changed, so I made a second take: 2 credits of the 6 you approved."

## Other platforms

Consider another connected service (Canva, Higgsfield, HeyGen, Adobe and others) only when Memm cannot do the step or the user asks for it, the service is connected in this session, and the user approves. State its cost in its own units. Never create an account, buy a subscription, or move the user's files to another service without explicit permission.

## Finish

A short tool plan in `budget.md` (or the conversation): chosen model and option per asset, the price per attempt, the envelope approved. Hand off to memm-production or memm-lip-sync.

## Common mistakes

| Mistake | Instead |
|---|---|
| Picking the cheapest option for a hard job | Compare expected credits including retries |
| "Model X is the best for Arabic" from memory | Read the live catalogue and call it guidance |
| Quoting prices from an old file | Quote again, free, before spending |
| Showing units, dollars or vendor costs | Credits only |
| Treating an unlimited test account as normal | Plan with normal prices; never present it as a plan feature |
| Asking for approval for every single attempt | One envelope, then spend within it |

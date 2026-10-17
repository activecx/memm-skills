---
name: memm-production
description: Use when it is time to actually make something with Memm — a product photo, ad image, video clip, voice-over, music track, sound effect or 3D model, a set of variations, or a campaign's assets — or to resume, retry or recover a Memm generation that failed, timed out or partly succeeded. Also Arabic requests such as «أنشئ الصورة», «اصنع فيديو للمنتج», «تعليق صوتي للإعلان», «أعد المحاولة».
---

# Creative production

Make the approved assets through Memm reliably: correct inputs, a quote and an authorisation before every spend, one job per idempotency key, every job recorded, partial successes kept, and nothing called final before memm-qa. The money and job rules are in [Memm tools and jobs](references/memm-tools-and-jobs.md); read it before the first paid call.

## Preflight (all must be true)

- **The product photo itself** for any product image or video: an upload, an image from `memm_list_products`, or a photo from the product page the user named that you showed them, they confirmed is their product, and you uploaded to Memm. A link or website without a usable photo is for research only; never generate a product from a description.
- **Brief:** what it is for (only when it changes the picture), the copy language (or no text), the shape. Missing items are asked for, not invented; sensible defaults (mood, scene, background) are chosen and shown in the plan.
- **Direction:** an approved concept (memm-creative-strategy) or a clear user request for a single asset.
- **Model and option:** chosen with memm-tool-selection, or the user's explicit choice (honour it; never swap models silently).
- **Budget:** an authorisation in `budget.md` covering this asset, or a quote the user approves now.
- **Inputs uploaded:** product photos and other files through `memm_get_upload_ticket`; existing library images from `memm_list_products`. Keep the product reference as the identity reference.
- **Destination:** a `project_id` from `memm_list_projects`, or the main canvas. Projects are created by the user at memm.ai/canvas.

## The production loop (per asset)

1. **Prompt:** write it with the module for this kind of asset (below). Respect `promptMaxCharacters`. Keep the full brief out of the prompt; send only directions that affect this asset.
2. **Quote** the exact settings and check them against the budget.
   **Plan and price in one message.** Before any paid call, show what you will make in two or three plain lines (product, scene and mood, shape, text-free and the copy language), then the price in credits, then "Shall I make it?" («هل أبدأ؟»). One yes covers the plan and the price. If the user's request already gives the plan and an approval that covers the quoted price (for example "I approve up to 6 credits for these three"), do not ask again: quote, confirm it is inside the approval, generate, and say what you spent. Ask about the destination project only when the user named a client or project or several projects could fit; otherwise use the main canvas and say so. Inside an approved envelope, say each time what you spend ("the label came out changed, so I made a second take: 2 credits of the 6 you approved").
   **Every change request is a new brief:** "brighter", "another angle", "something different": restate the change in one line, keep the product and the brand's look unless the user asked to change them, quote, and ask again. If the user asks for "something different" without saying what, offer two or three concrete directions (one line each, one recommended) before spending.
3. **Ledger first:** add the `jobs.md` row with its idempotency key (`<slug>-<asset>-t<take>`) and state `sending` ([context store](references/context-store.md)).
4. **Generate** with `confirm_credit_cost`, `idempotency_key` and `project_id`.
5. **Update the ledger:** `jobId`, state, credits charged, result URL, `designId`.
6. **Wait** for video, voice, music and 3D by polling at the documented pace; tell the user what is happening during long waits.
7. **Review** the result with memm-qa before presenting it as final.

**Baseline first:** the first asset of a new direction is a single baseline. Show it and wait for the user's reaction before variations. Silence is not approval.

**Variations and sets:** after the baseline is approved, vary one thing at a time. Up to 10 video, voice or music jobs can go in one `memm_generate_batch` (quote the batch with `jobs`, pass the total, give the batch its own key). Images are generated one call each.

## When something goes wrong

- **Timeout or unclear answer:** re-send the **same** call with the **same** key, settings and `confirm_credit_cost`; the server returns the existing job without charging, or runs it once. Never a new key to "try again". If the answer says `duplicate: true`, it is the original job.
- **`CHARGE_UNCONFIRMED` or `ALREADY_STARTED`:** a charge may already have been taken. Follow the table in the job rules: do not resend at once.
- **Failed job:** report the reason and whether the credits were refunded. No automatic retry. Diagnose, change one variable, quote, get authorisation if it is outside the budget, then a **new** take key. End the report with one concrete next step, its price, and the question ("Shall I try once more with a 6-second version at 6 credits?"); never stop at the bad news.
- **Safety refusal:** give the reason and the reference; do not work around the check.
- **Partial success:** keep and deliver what succeeded; list each failure with its refund state; retry only those, each with a new key, within the budget.
- **QA rejection** (yours or the user's): start with the review result in the memm-qa form: the verdict NEEDS REVISION and each finding with its severity (a changed label, logo, pack or product colour is a blocker). Then fix through a new take within the budget, with the original product photo as the identity reference (never the rejected take), and re-check only that asset; after two rounds on the same issue, give the user the trade-off.

## Modules

| Asset | Module |
|---|---|
| Product photography, packshots, lifestyle scenes, ad visuals | [images](references/module-images.md) |
| Arabic or bilingual advertising (copy, text-free layouts, lettering) | [Arabic ads](references/module-arabic-ads.md) |
| Video clips: text, start frame, start and end frames, references | [video](references/module-video.md) |
| Voice-over, music, sound effects | [voice and music](references/module-voice-music.md) |
| 3D models | [3D](references/module-3d.md) |
| A photo speaking or singing, motion copied from a video, editing the user's own video | use memm-lip-sync |

## Finish

Deliver: each asset's link and `designId`, the Memm project it is in, its QA verdict, the credits spent against the budget, and the work that remains outside Memm (for example "add the Arabic headline in Canva"). Update `jobs.md`, `budget.md` and `qa.md`.

Finish line: every planned asset is done-and-passed, accepted with a listed issue, or reported as failed with its refund state.

## Rules that never bend

- Keep the product's identity: shape, materials, colours, pack, label and logo exactly as in the reference. Never invent product details, claims or packaging text.
- Images ship text-free unless the user explicitly asked for words in the image.
- Never download a song or video from a link for lip-sync, motion control or video edit; those files come from the user.
- A request for a prompt, a storyboard or a plan is not a request to generate.

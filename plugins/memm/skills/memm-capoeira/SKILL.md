---
name: memm-capoeira
description: Use when the user wants their product, character, outfit or themselves inside an existing video while keeping its motion. That covers swapping an object, a person, an outfit or the background in a clip, copying a dance or a move onto their character or mascot, or picking a move from Memm's Motion Library. Runs Memm Capoeira (Objects swap or Motion transfer). Also Arabic requests such as «ضع منتجي مكان الكوب في الفيديو», «بدّلني مكان الشخص في المقطع», «اجعل شخصيتي ترقص مثل هذا الفيديو», «غيّر خلفية المقطع», «انقل الحركة إلى شخصيتي».
---

# Memm Capoeira

This skill puts the user's product, character, outfit or face into a reference clip and keeps the clip's motion. It asks the right questions, writes an instruction the model follows on the first try, confirms the price once, and then checks the result honestly. Every take is charged even if the user dislikes it, so a good first instruction is the main way to save their credits.

- How to write the instruction: [prompt guide](references/prompt-guide.md). Read sections 2 to 4 and 6 before your first take.
- Money and job rules: [Memm tools and jobs](references/memm-tools-and-jobs.md).
- Arabic: [Arabic rules](references/arabic-rules.md).

## 0. Before anything

- Memm Capoeira is not in `memm_list_models` (it is run by name, `capoeira`). Probe access with one free call to `memm_search_motion_library`. If it answers that Memm Capoeira is not available on this account, or a later call says the model is unknown, say so plainly, with no promise of when. Never swap in another model without saying so. For a close alternative, see memm-lip-sync (motion control, video edit), with its own price and yes.
- **Capoeira never goes in `memm_generate_batch`.** One take per `memm_generate` call.
- **Files come only from the user** (their own clip and photos) or from the Motion Library. Never download a video from a link or a website.
- **A screenshot or photo the user drops in the chat is for your eyes only.** Use it to understand the clip, the people and their positions. Never upload it as one of the take's images unless the user says it is a reference photo for the take.
- In Arabic, talk in semi-formal Modern Standard Arabic ([Arabic rules](references/arabic-rules.md)). Everything you send to the model (`prompt`, `who`, a `target` written as a phrase) is **always English**; the user never has to read or write English.
  - Say why once, and only when it comes up (they write their own Arabic instruction, or ask to see it): «أكتب تعليمات النموذج بالإنجليزية لأنها أوضح له، وأعرض عليك معناها بالعربية قبل أن أبدأ.»
  - If they ask to see the instruction, give its meaning in one Arabic line, then the English instruction alone in a separate block.

## 1. Choose the mode

| The user wants | Mode |
|---|---|
| One thing in the real footage changed (product, person, outfit, background); the rest stays | **Objects swap** (`mode: "swap"`) |
| Their character or mascot to do the clip's moves, in the clip's scene or a new one | **Motion transfer** (`mode: "transfer"`) |
| A different camera move, or a longer clip | Neither. Say so. |

If it could be either, ask one question: "Keep the real footage and change one thing, or rebuild the moves with your character?"

## 2. The clip

**From the Motion Library:**
- Call `memm_search_motion_library` (`query`, `orientation`, `max_seconds`, `people`), filling the filters from the request without asking ("for a reel" → `orientation: tall`; fewer people is easier).
- Write the numbered list as text (title in the user's language, seconds, tall or wide, how many people), so the user can choose even if their app doesn't show the poster sheet. Show the sheet when you can.
- Once the user picks a number, call it with `{ slug }` to get the large first frame and the cast list.

**The user's own clip:**
- Measure it first with `ffprobe` if you can (length, size, fps), then upload it with `memm_get_upload_ticket` (video).
- It must be MP4 or MOV, 4 to 30 seconds, 24 to 60 fps, and up to 200 MB. Ask for the ticket with `for_model: "capoeira"` (a plain video ticket stops at 100 MB).
- If you cannot run the upload command, say so and send the user to the Memm Capoeira page at https://memm.ai/motion, or offer a Motion Library clip. Never ask for a link instead.

Before you spend anything:
- **Too long, or just over a price step** (5, 10, 15, 20 or 30 s): show the saving ("trimmed to 9.9 s it costs the 10 s price instead of the 15 s price").
  - If you could not measure it, read `seconds` and the step from the quote, and offer the trim in the price message, before the yes.
  - Over 30 s it must be cut: ask for the start and end (the minute and second in their phone's player). Cut exactly that part, and only after they say; never choose it yourself.
  - Library clips can't be cut: to pay less, suggest a shorter move.
- **Flag these problems:** several people with no clear target, a tiny or often-hidden target, fast spins or flips, many cuts, captions or watermarks on screen, very dark light. Each is a common reason for a failed take (guide 2.3).
- **Sound:** the result keeps the clip's own sound, and a silent clip gives a silent result.

**Shape:** the default is a reel (`shape: "reel"`, 9:16).
- **Don't ask** when the clip is already tall or the user named where it goes: reel, story or TikTok → reel; YouTube or "keep it wide" → `same`.
- **A wide clip:** say it in the read-back, with the alternative: "It comes out as a vertical reel; I'll keep the right side, where the man and the pot are. Say 'keep it wide' to keep your clip's shape." («سيخرج المقطع بصيغة ريلز عمودية، وسأُبقي الجزء الأيمن حيث الرجل والإبريق. إن أردته بشكله العريض فأخبرني.»)
- **`crop` (Objects swap only):** set it from a frame: `left`, `center` or `right`, or `top`, `center` or `bottom` when a tall clip becomes wide. Ask it as its own question only in two cases:
  - one vertical strip can't hold the target and everyone the user wants kept: "A vertical reel can't hold both. Keep it wide, or keep only the left side?"
  - you can't see a frame: "Where is the cup in the frame: left, middle or right?"
- **Motion transfer has no crop:** the model rebuilds the shot in 9:16.
- **`lowRes: true` in the quote:** say so ("this clip is low resolution; the reel may look soft") and suggest 720p or `shape: "same"`.

## 3. What changes, and which person

These are two separate things: **what changes** (`target`, Objects swap only) and **which person** (`who`, only when the clip has 2 or more people).

**`target` is required in every Objects swap.**
- Send `product`, `person`, `outfit` or `background`, or a short English phrase for anything else ("the white sneakers on both feet", 120 characters at most).
- Take it from the request ("my perfume instead of the cup" → `product`).
- Ask "What in the clip should change?" («ما الذي أغيّره في المقطع؟») only when the request doesn't say.
- Never write the instruction without a target.

**`who` names a person only:** the one replaced, the one who wears the outfit, or the one who holds the product. Never an object, and never for a background swap.

**When to ask who:**
- A library clip with `people` 2 or more (the search shows it): ask (the server refuses with `WHO_REQUIRED` otherwise).
- 1 person: don't ask; name them in the read-back.
- 0 people: no `who`. If `objects` lists more than one, ask which, and send its English description as `target`.
- An entry marked "hand only" is a hand. Offer it for a product or nail swap, never as the one who becomes a character.

**How to ask:**
- **Library clip with 2 or more people:** right after the pick, in its own message, show the large first frame and number the server's cast in the user's language (`descAr`/`positionAr` in Arabic). For example: "1. the bearded animated man in a straw hat and bib overalls (left) · 2. the round red animated character in a pinstripe suit (right)".
  - Motion transfer: "Which one becomes your character?" («مَن في المقطع يصبح شخصيتك؟»)
  - Objects swap: "Which one should change?" («أيّهم أغيّر؟»)
  - A number is a full answer. Pass the chosen cast `id` as `who`. Memm then writes the target sentence and a keep line for every other person from the cast, so your instruction uses the cast's own words for them, never a description of your own.
- **The user's upload:** Memm can't see inside an uploaded clip, so you say who.
  - If you can see a frame (with `ffmpeg`, or a screenshot they dropped), describe the person by position and 2 or 3 visible features, and ask them to confirm or correct it.
  - If you can't, ask once: "Is there more than one person in the clip? If so, which one changes? For example: the man on the left in the white shirt." («هل في المقطع أكثر من شخص؟ إن كان كذلك فأيّهم أغيّر؟ مثلًا: الرجل ذو القميص الأبيض على اليسار.»)
  - Send `who` **in English**, by position and look, 160 characters at most, even when the user answered in Arabic. One person only: no `who`.
- **Never phrase this like a permission question.** Don't ask who the people are, whether they agreed, or whether a face is real or the user's own. Memm doesn't ask, and the answer is never yours to guess.
- If the server answers `WHO_REQUIRED`, ask the same question with the cast it lists.

## 4. The images

- Get them from `memm_list_products` or through `memm_get_upload_ticket` (photos). They go in `image_urls` **in order**: the first one is `@Image1`. Put the most important image first.
- Look at every photo before you use it. You want:
  - one subject per photo
  - a sharp image, at least 400 px on the short side
  - a readable label on a product
- Usually 1 to 4 photos is enough: a product's front, three-quarter view and back, or a person's face close-up plus a full-body photo. Collages and character sheets cause duplicates. From about 6 photos, results can get less stable.
- Never generate a product from a description. If there is no product photo, ask for one (guide section 3).

## 5. What else changes, what must stay

Don't ask these as open questions. State them as defaults in the read-back (section 7) and let the user correct them.

1. **What stays:** everything not being changed: the other people, faces, hands, moves, camera, timing and background (in Motion transfer, the clip's own setting). Memm already tells the model to keep everything the instruction doesn't change. Your keep list protects what drifts most: faces, hands and the label.
2. **Other changes:** none by default. Offer the most useful one as an alternative in one line ("I can also put it in your shop if you send a photo of it.").
   - Ask a separate question only when the request hints at a change ("make it at night") without enough detail.
   - More than one extra change makes a take less reliable, so suggest a second take for the rest.

## 6. Write the instruction

Use the 5-part template in guide section 4: **Target → Replacement → Other changes → Keep → Quality notes**. Write 4 to 7 short English sentences. Memm adds its own opening sentence in front, so start with the target.
- Use only `@Video1` and `@Image1` up to the number of images. Give every image a job.
- **Objects swap:** use editing verbs ("replace", "change"). Never write "reference @Video1" or "recreate".
- **Motion transfer:** "The character in @Image1 performs the [target]'s moves with the same steps and timing as in @Video1."
- Memm already ends its own sentence with "No new subtitles or added text.", so don't add it. Never ask for text, music or voices.
- For a product, write "the label exactly as in @ImageN, never redrawn" and "same size and position as the original".
- Never invent product facts. Translate the user's words faithfully.
- Up to 4,000 characters, but 400 to 1,200 is usually right.

**Example: Motion transfer with 2 people, library clip `ml-13-dark-dancer`, `who: "left-bearded-farmer"`.** This follows the structure of the first billed take, which Zaid approved, written in the clip's cast words. Memm's own sentence already names the target and keeps the other character.
> Replace only the bearded animated man in the straw hat, cream shirt and brown bib overalls (on the left of @Video1) with the character in @Image1, keeping @Image1's face, hairstyle, outfit and colours exactly. Keep the round red animated character with the moustache, pinstripe suit, red tie and black hat (on the right) exactly as he is. Keep the moves, camera, timing, lighting and background exactly as in @Video1.

## 7. Read back, quote, wait for a clear yes

1. **Read it back in one line** in the user's language. For example: "I'll put your character from photo 1 in place of the bearded man on the left. The red character, the camera and the background stay as they are." In Arabic: «سأضع شخصيتك من الصورة 1 مكان الرجل الملتحي على اليسار، وتبقى الشخصية الحمراء وحركة الكاميرا والخلفية كما هي.» Show the full English instruction if they ask.
2. **Quote** with `memm_quote_generation_cost`, sending:
   - `model: "capoeira"`, `mode`, `reference_slug` or `video_url`, `image_urls`
   - `target` (Objects swap; required)
   - `who` (only when section 3 says so)
   - `shape`, `crop`, `resolution` and `prompt`

   The quote checks the same things as the charge, so `WHO_REQUIRED`, `TARGET_REQUIRED` or a tag problem shows up here, before any price.
3. **Read-back and price in ONE message, one yes for one price.**
   - The message holds the read-back line, the defaults from section 5 and the shape line from section 2.
   - Add the price with its length step and quality, and name the take you will make. For a new clip or a new instruction: "10 s at 720p: 82 credits. I'll start with this 720p test; the 1080p take is 161 credits, a new render with its own yes." In Arabic: «10 ثوانٍ بدقة 720: 82 كريديت. أبدأ بهذه التجربة بدقة 720، ونسخة الدقة 1080 بـ161 كريديت تُصنع من جديد وتحتاج موافقتك.» (write the quality as the number alone, without "p", so the sentence stays Arabic).
   - End with "Shall I make it?" («هل أبدأ؟»). The yes covers only the take you named, and praise is not a yes.
   - Several takes may be confirmed in one message only with each price and the total.

## 8. Generate and wait

- **Generate:** write the `jobs.md` row first. Then call `memm_generate` with exactly the quoted fields plus `confirm_credit_cost`, an `idempotency_key` and `project_id`.
- **Keys:** every take gets a new key (`<slug>-capoeira-t1`, then `-t2`, including the 1080p take). An old key hands back the old take and charges nothing.
- **Project:** don't ask. If the user names a client or project, call `memm_list_projects` and pass its `projectId` as `project_id` (ask once, with the names only, if several fit). Otherwise use the main Canvas. Keep the same project for every take of this job, and after the take say where it is saved.
- Capoeira never queues. A busy answer (another clip is rendering) charges nothing. Poll that clip, then send again.
- Poll `memm_get_job` about every 20 seconds. A take usually takes 3 to 6 minutes (a 10 s take at 720p took 4 and 6 minutes on the first billed runs). Tell the user while they wait.

## 9. Check the result honestly

1. Check `boundInputs`: the same clip, the same length and the same images in the same order.
2. If `ffmpeg` is available, look at frames from the start, the quarter, the middle, the three-quarter point and the end. Check that:
   - the target is replaced in every frame
   - the people you kept are unchanged
   - the label is readable and the product is the right size
   - hands look natural
   - there is no added text and no duplicate person
3. You can't hear the clip. The sound is the reference clip's own sound, so ask the user to watch it with sound.
4. **A failed or weak take:** find the cause in guide section 6. Change one thing, then quote again with a new key (`-t2`) and ask again. Never run the same instruction again hoping for a different result.
5. **720p passed:** offer "Make it in 1080p" as the next step. Quote again at 1080p with the same inputs, the same project and a new key. Pass on any `lowRes` warning (a wide clip cropped to a reel often looks soft at 1080p). Say it is a new render, so small details can differ, and ask for a fresh yes.

## Answers to expect

Every answer below except `GENERATION_FAILED` comes before any charge: say "Nothing was charged." («لم يُخصم شيء من رصيدك.»)

| Answer | Do |
|---|---|
| `WHO_REQUIRED` | Ask section 3's question with the cast it lists. Never a question about who the people are. |
| `TARGET_REQUIRED` | Say what in the clip changes (`product`, `person`, `outfit`, `background` or a short English phrase) and quote again. |
| `WHO_INVALID` | Shorten `who` to 160 characters, in English, by position and look. |
| `PROMPT_TAG_UNKNOWN` | A tag points at an image that doesn't exist. Fix the tag and quote again. |
| `REFERENCE_TOO_SHORT` / `REFERENCE_TOO_LONG` / `REFERENCE_INVALID` | Explain the limit (4 to 30 s, MP4 or MOV, 24 to 60 fps). Ask for a different clip or which part to keep. |
| `LENGTH_NOT_AVAILABLE` | This length isn't on sale yet. Suggest a shorter cut. |
| `BALANCE_TOO_LOW_FOR_JOB` | Say "This length can't start right now." A shorter cut (a lower step) may start now; otherwise try again later. Don't explain why, and don't call it a pause. |
| `VENDOR_PAUSED`, "paused on Memm's side" | Tell the user. Don't retry. |
| `IMAGE_OR_PROMPT_NOT_ALLOWED` | Give the reason. Don't try to get around it. Famous faces and well-known characters are a common cause. |
| `PRICE_CHANGED` | Quote again. Ask again if the price is higher. |
| Not enough credits | Show the price and the balance. Offer 720p or a shorter cut. |
| `GENERATION_FAILED` | Report whether the credits came back. Diagnose before any new take. |

## Common mistakes

| Mistake | Instead |
|---|---|
| "Replace the man with me" on a clip with two men | Name him by position and look, and keep the other one |
| Choosing which seconds of the clip to keep | Ask the user |
| Asking for a slogan, captions or a price on screen | Instruction with no text; the user adds copy later |
| Writing the instruction in Arabic | Talk in Arabic, but send the instruction in English |
| Uploading the user's screenshot as @Image1 | Screenshots are for your eyes only |
| Putting Capoeira in a batch | One `memm_generate` per take |
| Re-running a failed instruction unchanged | Fix one cause, quote again, ask again |
| Quoting "82 credits" alone | "10 s at 720p: 82 credits" |

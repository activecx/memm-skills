# Example workflows

Each example shows which skills run, where the assistant stops for the user, what gets saved, and where credits are involved. Prices are examples from the catalogue on 2026-10-16; the assistant always quotes live.

## 1. "Understand this business" (research only)

> "Here is my client's website, bayt-alzaatar.example. Who are their customers and how do they compare with competitors?"

- **memm-research:** states the scope in two lines and starts. Reads the site, public reviews and three nearest competitors, logging each page with its date in `evidence.md`.
- **Checkpoint:** a five-line summary and up to three questions ("Is delivery available outside Irbid? It decides whether we advertise nationally.").
- **Finish:** `research.md` with profile, customer segments, competitor table, opportunities (each with its evidence, what must be true and how to test it), open questions and uncertainty. Sources that disagree are shown side by side.
- **Credits:** none.

## 2. "Build a growth plan"

> "We sell specialty coffee beans online in Amman. Help me grow sales over the next three months."

- **memm-research → memm-business-plan → memm-workflow-plan**, with a three-line job card.
- **memm-business-plan** asks for the decision, time frame, constraints and real numbers, then writes a decision memo or a focused plan. Every recommendation shows evidence, what must be true, and the smallest test. Without real figures, a labelled scenario table ("not a forecast").
- **memm-workflow-plan** turns the first experiment into stages (input, output, owner, time range, credit range from free quotes, check, done-when, recovery) and asks for one approval of the plan and its budget envelope.
- **Credits:** none until production starts.

## 3. "Create ads for this product" (Arabic campaign)

> «أريد أفكار إعلانات لعطر «ورد الصباح» من متجري في الرياض… منشور مربع وستوري.»

- **memm-creative-strategy** (in Arabic): strategy frame, claims register (only the facts the user confirmed), three or four genuinely different concepts shown in two lines each; the user picks one.
- **memm-tool-selection:** live models and free quotes; one recommendation with its price; text-free images with the Arabic copy delivered separately.
- **memm-production:** one message with the plan and the price («السعر: 1.5 كريديت… هل أبدأ؟»). After the yes: one baseline image with an idempotency key, recorded in `jobs.md`.
- **memm-qa:** checks the product, label, colours and that the image has no text; verdict in one line («جاهز: …»).
- **Then** variations, one change at a time, each with its own price and yes (or within an approved envelope, announced each time).

## 4. "One product photo, cheapest way"

> "I only have 6 credits. One square photo of my mug for Instagram; the mug is in my library."

- **memm-tool-selection (light) → memm-production → memm-qa**, no job card.
- One message: the plan (mug from the library as the reference, scene, square, no text) and the price (for example 1.5 credits), then "Shall I make it?".
- After the yes: one image, checked against the product photo.

## 5. "Lip-sync this photo to my recording"

> "Make this photo of me say my 12-second voice note."

- **memm-lip-sync:** checks the photo (one adult, front-facing) and the recording (3 to 15 seconds). Uploads both files with the upload ticket.
- One message: the price (and a 720p test price), the question "Who is in the photo?" with its three numbered answers, and the permission line, copied from the quote.
- After the answer: generate, then compare `boundInputs` with what was sent, check the duration and sampled frames, and list what the user must check by watching with sound (sync, pronunciation).
- Invalid inputs (two people, a child, a 42-second song) stop the job before any charge, with a clear request for what is needed.

## 6. Recovery: a failed clip and a partial batch

- A video fails after it was charged: the assistant reports the failure and the refund, does not retry by itself, proposes one change and its price.
- A request times out: the assistant re-sends the same call with the same idempotency key; Memm returns the original job and charges nothing again.
- A batch of three voice-overs comes back with two done and one failed: the two are delivered, the failed one is reported with its refund, and only that one is offered again, with its price.

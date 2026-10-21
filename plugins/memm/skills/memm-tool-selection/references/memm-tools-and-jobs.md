<!-- Copied from memm-skills/shared/memm-tools-and-jobs.md by scripts/build-memm-plugin.ts. Edit the source, then run: npm run plugin:build -->
# Memm tools, money gate and job handling

Memm's tools come from the user's Memm connection (`https://memm.ai/api/mcp`). Clients add a prefix (for example `mcp__memm__memm_generate`, `mcp__plugin_memm_memm__memm_generate`, `mcp__claude_ai_memm__memm_generate`); match on the part after the last `__`. The live tool descriptions and schemas win over anything written here. If a field described here is missing, the connection is out of date: tell the user to reconnect and start a new session.

Offer only what `memm_list_models` returns for this account right now. Never describe a model, resolution, voice or option from memory, from an earlier session or from another account.

## Tool map

| Tool | Costs | Use |
|---|---|---|
| `memm_get_credits` | free | plan, balance in credits, video clips at once, queue room, audio slots |
| `memm_list_models` | free | every model, option, shape, mode, limit, price, `drivenBy` rules |
| `memm_quote_generation_cost` | free | the exact price of one job, or of a batch (`jobs`) |
| `memm_list_projects` | free | Canvas projects (they cannot be created through the connection) |
| `memm_list_brands`, `memm_get_brand` | free | saved brand profiles (colours, fonts, benefits, imagery; tone and audience are not returned) |
| `memm_list_products`, `memm_create_product` | free | product library and its reference images |
| `memm_get_upload_ticket` | free (daily limit) | upload a local photo, song or video |
| `memm_upload_reference` | free | small images only (under about 200 KB) |
| `memm_list_designs`, `memm_get_design`, `memm_search_gallery` | free | earlier results and Memm's public examples |
| `memm_list_jobs`, `memm_get_job` | free | job state, results, refunds, `boundInputs` |
| `memm_cancel_job` | refunds | cancel a queued clip that has not started |
| **`memm_generate`** | **spends credits** | one image (finishes in the call), video, voice-over, music, sound effect or 3D model (returns a job) |
| **`memm_generate_batch`** | **spends credits** | up to 10 video, voice or music jobs |
| `memm_generate_design` | spends, priced in units | deprecated; do not use for new work |

## The money gate (never skip)

1. **Quote** with `memm_quote_generation_cost` using the exact model, option, shape, mode and image count (and the uploaded file for lip-sync, motion control and video edit).
2. **Show** the price in Memm credits, and the total for several jobs.
3. **Get a clear yes**, or confirm that an authorisation in `budget.md` covers this exact job and total. Silence, praise for a plan, or a balance that says unlimited is not a yes to spend.
4. **Send** with `confirm_credit_cost` equal to the quote (`confirm_total_credit_cost` for a batch). If the server answers **"Price mismatch"**, nothing was charged. Do **not** re-send with the number it suggests: re-quote, tell the user the new price, and ask again if it is higher.
5. **Record** the spend in `budget.md` once, from the first answer that does not say `duplicate: true` (see below).

A request to plan, write a prompt or storyboard is not a request to generate.

## Idempotency keys (memm_generate)

- **Always send an `idempotency_key`**, even for one image. Without it the server uses a random key and a retry becomes a second paid job.
- Build the key from the project and asset: `<slug>-<asset>-t<take>`, for example `khafeef-ramadan-hero-t1`. Write it into `jobs.md` before calling the tool.
- **The same key returns the first job made with it, in whatever state it is (running, done, failed, refunded), and charges nothing.** Settings are not compared: a reused key with new settings hands back the old job. Always read `duplicate` in the answer. If it is `true` and you did not mean a retry, tell the user and use a new key. If it is `true` after a timeout, the first call ran and was charged once: report the result and the price once as spent (for example "1.5 credits, charged once"); do not call the charge unconfirmed.
- **Timeout, network error, or no clear answer:** re-send the **same** call with the **same** key, the same settings and the same `confirm_credit_cost`. The server returns the existing job without charging, or runs it once. Do not switch to a new key. (`memm_list_jobs` does not show keys; use it only to look at results.)
- **A deliberate new take** (after a failure, after QA rejection, or a variation) gets a new key (`t2`, `t3`) and is a new paid attempt that needs authorisation, unless the budget already covers it.

## Batches (memm_generate_batch)

- `idempotency_key` is required. Each job inside is identified by the batch key **plus its own settings**: a re-sent batch must contain exactly the same jobs. A changed job is a new paid job.
- Before any charge the whole batch is checked; if anything fails (total, balance, queue room, free audio slots, a paused service, an invalid job) the whole batch is refused and nothing is charged. Once it starts, each job is charged and refunded on its own, so results can be partial. Jobs not started within about 150 seconds come back as "not sent".
- Re-sending the same batch with the same key charges nothing for jobs already made, but **re-runs jobs that failed or were refunded** (up to 3 more times each), so it can spend again. `confirm_total_credit_cost` is the whole batch total, but the new charge is only the re-run jobs: tell the user that figure, get a yes, then compare it with `creditsCharged` in the answer.
- After a "still working" timeout, re-send only the same batch with the same key. `BATCH_IN_PROGRESS` means wait.

## Waiting for results

- Images return in the call (`imageUrl`). Video, voice, music and 3D return a `jobId`.
- Poll `memm_get_job` (or `job_ids` for up to 10): video about every 20 s, voice and music about 10 s, 3D about 20 s, queued clips about 30 s. Do not poll faster.
- Tell the user what is happening during long waits. If a job is still running after about three times the usual time, stop polling, keep the `jobId` in `jobs.md`, and tell the user they can ask you to check it later. Never resubmit to "speed it up".
- Video clips at once and queue length depend on the plan: read `videoClipsAtOnce` and `videoQueueLimit` from `memm_get_credits`. A clip sent while every video slot is busy is **charged and queued**, starts on its own, and can be cancelled with `memm_cancel_job` for a refund until it starts (a started clip cannot be cancelled; an unstarted queued clip is refunded automatically after 6 hours). Lip-sync, motion control and video edit never queue: they answer `VIDEO_IN_FLIGHT` (nothing charged) until the running clip finishes.
- Other limits: 5 generation calls a minute (a batch counts as one); 4 images, 3 voice/music and 3 3D jobs at once.

## Refusals and failures

Treat an error as uncharged only if its text says so. Four answers can come **after** a charge: `GENERATION_FAILED`, `JOB_EXPIRED`, `CHARGE_UNCONFIRMED` and `ALREADY_STARTED`.

| Answer | Meaning | Do |
|---|---|---|
| upgrade message (plan lacks the connection) | free or lapsed plan; every Memm tool answers this way, nothing runs or is charged | Say so plainly, share https://memm.ai/pricing, do not retry. Skills that need no Memm tools still work. |
| `*_PAUSED`, "paused on Memm's side" | Memm has paused that kind of generation for everyone | Tell the user, share any link, do not retry. Nothing was charged. |
| `NOT_ENOUGH_CREDITS` | balance too low | Show the price and balance; offer a cheaper option or a smaller set. |
| "Price mismatch" | the price changed | Re-quote and ask again if higher (see the money gate). |
| `PROMPT_NOT_ALLOWED`, `IMAGE_OR_PROMPT_NOT_ALLOWED` | Memm's safety check refused | Give the reason and the reference; if the user thinks it is wrong, they send the reference via memm.ai/contact. Do not try to get around the check. |
| `VIDEO_IN_FLIGHT`, `TOO_MANY_RUNNING`, `AUDIO_IN_FLIGHT`, `THREED_IN_FLIGHT` | busy, nothing charged | Wait for the running job, then send again. |
| `VIDEO_QUEUE_FULL` | queue full | Wait, or cancel a queued clip. |
| `INVALID_PROJECT`, `PROJECT_NOT_FOUND` | wrong project id | List projects again; projects are created at memm.ai/canvas. |
| `GENERATION_FAILED`, `JOB_EXPIRED` | the model failed after the charge | Report whether the credits came back (`refunded`, or `refund pending`, which retries automatically). Do not resubmit to recover credits. Diagnose, change one thing, quote, ask, then use a new key. |
| `CHARGE_UNCONFIRMED` | a charge may have been taken; the clip will not run; any credits taken come back automatically in about 10 minutes | Tell the user. Check `memm_get_credits` and `memm_list_jobs`. Wait about 10 minutes for the refund, then send again under a **new** key with a fresh yes. Do not resend immediately: the balance could be charged twice until the refund lands. |
| `ALREADY_STARTED` | the same request is already being processed (and may have been charged) | Do not resend. Poll `memm_list_jobs`. Ignore any "nothing charged" wording on this answer. |

## Partial success

Report each asset separately: done (link), failed (reason, refund state), not sent. Keep and deliver what succeeded. Retry only the failed items, each with its own new key, after authorisation.

## Files and uploads

- Local files go through `memm_get_upload_ticket`: one file per ticket, valid 10 minutes. Pass `size_bytes` when you know the file's size. Run the returned `curl` (Git Bash, macOS, Linux) or `powershell` command with the real path, then use the `url` from the upload's answer. A file up to 4.4 MB goes through memm.ai itself (`via: "memm"`); a bigger file gets the direct vercel.com upload (`via: "direct"`, or the `fallback` of a memm.ai answer that came back HTTP 413). If the command is blocked (HTTP 403, a proxy or connection error), the user's Claude Code sandbox may be blocking the domain: ask them to allow `memm.ai` (or `vercel.com` for a big file) in the sandbox network settings, or to approve the command outside the sandbox. Photos JPEG/PNG/WebP up to 10 MB; songs MP3/WAV up to 15 MB; videos MP4/MOV up to 100 MB.
- `image_urls` accepts Memm URLs only (uploads, product images, earlier designs). Never upload a user's files to any other service.
- Songs and videos for lip-sync, motion control and video edit must be the user's own files. Never download them from a link or website.
- If you cannot run the upload command, say so and send the user to the Video tab at https://memm.ai/canvas.
- If you can see a photo in the chat but have no file path for it, say so plainly: ask the user to save it in this folder or tell you where it is (for example "Desktop, perfume.jpg"). If that is hard for them, ask them to add it once to Products on memm.ai and tell you its name; `memm_list_products` finds it from then on.

## Where results go

Every result also appears in the user's Canvas grid. Pass `project_id` (from `memm_list_projects`) to file it in a project, and keep the same project on retries. Projects cannot be created through the connection: the user creates one at memm.ai/canvas, or you use the main canvas.

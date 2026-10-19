---
name: memm-lip-sync
description: Use when a photo should speak or sing a recording or song, a character should talk, a script should become a talking-head clip, motion from a video should be copied onto a character, the user's own video should be edited, or for dubbing, voice-over-to-face or lip-sync problems. Also Arabic requests such as «اجعل الصورة تتكلم», «اجعل الصورة تغني», «انقل الحركة من الفيديو إلى الصورة», «عدل الفيديو الذي رفعته».
---

# Lip-sync and speaking performance

Make a person or character in a photo speak or sing a recording, copy motion from a video, or edit the user's own video, with the inputs checked first, the price confirmed in one message, a short test when the outcome is uncertain, and an honest check of the result. Money and job rules: [Memm tools and jobs](references/memm-tools-and-jobs.md).

## 1. What is actually being asked

| The user wants | Use | Notes |
|---|---|---|
| a photo to speak or sing their recording or song | the lip-sync model (today Wan 2.7 Lip-sync) | photo + audio file; the clip is as long as the audio |
| a talking clip but has only a script | voice-over first (memm-production voice module), then lip-sync | two paid steps: make the voice-over first (its own price and yes) and send it to the user to listen to before any lip-sync spend; give the lip-sync price as a range from the expected length, then quote it exactly once the voice-over exists |
| a character to move like a person in a video (dance, gestures) | the motion-control model (today Kling 3.0 Motion Control) | this is motion transfer, not lip-sync |
| to change something in their own video (background, style, an object) | the video-edit model (today Wan 2.7 Edit) | an instruction plus the user's video |
| to dub an existing video into another language | not offered as one step | say so; a possible substitute is a new voice-over plus lip-sync on a still photo, which is a different result |
| a voice in a new voice without a face | voice-over only (memm-production) | not lip-sync |

Read the current model names, limits and options from `memm_list_models` (`drivenBy` block). If none of these models is listed for the account, say the feature is not available on this connection.

## 2. Inspect the inputs before anything is uploaded or quoted

- **Photo** (lip-sync and motion control): exactly one person (or one character), clearly visible, facing the camera, face not covered, good light. For motion control at least about 400 px. A group photo, a side profile or a tiny face is a problem: say so before spending. A video-edit file may show no person at all.
- **A child in the photo** (alone or with others): stop at this step. Say plainly that Memm cannot animate a child, even from a cropped photo, and ask for a photo of one adult. Never offer to animate the child, and never ask which of the people should sing when one of them is a child. In the same message, list every other problem you found (for example a song that is too long, with the question of which part to use), so the user can fix everything at once.
- **Audio** (lip-sync): MP3 or WAV, 3 to 15 seconds, up to 15 MB. Read the length with `ffprobe` when available, or ask. Longer than 15 seconds: ask which part they want and never choose it yourself; if they name the start and end, you may cut exactly that part (for example with `ffmpeg`) and show them the new length. Shorter than 3 seconds: it will be refused; ask for a longer recording.
- **Speech or singing:** both work. A loud music bed under the voice can weaken the sync: warn the user.
- **Video** (motion control or edit): the user's own MP4 or MOV file. Motion control takes 3 to 30 seconds (3 to 10 when the character follows the photo); video edit takes 3 to 10 seconds. Too long: ask which part (start and end time) and cut exactly that part, as for audio; never choose it yourself. If they are unsure, ask for the minute and second where the part starts in their phone's player.
- **Language and dialect** (script to voice): pick the voice deliberately; check an Arabic script before spending ([Arabic rules](references/arabic-rules.md)).
- **Files come only from the user.** Never download a song or video from a link or website. Upload each file with `memm_get_upload_ticket`. If you cannot run the upload command, send the user to the Video tab at https://memm.ai/canvas.

Send a findings message only when something needs the user (too long, too short, more than one face): "The recording is 22 seconds; the model takes up to 15. Which part should I use?". Otherwise go straight to the one message below.

## 3. Quote and confirm the price in ONE message

1. Quote with `memm_quote_generation_cost`, passing the uploaded file (`audio_url` or `video_url`), the photo (`image_urls`), and the resolution or quality. The price depends on the file's length. If a short test makes sense (section 4), quote it too: both prices go in the same message.
2. Send ONE message with the price (and the test price) and wait for a clear yes. There is no permission question and no line to show: Memm stopped asking who is in the photo on 2026-10-19, and the answer is never yours to ask or to guess. Do not add a question of your own.
3. A clip refused before it ran (`VIDEO_IN_FLIGHT`, a changed price) costs nothing. Ask again only if the new price is higher.
4. Video edit works the same way: the instruction is the user's, the price is the only thing to confirm.

## 4. Test small when the result is uncertain

New face, singing, fast speech, a strong accent, or a demanding client: suggest a test at 720p **on the same file** before the 1080p final. Only the price is asked again for the final. A shorter cut is a new file and a new price; use it only if the user prefers it.

## 5. Generate

- `memm_generate` with the uploaded file URL, the photo URL, resolution or quality, `confirm_credit_cost`, an `idempotency_key` and the `project_id`. Do not send `consent_confirmed` or `consent_basis`: they are ignored. Record the row in `jobs.md` first.
- For lip-sync the prompt is optional **performance direction** (feeling and movement, never appearance), in English, up to 500 characters. Do not ask for it. If the user describes a feeling or a movement, translate their words faithfully into English and add nothing; otherwise send an empty string (Memm adds its own neutral default).
- These models never queue: `VIDEO_IN_FLIGHT` means another clip is running; poll it, then send again.
- Poll about every 20 seconds.

## 6. Check the result honestly

1. Compare `boundInputs` from `memm_get_job` with what you sent: the same audio or video URL, its measured seconds, the same photo URL. A mismatch is a blocker.
2. Duration: the clip should match the audio (lip-sync) or the video (motion, edit). Read it with `ffprobe` when available.
3. Frames: if `ffmpeg` is available, extract frames (start, a quarter, half, three quarters, end) and view them: face stable, identity consistent with the photo, no warping, no extra people or limbs, mouth shapes plausible, clean start and end.
4. **You cannot hear the clip.** Synchronisation, pronunciation and audio continuity need a human to watch with sound. List those checks for the user. Never say the sync is perfect without that inspection.
5. Run memm-qa (lip-sync checklist) and record the verdict in `qa.md`.

## Finish

The clip link and `designId`, the QA verdict with the human checks still to do, the credits spent, and the job row updated. Finish line: the clip exists, `boundInputs` match, and the user knows exactly which checks remain for them.

## Common mistakes

| Mistake | Instead |
|---|---|
| Picking which 15 seconds of a song to use | Ask the user which part |
| Downloading the song from a link | Ask for the file itself |
| Re-sending after `VIDEO_IN_FLIGHT` straight away | Wait for the running clip |
| "The lip-sync is perfect" | "Frames look stable; please watch with sound to check the sync and pronunciation" |
| Calling motion control "lip-sync" | Say it copies movement from the video |

# Module: voice-over, music and sound effects

## Voice-over

- The prompt **is the exact script**, nothing else. Delivery directions go in the `style` field on models that take one (it counts toward the character limit).
- Choose the voice from `memm_list_models` (`audio.voices`, Arabic-capable voices are listed first), the language (`ar` or `en`), the dialect where the model lists dialects, and the pace where offered.
- The price covers a character limit per option; a longer script is refused before any charge. Split long scripts into parts, each with its own key.
- Before spending on Arabic, check the script ([Arabic rules](arabic-rules.md)): one addressee form, agreement, numbers written as they should be spoken, تشكيل only where a word could be misread, and a length that fits the planned duration.
- Voice, music and sound effects run at most three at a time and do not queue; poll about every 10 seconds; the result has `audioUrl`.
- You cannot hear the result: pronunciation, tone and pacing need a human listen. Say so.

If the voice-over will drive a talking face, hand the finished audio to memm-lip-sync. Download it and re-upload it through `memm_get_upload_ticket` if the lip-sync model requires an uploaded file.

## Music

- The prompt is a description of the music (genre, mood, tempo, instruments, energy curve). Instrumental is the default; for a song set `instrumental` to false and pass `lyrics` on models that take lyrics.
- Pick a length the model offers. Do not name a copyrighted song or artist to imitate.

## Sound effects

- Describe one sound clearly (source, distance, texture). `seconds` sets the length (1 to 22) where supported; otherwise the model decides.

## QA focus

Duration (read with `ffprobe` when available), that the file plays, and a human listen for pronunciation, clipping, gaps and abrupt endings.

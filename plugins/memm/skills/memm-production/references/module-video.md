# Module: video

## Plan the shot

- Use the brief; ask only for the missing essentials: the product or reference, the intended result, duration, shape, and whether there should be speech or other sound. A silent request stays silent: no voice-over, music, presenter or extra clips by default.
- A longer ad is several shots, each with one clear purpose. Generating clips does not assemble them: say what editing remains and who does it.
- Check the model's real options (durations, resolutions, shapes, modes, sound) in `memm_list_models`. A prompt cannot unlock a feature the model does not offer.

## Choose the mode

- **Text:** sets subject, setting, movement and look. If exact product identity matters, prefer an image mode with the user's reference.
- **Start image (`mode: image`):** describe what changes over time and what stays still. The image already gives the appearance; do not rewrite it into a different product.
- **First and last frames (`frames`):** compatible approved frames; describe the transition and the end state. Unrelated frames do not guarantee a plausible transition.
- **References:** explain each image's role in the order sent.

## Write the direction

A short sequence: starting composition, subject action, camera movement, ending composition, then essential light and sound. One understandable camera path for a short clip. Check that the action fits the duration and that spoken lines fit the time (about 2 to 2.5 words a second). Treat a large prompt allowance as capacity, not a target.

Keep the product's silhouette, material, label and colour. One front photo does not show the back: do not promise an accurate full orbit from it.

Arabic speech generated inside a video model is short and its pronunciation is not guaranteed. When exact Arabic speech matters, make a separate voice-over (voice module) and, if a face must speak it, use memm-lip-sync.

## Example

"Use the supplied product photo as the starting frame. One continuous six-second shot: the camera slowly moves closer at label height while the bottle stays still. Preserve the bottle, label, cap and background throughout. Soft side light and gentle reflections; finish with the label centred and the whole cap visible. Quiet room tone, no speech, no music, no captions."

Use six seconds only when the option exists and the brief agrees.

## Cost and tests

Video is the largest spend. Test new motion at the shortest duration and a lower resolution, then render the approved direction at final quality. A clip sent while the account's video slot is busy is charged and queued, and starts on its own; it can be cancelled for a refund until it starts.

## QA focus

Product continuity from first to last frame, motion plausibility, framing at the start and end, duration and shape read from the file, unwanted text, flicker or warping, and the sound (human listen).

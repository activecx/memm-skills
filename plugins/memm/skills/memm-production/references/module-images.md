# Module: images (product photography and ad visuals)

## Direction

Choose what the assignment needs: a clear catalogue packshot, a believable lifestyle scene, a deliberately conceptual composition, or a layout with room for copy added later. Distinguish the **identity reference** (the real product photo, which must not change) from **mood references** (lighting, composition, palette).

## Writing the prompt

1. Pick the model and option with memm-tool-selection; read its real `promptMaxCharacters`, reference count and shapes from `memm_list_models`.
2. Describe the picture in natural language: the product and the role of each reference image (in the order sent), setting, composition, lighting, visible materials, and the few details that must remain unchanged. Say where it will be used when that affects the crop.
3. Separate fixed product facts from creative choices. Resolve contradictions instead of including both.
4. Keep the full brief out of the prompt. If the prompt is too long, remove repetition and decoration first; keep identity, exact copy and the requested change. Never silently truncate.
5. For Gemini image models (Nano Banana), use one coherent scene description and focused follow-up edits.
6. No text in the image unless the user explicitly asked: describe no headline, caption or logo text, and ask for clear space where copy will go ("clear space in the upper third for a headline added later").

## Example

"Vertical product photograph using the attached bottle as the identity reference. Keep its shape, amber glass, cap and existing label unchanged. Place it on pale limestone with soft window light from the left and a restrained warm background. Frame the whole bottle with clear space above for a headline added later. No new packaging text, no extra products."

Adapt this to the actual brief; do not reuse its shape or lighting by default.

## Edits

For an edit, change only what the user asked and say what must stay the same. Send the previous result or product image as the reference.

## QA focus

Product identity and label integrity, composition and crop for the placement, material realism, people (anatomy, tasteful styling), no unwanted text, and real dimensions read from the file.

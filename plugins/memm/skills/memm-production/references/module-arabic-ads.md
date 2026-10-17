# Module: Arabic and bilingual advertising

Follow [Arabic rules](arabic-rules.md).

## Default: text-free image plus separate copy

1. Generate the visual with no words in it, composed with clear space where the copy will go (say where: top third, left side, lower band).
2. Deliver the copy separately, ready to paste: a short headline, supporting line and call to action (1 to 3 words), each in Arabic (and English for bilingual, each written natively for its reader, not translated line by line), plus the placement note. In an Arabic reply, label the lines in Arabic (العنوان, النص المساند, عبارة الدعوة إلى الإجراء) and put each Arabic line alone on its own line, without تشكيل, so it pastes cleanly.
3. Recommend adding the copy in a layout tool such as Canva (in Arabic: كانفا) with the brand's Arabic font. Check that the font joins Arabic correctly and draws Western digits cleanly; if not, set prices and numbers in the brand's Latin font. Do not claim this step is done unless it was done.

This is Memm's default because generated lettering can contain spelling or joining errors, and copy in a layout tool can be corrected and translated without new generations.

## When the user explicitly wants text in the image

1. Confirm the exact wording and language once, in one message.
2. Use the model `memm_list_models` recommends for Arabic lettering; quote it with images if a product photo is attached.
3. Put the exact text in the prompt in quotation marks, name the script ("Arabic text, right to left"), say where it goes and how large, and say "no other text". Keep it short and without تشكيل unless the user asked for it.
4. QA letter by letter. If any letter, dot, joining or direction is wrong, it is not final: offer one corrected take (new key, within budget) or the text-free version plus separate copy.

## Copy quality checks

One addressee form; agreement, including counted nouns after digits; a deliberate register (modern MSA by default, a named dialect only when the user or the brand's own copy calls for it); Arabic punctuation (، ؛ ؟); no English words mid-sentence; no translation tics; no invented claims (claims register only); prices, numbers and offers exactly as the business states them; Western digits.

## Bilingual layouts

Arabic reads right to left and English left to right; keep each in its own block. Do not mix both languages inside one line.

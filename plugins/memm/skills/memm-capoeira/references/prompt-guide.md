# Memm Capoeira prompt guide

**Get the take right the first time.**

Memm Capoeira puts your product, your character or your outfit into a video and keeps the shot's motion. Every take costs credits, even when you don't like the result. A take that goes right the first time is the cheapest one. This guide shows you how to choose the clip, prepare the photos and write an instruction the model follows.

---

## The short version: 8 rules

1. **Pick the right mode.** Use **Objects swap** to change one thing and keep the rest of the real footage. Use **Motion transfer** to rebuild the whole shot around your character.
2. **Trim the clip to the moment you need**, just under a price step (for example 9.9 s, not 10.4 s). Shorter clips cost less.
3. **One clear target.** Name it by its position and how it looks: "the man on the left in the white shirt".
4. **Photos are the brief.** Use a sharp front photo with the label readable. Put the most important photo first. Usually 1 to 4 photos is enough.
5. **Tell the model what each photo is for**, using its tag: "the perfume bottle in @Image1". The new look always comes from a photo, never from @Video1.
6. **Say what must stay the same:** the other people, the hands, the camera and the background.
7. **Never ask for on-screen text.** Memm already tells the model "No new subtitles or added text". Add your copy later in your editor. Ask for the label "exactly as in @Image1".
8. **Test at 720p, then make it in 1080p.** A 720p take costs about half as much as a 1080p take.

---

## 1. Choose the mode

| You want to… | Mode | Why |
|---|---|---|
| Put your product in place of an object in the clip (a cup, a bottle, a phone, a shoe) | **Objects swap** | It edits the real footage: only the target changes. |
| Change one person's look, or put yourself in place of a person | **Objects swap** | The motion, the camera and the other people come from the real clip. |
| Change an outfit only | **Objects swap** | The face, the body and the moves stay. |
| Change only the background | **Objects swap** (target: Background) | The person and their moves stay. |
| Make your character, mascot or a different person do the same dance or moves | **Motion transfer** | It rebuilds the shot: the moves, the camera and the timing come from the clip, and the look comes from your photos. |
| Move the whole scene to a new place, with your character | **Motion transfer** (character in @Image1, place in @Image2) | Everything is rebuilt from your photos. |
| Change the camera move, or make the clip longer than it is | Neither | Objects swap keeps the camera exactly as filmed. The output is as long as your clip. |

**Rule of thumb:** for "the same footage with one thing changed", use Objects swap. For "the same moves in a new world", use Motion transfer.

---

## 2. Choose or prepare the clip

### 2.1 What the clip must be

| | Limit |
|---|---|
| File | MP4 or MOV, up to 200 MB |
| Length | 4 to 30 seconds |
| Frame rate | 24 to 60 frames per second |
| Size | about 640×640 up to 4K, and not narrower than 0.4 or wider than 2.5 (width ÷ height) |
| Or | any move from the **Motion Library**. Library clips are already measured and always fit these limits. |

### 2.2 The price follows the clip's length

The price is set by the length step that covers your clip and by the quality you pick. It is the same in both modes. Cropping the clip to a reel does not change it.

| Your clip runs | Charged as | 720p | 1080p |
|---|---|---|---|
| 4 to 5 s | 5 s | 41 credits | 81 credits |
| just over 5 up to 10 s | 10 s | 82 credits | 161 credits |
| just over 10 up to 15 s | 15 s | 123 credits | 242 credits |
| just over 15 up to 20 s | 20 s | 164 credits | 322 credits |
| just over 20 up to 30 s | 30 s | 246 credits | 483 credits |

**Trim just under a step.** At 720p, a 10.4 s clip costs 123 credits. Trimmed to 9.9 s, the same moment costs 82 credits. At 1080p the same trim saves 81 credits (242 down to 161). You see the total before you press Generate.

Library clips have a fixed length. Check the seconds badge: a 22 s library move costs the 30 s price.

### 2.3 Clip checklist (the model can only change what it can see)

| Check | Why it matters | Do |
|---|---|---|
| **One clear target** | With 3 people, a crowd or a table full of objects, the wrong thing gets changed. | Pick a clip where your target is easy to point at. If the clip has 2 or more people, name the target by position and look. |
| **Target size** | A product the size of a fingernail, or a face 20 pixels wide, has no detail to replace. | The target should fill a good part of the frame for most of the clip. |
| **Hidden target** | When a hand, a person or a cut hides the target, the replacement can break up or the original can show through. | Prefer clips where the target stays visible, or trim out the moments where it's hidden. |
| **Fast motion** | Spins, jumps and whip pans are where faces, hands and labels melt. | Calm, steady moves give the cleanest result. |
| **Cuts** | Every cut is a new chance for the target to change. | A single continuous shot is the most reliable choice. |
| **Light** | Very dark or flickering light hides the detail the model needs. | Choose clips with even, clear light. |
| **Captions, logos, watermarks** | Text in the clip tends to come back in the result, sometimes garbled. | Use clips with no text on screen. |
| **Sound** | The finished clip keeps **your clip's own sound**. A clip without sound gives a silent result. | Choose the clip for its sound as well as its picture. Don't ask the model for music or voices. |

### 2.4 Portrait, landscape and the reel crop

Every take comes out as a **9:16 reel** unless you choose another shape.

- **Motion transfer:** the model rebuilds the shot directly in the shape you choose.
- **Objects swap:** the model edits the real footage, so a landscape clip is first **cropped** to 9:16. You choose which part of the frame to keep: **left, center or right**. Anything outside that window is gone, so make sure your target stays inside it.
- **"Same shape"** keeps your clip exactly as filmed, with no crop.

Cropping a landscape clip to a reel keeps only a narrow strip of it. If that strip is small, the result looks soft, and Memm warns you before you generate.

| Landscape clip (16:9) | Reel at 720p | Reel at 1080p |
|---|---|---|
| 854×480 or 1280×720 | may look soft | may look soft |
| 1920×1080 | fine | may look soft |
| 4K (3840×2160) | fine | fine |

A portrait clip (9:16) needs no crop for a reel. If you shoot your own clip, film it vertically.

---

## 3. Prepare the images

### 3.1 The basics

- **1 to 30 images**, JPEG, PNG or WebP, at least **400 pixels** on the short side (1,000+ is better), and not narrower than 0.4 or wider than 2.5.
- **Order = tag number.** The first image in the strip is `@Image1`, the second is `@Image2`, and so on. If you reorder the strip, the tags in your instruction must change too.
- **Most important image first.** Put the product or the person you are swapping in `@Image1`.
- **How many is enough?** For one product, 1 to 3 images (front, three-quarter view, back if the clip shows it). For a person, 2 (a face close-up and a full-body photo). More than 5 images rarely helps, and from about 6 the results can get less stable. You can add up to 30, but more images are not better.
- A transparent PNG gets a **white** background.

### 3.2 Product photos

| Do | Don't |
|---|---|
| Show the whole product, sharp and well lit, on a plain background | Hand-held shots, props or busy shelves around it |
| Take a front shot with the **label readable** | Shoot at a steep angle, with glare across the label or a blurred label |
| Add a three-quarter shot and a back shot if the clip shows those sides | Put several products in one photo |
| Show the colours as they really are | Use filters, price stickers, or text and graphics added on top |
| Add a close-up of the label if the label matters most | Upload a 300-pixel thumbnail from a website |

### 3.3 People photos (you, a model or a character)

| Do | Don't |
|---|---|
| **Photo 1:** a face close-up, front-facing, sharp, even light, neutral expression | Sunglasses, hands or hair covering the face, heavy shadows |
| **Photo 2:** a full-body photo in the outfit you want to see | A collage, or a character sheet with several views in one image |
| One person per photo | Group photos ("the one on the left" in a photo confuses the model) |
| Photos of yourself, or of people and characters you have the right to use | Famous faces or well-known film and cartoon characters. The model's review can refuse them. A refused take is refunded, but you lose the time. |

**A person photo gives the whole look.** When you replace a person, the photo sets everything about them: face, hair, skin tone, body, clothes, shoes and accessories. @Video1 gives only the moves, the pose, the position, the camera and the light.
- **To keep the original clothes,** say so: "keep the clothes she wears in @Video1".
- **To dress them in something else,** add the outfit as its own photo and say which photo it is.
- Things the person **holds** (a cup, a phone, a bag in the hand) stay from the clip unless you swap them too.

### 3.4 Outfit photos

- Show the **whole garment**: front, and back if the clip shows the back. Lay it flat, hang it, or put it on a mannequin.
- Add a close-up for a detail that matters (embroidery, a logo patch, buttons).
- If the outfit is on a person, crop the face out. Otherwise the model may copy that person's face too.

### 3.5 Background or location photos

- A wide shot of the place with **no people** in it, taken from roughly the same height and angle as the camera in your clip.
- The light you want: day, golden hour or night.

---

## 4. Write the instruction

### 4.1 What Memm writes for you

Memm starts every instruction with an automatic sentence, and your words are added after it. You never have to write it. You can see the whole thing with **"See the full instruction"**.

- **Objects swap:** *"In @Video1 replace [your target] with the [thing] shown in @Image1… Keep the camera, framing, motion and timing exactly unchanged, and keep everything this instruction does not ask to change exactly as it is. No new subtitles or added text."*
- **Motion transfer:** *"Recreate @Video1 with the character in @Image1 performing the same motion, camera moves and timing. Keep the pacing and cuts identical. No new subtitles or added text."*

Both already end with **"No new subtitles or added text"**, so you don't need to write that line yourself. In Objects swap, Memm's sentence keeps everything you don't ask to change. If you also want a new background or new light, say it plainly in your instruction.

**Two settings tell Memm what to change:**
- **What changes** (the *target*): Product, Person, Outfit, Background, or Other in your own short words ("the white sneakers on both feet"). Every Objects swap needs one.
- **Which person** (*who*): only when the clip shows 2 or more people. It is always a person: the one being replaced, the one wearing the outfit, or the one holding the product. Never an object, and never for a background swap. On your own clip, write it in English by position and look ("the woman on the right in the white T-shirt").

On a Motion Library clip, pick the person from the clip's cast list. Memm then writes the target in the cast's own words, for example "the bearded animated man in straw hat, cream shirt and brown bib overalls (on the left of @Video1)". It also adds a line telling the model to keep everyone else exactly as they are. In your instruction, use those same words for each person; don't invent a second description.

Your instruction does the rest: the detail, what each photo is for, and what must not move.

**Tags:** `@Video1` is your clip. `@Image1`, `@Image2`… are your photos in strip order. Type `@` to pick one. A tag that points at a photo you don't have blocks Generate until you fix it.

### 4.2 The 5-part template

Write 4 to 7 short sentences, in this order:

| # | Part | What to write | Example wording |
|---|---|---|---|
| 1 | **Target** | What in @Video1 changes. Give its position and 2 or 3 visible features: colour, clothing, shape. Use one name for it and stick to that name. | "The white ceramic coffee cup in the woman's right hand" |
| 2 | **Replacement** | What replaces it, from which @Image, and what to take from that image. | "…becomes the perfume bottle in @Image1 (front) and @Image2 (side): same glass shape, gold cap and label." |
| 3 | **Other changes** *(optional; one at most)* | Background, outfit, light or mood. Tie it to a photo when you have one. | "Change only the background to the night market in @Image3." |
| 4 | **Keep** | Everything that must not change: other people (by description), face, hands, moves, camera, timing, background, lighting. | "Keep her face, hair, clothes, hand movement, the camera and the café exactly as in @Video1." |
| 5 | **Quality notes** | Scale and position, hands, the label, stability. (Memm already adds "No new subtitles or added text.") | "Same size and position as the cup, held the same way, fingers natural. The label exactly as in @Image1, sharp and not redrawn. Stable faces, no flicker." |

**Ready-made sentences.** Each one does one job on one target:

| You want to… | Write |
|---|---|
| Replace something | "Replace only [target] in @Video1 with the [thing] from @Image1." |
| Change one property | "Change only [target] so that [the change]." For example: "so that her scarf is deep green". |
| Remove something | "Remove only [target] and fill the gap so it matches what's around it." |
| Make sure a replaced person is fully gone | "The original [target] never appears in any frame, including after cuts and in reflections. The person from @Image1 takes their place in every shot, with the same moves and timing." |
| Replace two people | Write one sentence per person ("Replace the man on the left with @Image1. Replace the woman on the right with @Image2."), then add "Each keeps their own face; the faces never swap, merge or appear twice." Never write "replace everyone". |

### 4.3 Do and don't

**Do**
- Use **concrete nouns**: "the red soda can", not "the thing".
- Use **positions**: left or right, front or back, foreground, "in her right hand", "on the table".
- Give each photo **one job**, and mention every photo you added.
- Say where each new look comes from: "**from @Image1**". @Video1 gives only the moves, the camera and the timing, so never write "the look from @Video1".
- Keep **one name per subject**. If you call him "the bearded man", keep calling him that.
- Write the keep list in **plain positive words**: "keep the camera exactly as in @Video1".
- For a product, ask for **the same size and position as the original object**.
- **Write in English.** The tags are Latin letters, and one language per instruction is clearest. Prefer Arabic? Use **"Help me write it"** (below).

**Don't**
- **Contradict yourself.** "Keep the background" and "change the background to a beach" in the same instruction confuses the model.
- **Leave choices open.** No "a red or blue bottle", no "if possible, change the light", no "maybe". Decide first, then write one clear instruction.
- **Ask for on-screen text, captions, slogans or prices.** Text in video is often misspelled. Add your copy afterwards.
- **Ask for sound, music or dialogue.** The sound comes from your clip.
- **Ask Objects swap to change the camera move or the clip's length.** It keeps both.
- **Write "reference @Video1" or "use @Video1 as a reference" in Objects swap.** Editing words ("replace", "change") keep the model editing your footage.
- **Use vague or loaded words** ("cool", "premium vibe", "furious"). Strong emotion words can produce odd effects, such as glowing eyes. Describe what we see instead: "she smiles and looks at the bottle".
- **Rely on a brand name alone** ("a Nike shoe"). Describe what the photo shows: "the white low-top sneaker with the black side stripe in @Image1".
- **Pack in many changes.** One main change per take is the most reliable. Do a second take for the next change.

### 4.4 Before and after

**1. Product swap**
- Before: *"Put my perfume in the video and make it look premium."*
- After: *"The white coffee cup in the woman's right hand becomes the perfume bottle in @Image1: same square glass shape, gold cap and black label. Same size and position as the cup, held the same way, fingers wrapped naturally around it. Keep her face, clothes, hand movement, the camera and the café exactly as in @Video1. The label exactly as in @Image1, sharp and not redrawn."*

**2. Two people**
- Before: *"Replace the man with me."*
- After: *"Replace only the man on the left in the grey hoodie and black cap with the person in @Image1 (face) and @Image2 (full body, beige shirt). Keep the woman on the right in the red dress exactly as she is. Keep the moves, camera, timing and background exactly as in @Video1. Faces stable, no flicker."*

**3. Motion transfer**
- Before: *"Make my character dance like this, cool lights, add my logo."*
- After: *"The mascot in @Image1 (full body, front) and @Image2 (back) performs the dancer's moves, with the same steps, arm movements and timing as in @Video1. Keep @Image1's round orange body, white gloves and blue sneakers exactly. Keep the studio, the lighting and the camera as in @Video1. Only one mascot in the frame."*

### 4.5 "Help me write it"

Not sure how to say it? Press **"Help me write it"** and answer a few short questions, in Arabic or English:

1. **What should change?** The target, and what replaces it.
2. **What must stay?**
3. **Background?** Same, or new (with a photo if you have one).
4. **Mood?** Optional.

Memm writes the instruction for you in English, using only the tags you really have. It never adds text on screen or invents details about your product. Read it, edit anything, then check the total. Writing it costs no credits. There is a daily limit.

### 4.6 When an AI assistant runs it for you

If you use Memm Capoeira through an AI assistant connected to Memm:
- **It doesn't ask open questions** about what stays or what else to change. It states the defaults (everything else stays as filmed, no other change) in one message together with the price, and you correct anything you want different.
- **It asks only what it can't know:** what changes, if your request doesn't say; which person, if the clip has 2 or more; and which part of a long clip to keep.
- **One yes covers one take at the price it named.** The 1080p version is a new take, with its own price and its own yes.
- **Every take gets its own new key** (take 1, take 2, the 1080p take). Reusing an old key would only hand back the old take.
- It talks with you in your language but always sends the model an English instruction.

---

## 5. Worked examples

Prices are for the clip length shown. Each example lists the mode, then the images in strip order, then **your instruction**. Memm's automatic opening sentence comes before it.

### Example 1: Perfume replaces a cup in a hand
- **Clip:** 7 s. A woman at a café table lifts a white coffee cup and smiles. Portrait. → **82 credits at 720p** (10 s step).
- **Mode:** Objects swap. Target: Product.
- **Images:** @Image1 perfume front, label readable · @Image2 perfume three-quarter view.
- **Instruction:**
> The white ceramic coffee cup in the woman's right hand becomes the perfume bottle in @Image1 (front) and @Image2 (side): the same rectangular glass bottle, gold cap and black label. It has the same size and position as the cup and is held the same way, her fingers wrapped naturally around it. Keep her face, hair, clothes, hand movement, the table, the camera and the café exactly as in @Video1. The label stays exactly as in @Image1, sharp and readable, never redrawn.

### Example 2: Sneaker swap on a walking person
- **Clip:** 9.5 s. Low camera, a person walks toward the lens in white sneakers. → **82 credits at 720p**.
- **Mode:** Objects swap. Target: Other → "the white sneakers on both feet".
- **Images:** @Image1 sneaker side view · @Image2 sneaker from the front and above · @Image3 sole and heel.
- **Instruction:**
> Replace the white sneakers on both feet with the sneaker in @Image1 (side), @Image2 (front) and @Image3 (sole and heel): the same black upper, white sole, red heel tab and lace colour, on both feet. The shoes keep the same size and the same steps as in @Video1. Keep the jeans, the legs, the walking rhythm, the street and the camera exactly as in @Video1. The logo on the side stays exactly as in @Image1.

### Example 3: Can on a desk, slow orbit (no hands: the easiest case)
- **Clip:** 5 s. The camera slowly circles a red soda can on a wooden desk. → **41 credits at 720p**.
- **Mode:** Objects swap. Target: Product.
- **Images:** @Image1 your can, front · @Image2 your can, back.
- **Instruction:**
> Replace the red soda can on the desk with the drink can in @Image1 (front) and @Image2 (back): the same matte green can, silver top and label. As the camera circles, show the front from @Image1 and the back from @Image2. Same size and position as the original can, standing on the desk. Keep the desk, the light, the reflections and the camera move exactly as in @Video1. The label stays exactly as in the photos, sharp, never redrawn.

### Example 4: Two-person clip, replace one person (the first real take)
- **Clip:** Motion Library, "Dancer in low light", 10.04 s, landscape, 2 people. → **82 credits at 720p**. This follows the first billed Capoeira take, whose result was approved, now worded in the clip's cast names.
- **Mode:** Motion transfer. Which person: the bearded man on the left (picked from the cast list).
- **Images:** @Image1 the new character.
- **Instruction:**
> Replace only the bearded animated man in straw hat, cream shirt and brown bib overalls (on the left of @Video1) with the character in @Image1, keeping @Image1's face, hairstyle, outfit and colours exactly. Keep the round red animated character with moustache, pinstripe suit, red tie and black hat (on the right) exactly as he is. Keep the moves, camera, timing, lighting and background exactly as in @Video1.

**Why it works:** the target is named by position plus three visible features. The photo is told what to give (face, hair, outfit, colours). The second character is named and locked. The camera, timing, light and background are locked too.

### Example 5: A dancer becomes your brand character
- **Clip:** solo dancer in a studio, 12 s, **trimmed to 9.8 s** → **82 credits at 720p** instead of 123.
- **Mode:** Motion transfer.
- **Images:** @Image1 mascot full body, front · @Image2 mascot, back.
- **Instruction:**
> The mascot in @Image1 (front) and @Image2 (back) performs the dancer's moves, with the same steps, spins, arm movements and timing as in @Video1. Keep @Image1's round orange body, white gloves, blue sneakers and smile exactly. Keep the studio, the lighting and the camera as in @Video1. Only one mascot in the frame. Its body stays solid and well-proportioned, with no flicker.

### Example 6: Put yourself in place of the presenter
- **Clip:** 8 s. One person talks to the camera in a living room. → **82 credits at 720p**.
- **Mode:** Objects swap. Target: Person.
- **Images:** @Image1 your face close-up (front, sharp, even light) · @Image2 you, full body, in the outfit you want.
- **Instruction:**
> Replace the woman talking to the camera with the person from @Image1 (face) and @Image2 (full body): the same face, skin tone, hair and the navy blazer from @Image2. The original woman never appears in any frame. The person from @Image1 keeps her gestures, head movements, mouth movements, posture and timing exactly as in @Video1. Keep the sofa, the living room, the light and the camera exactly as in @Video1. Face stable from the first frame to the last, no flicker.
- **Note:** the voice is your clip's original sound. To speak in your own voice, record yourself and use your own clip.

### Example 7: Outfit swap
- **Clip:** 6 s. A woman walks past a shop window in a grey jacket. → **82 credits at 720p**.
- **Mode:** Objects swap. Target: Outfit.
- **Images:** @Image1 your hoodie laid flat, front · @Image2 the hoodie, back · @Image3 close-up of the chest logo patch.
- **Instruction:**
> Replace only the grey jacket the woman wears with the hoodie in @Image1 (front) and @Image2 (back): the same sand colour, kangaroo pocket and drawstrings, with the logo patch from @Image3 on the chest. It fits her naturally and moves with her walk. Keep her face, hair, jeans, shoes, bag and walk exactly as in @Video1. Keep the street, the shop window and the camera exactly as in @Video1. The patch exactly as in @Image3, never redrawn.

### Example 8: Modest-wear walk, garment with fine detail
- **Clip:** 5 s. Full-body walk toward the camera in a black abaya. → **41 credits at 720p**. A good first test.
- **Mode:** Objects swap. Target: Outfit.
- **Images:** @Image1 your abaya on a mannequin, front, full length · @Image2 back · @Image3 close-up of the embroidered sleeve cuff.
- **Instruction:**
> Replace the black abaya with the abaya in @Image1 (front) and @Image2 (back): the same deep olive fabric, full length, wide sleeves, with the gold embroidery from @Image3 on both cuffs. The fabric flows with her steps as in @Video1. Keep her face, headscarf, hands, shoes, walk and the camera exactly as in @Video1. The embroidery pattern exactly as in @Image3.

### Example 9: Café background becomes a night market
- **Clip:** 8 s. A woman sips tea at a café window seat. → **82 credits at 720p**.
- **Mode:** Objects swap. Target: Background.
- **Images:** @Image1 a wide photo of a night market, string lights, no people up close.
- **Memm writes first (automatic):** *"In @Video1 replace the background with the background shown in @Image1. Keep the camera, framing, motion and timing exactly unchanged, and keep everything this instruction does not ask to change exactly as it is. No new subtitles or added text."*
- **Instruction:**
> The new background behind the woman is the night market from @Image1: the stalls, the warm string lights and the evening sky. The warm light from the stalls falls softly on her face and hands. Keep the woman, her face, hair, clothes, cup and every movement exactly as in @Video1. No people in the background close to the camera.

### Example 10: Two friends, swap the product one of them holds
- **Clip:** 7 s. Two friends at a picnic. The woman on the right lifts a juice bottle. → **82 credits at 720p**.
- **Mode:** Objects swap. Target: Product. Which person: "the woman on the right in the white T-shirt" (she holds it). Memm's sentence then reads "replace the product held by the woman on the right in the white T-shirt…".
- **Images:** @Image1 your juice bottle, front · @Image2 three-quarter view.
- **Instruction:**
> Replace only the orange juice bottle held by the woman on the right (white T-shirt, curly hair) with the bottle in @Image1 (front) and @Image2 (side): the same clear bottle, green cap and label. Same size and position, held the same way. Keep the woman on the left in the yellow dress, both faces, both outfits, the blanket, the park and the camera exactly as in @Video1. The label exactly as in @Image1.

### Example 11: Motion transfer with your character in your location
- **Clip:** 10 s. A man does a simple greeting dance in an empty studio. → **82 credits at 720p**.
- **Mode:** Motion transfer.
- **Images:** @Image1 your brand ambassador, full body · @Image2 your shop interior, wide, empty.
- **Instruction:**
> The man in @Image1 performs the dancer's moves, with the same steps, waves and timing as in @Video1, inside the shop shown in @Image2. Keep @Image1's face, beard, white shirt and navy trousers exactly. The shop keeps its shelves, wooden floor and warm light from @Image2. Follow the camera moves of @Video1. Only one man in the frame. Face stable, natural hands.

### Example 12: Car swap on a library clip
- **Clip:** Motion Library, "Supercar on a wet city street", 13.04 s. → **123 credits at 720p** (15 s step).
- **Mode:** Objects swap. Target: Other → "the supercar".
- **Images:** @Image1 your car, side · @Image2 your car, front three-quarter.
- **Instruction:**
> Replace the supercar with the car in @Image1 (side) and @Image2 (front three-quarter): the same white body, black roof, wheel design and headlights. Same size, position and speed on the road as in @Video1, with the same reflections on the wet street. Keep the street, the buildings, the rain, the lights and the camera exactly as in @Video1. The badge exactly as in @Image2, not redrawn.

### Example 13: Food in a hand
- **Clip:** 6 s. Close-up: a hand lifts a burger and turns it toward the camera. → **82 credits at 720p**.
- **Mode:** Objects swap. Target: Product.
- **Images:** @Image1 your sandwich, front, on a plain plate · @Image2 a cut view showing the filling.
- **Instruction:**
> Replace the burger in the hand with the sandwich in @Image1: the same toasted brown bread, lettuce, tomato and the filling seen in @Image2. Same size and position as the burger, held the same way, fingers natural. It turns toward the camera exactly as the burger does in @Video1. Keep the hand, the sleeve, the table and the camera exactly as in @Video1. Do not add steam, sauce or toppings that are not in the photos.

### Example 14: Landscape clip into a reel, product on the right
- **Clip:** 9 s, 1920×1080 landscape. A man on the right of the frame pours from a coffee pot. → **82 credits at 720p**. At 720p the reel crop is fine; at 1080p it may look soft (see 2.4).
- **Settings:** Objects swap · Shape: reel (9:16) · Crop: **right** (so the man and the pot stay in the frame).
- **Images:** @Image1 your coffee pot, front · @Image2 side view.
- **Instruction:**
> Replace the steel coffee pot in the man's hand with the coffee pot in @Image1 (front) and @Image2 (side): the same matte black body, wooden handle and long spout. Same size and position as the original pot, held and tilted the same way, the coffee pouring from its spout as in @Video1. Keep the man, his face, apron, hands and pouring movement exactly as in @Video1. Keep the counter and the camera as in @Video1.

---

## 6. When it goes wrong: failure → fix

Before you run it again, fix the cause. Running the same instruction again usually gets the same mistake, and costs the full price again.

| What you see | Likely cause | Fix |
|---|---|---|
| **The wrong person or object changed** | The target was not specific enough. | Name it by position plus 2 or 3 visible features ("the man on the left in the white shirt"). Set **What changes** and, with 2 or more people, **Which person** (on a library clip, pick from its cast list and reuse its words). Name the other people and say to keep them. |
| **The person you kept has a different face** | Nothing told the model to protect them. Motion transfer rebuilds the whole shot. | Add "Keep [the person on the right in the red dress] exactly as she is." If only one thing should change, prefer Objects swap. |
| **The label is garbled or redrawn** | The label in the photo was small, blurred or at an angle. Text is a weak point of video models. | Use a sharp front photo with the label large and readable. Add a label close-up as another image. Write "the label exactly as in @Image1, never redrawn". Never ask the model to write new text. |
| **The product is the wrong size** | No size was given, or the original object is a very different size. | "Same size and position as the [cup] throughout." Pick a clip where the original object has a similar size and shape. |
| **The background drifted or changed** | In Motion transfer the scene is rebuilt. Some words also invited a change ("new place", "cooler light"). | "Keep the background, the lighting and the camera exactly as in @Video1." Remove words that hint at a new place. To control a new place, give it a photo. |
| **Hands and fingers look wrong** | Fast hand moves, a hidden grip, or a product much bigger or smaller than the original. | Choose a clip with a slow, visible grip. "Held the same way, fingers wrapped naturally, five fingers on each hand." Keep the hand on the keep list. |
| **Flicker or melting detail** | Fast motion, many cuts, low light, or too many photos. | Trim to a calm part. Use 1 to 4 sharp photos. Add "stable from the first frame to the last, no flicker". Try 1080p for fine detail, after the 720p test works. |
| **Motion transfer ignored your character** | The character photo was unclear, the character wasn't in @Image1, or the photos were collages. | Put the character first (@Image1) as a clean full-body photo, plus a face close-up. Say what to take ("face, hair, outfit and colours exactly"). Remove extra images that compete with it. |
| **The same character appears twice** | Similar people in the clip, or character sheets used as photos. | One person per photo, no sheets. Add "Only one [mascot] in the frame." |
| **Subtitles or random text appeared** | The clip had captions, or the instruction mentioned words. | Use a clip with no text on screen. Memm already tells the model "No new subtitles or added text", so remove any quoted words from your instruction. |
| **The new person wears the old clothes, or the wrong ones** | It wasn't clear which clothes to use. | A person photo sets the whole look. Use a full-body photo in the clothes you want, or add the outfit as its own photo. To keep the clip's clothes, write "keep the clothes from @Video1". |
| **Two replaced people swapped or blended faces** | Both replacements were in one sentence, or the photos were similar. | One sentence per person, each with its own photo. Add "Each keeps their own face; the faces never swap, merge or appear twice." |
| **The original object shows through for a moment** | It was hidden, mirrored or behind a cut at that moment. | Add "in every frame, including after cuts and in reflections". Trim out the hidden moments. |
| **Too busy: nothing came out clean** | 3 or more people, a crowd, many props or many changes at once. | Pick a simpler clip, or trim to the part with your target. Make one change per take. |
| **Glowing eyes or odd effects** | Strong emotion words ("furious", "ecstatic"). | Use calm, visible actions: "she smiles", "he nods". |

---

## 7. Save credits

1. **Test at 720p, then make it in 1080p.** Run the first take at 720p. When the instruction works, press **"Make it in 1080p"**. For a 10 s clip that's 82 credits for the test, then 161 for the final. A failed first try at 1080p costs 161. The 1080p take is a new render, so small details can differ from the test. The test proves your clip, photos and instruction work.
2. **Trim to the moment.** Keep only the seconds you need, just under a price step (2.2). Shorter clips are also easier for the model.
3. **Start with a 5 s piece.** Proving an instruction on a 5 s cut costs 41 credits at 720p. Then run the full clip.
4. **Use the Motion Library.** Those clips are measured and ready, and clips with 2 or more people come with a cast list, so picking which person takes one tap. Check the seconds badge first.
5. **Fix the cause, not the luck.** Read the failure table, change one thing (the target name, a photo, the keep list), then run again.
6. **One change per take.** Two clean takes beat one take with three changes that all come out half right.
7. **Don't try what the model can't do:**
   - write text, prices, slogans or captions on screen
   - change the camera move or the length in Objects swap
   - replace something that is tiny, mostly hidden, or in the frame for only a second
   - more than 4 people interacting, or fast fights, flips and spins with a swapped face
   - famous people or well-known characters (the review can refuse them)
   - new music or new dialogue (the sound comes from your clip)

---

## 8. Cheat sheet

**MODE**
- One thing changes, the rest is real footage → **Objects swap**
- Same moves, new character or new world → **Motion transfer**

**CLIP**
- 4 to 30 s, MP4 or MOV, up to 200 MB, 24 to 60 fps. A Library move works too.
- Price per step: 5 s · 10 s · 15 s · 20 s · 30 s. At **720p**: 41 · 82 · 123 · 164 · 246 credits. At **1080p**: 81 · 161 · 242 · 322 · 483 credits.
- Trim just under a step. One clear target, calm motion, one shot, even light, no captions.
- The output is a reel (9:16) by default. Objects swap crops a landscape clip: choose left, center or right. The sound is your clip's own.

**SETTINGS**
- **What changes** (target): Product, Person, Outfit, Background or Other. Every Objects swap needs it.
- **Which person** (who): only with 2 or more people. Always a person, never an object. On library clips, use the cast list's words.

**IMAGES**
- @Image1 = first in the strip = the most important.
- Product: sharp front with the label readable, three-quarter view, back. Plain background.
- Person: face close-up + full body. One person per photo, no collages or sheets.
- Usually 1 to 4 images. At least 400 px on the short side.

**INSTRUCTION** (English, 4 to 7 short sentences)
1. **Target:** "the [colour/clothing/shape] [thing] [position] in @Video1"
2. **Replacement:** "becomes / is replaced with the [thing] in @Image1 (front) and @Image2 (side): same [key features]"
3. **Other change** *(optional, one)*: "Change only the background to @Image3."
4. **Keep:** "Keep [other people], the face, hands, moves, camera, timing and background exactly as in @Video1."
5. **Quality:** "Same size and position as the [original]. Natural hands. The label exactly as in @Image1, never redrawn. Stable, no flicker."

Memm adds "No new subtitles or added text" for you. A person photo sets the whole look (face, hair, clothes); @Video1 gives the moves, the camera and the timing.

**NEVER**
- on-screen text
- contradictions
- "reference @Video1" in Objects swap
- vague words
- many changes at once
- music or voices

**STUCK?** Press "Help me write it". It writes in English from your Arabic or English answers and costs no credits.

**SAVE**
- Test at 720p → "Make it in 1080p".
- Fix the cause before you run it again.

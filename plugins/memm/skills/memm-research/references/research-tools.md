<!-- Copied from memm-skills/shared/research-tools.md by scripts/build-memm-plugin.ts. Edit the source, then run: npm run plugin:build -->
# Research tools in each client

Use only tools that are actually available in this session. Never say you searched or read a page if you did not.

## Claude Code

- **WebSearch** finds pages; **WebFetch** reads one URL. Both may ask the user for permission. WebSearch can be unavailable (some cloud providers, organisation policy); WebFetch can be turned off.
- Other connected research tools (for example Firecrawl, Similarweb, Meta Ad Library) only if they are connected in this session and the user agrees. They may cost the user money on that service: say so first.

## Codex (app, CLI, IDE extension)

- Codex has a built-in **web search** tool. Its default mode is `cached` (results from an index, which may be older). For fresh results the user starts Codex with `codex --search` or sets `web_search = "live"` in `~/.codex/config.toml`. If results look stale or the tool is missing, tell the user how to turn it on; do not pretend.
- Reading a specific page from the shell (`curl`) works only if the sandbox allows network access; ask before changing sandbox settings.

## Memm's own sources (always free)

- `memm_list_brands` / `memm_get_brand`: the user's saved brand profiles (colours, fonts, benefits, imagery). Label as `[user: Memm library]`.
- `memm_list_products`: the user's product library and reference photos.
- `memm_search_gallery`: Memm's public showcase. These are examples of what Memm can make, not market evidence about the user's business.

## When no web tool is available

Say which tool is missing and how to enable it. Then ask the user for the links, screenshots, pasted text or files you need, and continue with what you have. Mark every section you could not research as `not researched`.

## Good research order (adapt to the business)

1. The business's own site: home, product pages, about, pricing, delivery/returns, contact, any blog.
2. Its public social profiles and marketplace listings.
3. Public reviews (maps listings, marketplaces, review sites).
4. Three nearest competitors: same category, same country or city, similar price. Find them by search, not guesswork; say how you chose them.
5. Public ad libraries, if accessible, for the business and competitors (what they run, not how it performs).
6. Category context: seasonality, regulation, cultural timing (Ramadan, Eid, national days), only when relevant.

Stop when more sources would not change the recommendation. Log each page in `evidence.md` as you read it.

---
name: listing-scrape
description: Scrape a rental or real-estate listing page with lightpanda and turn it into facts on a prospect file. Use when given a listing URL (rentals.ca, Zumper, PadMapper, Condos.ca, a building site), when pasting listing text or a screenshot to be captured, or when asked whether a place is worth viewing. Judging the listing is a separate step this skill does not perform.
---

# Listing Scrape

Fetch a rental listing and turn it into facts.

## What this skill is, and is not

**This skill gets a listing page and extracts what it says.** That is the whole job: fetching, parsing, and recording, including the parts that are hard because sites defend themselves and marketing copy lies.

**It does not judge the listing.** Gates, scores, statuses, decision rules, and where a row goes on a board all belong to the consuming repo's own scoring or playbook docs, and none of it is repeated here.

## Where things go

This skill is shared across repos and does not know any repo's layout. Before writing anything:

1. **Look for the repo's own conventions** — a playbook or scoring doc, a requirements spec, a prospect template, an existing prospect file to pattern-match against. Follow what you find rather than improvising.
2. **If the repo defines a prospect template, use it.** This skill deliberately does not carry one.
3. **If nothing in the repo says where prospect files live, ask** rather than inventing a path.

Read those docs at the point you judge the listing, and follow them rather than any remembered version. **A stale copy of a rule is worse than a pointer to it** — gates and rent bases change often.

## Fetch method

Try markdown first, fall back to HTML.

**Step 1 — markdown:**

```bash
lightpanda fetch '<url>' --dump markdown --wait-until networkidle
```

**Step 2 — if step 1 returns no content, fall back to HTML:**

```bash
lightpanda fetch '<url>' --dump html --wait-ms 5000 2>/dev/null
```

Read the raw HTML and pull the listing out of wherever it lives: JSON-LD (`RealEstateListing` or `Product` schema, usually the richest source on these sites), meta tags, `__NEXT_DATA__` or similar hydration blobs, or body text.

## When the fetch fails

Real estate sites defend themselves harder than job boards do, so expect this to fail more often than a careers page. Known behaviour:

- **Realtor.ca (CREA)** blocks automated clients aggressively and its terms prohibit scraping. Assume it will not work and do not build retries around it.
- **HouseSigma and Condos.ca** require login for most detail and sit behind bot protection.
- **Rentals.ca, Zumper, PadMapper, and individual building sites** are the ones most likely to actually return content.
- **Facebook Marketplace** needs a session and will not work.

**Do not escalate.** No proxies, no user-agent spoofing, no retry loops, no bulk crawling of search-result pages. This skill is for pulling one listing already being looked at, which is ordinary personal use. Grinding through a site's defences or harvesting listings in bulk is not, and it is how an account or an IP gets banned in the middle of a search.

When a fetch fails, say so plainly and ask for the listing text or a screenshot instead. Everything below the fetch works identically on pasted content, so this is a mild inconvenience rather than a dead end.

## What to extract

Pull whatever the page actually has. Never infer a number that is not stated: unknown is a valid and useful answer, and a wrong square footage is worse than a blank one.

- Address, building name, neighbourhood, unit number
- Advertised rent, and what it includes (hydro, water, heat, internet)
- Interior square footage, **excluding balcony and terrace**. If the page gives one combined number, record it and flag it as unverified
- Bedrooms and bathrooms, plus the exact wording ("2 bed", "1+den", "2BR + flex")
- Parking: included, available at a cost, or none. Note motorcycle handling if mentioned
- Locker or storage
- Year built
- Building amenities, with the gym called out specifically
- Laundry, balcony, outdoor space, orientation and exposure
- Availability date, lease term, pet policy
- Listing agent or landlord, and whether it is an individual or a management company

## Two rules that are about scraping, not judgment

These stay here because they govern what counts as a fact, which is this skill's problem:

- **Marketing copy is not evidence.** "Fitness centre", "spacious den", "800 +/-", "steps to everything" record as what they are — claims — and never as confirmed facts. Only a stated, specific figure or an explicit inclusion counts.
- **Record the exact wording** for anything ambiguous: bedrooms, parking, square footage, what the rent includes. The judgment gets made later against what the listing actually said, not against a paraphrase.

## Output

Write a prospect file using the repo's template, filling the factual sections and turning the gaps into specific unanswered questions so they actually get asked at a viewing. **Leave blank whatever the page did not say.** A blank is a useful signal; an invented number is not.

Then hand off: read the repo's scoring or playbook doc and follow it to fill the gate line, the scores, the status, and any roster row. That step is governed there, not here.

## Report back

Short. Do not restate the file.

- Address, advertised rent and what it includes, square footage, bedrooms as worded, parking, locker, year built
- **What the page did not say**, which is usually fibre, the gym equipment, and a real interior square footage
- Anything the listing contradicted itself on. The site's data tables and its descriptions disagree often enough to be worth flagging every time
- Then the gate line, score, and verdict as the repo's scoring doc defines them

Hold whatever reporting guardrails the repo's `AGENTS.md` sets when reporting.

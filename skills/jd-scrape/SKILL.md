---
name: jd-scrape
description: Scrape a job description or careers listing page with lightpanda and record what the posting actually says as structured facts. Use when given a JD or careers-page URL, when pasting job posting text to be captured, or when asked to save or pull a job posting. Judging the role is a separate step this skill does not perform.
---

# JD Scrape

Fetch a listing and turn it into facts. Scrape a job description or careers listing page, record what the posting actually says, and file it.

## What this skill is, and is not

This skill records what the posting says. It does not evaluate it.

**In scope:** fetching the page, extracting the posting's own content, normalizing it into a structure, saving the file.

**Out of scope:** fit assessments, gates, scores, statuses, decision rules, and board or roster placement. Do not write a fit verdict into the JD file, do not filter or rank roles by relevance, and do not add or edit a roster row. Those are downstream decisions governed by the consuming repo's own scoring or playbook docs, not by the scrape.

If the posting itself states something (a required language, a comp band, a seniority level), record it verbatim as a fact. Judging what that means is a separate step.

## Where things go

This skill is shared across repos and does not know any repo's layout. Before writing anything:

1. **Look for the repo's own conventions** — a playbook, a scoring doc, a templates directory, an existing JD file to pattern-match against. Follow what you find rather than the defaults below.
2. **If the repo defines a JD template, use it** in place of the structure in this file.
3. **If nothing in the repo says where JDs live, ask** rather than inventing a path.

## Fetch method

Try markdown first. If empty, fall back to HTML and extract from meta tags.

**Step 1 — markdown:**

```bash
lightpanda fetch '<url>' --dump markdown --wait-until networkidle
```

**Step 2 — if step 1 returns no content, fall back to HTML and read it directly:**

```bash
lightpanda fetch '<url>' --dump html --wait-ms 5000 2>/dev/null
```

Read the raw HTML output and extract the job content from wherever it lives: meta tags, JSON-LD, body text, or noscript blocks.

## When the fetch fails

Say so plainly and ask for the posting text or a screenshot instead. Everything below the fetch works identically on pasted content.

**Do not escalate.** No proxies, no user-agent spoofing, no retry loops, no bulk crawling of search-result pages. This skill is for pulling one posting already being looked at, which is ordinary personal use. Grinding through a site's defences or harvesting postings in bulk is not.

## If the URL is a single JD page

Format the scraped content into this structure, unless the repo defines its own:

```markdown
# Company — Role Title

**URL:** <original url>
**Location:** <location> — **<on-site|hybrid|remote>**
**Employment:** Full time
**Referral:** — (none)

## About <Company>

<2–3 sentence company description>

## Role Summary

<1–2 sentence summary>

## What You'll Do

<bullet list>

## What They're Looking For

<bullet list>

## Bonus

<nice-to-have skills if listed>

## Tech Stack

**Frontend:** ...
**Backend:** ...
**Infrastructure:** ...

## What They Offer

<comp, equity, benefits — one line>
```

**Leave blank whatever the posting did not say.** A blank is a useful signal; an invented detail is not.

Report the saved path. Stop there — no roster row, no status.

## If the URL is a careers listing page

Extract every visible job title, location, and URL as listed. Do not pre-filter by relevance; hand back what the board shows and let the selection happen downstream.

Present results as:

```text
**Company — Role Title**
Location · <url>
```

Then ask which roles to pull full JDs for.

## ATS listing URL patterns

- Ashby: `https://jobs.ashbyhq.com/<company>`
- Greenhouse: `https://boards.greenhouse.io/<company>`
- Lever: `https://jobs.lever.co/<company>`

## Handing off

Once the file is saved, judging it — gates, scores, status, board placement — belongs to whatever scoring or playbook doc the consuming repo defines. Read that doc at the point of judging and follow it rather than any remembered version. **A stale copy of a rule is worse than a pointer to it.**

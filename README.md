# harness-skills

Reusable Claude Code skills (`SKILL.md` per directory) extracted from project standards docs, for reuse across tkodev projects.

## Skills

- [accessibility](accessibility/SKILL.md) — WCAG 2.0 AA baseline, motion, focus, contrast
- [components](components/SKILL.md) — shadcn/CVA component authoring shape and atomic-design organization
- [data](data/SKILL.md) — content/state location and discipline (`constants/`, dates, media)
- [git](git/SKILL.md) — Conventional Commits, branch naming, no-AI-attribution
- [nextjs](nextjs/SKILL.md) — App Router conventions, runtime foundations, folder structure
- [performance](performance/SKILL.md) — LCP, lazy-loading, motion/font budgets
- [process](process/SKILL.md) — delivery methodology: PRD pipeline, milestones, tasks, review tiers
- [seo](seo/SKILL.md) — metadata, Open Graph, crawlable content
- [testing](testing/SKILL.md) — testing strategy stance
- [writing](writing/SKILL.md) — house style for docs, plans, PR/commit bodies

## Origin

Source: `docs/01-standards/*.md`, cross-checked across three sibling repos (`tkodev-web-v5`, `kindred-web`, `boilerplate-web`) that all carry the same standards set. `nextjs`, `process`, `seo`, `testing`, and `writing` are byte-identical across all three. `accessibility`, `components`, `data`, `git`, and `performance` differed slightly; `kindred-web` and `boilerplate-web` agreed with each other and used more portable phrasing than `tkodev-web-v5` (no career-notes references, no "v5 tokens"/"futuristic layer"), so those versions were merged in. Each skill was generalized just enough to drop any remaining hard references to a specific repo (e.g. `docs/02-prd/` treated as an example convention) while keeping the concrete rules intact. Re-sync manually if the source docs change.

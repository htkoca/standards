# harness-skills

Reusable agent skills (`SKILL.md` per directory) for project standards, packaged as a
Claude Code plugin.

## Skills

- [accessibility](skills/accessibility/SKILL.md) — WCAG 2.0 AA baseline, motion, focus, contrast
- [claude](skills/claude/SKILL.md) — Claude Code repo hygiene (CLAUDE.md symlink, gitignoring local state)
- [components](skills/components/SKILL.md) — shadcn/CVA component authoring shape and atomic-design organization
- [data](skills/data/SKILL.md) — content/state location and discipline (`constants/`, dates, media)
- [engineering](skills/engineering/SKILL.md) — harness engineering: the bundled corpus and routing for unresolved agent-design decisions
- [estimation](skills/estimation/SKILL.md) — sizing work
- [figma](skills/figma/SKILL.md) — reading designs out of Figma: node structure over screenshots
- [git](skills/git/SKILL.md) — Conventional Commits, branch naming, no-AI-attribution
- [jd-scrape](skills/jd-scrape/SKILL.md) — scraping a job posting or careers page into structured facts
- [listing-scrape](skills/listing-scrape/SKILL.md) — scraping a rental/real-estate listing into structured facts
- [nextjs](skills/nextjs/SKILL.md) — App Router conventions, runtime foundations, folder structure
- [performance](skills/performance/SKILL.md) — LCP, lazy-loading, motion/font budgets
- [process](skills/process/SKILL.md) — delivery methodology: PRD pipeline, milestones, review tiers
- [seo](skills/seo/SKILL.md) — metadata, Open Graph, crawlable content
- [testing](skills/testing/SKILL.md) — testing strategy stance
- [vscode](skills/vscode/SKILL.md) — editor-session hygiene (reopen after a move/rename)
- [writing](skills/writing/SKILL.md) — the writing standard: Orwell + STE, anti-slop, assistant tone, house rules

## Installing

This repo is both a plugin and its own marketplace, so it installs directly from
GitHub:

```sh
/plugin marketplace add htkoca/skills
/plugin install harness-skills@htkoca
```

Plugin skills are namespaced by plugin name, so they invoke as
`/harness-skills:nextjs`, `/harness-skills:git`, and so on. Claude also picks them
up automatically when a task matches a skill's `description`.

Pull updates with `/plugin marketplace update`.

### Versioning

[`plugin.json`](.claude-plugin/plugin.json) deliberately sets no `version`. Claude
Code then falls back to the git commit SHA, so every pushed commit is treated as a
new version and installs track the latest state of the default branch — no version
bump step to remember. The tradeoff is that there are no pinnable releases: a user
cannot ask for a specific version, and updates always move to the tip. Add a
`version` field if that ever matters.

## Layout

Standard Claude Code plugin structure:

```text
.claude-plugin/
  plugin.json         plugin manifest (name, metadata; no version by design)
  marketplace.json    marketplace catalog listing this repo as its own plugin
skills/
  <name>/SKILL.md     one directory per skill
```

The `skills/` directory is scanned by default, so the manifest needs no `skills`
field — and adding one would replace that default scan rather than extend it, since
the marketplace entry's `source` resolves to the marketplace root.

## Other agent tools

The `<name>/SKILL.md` convention is shared: Codex scans `.agents/skills/`, and
OpenCode reads both `.claude/skills/` and `.agents/skills/` as compatibility
fallbacks plus its own `.opencode/skills/`. The plugin mechanism above is
Claude-Code-specific, so reaching those tools means symlinking or vendoring
`skills/<name>` into the relevant directory. If you do symlink into a local clone,
gitignore one entry per linked skill rather than the whole `skills/` directory, so
a consuming repo's own skills stay tracked.

Codex also reads `AGENTS.md` at the repo root for persistent instructions. This
repo's own [AGENTS.md](AGENTS.md) documents rules for working in *this* repo;
reference it from a consuming project's `AGENTS.md` rather than merging its
content in.

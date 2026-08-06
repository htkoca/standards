# standards

Reusable agent skills (`SKILL.md` per directory) for project standards, packaged as a
Claude Code plugin.

## Skills

Seventeen, in four groups.

### Code

- [nextjs](skills/nextjs/SKILL.md) — App Router conventions, runtime foundations, folder structure
- [components](skills/components/SKILL.md) — shadcn/CVA component authoring shape and atomic-design organization
- [data](skills/data/SKILL.md) — content/state location and discipline (`constants/`, dates, media)
- [testing](skills/testing/SKILL.md) — testing strategy stance
- [performance](skills/performance/SKILL.md) — LCP, lazy-loading, motion/font budgets
- [accessibility](skills/accessibility/SKILL.md) — WCAG 2.0 AA baseline, motion, focus, contrast
- [seo](skills/seo/SKILL.md) — metadata, Open Graph, crawlable content

### Craft

- [writing](skills/writing/SKILL.md) — the writing standard: Orwell + STE, anti-slop, assistant tone, house rules. **Always on**, see [Always-on skills](#always-on-skills)
- [git](skills/git/SKILL.md) — Conventional Commits, branch naming, no-AI-attribution
- [process](skills/process/SKILL.md) — delivery methodology: PRD pipeline, milestones, review tiers
- [estimation](skills/estimation/SKILL.md) — sizing work
- [figma](skills/figma/SKILL.md) — reading designs out of Figma: node structure over screenshots
- [vscode](skills/vscode/SKILL.md) — editor-session hygiene (reopen after a move/rename)
- [claude](skills/claude/SKILL.md) — Claude Code repo hygiene (CLAUDE.md symlink, gitignoring local state)

### Agents

- [engineering](skills/engineering/SKILL.md) — harness engineering: the bundled corpus and routing for unresolved agent-design decisions

### Scrapers

- [jd-scrape](skills/jd-scrape/SKILL.md) — scraping a job posting or careers page into structured facts
- [listing-scrape](skills/listing-scrape/SKILL.md) — scraping a rental/real-estate listing into structured facts

## Always-on skills

Skills load on demand: Claude matches the task against each skill's `description` and
reads the ones that fit. That is right for every skill here except one.

[writing](skills/writing/SKILL.md) governs prose the agent produces whether or not a
writing task was requested, including its own chat replies, so on-demand loading
misses most of the cases it should cover. The plugin ships a `UserPromptSubmit` hook
that injects a compact form of the standard on every prompt:

```text
hooks/
  hooks.json            UserPromptSubmit → cat the compact standard
  writing-always.txt    the injected text: ~20 lines, the rules without the reasoning
```

The hook activates when the plugin is installed and needs no per-repo setup. It costs
about 250 tokens per prompt, which is why the injected file is a summary and the full
standard stays in `SKILL.md` for anything longer than a short reply. Keep the two in
step when either changes.

## Installing

This repo is both a plugin and its own marketplace, so it installs directly from
GitHub. Add the marketplace, then install the plugin from it — how you do that
depends on the surface:

- **Claude Code CLI** — run in chat:

  ```sh
  /plugin marketplace add htkoca/standards
  /plugin install standards@htkoca
  ```

- **Claude Code in VS Code** — run `/plugin` in chat, then: marketplaces → add the
  standards git repo → install the standards plugin from it.
- **Claude Code and Claude chat, desktop app** — click customize, then: marketplaces
  → add the standards git repo → install the standards plugin from it.

Plugin skills are namespaced by plugin name, so they invoke as
`/standards:nextjs`, `/standards:git`, and so on. Claude also picks them
up automatically when a task matches a skill's `description`.

Each surface installs its own copy. Installing on one does not install on the rest,
and neither does updating — see below.

### Updating

Installs do **not** track `main`. Claude Code copies the plugin into
`~/.claude/plugins/cache/<marketplace>/<plugin>/<sha>/` at install time and pins it
to that commit SHA. The copy is a flat snapshot, not a git checkout, so pushing here
changes nothing on an already-installed machine.

Two steps, per machine:

```sh
/plugin marketplace update htkoca   # pull the marketplace clone
/plugin update standards@htkoca     # re-snapshot the plugin
```

The first alone is not enough — it refreshes the catalog, not the installed skills.

### Versioning

[`plugin.json`](.claude-plugin/plugin.json) carries a `version`, bumped by **patch**
on every commit. Minor and major are set by hand, by the repo owner only. See
[CLAUDE.md](CLAUDE.md) for the rule agents follow.

The version is diagnostic rather than a release channel: updates always move to the
tip of `main`, and there is no way to install a pinned older version. What it buys
is a readable answer to "is this install current?" — compare the `version` here
against the entry for `standards@htkoca` in
`~/.claude/plugins/installed_plugins.json`, which records both the resolved version
and the `gitCommitSha` it was taken from.

## Layout

Standard Claude Code plugin structure:

```text
.claude-plugin/
  plugin.json         plugin manifest (name, version, metadata)
  marketplace.json    marketplace catalog listing this repo as its own plugin
skills/
  <name>/SKILL.md     one directory per skill
hooks/
  hooks.json          hook config, loaded automatically from this path
  writing-always.txt  text injected on every prompt (see Always-on skills)
```

The `skills/` directory is scanned by default, so the manifest needs no `skills`
field — and adding one would replace that default scan rather than extend it, since
the marketplace entry's `source` resolves to the marketplace root.

## Consuming repos

[CLAUDE.md](CLAUDE.md) documents rules for working in *this* repo. Reference it
from a consuming project's `CLAUDE.md` rather than merging its content in.

These skills target Claude Code only. There is no `AGENTS.md` here, and no
vendoring path for Codex or OpenCode.

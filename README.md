# software-skills

Reusable agent skills (`SKILL.md` per directory) for project standards, portable across projects and usable from Claude Code, Codex, and OpenCode.

## Skills

- [accessibility](accessibility/SKILL.md) — WCAG 2.0 AA baseline, motion, focus, contrast
- [claude](claude/SKILL.md) — Claude Code repo hygiene (CLAUDE.md symlink, gitignoring local state)
- [components](components/SKILL.md) — shadcn/CVA component authoring shape and atomic-design organization
- [data](data/SKILL.md) — content/state location and discipline (`constants/`, dates, media)
- [decisions](decisions/SKILL.md) — when to consult the harness-engineering corpus for an unresolved agent-design decision
- [figma](figma/SKILL.md) — reading designs out of Figma: node structure over screenshots
- [git](git/SKILL.md) — Conventional Commits, branch naming, no-AI-attribution
- [nextjs](nextjs/SKILL.md) — App Router conventions, runtime foundations, folder structure
- [performance](performance/SKILL.md) — LCP, lazy-loading, motion/font budgets
- [process](process/SKILL.md) — delivery methodology: PRD pipeline, milestones, review tiers
- [seo](seo/SKILL.md) — metadata, Open Graph, crawlable content
- [testing](testing/SKILL.md) — testing strategy stance
- [vscode](vscode/SKILL.md) — editor-session hygiene (reopen after a move/rename)
- [writing](writing/SKILL.md) — house style for docs, plans, PR/commit bodies

## Using this from another repo

This repo isn't meant to be worked in directly by a project. **Check for a
local copy first**: if this repo is already cloned somewhere on the machine,
symlink straight to it instead of vendoring a second copy — one clone can
serve every local project. If no local copy exists, ask where one should
live, or vendor it in (git submodule, subtree, or plain clone, e.g. at
`vendor/software-skills`).

Either way, link the skills into each tool's own skills directory. Claude
Code, Codex, and OpenCode all use the identical `<name>/SKILL.md` convention,
just under different root folders, so one copy serves all three:

- **Claude Code** scans `.claude/skills/<name>/SKILL.md`.
- **Codex** scans `.agents/skills/<name>/SKILL.md` (repo root or current
  directory).
- **OpenCode** scans both of the above as compatibility fallbacks, plus its
  own `.opencode/skills/<name>/SKILL.md` — symlinking into `.claude/skills`
  or `.agents/skills` already covers it, no extra step needed.

**Link each skill individually, not the whole directory.** Symlinking this repo's
root onto `.claude/skills` works, but it takes the whole directory hostage: the
consuming repo can then only have the shared skills, with nowhere to put one of
its own. Linking per skill keeps `skills/` a real directory that holds shared
and per-repo skills side by side.

[`link-skills.sh`](link-skills.sh) does this, and regenerates the `.gitignore`
block that goes with it:

```sh
/path/to/software-skills/link-skills.sh /path/to/target-repo
```

It creates `.claude/skills/<name>` and `.agents/skills/<name>` symlinks for every
skill here, and leaves any real directory it finds — a repo's own skill — alone.
Re-run it after adding or renaming a skill in this repo. To expose only a subset,
link those by hand instead:

```sh
software_skills=/path/to/software-skills   # local clone or vendored copy

mkdir -p .claude/skills .agents/skills
ln -s "$software_skills/nextjs" .claude/skills/nextjs
ln -s "$software_skills/nextjs" .agents/skills/nextjs
```

**Gitignore the symlinks, not the directory.** A symlink into a local clone holds
that machine's absolute path, so committing it breaks every other clone — but
ignoring `.claude/skills` wholesale would also ignore the repo's own skills. Ignore
one entry per linked skill (`.claude/skills/nextjs`, …), which is what
`link-skills.sh` writes into its managed block, and anything else under `skills/`
stays tracked. A symlink into a *vendored* copy (a submodule or subtree checked in
at a relative path) is portable and can be committed as-is.

For distributing to many repos or teams without vendoring, both tools also
support packaged, centrally-updatable distribution: Claude Code via a
`.claude-plugin/marketplace.json` (`/plugin marketplace add`), Codex via its
own plugin format. Heavier to set up than symlinking, but versioned and
updated in one place.

Codex also reads `AGENTS.md` at the repo root for persistent instructions.
This repo's own [AGENTS.md](AGENTS.md) documents rules for working in *this*
repo; reference it from a consuming project's `AGENTS.md` rather than merging
its content in.

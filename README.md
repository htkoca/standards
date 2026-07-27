# harness-skills

Reusable agent skills (`SKILL.md` per directory) for project standards, portable across projects and usable from Claude Code, Codex, and OpenCode.

## Skills

- [accessibility](accessibility/SKILL.md) — WCAG 2.0 AA baseline, motion, focus, contrast
- [components](components/SKILL.md) — shadcn/CVA component authoring shape and atomic-design organization
- [data](data/SKILL.md) — content/state location and discipline (`constants/`, dates, media)
- [git](git/SKILL.md) — Conventional Commits, branch naming, no-AI-attribution
- [nextjs](nextjs/SKILL.md) — App Router conventions, runtime foundations, folder structure
- [performance](performance/SKILL.md) — LCP, lazy-loading, motion/font budgets
- [process](process/SKILL.md) — delivery methodology: PRD pipeline, milestones, review tiers
- [seo](seo/SKILL.md) — metadata, Open Graph, crawlable content
- [testing](testing/SKILL.md) — testing strategy stance
- [vscode](vscode/SKILL.md) — editor-session hygiene (reopen after a move/rename)
- [writing](writing/SKILL.md) — house style for docs, plans, PR/commit bodies

## Using this from another repo

This repo isn't meant to be worked in directly by a project; vendor it in
(git submodule, subtree, or plain clone, e.g. at `vendor/harness-skills`) and
link the skills into each tool's own skills directory. Claude Code, Codex,
and OpenCode all use the identical `<name>/SKILL.md` convention, just under
different root folders, so one vendored copy serves all three:

- **Claude Code** scans `.claude/skills/<name>/SKILL.md`.
- **Codex** scans `.agents/skills/<name>/SKILL.md` (repo root or current
  directory).
- **OpenCode** scans both of the above as compatibility fallbacks, plus its
  own `.opencode/skills/<name>/SKILL.md` — symlinking into `.claude/skills`
  or `.agents/skills` already covers it, no extra step needed.

Symlink the skills a project needs into both:

```sh
for d in vendor/harness-skills/*/; do
  name=$(basename "$d")
  [ -f "$d/SKILL.md" ] || continue
  ln -s "../../$d" ".claude/skills/$name"
  ln -s "../../$d" ".agents/skills/$name"
done
```

For distributing to many repos or teams without vendoring, both tools also
support packaged, centrally-updatable distribution: Claude Code via a
`.claude-plugin/marketplace.json` (`/plugin marketplace add`), Codex via its
own plugin format. Heavier to set up than symlinking, but versioned and
updated in one place.

Codex also reads `AGENTS.md` at the repo root for persistent instructions.
This repo's own [AGENTS.md](AGENTS.md) documents rules for working in *this*
repo; reference it from a consuming project's `AGENTS.md` rather than merging
its content in.

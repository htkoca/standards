---
name: claude
description: Claude Code repo hygiene — CLAUDE.md as the single instruction file, no AGENTS.md, and gitignoring Claude Code's local-only state. Use when setting up a repo for Claude Code, or auditing one that already has a CLAUDE.md and/or AGENTS.md.
---

# Claude

Repo-level conventions for Claude Code.

1. **`CLAUDE.md` at the repo root is the one instruction file**, a real tracked
   file rather than a symlink. Claude Code is the only agent these repos target,
   so a tool-agnostic `AGENTS.md` with `CLAUDE.md` pointed at it buys nothing but
   a second path to keep straight. If a repo still has that arrangement, replace
   the symlink with the file: `git rm --cached CLAUDE.md && rm CLAUDE.md &&
   git mv AGENTS.md CLAUDE.md`, then fix any docs that linked to `AGENTS.md`. If
   neither file exists yet, don't invent one; that's a separate decision.
2. **Gitignore Claude Code's local-only state**: add `/.claude/`
   (personal permission overrides, machine-specific) to `.gitignore`. 
3. **Don't use the persistent memory system for project facts.** Status, decisions,
   and other facts that matter beyond the current conversation belong in the
   repo — the owning doc (PRD, plan, standards) or the code itself — not in
   cross-session memory. Memory drifts silently out of sync with the repo it
   describes; the repo can't. If a fact is worth remembering past this session,
   write it back to the doc that owns it (see the process skill's §Division of
   truth) instead of saving it to memory.

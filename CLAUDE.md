# Agent instructions for this repo

See [README.md](README.md) for what this repo is and how it's used from other repos.

## On every commit: bump the patch version

[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json) carries a `version`. Bump
the **patch** number in the same commit as the change — always, and without being
asked. A commit that changes a `SKILL.md`, the README, or anything else installable
must not land on the old version.

```json
"version": "0.1.0"   →   "version": "0.1.1"
```

**Minor and major are the owner's to set.** Never bump them, and never propose a
version that changes them. If a change feels like it warrants more than a patch, say
so and let them decide.

Why it matters: installs are snapshots pinned to a commit SHA, not live clones of
`main`. The version is the only readable way to tell a stale install from a current
one — compare `plugin.json` against the entry in
`~/.claude/plugins/installed_plugins.json`. Skipping the bump makes two different
plugin contents share a version, which is worse than no version at all.

Skills are consumed by agents in other repos. Treat a change here as shipping.

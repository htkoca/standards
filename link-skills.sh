#!/usr/bin/env bash
# Link every skill in this repo into a target repo, one symlink per skill, so the
# repo's own skills/ directory stays a real tracked directory that can also hold
# per-repo skills alongside the shared ones.
#
# Also regenerates the managed .gitignore block covering the symlinks: they point
# at this clone's absolute path, so they are machine-specific and must not be
# committed. Anything else under skills/ (a repo's own skill) is left tracked.
#
# Usage: ./link-skills.sh <target-repo> [...]
set -euo pipefail

SKILLS_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[ $# -ge 1 ] || { echo "usage: $(basename "$0") <target-repo> [...]" >&2; exit 1; }

names=()
for d in "$SKILLS_ROOT"/*/; do
  [ -f "$d/SKILL.md" ] || continue
  names+=("$(basename "$d")")
done
[ ${#names[@]} -gt 0 ] || { echo "no skills found in $SKILLS_ROOT" >&2; exit 1; }

for target in "$@"; do
  target="$(cd "$target" && pwd)"

  for agent in .claude .agents; do
    dir="$target/$agent/skills"
    # a legacy whole-directory symlink becomes a real directory
    if [ -L "$dir" ]; then
      rm "$dir"
    fi
    mkdir -p "$dir"
    for n in "${names[@]}"; do
      if [ -L "$dir/$n" ]; then
        rm "$dir/$n"
      elif [ -e "$dir/$n" ]; then
        # a real directory here is a per-repo skill shadowing a shared name
        echo "  skip $agent/skills/$n (local skill, not overwritten)" >&2
        continue
      fi
      ln -s "$SKILLS_ROOT/$n" "$dir/$n"
    done
  done

  SKILL_NAMES="${names[*]}" python3 - "$target/.gitignore" <<'PY'
import os, sys

path = sys.argv[1]
names = os.environ["SKILL_NAMES"].split()
BEGIN = "# BEGIN software-skills symlinks (managed by link-skills.sh)"
END = "# END software-skills symlinks"
LEGACY = {".claude/skills", ".agents/skills", "/.claude/skills", "/.agents/skills"}

lines = open(path).read().splitlines() if os.path.isfile(path) else []
kept, skip = [], False
for line in lines:
    if line == BEGIN:
        skip = True
        continue
    if line == END:
        skip = False
        continue
    if skip or line.strip() in LEGACY:
        continue
    kept.append(line)

while kept and not kept[-1].strip():
    kept.pop()

block = [BEGIN]
for n in names:
    block.append(f".claude/skills/{n}")
    block.append(f".agents/skills/{n}")
block.append(END)

out = kept + ([""] if kept else []) + block
open(path, "w").write("\n".join(out) + "\n")
PY

  echo "linked ${#names[@]} skills into $target"
done

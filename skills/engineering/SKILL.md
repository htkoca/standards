---
name: engineering
description: Harness engineering — improving agent output by shaping the context and tools around a fixed model and coding agent. Use on a genuinely unresolved agent-design decision: writing or debugging a SKILL.md/AGENTS.md, deciding what belongs in context vs. tools vs. code, defining an agent's authority or permission boundary, choosing progressive disclosure vs. a runbook vs. a sidecar, or diagnosing a bad agent trajectory.
---

# Harness engineering

A reference corpus, not a dependency. It holds a thesis and playbooks for improving
agent output by shaping the environment around a fixed model and agent — not code a
project imports or vendors. Ryan Lopopolo's work, bundled here under CC BY 4.0; see
[COPYING.md](COPYING.md) and [LICENSE](LICENSE).

## When to reach for it

1. **Only on a genuinely unresolved decision.** Read the target repo's own
   instructions, domain model, and precedent first. Consult this corpus for the
   specific concern local evidence leaves open. Don't preload it for routine work.
2. **Target-local truth always wins.** The corpus can sharpen a decision; it never
   overrides the target repo's contracts, authority, or conventions. Adapt the
   applicable idea — don't copy its file layout, policies, or fixtures.
3. **Treat it as read-only.** It is reference material, not a working tree.

## Working loop

1. Read the target's available instructions and architecture first. For a repository,
   begin with its agent guide.
2. Inspect the target's actual domain model, manifests, tools, tests, permissions,
   operating history, and neighboring implementations. Find the local owner or
   precedent for the concern before retrieving general guidance.
3. Name the governing decision that local evidence leaves unresolved. Stop here when
   none remains. Otherwise pick **one** primary route below and read that thesis
   `README.md`. Add a second route only for a genuinely distinct concern.

## Context routing

Route an unresolved decision to one thesis section under
[reference/docs/](reference/docs/README.md):

| Unresolved concern | Route |
| --- | --- |
| What the agent can see and when | [just-in-time-context](reference/docs/just-in-time-context/README.md) |
| Whether a tool's surface is readable to the agent | [tool-legibility](reference/docs/tool-legibility/README.md) |
| What the agent is allowed to decide or do | [authority](reference/docs/authority/README.md) |
| Modeling the domain so requirements are recoverable | [domain-modeling](reference/docs/domain-modeling/README.md) |
| Showing the outcome actually holds | [proof](reference/docs/proof/README.md) |
| Closing the loop from a run back into the harness | [feedback](reference/docs/feedback/README.md) |
| Systems that survive their maintainers | [durable-systems](reference/docs/durable-systems/README.md) |
| Keeping a repo healthy over time | [continuous-maintenance](reference/docs/continuous-maintenance/README.md) |
| Whether the harness is actually working | [effectiveness](reference/docs/effectiveness/README.md) |
| Scoping the agent to a whole job, not a fragment | [whole-job](reference/docs/whole-job/README.md) |
| Holding the worker fixed while changing its environment | [fixed-worker](reference/docs/fixed-worker/README.md) |
| Getting work the last mile into production | [last-mile-deployment](reference/docs/last-mile-deployment/README.md) |
| Tracing a claim back to its source | [lineage](reference/docs/lineage/README.md) |

## Application routing

For applying the practice rather than deciding a point of design, read
[reference/playbooks/README.md](reference/playbooks/README.md) before selecting a
procedure:

- **Improve the harness around one observed job** —
  [improve-harness.md](reference/playbooks/improve-harness.md), read after the
  target's instructions and before collecting a baseline or making a change. Use the
  thesis routing above inside its gap-classification step.
- **Assess a repository broadly** —
  [repository-review.md](reference/playbooks/repository-review.md), read before
  beginning the review.
- **Make a comparative, causal, or longitudinal claim** —
  [reference/evals/README.md](reference/evals/README.md), read before running
  conditions.

To learn or teach the practice as a whole, start at
[reference/README.md](reference/README.md) and the thesis index in
[reference/docs/README.md](reference/docs/README.md).

## Provenance

[reference/sources/](reference/sources/README.md) holds the raw source material the
prose draws on. Consult it to check a claim against its origin; it is provenance, not
guidance. The CC BY 4.0 grant excludes third-party quotations, images, screenshots,
embeds, logos, and trademarks identified in the sources — those remain with their
rightsholders.

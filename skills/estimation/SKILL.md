---
name: estimation
description: How to build a dev-hour estimate for client-requested change sets — the harness-assisted base-hour method, the multiplier/overhead formula, rounding, and splitting an internal working doc from a client-facing summary. Use when a client or PM asks for an itemized effort estimate, when scoping a change set into hours, or when preparing an estimate to send to a client/PM.
---

# Estimation

How to turn a scoped set of changes (design frames, a voicemail, a ticket list)
into an hour estimate that's honest about where the time actually goes, and
how to hand that estimate to a client without exposing internal reasoning
they don't need.

## The formula

For each line item, start from a **base hours** figure, then apply a shared
formula across the whole estimate — not per item:

1. **Base hours reflect harness-assisted implementation time**, not manual
   hand-typed pace, when the work is actually being built with a coding
   harness. Don't estimate as if a human is typing every line; estimate the
   real build time given the tooling actually in use + the dev guiding it.
2. **× 2** is not a slowdown multiplier on implementation. It's buffer for
   the client interaction that shows up mid-build — clarifying questions,
   requirement tweaks, scope wobble — a fixed cost of any client engagement
   regardless of how fast the code itself gets written. Name it as such; if
   the real risk for a project is something else (e.g. unfamiliar codebase,
   flaky CI), swap in that reasoning instead, but keep the multiplier
   labeled for what it actually buys.
3. **Contingency, meetings, and review/fix time are each their own line
   item** — never merged into a single "overhead" bucket. A reader should be
   able to see the contingency percentage and the flat hours separately, not
   a pre-summed number they have to trust.
4. **Contingency scales with the build-time subtotal (e.g. +10%); meetings
   and review/fix time are flat, one-time additions — not per line item.**
   All three apply once across the *whole* estimate. Confirm this placement
   explicitly; the default instinct is to add flat items per line, which
   silently lets fixed overhead dominate the total once there are more than
   a couple of items.
5. **Round to a clean increment** (e.g. nearest 0.25h, rounding up when
   between) at each stage.
6. **If the total needs to round up to a "solid" number** (e.g. a stakeholder
   wants a round total), allocate the rounding buffer to **specific items**
   with real schedule risk — don't spread it evenly. Say which items got it
   and why (most interaction-state surface, least design certainty, etc.) so
   the padding is legible, not hidden.

## Keep items itemized when asked

If the client wants effort broken out per feature/section rather than one
lump sum, keep each item as its own row through the whole process — base
hours, multiplier, and any rounding buffer all itemized — even though the
flat overhead (step 4) is added once at the bottom, not per row.

## Flag what the estimate can't yet account for

Call out, explicitly, any item whose scope is still unresolved — a design
option not yet chosen, a content source (hard-coded vs. API) not yet decided
— as a named blocker on the estimate, not folded silently into the base
hours. State the assumption the current number rests on, so it's clear what
changes the number if the open question resolves the other way.

## Two documents, not one

Keep an **internal working doc** (full method: base-hours reasoning, the
formula, the rounding, why buffer landed where it did) separate from a
**client-facing summary** (final hours per item, the open blockers phrased
as decisions for them to make, nothing about how the sausage got made).
Client-facing doesn't need: the harness-assisted-pace framing, the
multiplier's internal justification, the contingency percentage, or which
items absorbed the rounding buffer and why — just the numbers and the
questions that block finalizing them.

If the project's PRD/planning docs are marked confidential (see the project's
own repo instructions), don't place the client-facing version inside that
confidential location — write it somewhere clearly separate from internal
planning material before sharing it out.

---
name: figma
description: How design values are read out of Figma — node structure and design context over screenshots. Use when implementing a design from a Figma URL/node, transcribing tokens, checking a component against the design, or any design-to-code work backed by the Figma MCP.
---

# Figma

How a design gets read. The Figma dev file is the design source of truth; this skill governs
*how* its values are extracted, not what the design says.

## Nodes over screenshots

1. **Derive every value from the node tree, never from a rendered image.** `get_metadata`
   for structure and `get_design_context` for the node being implemented return exact
   values — spacing, color, type ramp, layer and variant names, text content, hierarchy.
   A screenshot only supports a guess at those, and guesses land as arbitrary values
   (`text-[13px]`, `#4467a8`) that miss the token they were supposed to hit.
2. **Screenshots are for orientation and verification only.** Use one to see roughly what a
   surface looks like before drilling in, or to sanity-check a build against the design
   after the fact. Never to read a value out of.
3. **A screenshot silently omits things the node tree carries**: layers outside the crop,
   `hidden="true"` variant/state layers, component and variant names, exact text, and
   anything obscured by an overlapping layer. Working from the image alone means never
   learning those exist.
4. **When the image and the node data disagree, the node data wins.** Same rule as the
   archived screenshot exports versus the live Figma file — the file wins.

## Working a node

1. **Start with `get_metadata`** on the page or top node to map the structure, then drill
   into the named child nodes that matter. It is cheap and returns ids, names, types, and
   geometry — enough to decide what to pull in full.
2. **Then `get_design_context`** on the specific node being implemented. **Load the
   design-to-code guidance first** — the `/figma-design-to-code` skill if present,
   otherwise the `skill://figma/figma-design-to-code/SKILL.md` MCP resource. The MCP
   requires it, and skipping it produces code that ignores the project's own components
   and tokens.
3. **Treat returned code as reference, not output.** Adapt it to the project's existing
   components, design tokens, and conventions; never paste it in as-is.
4. **`get_variable_defs`** for the token/variable values behind a node when transcribing a
   design-token contract rather than building a single component.
5. **`hidden="true"` layers are alternate states**, not content to build — dropdowns,
   empty states, second options. Note them, build the visible state, and ask before
   inventing behavior for them.
6. **A URL with no `node-id` is not actionable.** Ask for a node-specific URL rather than
   guessing a node id or defaulting to the page root.

---
name: plain-english
description: Plain-English discipline for documentation prose and for the assistant's own tone in replies — Orwell's six rules plus an ASD-STE100 baseline. Use when drafting, rewriting, editing, reviewing, simplifying, or de-slopping docs, READMEs, comments, PR bodies, or an agent's conversational output. Explicitly not for marketing or product copy, which has different goals.
---

# Plain English

How the words read, whether they land in a doc or in a reply to the user. This skill
owns diction and sentence-level honesty. Where prose is *structured* — ownership
openings, bold-lead rule lists, tables, headings — is the `writing` skill's concern.

Adapted from the `orwell-writing` skill in
[tamdogood/builder-essential-skills](https://github.com/tamdogood/builder-essential-skills)
(MIT).

## This is not marketing copy

Marketing copy is allowed to sell: to compress a claim into something memorable, to
lean on rhythm and superlative, to make the reader feel a thing. Documentation and
assistant prose are not. They exist to let a reader act correctly, which means the
failure modes are opposite — a marketing sentence fails by being forgettable, a doc
sentence fails by being wrong, vague, or overclaiming.

Concretely, in this scope:

1. **No superlatives or intensifiers.** Not "blazing fast", "seamless",
   "powerful", "simply", "just", "easily". If a thing is fast, give the number.
2. **No benefit framing.** State what the code does, not what the reader will gain
   from it.
3. **No enthusiasm as filler.** "Great question", "Perfect!", "You're absolutely
   right" carry no information. Cut them.
4. **Claims are falsifiable or absent.** "Handles most cases" is either a specific
   set of cases or nothing.
5. **Hedging is not humility.** "This should probably work" either has a reason for
   the doubt, which you state, or it doesn't, and you drop the hedge.

Product and site copy is out of scope entirely; its voice belongs to the design.

## Orwell's six

From "Politics and the English Language", still the sharpest filter available:

1. Never use a metaphor, simile, or other figure of speech you are used to seeing in
   print.
2. Never use a long word where a short one will do.
3. If it is possible to cut a word out, always cut it out.
4. Never use the passive where you can use the active.
5. Never use a foreign phrase, a scientific word, or a jargon word if you can think
   of an everyday English equivalent.
6. Break any of these rules sooner than say anything outright barbarous.

Rule 6 is load-bearing. A sentence mangled into compliance is worse than the
mannered one it replaced.

## Technical baseline

For reference docs, procedures, and error messages, the ASD-STE100 discipline:

1. **One idea per sentence.** One main action or statement.
2. **Name the actor.** Clear subject, active verb, whenever the actor matters.
3. **Same term, same thing.** Never vary a term just to avoid repetition — variation
   reads as a distinction that isn't there.
4. **Familiar words with one meaning.** No idioms, no slang, no vague verbs
   ("handle", "support", "deal with").
5. **Precise technical terms when accuracy needs them**, defined or linked at first
   use.
6. **Short noun groups.** Use prepositions to show the relationship rather than
   stacking three nouns.
7. **Procedures state condition, action, and expected result.**
8. **Positive instructions.** Say what to do, not only what to avoid.
9. **Consistent American spelling** unless a style guide says otherwise.
10. **Never silently simplify** code, commands, identifiers, product names, legal
    text, or quotations.

Where strict compliance would cost accuracy, break it and mark the exception.

## Assistant tone

The same discipline applied to a reply:

1. **Answer first.** The conclusion leads; the reasoning follows for those who want
   it. No throat-clearing preamble restating the question.
2. **Report what happened, not what was attempted.** "Tests fail, here's the output"
   over "I've made great progress on the tests."
3. **State uncertainty once, with its reason,** then proceed. Repeated hedging reads
   as evasion.
4. **No self-congratulation and no ritual apology.** Both spend the reader's
   attention on the assistant rather than the work.
5. **Match length to the question.** A yes/no question gets a yes or no, then the
   caveat if there is one.

## Revising

1. Preserve meaning and any explicit tone or format constraint the user set.
2. Cut words, clauses, and whole sentences that do no work. Conciseness comes from
   dropping points, not from compressing surviving ones into shorthand.
3. Replace stale figures of speech with plain phrasing, or with a specific image that
   earns its place.
4. Convert passive to active where the actor matters and is known.
5. **Flag necessary jargon rather than removing it.** Precision lost to simplification
   is the expensive failure; say why the term stays.
6. Check term consistency, that each instruction names its required action, and that
   every remaining exception is deliberate.

## Creative and narrative prose

Out of scope as a constraint. Where a task is genuinely creative — fiction, a talk, a
personal essay — treat this skill as a clarity aid and keep intentional ambiguity,
cadence, dialogue, and character voice. Remove only what is inherited, inflated, or
evasive. Apply the technical baseline strictly only on request, and say when that
request fights the effect the piece is going for.

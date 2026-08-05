---
name: components
description: House style for authoring, shaping, and styling React/shadcn components (file skeleton, CVA variants, atomic-design organization, layout shell). Use when adding, refactoring, or reviewing a component in any project using shadcn + Tailwind v4.
---

# Components

How components are added, shaped, styled, and organized. This skill owns authoring and styling rules; what components exist and what they look like is the design contract's concern, not this skill's.

## The flow: shadcn first

1. **Check shadcn before writing anything.** Primitives use shadcn, which uses Radix primitives underneath. Adding a new component starts with a check of the shadcn library: if it exists there, import it with the CLI (`pnpm dlx shadcn@latest add <name>`), then **reformat it to the house shape below and re-theme it with the project's design tokens**.
2. **Custom components use the identical shape.** If shadcn doesn't have it (or the design calls for something bespoke), author it from scratch in exactly the same format; the only difference is there's nothing to import.
3. **When a library component can't express the design, fork it once.** Copy it into the project's own component directory, reshape it there (content as markup rather than fixed slots, surfaces as variants, `className` reaching the element that needs it), and build every usage on that one fork. Its TSDoc names the constraint that forced the fork. Reaching past it to the underlying primitive at a call site is how a codebase ends up with four tooltips that drift apart.

## The file shape

1. **Every component follows this example skeleton:**

   ```tsx
   import { forwardRef, type HTMLAttributes } from 'react'
   import { cn, cva, VariantProps } from '@/utils/theme'

   const styles = {
     root: cva('…', { variants: { … }, defaultVariants: { … } })
   }

   type ExampleRef = HTMLDivElement
   type ExampleProps = HTMLAttributes<ExampleRef> & VariantProps<typeof styles.root>

   const Example = forwardRef<ExampleRef, ExampleProps>((props, ref) => {
     // props
     const { className, ...rest } = props

     // hooks

     // render vars

     // jsx
     return <div ref={ref} className={cn(styles.root({ className }))} {...rest}></div>
   })
   Example.displayName = 'Example'

   export { Example }
   export type { ExampleProps, ExampleRef }
   ```

   Order within the file: **CVA styles/constants on top → types (`XxxRef`, `XxxProps`) → component.** Order within the function body, each under its comment: **props** destructure → **hooks** → **render vars** → **handlers** → **jsx** (composed with `cn()`). Sections with nothing in them are omitted.
2. **Named exports only**: the component plus its `Props` and `Ref` types; `displayName` set on `forwardRef` components. No default exports.

## Styling

1. **CVA for all visual variants.** Each component defines a local `styles` object of `cva()` calls; never ad-hoc conditional className logic at call sites.
2. **No class string ever appears in JSX.** Every class lives in the `styles` object under a name, including one-offs with no variants (`icon: cva('size-5')`) — markup reads as structure, and a component's whole visual surface is one object at the top of the file. That means no `className="…"` literal, and no literal passed to `cn()` alongside a style entry; add or extend the entry instead.
3. **`cn()` for all className composition**: `twMerge(clsx(...))` from `utils/theme.ts`, which also re-exports `cva` and `VariantProps` so components have one import point.
4. **Layout utilities at the call site, visual styles in the CVA.** `w-full`, grid placement, margins come from the parent; color, radius, type, borders live in the component's variants.
5. **Semantic tokens only.** No raw hex, no palette utilities (`text-zinc-400`), no arbitrary color values in JSX. Backgrounds pair with their foregrounds (`bg-primary` → `text-primary-foreground`).
6. **Type comes from the ramps.** Use the heading/expressive/body typography utilities defined by the design tokens: no arbitrary `text-[13px]`. Uppercase is CSS `uppercase`; content is written in normal case.
7. **Tailwind v4 CSS-first.** All theme extension in `themes/theme.css` `@theme`; no `tailwind.config.ts`.
8. **`asChild` + Radix `Slot`** when a component delegates rendering (`<Button asChild><Link …/></Button>`); never nest interactive elements.

## Comments

1. **Inside a component, the only comments are the section markers** from the file shape — `// props`, `// hooks`, `// render vars`, `// handlers`, `// jsx`. No explanatory prose in the body, none inside JSX, and never TSDoc: a component body is read as a sequence of the same five sections in every file, and prose between them breaks that scan.
2. **Rationale goes on something declared at module scope** — the component's own TSDoc block, a `styles` key, a type member, a constant, or a helper function. Anything that can't be attached to a declaration is usually a comment that shouldn't be written.
3. **TSDoc blocks are for declarations only**: constants, types and their members, object keys, functions, and component definitions. Line comments (`//`) carry short notes on those same declarations.
4. **Lint directives are not comments.** `// eslint-disable-next-line …` stays wherever the rule requires it.

## Organization: atomic design

1. Components live in `components/` in an atomic-design structure:
    - `atoms/`: simple components. E.g. a button, a badge, the wordmark.
    - `molecules/`: collections of atoms. E.g. a search bar, a date picker, an accordion, a project card.
    - `organisms/`: collections of atoms/molecules. E.g. a page block, a dialog, a menu, an overlay.
    - `templates/`: layout-focused things: footer, header, layout, main, section.
2. shadcn CLI imports land in `atoms/` (the `components.json` `ui` alias points there) and are reformatted on arrival.

## Layout shell

1. **One persistent shell wraps every page**, composed from `templates/`:

   ```text
   layout
   ├── underlays    # site-wide background layers (e.g. custom webgl backgrounds)
   ├── header       # top bar: identity + nav links
   ├── main         # page content, sections in flow
   ├── footer       # bottom bar: copyright, quick links
   └── overlays     # takeover layers (e.g. loading screen, nav overlay)
   ```

2. **Pages are stacks of `section` shells.** Every section renders through the `section` template: a full-bleed wrapper with a centered inner container in one of three widths (`lg` / `md` / `sm`, values set by the design tokens), never ad-hoc page-level wrappers.

## Reusability

1. **All components are reusable by construction.** Content is passed in via props or children, never defined inside a component. Content is defined in `constants/`, API calls, or pages (the consuming layer) only. A component with a hardcoded heading is a bug.
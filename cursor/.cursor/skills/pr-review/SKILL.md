---
name: pr-review
description: >-
  Reviews a PR or branch diff using Samuel's personal review bar: changed
  code must work as intended; then maintainability, clarity, and preventing
  future issues. Augments a normal PR review rather than replacing it. Use
  only when explicitly named (e.g. /pr-review, "run my PR review skill",
  "personal PR review"). Never self-invoke for ordinary coding or generic
  review requests. For Harmoni evidence-first reviews, use harmoni-pr-review.
disable-model-invocation: true
---

# PR Review

These rules **augment** a normal PR review. They are not a replacement. After
the checks in this skill, still run the other checks you would run for a PR.
Do not skip those because this file has its own lists. Do not load
`harmoni-pr-review` snapshot/ledger machinery unless the user named that skill.

If unsure of comment tone, read [examples.md](examples.md).

## Goals

The **primary** goal is to ensure that code works as intended. This includes
new functionality / code and existing functionality / code that was modified.

Unchanged code with bugs should be called out as a **secondary note**, not the
primary PR review comment.

The **secondary** priority is to ensure code maintainability, clarity, and
prevention of **future or potential** issues. Code is read by both humans and
agents, and should be easy to understand and modify.

**Cognitive load** is how hard it is for that reader to follow the logic.
Prefer code where the next change is likely to do what the author intends,
because the current logic is visible without holding several combinations of
values in mind. Apply this to conditionals, control flow, and any other
expression a reader has to simulate. A correct but hard-to-follow expression
still belongs in the primary comment when it is on changed code.

## Constraints

- Read-only unless asked to fix. Do not post to GitHub unless asked. Do not commit.
- Name the actual base branch (`dev`, `main`, …), never "dest".
- Unverified CI or runtime claims stay caveats, not facts.
- Already-landed follow-ups may be noted so they are not re-litigated. Do not thank for them.

## Workflow

1. Resolve the repo root (required in a multi-root workspace) and the base
   (`gh pr view`, `origin/HEAD`, or the branch the user named). Diff
   merge-base…HEAD. Include uncommitted work only when reviewing the working tree.
2. Review **changed** code first (new + modified): does it work as intended,
   including issues the author may have missed that could or would break, then
   maintainability of that same surface, including cognitive load. Follow
   callers, tests, and fixtures of the change. Bugs in unchanged files go to
   the secondary note only.
3. **Repeated issues: comment once, not everywhere.** If the same issue appears
   in many files, write **one** item: name one representative location in enough
   detail to fix it, list a few more paths so the owner can grep the rest, then
   say there are more. Do not enumerate every instance. The owner should have
   enough to find and fix the class of issue without reading a long list. A
   one-off stays a single-location item.
4. Split the pasteable comment: **primary** (issues in new or modified code) vs
   **secondary note** (bugs in unchanged code). Within the primary section, order
   by likelihood of user-facing bugs, unintended behavior, or a later change
   missing one of the copies. Maintainability items come after correctness items.
5. Default deliverable: one pasteable GitHub **conversation** comment (not
   Files-changed inlines unless asked). Action, then where, then why.
6. **Then run a normal PR review.** After the checks above, do the other review
   work you would do without this skill (tests, regressions, security-adjacent
   issues in the diff, API/contract breaks, missing coverage, obvious
   performance or UX problems, and anything else a thorough review would catch).
   Merge those findings into the same comment using the same split, ordering,
   and "comment once" rules. This skill's lists are extra, not a cap.
7. On a later pull: for each primary item, report unchanged / partial / fully
   addressed. Partial means related code moved but the original issue remains.
8. **Grow the skill** (in the chat, not the GitHub comment). See below.

## Correctness

The most important check is whether the code **works as intended**. Point out
issues the developer might not have noticed that could (or definitely would)
cause issues. Non-exhaustive list:

- Conditionals that will always be true, or always be false
- Code that is doing something other than intended (e.g. comparing dates or
  numbers alphabetically instead of chronologically / numerically; looping
  through fields of an object's prototype instead of iterating through an
  array's items; checking against the value of a promise instead of its
  resolved value)
- Code with race conditions
- Other broken code you find
- Cross-cutting contracts copied N times (error unwrap, auth expiry, logout)
  instead of one owner. Prefetch or a second consumer of the same operation
  skips the per-call-site copy
- Failures cached or stored as success (`catch { return [] }`, missing flags
  treated as empty success) — the UI cannot tell "empty" from "the request failed"
- Cache lifetime / staleness defaults that may have been copied rather than
  chosen. If never-refresh is intentional, say so rather than demanding a change
- Dual sources of truth after a cutover (old store vs new URL/API; tests or
  fixtures targeting deleted infrastructure; comments that still describe the
  old system)
- Keyed caches, memo tables, or persisted blobs that omit a dimension the data
  is actually scoped to (user, account, tenant, locale, environment, …). Do not
  add those dimensions to data that is truly global. An existing wipe-on-switch
  is a mitigation, not a pass: wrong keys still leak if a reset is skipped or a
  prefetch lands first
- Guards that fail open (a boolean true without the credential it claims)
- Tests that do not match the new runtime; dead injects and stale architecture
  comments. Caveat if e2e was not run

## Maintainability, clarity, future issues

Still in the **primary** comment when they are on changed code; after
correctness. Judge this section by cognitive load: can a reader follow the
logic, and would a later edit still do what that reader meant? This includes
but is not limited to:

- Clear and concise naming
- Complex conditionals. Avoid a condition that is hard to read. The more
  complex it is, the more likely a later change will not do what the developer
  intends. Flag an expression that does several of these at once:
  - multiple conditions in one expression
  - nested conditions (a parenthesized expression inside the outer one)
  - mixed checks: a negation, a comparison to `true` or `false`, and another
    kind of check such as a length, joined with both AND and OR
  - optional chaining, nullish coalescing, and a nested boolean stacked in one
    assignment
  AND, OR, and NOT together force the reader to enumerate combinations. If
  they change the expression without having the real combination in mind, the
  code will not match what they meant. A check that runs on for many lines
  (about seven or more) is a smell, not proof that it is wrong. Name an
  intermediate when it is one idea. Prefer that, or an early return per case,
  over one expression that mixes the forms above. Shape to flag:

  ```ts
  const limitColumns =
    !inDrillDown &&
    flag === true &&
    (items.length > 0 || touched);

  const hidden =
    column.filters?.some(match) ??
    (inDrillDown && !column.keep && match(column.field));
  ```
- Functions that don't try to do too much. There isn't a hard limit on lines,
  statements, or complexity, but a function that is hundreds of lines long, has
  deeply nested code, or tries to do many only loosely related things is a sign
  that things should be simplified
- Avoid unnecessary abstraction. No hard and fast rules, but while extracting a
  function that is used in 3 places is good, and extracting a function that is
  only used once or twice can also be good if it aids in maintainability and
  readability, it might overcomplicate things to have a lot of small small
  functions that exist only so that the call sites have fewer lines
- Logical and easy to follow control flow (e.g. avoiding nesting by using early
  returns, code that is read top to bottom instead of nested function calls).
  Deep nesting and stacked operators raise cognitive load the same way a
  complex conditional does
- When using TypeScript, proper and robust use of the type system. Types should
  represent the data or logic without being overly broad (e.g. a field that can
  be string, number, or boolean is bad). If possible, make it impossible to
  represent state that should never happen (e.g. instead of using several
  boolean flags that should never be true at the same time, use one union
  field). Types are a great way to understand what the code can and should do,
  so good types are something we should strive for. Throwing away type
  information by using `as any` or `as NarrowerType` is very bad, because it
  hides potential bugs. If using a TS version that has it, `satisfies` can be
  used in some situations instead of `as`. Prefer `unknown` over `any`. If
  `any` is unavoidable, comment **that binding**, not the whole file. No
  file-level `eslint-disable` (especially `no-explicit-any`)
- ESLint rules should always be followed except in two cases: (1) code that had
  linting issues before the PR, where we don't want to change behavior; (2) code
  that technically breaks a rule, but is actually the best way to do a task.
  This could be best practices, or it could be excluding a value from a React
  hook's dependency array because to include it would cause unnecessary
  re-renders. These are just two examples, and are not exhaustive. A short
  why-comment on the disable is helpful, not required
- JSDoc on symbols is fine when it adds information. Prefer JSDoc over a nearby
  inline comment. Do not strip useful docs in cleanup. Delete leftover/noise
  comments
- Unused code, such as exports that are not imported anywhere, dead functions,
  and unused imports. For new or leftover exports, search the repo (and sibling
  packages in a workspace) for importers. Caveat public package entrypoints and
  dynamic/string-based imports; do not demand deletion of a published API from a
  skim. Leftovers after a cutover count here too

## Comment format

The generated review must be easy to understand for **both the reviewer and the
PR author**. Plain language. Enough context to see the problem without already
knowing the review. No unexplained jargon or internal shorthand. Agents should
still be able to follow it, but that must not make it harder for the humans.
When the finding is a hard-to-follow expression, state the combination the
reader has to simulate and what a mistaken edit would do. Do not make the
author reconstruct it.

Each item: **what to change**, then **where**, then **why**. Bake in a caveat
if the claim is inferred. Repeated issue: one location + a few more + "and
more" — never a full inventory.

```markdown
## Primary

### 1. <action>

In [`path`](url) <what to change>. Same in `a.ts`, `b.ts`, and more.

<why, including what could or would go wrong. Caveat if inferred.>

### 2. <action>
...

## Secondary note

These were already on `<base-branch>`; they are not introduced by this PR.

### 1. <action>
...
```

Do not thank for already-fixed items; a short note that they landed is enough
if it helps the reader skip them.

Do not post until asked.

## Re-review after a pull

For each primary item: **unchanged**, **partial**, or **fully addressed**.
Partial = related code moved but the original issue remains.

## Skill growth

After the review (or a re-review), if a finding is a new **general** pattern
not already in this skill, suggest adding it in the chat — not in the GitHub
comment. Do not edit this skill until Samuel asks.

A pattern is general enough if it would apply in another repo or stack without
renaming product types. Propose a one-line checklist item plus why it is
general.

Skip: one-off bugs, this-repo contracts, stack-only rules (those belong in a
different skill), and generic "would have caught this anyway" items. Never
append silently.

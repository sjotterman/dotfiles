---
name: pr-review
description: >-
  Reviews a PR or branch diff using Samuel's personal review bar: changed
  code must work as intended; then maintainability, clarity, and preventing
  future issues. Augments a normal PR review rather than replacing it. The
  review workflow runs only when explicitly named (e.g. /pr-review, "run my
  PR review skill", "personal PR review"). The Correctness and
  Maintainability sections are also the bar for code you write: read them
  when generating or editing code. For Harmoni evidence-first reviews, use
  harmoni-pr-review.
disable-model-invocation: true
---

# PR Review

These rules **augment** a normal PR review. They are not a replacement. After
the checks in this skill, still run the other checks you would run for a PR.
Do not skip those because this file has its own lists. Do not load
`harmoni-pr-review` snapshot/ledger machinery unless the user named that skill.

If unsure of comment tone, read [examples.md](examples.md).

## When writing code

The Correctness and Maintainability sections below are the bar for every change you add or edit, in every repository, in every chat. Read them before that change is finished, and fix those issues in the code. Do not run the review workflow while writing: no GitHub comment, no review writeup, and no secondary note.

Matching this bar is part of writing the change. It is not a follow-up. Do not call the change complete, tell the user it is done, or move on while code you added or edited still misses it. Passing tests, a working feature, or confirmation of the behavior does not waive the check. Do not leave a mismatch so a later cleanup can fix it.

A repository `AGENTS.md` or `.cursor/rules` file wins only where it conflicts. If Samuel says not to follow this, that applies only to the current chat. Do not write that exception into a repo rule, `AGENTS.md`, or a comment that a later session would treat as the default.

The review workflow still runs only when this skill is explicitly named.

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
4. Split the suggestions: **primary** (issues in new or modified code) vs
   **secondary note** (bugs in unchanged code). Within the primary section, order
   by likelihood of user-facing bugs, unintended behavior, or a later change
   missing one of the copies. Maintainability items come after correctness items.
   Mark an item as a **suggestion** when it is optional. Leave it unmarked when
   it is a required change.
5. Default deliverable: those suggestions **in chat**, so Samuel can read them
   before anything is formatted for GitHub. Each one: action, then where, then
   **why it is called out** (incorrect behavior, harder to read/track, future
   miss). After the suggestions, offer two follow-ups and wait: a **plan** for
   the changes, or a pasteable GitHub **conversation** comment in markdown.
   Do not write the plan or the markdown comment until he picks one. Not
   Files-changed inlines unless asked.
6. **Then run a normal PR review.** After the checks above, do the other review
   work you would do without this skill (tests, regressions, security-adjacent
   issues in the diff, API/contract breaks, missing coverage, obvious
   performance or UX problems, and anything else a thorough review would catch).
   Merge those findings into the same chat suggestions using the same split,
   ordering, and "comment once" rules. This skill's lists are extra, not a cap.
7. On a later pull: for each primary item, report unchanged / partial / fully
   addressed, in chat. Partial means related code moved but the original issue remains.
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

Code you add or edit must be maintainable. A reader, and a person updating it later, should be able to understand it. Follow best practices whenever possible.

Still in the **primary** comment when they are on changed code; after
correctness. Judge this section by cognitive load: can a reader follow the
logic, and would a later edit still do what that reader meant?

The list below is examples, not a closed set. During this check, also fix any other change that would make the code easier to read or to update. This includes
but is not limited to:

- Clear and concise naming. A good name is a simple way to make the code easier to understand, so names of functions, variables, and types should be accurate and concise. A name should be only as long as necessary to convey what it represents. It does not need to be a sentence. There is no minimum length and no maximum length. The examples below are not exhaustive.
  - The name has to make sense for the values it actually takes. `isEqual(user, date)` is a bad name: it does not make sense to check equality of a user and a date. If that operation is real, name the operation.
  - A parameter or local name that is only a type does not say which value it is. `value`, `data`, `item`, `flag`, and `obj` are the usual cases. `sameResource(decoded, value)` is one: the second argument is a resource id, and `decoded` is only read for `resourceId`.
  - Do not bake a negative into the name. `isNotReady` and `disableUnless` make the caller write `!isNotReady`, and the next edit inverts the wrong half. Prefer the positive name and negate it at the call.
  - A read-shaped name should not write. `get`, `is`, `has`, and `check` should not be the name of a function whose main job is to save, delete, or send a response. If it does that work, use an imperative verb.
  - Follow a consistent pattern for what the function does. Boolean functions look like `isValid()`, `isAdmin()`, `isError()`, and the same shape for `has` and `can`. An imperative verb (`save`, `delete`, `emit`) means the function performs an action. `getNoun()` returns that noun and should not have side effects.
  - Extracting a complex conditional into a named variable or a well-named function is self-documenting in two ways: the caller is easier to read, and you only open the variable or function when you need to change the condition itself. A function also allows an early return per case, which is easier to follow than one expression.
  - Prefer a name that says the operation in plain words. A reader who has not opened this code in months should not need the jargon of a library to tell what it does. `sendHeldAuditRecords` says the operation; `flushLogs` does not. A boolean reads as a boolean (`isShutdownLogStarted`, not `loggingRecorded`). A file name matches what the file contains.
- Comments are fine when they add a detail the name cannot hold. That includes a why, a constraint, a gotcha, or any other fact that would not fit in the name, such as when to call the function or what a short name leaves out. They do not restate the function name or narrate the next line. If a comment would only repeat the code, rename the code and delete the comment. A flag set before a send finishes, so a failed send still blocks a second attempt, is a detail worth a comment. `/** Sends held records. */` on `sendHeldAuditRecords` is not. Every comment, including JSDoc, has to make sense without the conversation, review, or plan that produced it. A JSDoc comment is useful when the caller needs that detail. Do not use one for an implementation detail the caller does not need. That detail belongs on the statement or branch it explains. Flag one that says "the callback" or "the success path" when the code it means is not named, or that refers to a chat. The comment has to name the function, file, or nearby line a later reader can see.
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
- Extract a function to remove duplicated code, or to name an abstraction a
  reader can use. A function used in several places is the usual case. One
  used once or twice can still be worth extracting when the name makes the
  caller easier to follow. Skip the extraction when it does not add much. A
  body that is only one line, or a function that needs many parameters because
  it is coupled to its caller, is usually better left inline. Those are
  examples; the same judgment applies to other extractions that do not earn
  their name. A pile of small functions that exist only so the call sites have
  fewer lines is the same problem
- Logic duplicated across repositories. When the same logic appears in more
  than one repository, note it in the chat or the plan so a better solution
  can be discussed. Do not put that note in the code unless Samuel asks for it
- Logical and easy to follow control flow (e.g. avoiding nesting by using early
  returns, code that is read top to bottom instead of nested function calls).
  Deep nesting and stacked operators raise cognitive load the same way a
  complex conditional does
- Clever compression. Flag changed code that saves a few lines by being harder
  to follow. Prefer the ordinary form of a pattern. The goal is ease of
  reading and maintenance.
  - An async IIFE where a named async function would hold the same work. Call
    that function and store its promise. An IIFE is fine when there is a
    reason a name does not fit. IIFEs are not banned.
  - A ternary that spans several lines, or a nested ternary. A short readable
    ternary can stay.
  - A nested call, or an object field set to a complex expression, where an
    intermediate variable would name the value.
- When using TypeScript, proper and robust use of the type system. Types should
  represent the data or logic without being overly broad (e.g. a field that can
  be string, number, or boolean is bad). Types are a great way to understand
  what the code can and should do, so good types are something we should strive
  for. Throwing away type information by using `as any` or `as NarrowerType` is
  very bad, because it hides potential bugs. If using a TS version that has it,
  `satisfies` can be used in some situations instead of `as`. Prefer `unknown`
  over `any`. If `any` is unavoidable, comment **that binding**, not the whole
  file. No file-level `eslint-disable` (especially `no-explicit-any`)
- Make illegal combinations unrepresentable. A variable, especially one that is
  updated often such as React state, should not be settable to a combination
  that should never happen or that would do something undefined or undesired.
  The common case is several boolean `useState` values for phases that are
  mutually exclusive. A union (usually a discriminant such as `status`) is
  often the better type: one update replaces the whole phase, and a reader does
  not have to simulate which flags can be true together. The point is fewer
  bugs and easier reading. It is not a reason to delete lines. Judge it with
  the other rules in this skill and in the code-clarity guideline. Do not
  introduce a union that is harder to follow than the booleans. If one phase
  only exists after another has settled, nest it on that variant instead of
  adding a sibling that copies the settled fields. Name each variant for what
  the value actually is.
- Types with many optional fields are a code smell: an indicator that one type
  is trying to do too much. If we need a type to cover multiple scenarios, a
  discriminated union might be a good fit. Prefer **named** variant types (and
  a named base for truly shared fields) over anonymous objects in the union.
  Optional fields that only apply to some `kind`/`type` values belong on those
  variants, not on everyone. Prefer types (such as discriminated unions) that
  allow using control-flow narrowing of types, rather than having to check for
  specific fields every time (`if (x.options)`, `if (x.columns)`). After
  `if (x.type === 'select')`, `options` should be in the type, not guessed at.
- Non-null assertions (`value!`) are the same bug as `as NarrowerType`: they tell
  the compiler a value is present when it might not be. Prefer a narrow
  (`if (!x) return`) over `!`
- Unions that cannot be exhausted: after a `switch` on a discriminant, a
  `default` that is not `never` (or a missing case) means a later variant
  compiles and then does the wrong thing at runtime. This is the other half of
  preferring types that narrow
- Type predicates that lie: `function isFoo(x: unknown): x is Foo` that does
  not actually prove `Foo` is `as` with a nicer name. Same family as throwing
  away type information
- `Partial<T>` / `Record<string, …>` as the **domain** type. They recreate the
  bag of optionals: every field is optional or every key is allowed. Fine at a
  parse boundary; bad as the type the rest of the app uses
- Declared `any` that is really `unknown`: `JSON.parse`, `Response.json()` /
  `response.json()`, and other helpers with the same shape are declared as
  `any` or `Promise<any>`. The runtime value is `unknown` until it is checked.
  Annotating the result (`const data: Foo = await response.json()`), returning
  it as `T`, or reading a property off it typechecks, because `any` is
  assignable. A clean typecheck is not evidence the body was validated. Treat
  that the same as `as Foo`. Bind the result as `unknown` and narrow it before
  use. If the project remaps these to `unknown`, the annotation becomes a
  compile error. If it does not, still flag the assumption. `catch (e)`,
  `event.target`, and query params are the same hole: they are `unknown` until
  checked, and using `.message` or passing them through as a typed object is a
  hidden `as`
- ESLint rules should always be followed except in two cases: (1) code that had
  linting issues before the PR, where we don't want to change behavior; (2) code
  that technically breaks a rule, but is actually the best way to do a task.
  This could be best practices, or it could be excluding a value from a React
  hook's dependency array because to include it would cause unnecessary
  re-renders. These are just two examples, and are not exhaustive. A short
  why-comment on the disable is helpful, not required
- JSDoc on symbols is fine when it adds a detail the name and signature
  cannot hold. Prefer JSDoc over a nearby inline comment.
  Do not strip useful docs in cleanup. Delete leftover comments, and delete a
  comment that only restates the name.
- Unused code, such as exports that are not imported anywhere, dead functions,
  and unused imports. For new or leftover exports, search the repo (and sibling
  packages in a workspace) for importers. Caveat public package entrypoints and
  dynamic/string-based imports; do not demand deletion of a published API from a
  skim. Leftovers after a cutover count here too

## Comment format

Use this shape for the chat suggestions, and again for the markdown comment
if Samuel asks for one. The plan, if he asks, is the same items as steps.

The suggestions must be easy to understand for **both the reviewer and the
PR author**. Plain language. Enough context to see the problem without already
knowing the review. No unexplained jargon or internal shorthand. Agents should
still be able to follow it, but that must not make it harder for the humans.
When the finding is a hard-to-follow expression, state the combination the
reader has to simulate and what a mistaken edit would do. Do not make the
author reconstruct it.

Each item: **what to change**, then **where**, then **why it is called out**. Be
brief and specific:

- If there is a potential for **incorrect behavior** (wrong data, dropped
  filters, swallowed errors, a later edit compiling then doing the wrong
  thing), say so.
- If a grab-bag type, tangled conditional, or extra source of truth makes the
  code **harder to read and harder to track**, say that. Example: one type with
  many optional fields forces every caller to re-check which fields apply.
- If the risk is **future** (a new union member, a missed copy of a contract),
  say that.

Bake in a caveat if the claim is inferred. Repeated issue: one location + a
few more + "and more" — never a full inventory.

```markdown
## Primary

### 1. <action>

In [`path`](url) <what to change>. Same in `a.ts`, `b.ts`, and more.

<why it is called out: incorrect behavior, harder to read/track, and/or a later change will miss this. Caveat if inferred.>

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

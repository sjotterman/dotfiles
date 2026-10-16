---
name: guided-implementation
description: >-
  Plans and guides a new feature or other multi-step change as confirmed
  chunks, with Samuel as an active participant. Use when starting a feature,
  a project, or a change that will take more than one commit. Do not use for
  a small fix or a single-file edit.
---

# Guided implementation

Samuel is an active participant in development. Making a large amount of changes without interaction or confirmation is antithetical to this.

## When this applies

Apply this skill when Samuel starts a new feature, a new project, or any other multi-step change. A small fix or a single-file edit does not start a plan and does not wait on this workflow.

A repository `AGENTS.md` or `.cursor/rules` file wins only where it conflicts. If Samuel says not to follow this skill, that applies only to the current chat. Do not write that exception into a repo rule, `AGENTS.md`, or a comment that a later session would treat as the default.

## Plan

Create a Cursor plan and keep it updated as the record of implementation progress.

Break the work into logical chunks that can be implemented one at a time. A chunk has no strict size. It is no smaller than a single commit and no larger than a single pull request.

Prefer chunks that can merge on their own, without another pull request landing at the same time or in a required order. When that cannot be avoided, or when splitting them would be counterproductive, say so on that chunk.

When a chunk is finished, replace its detail with a short summary. The body of the plan is the work that remains.

## Before writing code

Before every step that writes or edits code, stop and explain the change. Do not write the files in that same step. Name what the change does and why. Include a snippet when it helps. Say how many lines change across how many files. If and only if the change spans multiple repositories, say how many repositories are affected.

Samuel's understanding of the plan as a whole, and clarity on each step, is a high priority. He needs to understand the change so he can maintain it later, and so the change is the right one. Vague information about what is being changed can hide an assumption or a decision. State the assumptions and decisions in the step.

## Questions

A clarifying question is a request for an explanation. Do not take it as an invitation to change a decision or update the plan.

If a clarifying question leads to the suggestion of a plan change, say that it is a suggested change and get confirmation before updating the plan.

If a change in the plan conflicts with a project skill that already records the decision, name the conflict before treating the plan as the new decision. Do not edit that skill for the conflict unless Samuel asks.

## Confirmation

Get confirmation before implementing a step, even if agent mode is enabled.

If Samuel says he will make the change, do not write those files.

## Working as intended

Implementing a new feature is not merely writing code. It is building or modifying functionality so that it actually works as intended. "As intended" includes, but is not limited to:

- Meeting all explicitly defined requirements.
- Not changing or breaking functionality other than what is specified.
- Meeting unspoken user assumptions, UI and UX best practices, and industry standards. A feature should not surprise users by working in a way they did not expect.

If any of these requirements conflict, or for any other reason cannot be met, call that out so it can be addressed. Do not ignore it.

A step is not complete until all of these requirements are met, or until specific requirements or assumptions are explicitly designated to be ignored.

## Testing

Implementing new functionality includes testing that confirms the changes did what they were supposed to do. Each step has testing instructions before it is considered complete.

For code, that can be manually interacting with an application, running unit tests, or making network requests, either one-off or repeatable (for example `.hurl` files or an API testing tool such as Postman). If another way of testing the functionality is a good fit, include it in that step's testing instructions. Use the combination that gives good confidence without spending a huge amount of time or resources. The assumption is that all of these testing steps are done. If exhaustive testing would take a very long time, say so and give a representative subset to complete.

Automated unit tests are a low-cost, repeatable way to test functionality. The tests have to be practically useful. They should test our code. Mocks, and calls that only exercise an external package, are not banned, but they are not what the tests should focus on.

## Git

Do not perform git actions that write, such as commit, push, or `gh pr create`. Do not ask Samuel if he wants these actions. If he wants one, he will explicitly say so.

If he explicitly asks for a git action that writes, list the git commands that will be run and get confirmation before running them, even in agent mode.

Read-only git commands, such as `git status`, `git diff`, `git log`, `git show`, and `git branch`, are fine to run without that confirmation.

## Project skills

When the work records requirements or decisions a later session would need, suggest updating an existing project skill or creating one. Do not create or edit that skill until Samuel confirms.

For a Harmoni project, that skill lives in harmoni-ai-skills, in the same way as the audit logging and Keycloak auth skills. Another team uses that team's skill location. Do not put team-specific requirements in this personal skill.

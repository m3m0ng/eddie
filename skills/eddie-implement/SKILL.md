---
name: eddie-implement
version: 0.1.0
description: Fourth phase of EDDIE. Breaks the PRD + architecture into a vertical-slice task list, then executes one task at a time with TDD enforced via Red/Green/Refactor subagent isolation. Walking skeleton first, then user-story slices (each built start-to-finish across all layers before moving on), then polish. Calls into eddie-evaluate per slice for the integration test. Hard gate at end.
---

# EDDIE — Implement phase

You are the Implement phase. Your job is to convert the PRD + architecture-design.md into a vertical-slice task list, then execute it one slice at a time with TDD enforced via subagent isolation.

## Operating rules

- **Vertical slices, never layers.** Each user story is built start-to-finish across all layers (DB → backend → UI) before moving to the next. NEVER "all DB stuff first, then all backend, then all UI."
- **Walking skeleton first.** Before any feature work, stand up the full pipeline end-to-end with "Hello World" at every integration point.
- **Tight tasks.** 2–5 minutes each, exact file paths, complete code (no placeholders), verify command + expected output.
- **TDD via subagent isolation.** Red writer (sees spec only) → Green implementer (sees failing test only) → Refactor (fresh context). Required because single-context agents will silently delete failing tests.
- **Subagent for every task except Setup.** Foundational (walking skeleton), all slice tasks (Red/Green/Refactor), per-slice integration tests, and Polish all run as isolated subagent invocations. Setup runs inline because it often needs interactive permission prompts.
- **Model assignments for subagents:**
  - Foundational (walking skeleton) → `model: opus`, `effort: low`
  - Slice — Red (test writer) → `model: sonnet`
  - Slice — Green (implementer) → `model: opus`, `effort: low`
  - Slice — Refactor → `model: opus`, `effort: low`
  - Per-slice integration test (delegated to `/eddie:evaluate --slice`) → `model: sonnet`
  - Polish → `model: opus`, `effort: low`
  Rationale: Red and integration-test scaffolding are spec-translation work — Sonnet handles them cleanly and cheaply. Green/Refactor/Foundational/Polish are real implementation reasoning where Opus low-effort earns its keep.
- **Re-grounding every task.** Inject PRD + architecture-design.md into every task's context prefix. One task at a time.
- **Continuous Evaluate.** After each slice's task is `DONE`, invoke `/eddie:evaluate` to write that slice's integration test before starting the next slice.

## Inputs

- `eddie/<run-slug>/prd.md`
- `eddie/<run-slug>/architecture-design.md` (or `approach.md`)
- `eddie/<run-slug>/.eddie-config.json`

## Step 1 — Generate tasks.md

Use `templates/tasks-template.md`. Four buckets in order:

1. **Setup** — install tools, create folders, set up repo. Boring "clean the workshop" tasks. Tiny.
2. **Foundational** — the walking skeleton. One task: stand up the full deployment pipeline end-to-end with a Hello World response at every integration point. Proves infrastructure before any feature exists.
3. **User Story slices** — one slice per PRD user story, ordered by the user-story-map top row (which gives MVP). Each slice = one full vertical from DB to UI. Tasks within a slice are sequential; slices themselves can be parallel where independent (mark `[P]`).
4. **Polish** — performance, cleanup, final UX touches.

Each task block:
```markdown
### TASK-XXX — <short title>

- **Req IDs covered:** <PRD Req IDs>
- **Files touched:** `<exact paths>`
- **Scope:** 2-5 min single AI invocation
- **Implementation:**
  ```<lang>
  <complete code, no placeholders>
  ```
- **Verify:** `<exact command>` should output `<exact expected output>`
- **Status:** TODO
```

Write eddie/<run-slug>/tasks.md but do not proceed to Step 2. Stop and ask the user: "Here is the task list. Any changes before I execute? Reply confirm to proceed, or tell me what to revise." You must receive an explicit confirmation (not just "okay" or "sure") that names the task list before executing the first task.                          

## Step 2 — Execute Setup (inline) and Foundational (subagent)

**Setup tasks** are the ONLY tasks that run inline. From the walking skeleton onward, every single task, refactor, and polish item must run as an isolated subagent invocation. No exceptions. "Small project" is not a reason to skip subagent isolation.. After each: run the verify command, confirm output, mark `DONE`.

**Foundational** (the walking skeleton) runs as a single subagent invocation with `model: opus, effort: low`. Pass it the full PRD + architecture-design.md context, the integration points to wire up, and the verify command. Returns the implementation; main session runs the verify and marks `DONE`.

## Step 3 — Execute User Story slices via TDD subagent isolation

For each slice (one user story = one slice):

**3.1 — Re-grounding header.** Construct the context prefix that will be injected to every subagent for this slice:
```
PRD section: <relevant PRD section>
Architecture decisions relevant: <relevant ADR IDs>
Acceptance criteria (Given-When-Then): <from PRD>
Files in scope: <list>
```

**3.2 — RED agent.** Spawn subagent using `tdd-red-agent.md` system prompt. Sees:
- The re-grounding header
- The Given-When-Then acceptance criteria
- NO implementation hints
Returns: a failing test file. Must verify the test fails (red) before proceeding.

**3.3 — GREEN agent.** Spawn fresh subagent using `tdd-green-agent.md`. Sees:
- The re-grounding header
- The failing test (with file path)
- NO instruction beyond "make this test pass with the minimum change"
Returns: the implementation. Run the test; verify it passes.

**3.4 — REFACTOR agent.** Spawn fresh subagent using `tdd-refactor-agent.md`. Sees:
- The re-grounding header
- The current code + tests
- Architecture conventions (relevant style/patterns)
Returns: cleaned-up code. Run all tests; must still pass.

**3.5 — Per-slice integration test.** Invoke `/eddie:evaluate` with `--slice <Req-ID>`. Evaluate writes the integration test for this slice, runs it, adds the row to RTM. Only proceed to next slice when this is `passing`.

**3.6 — Re-grounding self-check.** After every slice, run a quick subagent that's given only the PRD section + the implemented code, and asked: "list any acceptance criteria not addressed." Surface any gaps.

## Step 4 — Execute Polish tasks

Each Polish task runs as a subagent invocation with `model: opus, effort: low`. Same pattern as Foundational: pass context, get implementation, run verify in the main session, mark `DONE`.

## Step 5 — Hard gate

> Phase `implement` complete. Output: working code + per-slice integration tests in `tests/<run-slug>/`. You are NOT allowed to proceed to the next phase until the user explicitly confirms one of:  
> 1. **Proceed** to `evaluate` (final pass: E2E + LLM-judge + project-wide regression)
> 2. **Revise** any slice
> 3. **Stop** here

Silently updating config files or invoking the next phase skill without this confirmation violates the protocol.

On proceed: update `.eddie-config.json`, hand off to `/eddie:evaluate`.

## Adaptive behavior — non-software runs

For `craft-physical` runs (e.g., robotics SOP):
- Replace TDD subagent flow with: "execute step → user reports outcome → log result → next step."
- `tasks.md` becomes a step-by-step guide the user (or designated builder) follows physically.
- "Verify" becomes "user observes outcome matches expected."

For `process-redesign`: this phase is `skipped`; the SOP IS the deliverable from Design.

## Refusal conditions

Do not proceed if:
- Any task contains placeholders ("TODO", "TBD", pseudocode, "// add error handling here").
- Any task is larger than ~5 minutes of single-agent work.
- Any task is missing exact file paths or a verify command.
- The walking skeleton hasn't actually been verified end-to-end before starting slice work.
- A slice marked DONE doesn't have its integration test in the RTM.

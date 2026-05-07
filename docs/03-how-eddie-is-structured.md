# How EDDIE Is Structured

EDDIE has five phases, an orchestrator, and a hard rule: **never auto-flow past a question the user hasn't answered.**

## The five phases

| Phase | What it does | What you get |
|-------|-------------|--------------|
| **Explore** | Interview-style grilling. Justify the build cost. Surface who it's for and why now. | `interview.md` — Vision + Scope, with your verbatim quotes |
| **Define** | First-draft PRD, then probe edge cases, anti-patterns, YAGNI, out-of-scope. | `prd.md` — product requirements with Given-When-Then acceptance criteria |
| **Design** | Parallel research agents on existing solutions + technical feasibility. ADR-style architecture decisions. | `architecture-design.md` (or `approach.md` for non-software) |
| **Implement** | Vertical-slice task list. TDD via isolated subagents. Each slice built start-to-finish before moving on. | `tasks.md` + working code + tests |
| **Evaluate** | Integration tests per slice as you build. Final wrap-up: E2E + LLM-judge + coverage report. | `evaluation/rtm.md` + full project test suite |

Between every phase, EDDIE asks: **proceed, revise, or stop?** The user always controls the gate.

> EDDIE is a **pushback engine, not a judge.** It makes you think harder. It never tells you no.

## The orchestrator

The orchestrator runs at the start of every `/eddie` invocation. It checks whether you're resuming an existing run, starting a new one, or switching between runs. Then it asks the most important question:

**"What kind of project is this?"**

The orchestrator reads your project files and proposes a type. You confirm or override. The type is **per-run, not per-project** — so a software app today and a process redesign next month can coexist in the same repo.

## How project types change what runs

| Type | Phases that run | What changes |
|------|----------------|--------------|
| `software-app` | All 5 | Full architecture doc, TDD, automated tests |
| `software-script` | Explore, Define, Implement, Evaluate | Skips Design by default (can override) |
| `craft-physical` | All 5 | `approach.md` replaces architecture doc; step-by-step guides replace TDD; human-observation rubric replaces automated tests |
| `process-redesign` | Explore, Define, Design, Evaluate | Skips Implement — the redesigned SOP itself is the deliverable |
| `research-doc` | Explore, Define, Design | Stops after design; the document itself is the output |

This is the reason EDDIE is domain-agnostic. The same five-phase discipline adapts to what you're actually building.

## Multiple runs in one project

Every EDDIE run lives in its own folder: `<project>/eddie/<run-slug>/`. Each has its own `interview.md`, `prd.md`, `architecture-design.md`, `tasks.md`, `evaluation/`, and `.eddie-config.json`.

Tests accumulate across runs at `<project>/tests/<run-slug>/`. At the end of every run's Evaluate phase, the **full project test suite re-runs as a regression check** — so adding a feature can never silently break a previous one.

A new run can even declare `supersedes: <prior-Req-ID>` in its PRD. EDDIE marks the old row `SUPERSEDED`, archives the old test (kept for history, excluded from live suite), and updates the project-wide RTM.

## What EDDIE said no to — deliberately

These aren't missing features. They're intentional boundaries.

| We said no to | Why |
|---------------|-----|
| Multi-user collaboration | v1 is one human + Claude. Simplicity is the feature. |
| Databases or external integrations | Just markdown files. Implement may *recommend* GitHub Issues, but EDDIE doesn't manage it. |
| Automatic phase-skipping | EDDIE may *propose* skipping a phase, but you always decide. |
| Model routing, telemetry, GUI | Pure markdown skill files in Claude Code. |
| Mobile testing defaults | Deferred to v1+ — needs its own research pass first. |

The single most important "no" — the anti-goal — is this:

> "Extra steps are fine, but they must be **meaningful and critical to the design decision.**"

EDDIE never becomes heavy for its own sake. Every phase has to earn its place. The moment it becomes documentation theater, it's failed.

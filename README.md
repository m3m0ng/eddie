# EDDIE

**E**xplore → **D**efine → **D**esign → **I**mplement → **E**valuate.

A meta-skill plugin for Claude Code that walks non-technical builders through the same disciplined intent → design → create flow a professional product team would use. Research is a first-class citizen. Decisions are recorded with their *why*. Works for software, craft projects, process redesigns, and research write-ups.

> EDDIE is a **pushback engine, not a judge.** Every gate makes you think harder. The user always controls whether to proceed.

---

## Why this exists

I'm a non-IT founder building in public. I'd been using `superpowers:brainstorming` to design features for my site, and two failure modes kept biting me:

1. **No durable record of *why*.** The brainstorm gave easy multiple-choice answers and moved on. Six weeks later, when I went to extend something, nobody — including me — could remember why we picked B over A. There was no anchor doc.
2. **The AI defaulted to "what it knew"** rather than "what was actually most stable, efficient, or domain-correct." Without forced research, the agent would happily pick the obvious-but-not-best option, and being non-technical, I had no way to push back.

EDDIE fixes both: **forced domain research before architecture, and durable PRD + architecture documents that survive 3-month gaps.**

A third thing emerged while designing it: this discipline isn't software-specific. So EDDIE also runs for robotics build guides, process redesigns, and research write-ups — same five phases, adapted artifacts.

## Who it's for

- Non-technical founders, hobbyists, and process designers who want professional-grade output without a CS degree.
- Engineers who keep losing the thread between "we decided X" and "why did we decide X."
- Anyone who's been burned by AI-generated code that *looked* fine and broke six weeks later.

If you've used `superpowers:brainstorming` and felt the gap, EDDIE is the opinionated version that closes it.

## Install

System-wide:
```bash
claude plugin install https://github.com/m3m0ng/eddie
```

Project-local (for development or one-off use):
```bash
claude plugin install --plugin-dir ./eddie
```

## Usage

In any project:
```
/eddie
```

The orchestrator checks whether there's an active EDDIE run, classifies the project type (or resumes a prior run), and walks you through the active phases one at a time. Hard gates between every phase — you can always revise or stop.

## What you get

For each EDDIE run, a self-contained folder under `<project>/eddie/<run-slug>/`:

- `interview.md` — full Explore + scope synthesis with your verbatim quotes
- `prd.md` — product requirements with Given-When-Then acceptance criteria
- `architecture-design.md` (or `approach.md` for non-software) — the *why* behind every major decision, ADR-style
- `tasks.md` — vertical-slice task list keyed to PRD requirements
- `evaluation/rtm.md` — Requirements Traceability Matrix mapping each PRD requirement to the test that proves it
- `.eddie-config.json` — run state for resumption

Multiple runs per project coexist. Tests accumulate at `<project>/tests/<run-slug>/`. The full project test suite re-runs at the end of every EDDIE round as a regression check, so adding a feature can never silently break a previous one.

## Phases at a glance

| Phase | What it does | Output |
|-------|--------------|--------|
| **Explore** | Interview-style grilling. Justify the build vs. no-cost alternatives. | `interview.md` (Vision + Scope) |
| **Define** | First-draft PRD, then probe edge cases, anti-patterns, YAGNI. | `prd.md` |
| **Design** | Parallel research subagents on existing solutions + technical feasibility. ADR-style architecture decisions. | `architecture-design.md` or `approach.md` |
| **Implement** | Vertical-slice task list. TDD enforced via Red/Green/Refactor subagent isolation. | `tasks.md` + working code + tests |
| **Evaluate** | Testing Trophy default. Continuous companion to Implement (per-slice tests) + final wrap-up (E2E + LLM-judge). | `evaluation/rtm.md` + full project test suite |

## Adaptive by project type

The orchestrator classifies each run as one of: `software-app`, `software-script`, `craft-physical`, `process-redesign`, `research-doc`, `hybrid`. Phase activation adapts:

- `software-script` skips Design unless requested.
- `craft-physical` swaps `architecture-design.md` for the lighter `approach.md`, replaces TDD with step-by-step guides, and uses a human-observation rubric for Evaluate.
- `process-redesign` skips Implement (the redesigned SOP itself is the deliverable).
- `research-doc` runs Explore + Define + Design only.

Classification is **per-run**. A single project can host a `software-app` run today and a `process-redesign` run next month.

## Design principles

- **Pushback, not rejection.** Gates force reflection; the user always has the final call.
- **Research before resource commitment.** Borrowed from ADRs, Amazon's PR-FAQ, Google design docs, Shape Up, Stage-Gate, NASA mission gates — every survived methodology bakes this in.
- **Vertical slices over layered scaffolding.** Each user story is built start-to-finish across all layers before moving on. No "all the DB first, then all the backend."
- **Testing Trophy over Test Pyramid.** For AI-generated code, integration tests catch the wiring bugs at module seams that unit tests miss.
- **No documentation theater.** Every step has to earn its place by being meaningful and critical to a real design decision.

## What EDDIE is *not*

- Not multi-user. v1 is one human + Claude.
- Not an external integration. No DB, no Issues sync. Just markdown files.
- Not auto-flowing. Every phase boundary is a hard gate.
- Not a judge. EDDIE pushes back; the user always decides.
- Not heavyweight for its own sake. If a step doesn't move a real design decision forward, it doesn't exist.

## Skills in this plugin

- `eddie` — orchestrator (gatekeeper, run management, phase routing)
- `eddie-explore`
- `eddie-define`
- `eddie-design`
- `eddie-implement`
- `eddie-evaluate`

## Try it and tell me what breaks

EDDIE is v0.1. I'm dogfooding it on my own projects, but it'll only get better with other people running it on theirs. If you try it:

- Open an issue at https://github.com/m3m0ng/eddie/issues with what worked, what felt heavy, what you wish it asked.
- Share the run folder (or a redacted version) — I'd love to see what other domains it gets pulled into.

## License

MIT.

---

## Why EDDIE works this way

Curious about the research, the design decisions, and why specific patterns were chosen? The full story is in [`docs/`](./docs/).

# Lessons From Real Runs

EDDIE has been dogfooded on itself twice. Both runs revised EDDIE's own skill files. Both surfaced concrete lessons that fed back into the framework. This document records what was learned, in case you hit the same friction on your own runs.

## Run 1 — `edi-orch-pine` (orchestrator refactor)

The first real EDDIE run revised `skills/eddie/SKILL.md`. The orchestrator had been written with a lot of inherited assumptions — duplicated gate templates, duplicated "never auto-flow" rules, an introductory briefing step the user did not need.

### What got cut

- **Duplicate hard-gate template.** The orchestrator carried its own copy of the three-option gate question. Phase skills also carried their own. We picked one owner: **phase skills own gates; the orchestrator owns routing.** The orchestrator's copy was deleted.
- **Duplicate "never auto-flow" rule.** Stated twice in the orchestrator and again in every phase skill. Kept once at the top under operating rules; removed elsewhere.
- **The intro briefing step.** The orchestrator used to start each run by explaining what EDDIE is. Cut. The user already invoked `/eddie` — they know what they're starting. The first user-facing message now goes straight to project-type proposal.

### What got tightened

- **Auto-resume is phase-level only.** Mid-phase conversational state is never claimed to be preserved. The phase skill re-enters from the top of its own flow and reads any existing artifact on disk as input.
- **`project_type` is write-once.** It is consulted at run creation to derive `active_phases`, then never used for routing again. `active_phases` becomes the source of truth.
- **Clobber refusal.** If the orchestrator is about to write a file that has existing user content, it halts and surfaces the conflict.

### The lesson

**Where ownership is ambiguous, behavior diverges.** Two files both claiming to own the gate template means one will drift from the other. Pick one owner; delete the copy. This applies anywhere in EDDIE: gates, rules, frontmatter, language.

## Run 2 — `explore-skill-revision` (Explore phase rewrite)

The first run exposed Explore as the weakest phase. Run 2 fixed it. The full filed issue is at [m3m0ng/eddie#2](https://github.com/m3m0ng/eddie/issues/2).

### What was wrong

- The skill still referenced `interview-me`, a skill it had absorbed discipline from. Pure lineage clutter — end users have no idea what `interview-me` is.
- The interview was not relentless enough. Surface answers got accepted. Downstream PRDs were therefore crude.
- "Scope" was used without ever being defined. Loose terminology became AI slop.
- Section order (Vision → Audience → Why Now → Success Picture → Build vs Alternative → Anti-Goal → Out of Scope) was inherited from an "idea-bloom" template with no defended rationale.
- The skill announced phases out loud ("Step 1 — Vision interview", "1.1 Target audience", "1.2 Why now"). The user felt walked through a form, not interrogated.

### What changed

**Two-pass interrogation with a market-research subagent between.**

Explore now runs as two distinct interrogation modes:

1. **First-pass — raw intent.** Capture the operator's unvarnished vision, audience, why-now, success picture, anti-goal, and existing-stack inventory. No research yet. The operator answers unprimed.
2. **Market-research subagent.** A dedicated subagent (declared at `skills/eddie-explore/agents/eddie-market-research.md`) surveys the problem space — existing tools, composition options using the operator's stack, anti-patterns competitors fall into. Output goes to `research-findings.md`.
3. **Second-pass — evidence-armed.** Resume interrogation, weaving specific findings into specific re-probes. Contradictions between first-pass intent and research findings get surfaced first.

The PRD coming out of Explore + Define is now dense enough that Design doesn't have to re-interview the operator on problem-space questions.

### Slot-as-output-template, not procedural steps

The biggest single change. Instead of writing the skill as `## Step 1 — Vision interview` with numbered sub-bullets, the skill now declares the slots it must fill (vision, audience, why-now, success picture, build-vs-alternative, anti-goal, what-user-brings, gaps, out-of-scope) and instructs the AI to fill them in *any natural order the conversation allows*. The operator never sees "phase 1 begins now."

This pattern was confirmed in research by examining `superpowers:brainstorming`, `shape`, and `impeccable teach` — reference skills that all hold an internal checklist while running a free-form conversation.

### Build-vs-alternative as informational pushback

Originally framed as a gate ("did you check?"). Reframed as informational: the operator commits to building (or not) with full knowledge of what already exists. If they say "I still want to build," the skill accepts cleanly and records *"operator chose to build with knowledge of alternatives X, Y, Z"*. If they say "the alternative is fine," the skill pivots to a clean early exit instead of forcing the run forward.

The intent: **EDDIE never spends operator time building something they would have skipped if they had known X existed.** It is not a blocker on building.

### Stack-aware research

The research subagent receives `{{OPERATOR_STACK}}` as a first-class input. If the operator already runs n8n, the subagent suggests an n8n workflow before suggesting a net-new tool. **Composition over building from scratch** becomes the default recommendation.

### Gap-driven incremental research across runs

When a follow-up run references prior runs that already produced research, the subagent reads the prior findings and researches only the gaps — not the whole problem space from scratch. The operator confirms the gap list before the subagent runs. Findings record which came from prior runs (inherited) vs which are fresh.

### Trivial-mode skip — operator-driven, no heuristic

A first draft tried to detect triviality with keyword heuristics ("does the project description mention 'platform' or 'system'?"). Rejected. The operator knows their task better than a regex ever will. Final form: after first-pass intent is captured, the skill asks plainly:

> *I'm about to spawn the market-research subagent. Skip it? Skip only if this task is a single-purpose script where you're confident AI already knows the standard tools — e.g., "OCR a file", "parse a CSV". Default: don't skip.*

The operator answers yes or no. No heuristic, no signal counting, no project_type lookup. Robust to misclassification because the operator owns the call.

### Dedicated subagent via `agent.md`

This run established the pattern: when a phase skill needs a subagent that returns a structured, EDDIE-specific output, declare it via an `agent.md` file inside the skill folder. Prompt parameterization happens via `{{PLACEHOLDER}}` markers the calling skill fills at invocation time. Output format is fixed (required section headings) so downstream conversation can mechanically reference findings.

This pattern is now available for any future EDDIE phase that needs purpose-built subagents.

### Issues spun off

Three structural concerns surfaced during this run were too large to bundle. They were filed as separate GitHub issues for future runs:

- [#5 — EDDIE-wide glossary unification](https://github.com/m3m0ng/eddie/issues/5). "Scope," "intent," "vision," "anti-goal" appear across all phase skills with overlapping meaning. Needs one source-of-truth glossary that each phase references.
- [#6 — Phase decomposition revisit](https://github.com/m3m0ng/eddie/issues/6). The five-phase shape was inherited from human-team workflows. A redesign for AI execution may merge or split phases. Includes the question of whether `project_type` should be classified before or after Explore.
- [#7 — Subagent loader verification](https://github.com/m3m0ng/eddie/issues/7). The skill-scoped `agents/` directory is convention-based; Claude Code's loader behavior is not authoritatively documented. If subagent invocations fail in real use, this issue documents the verification approach and fallback options.

## Cross-run lessons

A pattern across both runs:

- **Ownership ambiguity caused both wastes.** In run 1, two files claimed the gate template. In run 2, "scope" was claimed by every phase and defined by none.
- **Cargo-culted inheritance is the second-biggest source of friction.** Both runs revealed inherited structure (briefing step, `interview-me` lineage, idea-bloom section order) that nobody had defended on first principles. EDDIE should periodically re-derive its own shapes.
- **The user's framing of "small" lies to you.** Issue #2 was filed as a comment dump. Treated as a real EDDIE run, it surfaced 19 user stories, three spun-off issues, and a structural redesign of the Explore phase. **Depth emerges from surface area, not from how the user framed the task.**

If you run EDDIE on your own project and feel like a phase is friction-heavy or terminologically loose, that observation deserves its own run — file an issue and treat it as a first-class problem.

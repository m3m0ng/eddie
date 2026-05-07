# What EDDIE Promises You

These are the commitments EDDIE makes to you as a user. Every design decision — every phase, every gate, every default — is tested against this list.

## You will know why you're building something before you build it

1. **When you start a new project, EDDIE interviews you through Explore.** You will be forced to articulate who the project is for and why it justifies the build cost — before you commit time or money.
2. **When your justification is weak, EDDIE pushes back — but never shuts you down.** You make the decision with your eyes open, not because the AI said yes.

## You will have durable records that survive breaks

3. **When Explore finishes, you get a PRD generated from your own words.** It is the single source of truth for *what* you're building, with anti-goals and out-of-scope items recorded verbatim from your own quotes.
4. **When Design finishes, you get an architecture document** that records each major decision with Context, Decision, Status, Consequences, and Alternatives Considered. When you come back in three months, you can see *why* a thing was chosen — not just what was chosen.
5. **When you resume a project after a break, EDDIE knows where you left off.** A small `.eddie-config.json` and an auto-maintained `eddie/index.md` tell the orchestrator your active run, project type, and current phase.

## You won't be at the mercy of the AI's defaults

6. **During Design, EDDIE spawns parallel research agents** that pull authoritative sources on existing solutions and technical feasibility. You're not stuck with whatever the AI happened to know.
7. **When your product itself uses AI, EDDIE auto-activates an LLM-as-judge layer.** A *different* model grades the outputs against a rubric you defined — so the subjective quality of AI outputs gets scored by something that didn't generate them.

## You will build in slices you can actually see working

8. **When Implement starts, your PRD is broken into vertical slices.** Each user story is built start-to-finish across all layers (database, backend, UI) before moving to the next. You see working features sooner — no drowning in scaffolding.
9. **Every task is tightly scoped:** exact file paths, complete code (no placeholders), a verify command with expected output, and a 2–5 minute scope. The AI agent cannot drift from your PRD because the bounds are explicit.
10. **When you do TDD, red/green/refactor is enforced by separate isolated subagents.** The test-writer sees only the spec. The implementer sees only the failing test. The refactorer sees neither. This is how you prevent the AI from silently deleting failing tests to make them pass.

## You will know whether your code actually works

11. **Tests are written as each vertical slice is built, not at the end.** Bugs are caught while the AI still has the implementation in context — not three weeks later when everyone has forgotten what the code was supposed to do.
12. **You get a Requirements Traceability Matrix** that maps every PRD requirement to the test that proves it. You can answer "is this requirement actually working?" with one glance.
13. **When you add a feature to an existing project, EDDIE re-runs all prior tests as a regression check.** Adding a feature can never silently break a previous one.
14. **When you replace a prior requirement** (e.g., "login by email" → "login by email + MFA"), you declare `supersedes: <Req-ID>` in the new run's PRD. The old test is archived, not deleted. The project-wide RTM marks it `SUPERSEDED`. History is preserved.

## You can use EDDIE for things that aren't software

15. **When your project is non-software** (robotics SOP, process redesign, research write-up), EDDIE adapts: `approach.md` replaces the architecture doc, step-by-step guides replace TDD, and a human-observation rubric replaces automated tests.
16. **The same project can host a software run today and a process-redesign run next month.** Project type is set per-run, not per-project.

## You are always in control

17. **Every phase ends with a hard gate:** proceed, revise, or stop. EDDIE never auto-flows past a question you haven't answered.
18. **Every phase produces something you can show** in under ~15 minutes of meaningful work. EDDIE never feels like documentation theater.
19. **You can install EDDIE system-wide with one command** and use it on any project, software or not.

## What EDDIE does *not* promise

These are the boundaries, not the gaps:

- Multi-user collaboration. v1 is one human + Claude.
- External tool management. EDDIE may recommend GitHub Issues or Notion, but it doesn't sync with them.
- Auto-skipping phases. EDDIE may *suggest* skipping a phase, but you always decide.
- Mobile testing defaults. Needs its own research pass before the first mobile run.
- GUI or web interface. Pure markdown skill files.

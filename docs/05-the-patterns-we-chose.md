# The Patterns We Chose

EDDIE borrows from many sources. Here's why specific patterns were chosen for implementation, evaluation, and orchestration — and what the research said about each one.

## Implementation: Why vertical slices?

Three complementary patterns work together: walking skeleton, vertical slice, and tracer bullet.

| Pattern | When you use it | What it proves |
|---------|----------------|--------------|
| **Walking skeleton** | First thing, before any features | The pipeline works end-to-end. "Hello World" at every integration point. |
| **Tracer bullet** | When you need to answer a specific technical question | "Will this API + this database actually work together?" Targeted, not wholesale. |
| **Vertical slice** | After the skeleton, for every user story | A real user can complete a real journey. Built across all layers at once. |

**The sequence is deliberate:** walking skeleton first (prove the pipeline) → vertical slices for user value (prove the product).

We rejected the "all the database first, then all the backend, then all the UI" approach. That leaves you with months of scaffolding and nothing you can show a user. Vertical slices mean you see a working feature after every slice — critical for momentum with a non-technical builder.

### Why isolated subagents for TDD?

Kent Beck calls TDD "a superpower with AI agents" — but with a warning: **agents will silently delete or disable failing tests to make them pass.** This is not hypothetical. It's been observed repeatedly.

The fix is subagent context isolation. Three separate agents:

1. **Red writer** — sees the spec only, writes a test that must fail
2. **Green implementer** — sees the failing test only, writes code to make it pass
3. **Refactorer** — fresh context, cleans up without knowing which tests were "supposed" to fail

This raised one developer's TDD skill activation from ~20% to 84%. It's not optional for AI-generated code. It's the engineering fix to AI-TDD cheating.

### Task discipline

Every task follows exact file paths, complete (non-pseudocode) code, 2–5 minute scope, a verify command with expected output, and no placeholders. This isn't bureaucracy — it's how you prevent drift when the agent forgets the broader spec.

## Evaluation: Why the Testing Trophy?

For AI-generated code, **Kent C. Dodds' Testing Trophy** beats the classic Test Pyramid.

The Pyramid says invest heavily in unit tests. The Trophy says invest heavily in integration tests. The research on AI-generated code sides strongly with the Trophy: **no direct correlation between a model's unit-test pass rate and overall code quality.** AI agents write functions that pass unit tests while shipping bugs at the seams between modules.

**EDDIE's four layers, from base to top:**

| Layer | What it is | Effort | Why it matters for AI code |
|-------|-----------|--------|---------------------------|
| **Static analysis** | TypeScript, ESLint — reads code without running it | Set up once, zero ongoing work | Catches AI typos and shape mismatches in <1 second |
| **Integration tests** | Multiple parts of the system together | ~60% of test effort | Catches the wiring bugs at module seams — where AI code actually breaks |
| **E2E tests** | Real browser driving real clicks | ~30% of effort, critical paths only | Catches "the page doesn't load" or "the button does nothing" |
| **Unit tests** | One tiny function in isolation | ~10% of effort, pure logic only | Only for `lib/` or `core/` — date math, parsing, business rules |

**Web apps:** Playwright for both integration and E2E. Its `codegen` feature — record your clicks, it writes the test — is the killer feature for non-programmers.

**Backend / API:** Vitest for integration. Playwright only if a UI exists.

**CLI tools:** Vitest against stdout/stderr. No E2E needed.

**Mobile:** Out of scope for v1.

**Non-software runs:** No automated tests. A human-observation rubric in plain language instead.

### Why LLM-as-judge needs a *different* model

If your product itself uses AI (chatbot, content generator), you can't unit-test "is this response helpful?" You need judgment.

The Anthropic-recommended pattern: write a rubric, ask the judge model to *think* about its score first, *then* output the score, then discard the reasoning. **The judge model must be different from the generating model.** This prevents the model from rubber-stamping its own output.

### Traceability — the Requirements Traceability Matrix

Every test file carries a comment header listing the Req IDs it covers. The RTM is a simple table:

| Req ID | PRD Section | Layer | Test File | Test Name | Status |

At the end of every run, EDDIE auto-generates a coverage report. Any PRD requirement with no corresponding test row is flagged. This is how you answer "is this actually working?" with one glance.

## Orchestration: Why this structure?

The orchestrator follows the `obra/superpowers` pattern: a gatekeeper meta-skill that mandates phase selection before any action. Each phase is its own skill with an explicit downstream handoff in prose.

**Why this works:**

- Skills are auto-selected by Claude matching your message against their `description` + `when_to_use` fields
- Phase skills load only on invocation, keeping the context budget clean
- Each phase writes artifacts to disk *as it progresses*, commits before handoff — so context loss never means starting over
- File-first discipline borrowed directly from `idea-bloom` and `superpowers`: write, then hand off

**Subagent boundaries — where EDDIE spawns agents vs. stays inline:**

| Phase | Spawns subagents? | Why |
|-------|------------------|-----|
| Explore | No | Needs conversation continuity with you |
| Define | No | Needs conversation continuity with you |
| Design | Yes | 2–3 parallel research agents (existing solutions, technical feasibility, domain expert) |
| Implement | Yes | TDD isolation: Red → Green → Refactor as separate agents |
| Evaluate | No | Needs conversation continuity for review and sign-off |

**The research agents in Design each get their own `.md` file in the skill folder.** They're dispatched in parallel, report back, and their findings feed into the architecture decisions you review together.

## The cross-run discipline

Tests live at `<project>/tests/<run-slug>/` so they accumulate across EDDIE rounds. The project-wide RTM at `eddie/rtm.md` auto-aggregates from per-run RTMs.

At the end of **every** run's Evaluate phase, the full project test suite runs. New code only ships if both new tests and prior tests pass. This is the regression guarantee — the reason you can add a feature six months later without breaking what you built today.

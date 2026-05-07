# What the Research Showed

Before building EDDIE, we studied three things: what AI-coding skills already do well, what kills planning frameworks, and which cross-domain methodologies have survived decades. The pattern was clearer than expected.

## What AI-coding skills already get right

A healthy ecosystem exists. `obra/superpowers`, GitHub's Spec Kit, Matt Pocock's skills collection, and Aider's `CONVENTIONS.md` have all converged on the same shape:

- Force a structured pre-coding phase before any implementation
- Write skills as plain markdown, not code
- Use phase gates that slow the agent down on purpose
- Persist decision artifacts so they survive session resets

These are good patterns. EDDIE borrows from all of them.

**But none of them do the two things EDDIE needs.**

1. **None make domain research a mandatory, first-class phase before architecture decisions.** Research is treated as optional — something you might do if you feel like it. EDDIE makes it non-negotiable.
2. **None target non-technical users.** Every surveyed skill assumes you're already a developer. The language, the defaults, the assumptions all require technical fluency. EDDIE is built for the person who doesn't have it.

## What kills planning frameworks (and how EDDIE avoids it)

Every era produces heavyweight planning frameworks — Waterfall, RUP, BDUF, design-thinking workshops, even modern ones like LangChain's agent orchestrators. They all die the same way:

> **Documentation accumulates faster than delivered value.** The artifacts become the thing, instead of the work being the thing. People quietly stop using them.

- Waterfall: 59% outright failure rate (Standish CHAOS), locked phases compound errors
- RUP: "Rational's worst mistake was to provide diagrams and templates." Artifacts became what people implemented instead of the practice.
- Design thinking → "innovation theater": Google brainstorming "didn't usually lead to built products"
- LangChain abandonment: "increased complexity, no perceivable benefit. After removal: we could just code."
- Gartner predicts 40%+ of agentic AI projects canceled by 2027 — gap between demo and deployed system invisible at design time

**The abandonment trigger is cognitive load.** The moment a framework asks you to update a system that feels like extra work — not part of the real work — you complete bias kicks in. You feel done after the task; updating the framework feels like unpaid labor.

**EDDIE's defense against this:**

- Every phase must produce something you can *show* in under ~15 minutes
- First drafts are auto-generated; you *correct* them, not author from a blank page
- EDDIE writes artifacts to disk *as work progresses*, not at the end — so context loss never means starting over
- The Implementation phase is always the unambiguous focus; prior phases serve it, not vice versa

## What survives — and what they share

Across engineering, product, design, and government, every methodology that's lasted 10+ years bakes in the same two non-negotiables:

1. **No build resources committed until research is complete**
2. **A written record of *why* that's specific enough for a stranger to reconstruct the reasoning six months later**

Survivors include:

| Methodology | What EDDIE stole from it |
|-------------|--------------------------|
| Architecture Decision Records (Michael Nygard) | Five-section format (Context, Decision, Status, Consequences, Alternatives) for every major choice |
| Amazon PR-FAQ / Working Backwards | Write the press release *first* — forces customer-value articulation before any code |
| Google design docs | "Alternatives Considered" is the load-bearing section — shows *why* the chosen solution beats the rejected ones |
| Shape Up (Basecamp) | Never bet on raw, unshaped ideas. Direct parallel to EDDIE's Explore → Define → commit flow |
| Stage-Gate (Cooper) | Every gate requires deliverables + criteria + outputs. No "approval without resources." |
| NASA Key Decision Points | Gated lifecycle with documented entrance/exit criteria; waivers require written justification |

**The survivability rule:** A methodology lives or dies by how hard it is to skip the research phase and the rationale-capture. If you can walk around them, you will. If you can't, the discipline becomes self-enforcing.

## The gap EDDIE fills

1. **Forced domain research** — no surveyed AI skill mandates it. Uncontested.
2. **Decision provenance for non-technical users** — ADRs exist for developers; nothing exists for non-technical founders.
3. **Domain-agnostic professional discipline** — every existing skill assumes software. EDDIE doesn't.

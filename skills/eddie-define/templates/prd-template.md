# <Run name> — PRD

## Problem Statement

One paragraph. The problem the target user is facing, told from their perspective. Concrete and specific — not "users want better X" but "[specific person in specific situation] cannot do [specific thing] because [specific cause]."

## Solution

One paragraph. What the user gets and what changes for them. No implementation language.

## User Stories

Numbered list. Every story uses Given-When-Then for acceptance criteria so they map directly to integration tests.

1. **As a** [actor], **I want** [feature], **so that** [benefit].
   - **Given** [precondition / context]
   - **When** [action]
   - **Then** [expected outcome]

2. **As a** [actor], **I want** [feature], **so that** [benefit].
   - **Given** [...]
   - **When** [...]
   - **Then** [...]

(Cover golden path, edge cases, admin/maintenance flows, failure modes.)

## Implementation Decisions

(Stub here; filled in during Design.)

- Major modules / workstreams
- Interfaces / handoffs between them
- Architectural decisions (with PRD Req IDs they support)
- Schema / data / material decisions
- API or other inter-party contracts

(Do NOT include file paths or code snippets — those rot.)

## Testing Decisions

(Stub here; filled in during Design / Evaluate.)

- Required layers (Static + Integration + critical-flow E2E)
- Optional layers (Unit / LLM-judge / Visual regression)
- Framework choice
- Cross-run inheritance + supersession rules

## Out of Scope

What is explicitly NOT in this run, with verbatim user quotes:

> "[user's verbatim phrasing on what's being cut and why]"

Be thorough. This section prevents re-litigating decisions later.

## Anti-goal

The single most important thing this run must never become — in the user's words:

> "[verbatim from interview.md]"

## Supersedes

If this run replaces requirements from a prior run:

- `supersedes: <prior-Req-ID>` from `<prior-run-slug>` — reason: [why this is being replaced]

## Open Questions

Anything Define couldn't resolve, carried into Design:

- ...

## Further Notes

- External dependencies
- Links to sibling docs in this run folder

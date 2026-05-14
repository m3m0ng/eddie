# <Run name> — PRD

## At a glance

<One short paragraph: what this run is + who it's for, in plain English. No EARS keywords, no IDs.>

Top requirements (plain English, no IDs):

- <Bullet 1>
- <Bullet 2>
- <Bullet 3 — up to 5 max>

Line we mustn't cross: <one-sentence paraphrase of the anti-goal in third person, no quotes>.

*(Each sub-element above is omitted if its source data is empty — no placeholder headers.)*

---

## Meta

- run_name: <slug>
- source: [interview.md](interview.md), [research-findings.md](research-findings.md) (if present)

## Problem

One short paragraph. The problem the target user is facing, told from their perspective. Concrete and specific — not "users want better X" but "[specific person in specific situation] cannot do [specific thing] because [specific cause]."

## Solution

One short paragraph. What the user gets and what changes for them. No implementation language.

## Requirements

Numbered REQ blocks. Each REQ carries one user story and at least one EARS-shaped acceptance criterion. Source-quote references go inline as `[Q-###]` (the verbatim text lives only in `interview.md`). Cover golden path, edge cases, admin/maintenance flows, and failure modes — be extensive.

### REQ-001 — <short title>

**As** <actor>, **I want** <feature>, **so that** <benefit>.

Acceptance criteria (EARS):

- **AC-001.1** — When <trigger>, the <system> shall <response>.
- **AC-001.2** — If <unwanted trigger>, then the <system> shall <response>.

Source quotes: [Q-001], [Q-003]

### REQ-002 — <short title>

**As** <actor>, **I want** <feature>, **so that** <benefit>.

Acceptance criteria (EARS):

- **AC-002.1** — ...
- **AC-002.2** — ...

Source quotes: [Q-...]

(repeat per requirement; non-functional requirements use the ubiquitous shape — `The <system> shall <response>.` — and if even that doesn't fit, the candidate is not a requirement and belongs in Out-of-scope or Anti-goal)

## Anti-goal

The single most important thing this run must never become — verbatim quote from `interview.md`:

> "[verbatim phrasing]"

## Out-of-scope

Verbatim cut quote(s) from `interview.md`:

> "[verbatim phrasing on what's being cut and why]"

Additional cuts (numbered, plain English):

1. ...
2. ...

Be thorough. This section prevents re-litigating decisions later.

## Supersedes

If this run replaces requirements from a prior run:

- `supersedes: <prior-Req-ID>` from `<prior-run-slug>` — reason: [why this is being replaced]

(Or: `None.` if this run doesn't supersede anything.)

## Deferred

Items carried forward — open questions for Design, cut user stories with reasons, or follow-up issues filed for adjacent skills:

- ...

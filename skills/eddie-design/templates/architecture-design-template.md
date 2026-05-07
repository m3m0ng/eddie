# <Run name> — Architecture Design

## System Overview

[One paragraph + ASCII diagram or component list. The shape of the thing.]

```
[diagram]
```

## Tech Stack

| Component | Choice | Alternative Considered | Reason |
|-----------|--------|------------------------|--------|
| Frontend | ... | ... | ... |
| Backend | ... | ... | ... |
| Database | ... | ... | ... |
| Hosting | ... | ... | ... |
| Testing (Integration) | ... | ... | ... |
| Testing (E2E) | ... | ... | ... |

## Architecture Decisions

(One ADR block per major decision. Order from most foundational to most peripheral.)

### Decision: [name]

**Context:** [Why this decision needs making. List PRD Req IDs that drive it.]

**Decision:** [What was decided.]

**Status:** Proposed / Accepted / Superseded

**Consequences:**
- **Enables:** [...]
- **Costs:** [...]
- **Risks:** [...]

**Alternatives Considered:**
- **[Alt 1]** — rejected because [reason from research].
- **[Alt 2]** — rejected because [reason].

---

(repeat ADR block per major decision)

## Integration Points & External Dependencies

| Service / API / Library | Version | Contract | Fallback if unavailable |
|-------------------------|---------|----------|-------------------------|
| ... | ... | ... | ... |

## Open Risks (carried into Implement)

- [Risk] — mitigation plan.

## PRD Alignment

| PRD Req ID | Supported By (decision name) |
|-----------|------------------------------|
| ... | ... |

(Every PRD user story must appear here. Stories without architectural support must either get an ADR or be cut from the PRD.)

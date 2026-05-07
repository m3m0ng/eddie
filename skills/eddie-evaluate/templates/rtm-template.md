# <Run name> — Requirements Traceability Matrix (RTM)

Maps each PRD requirement to the test(s) that prove it works.

| Req ID | PRD Section | Layer | Test File | Test Name | Status |
|--------|-------------|-------|-----------|-----------|--------|
| Req-001 | User Stories §1 | Integration | `tests/<run-slug>/signup.spec.ts` | `user can sign up with email` | passing |
| Req-002 | User Stories §2 | E2E | `tests/<run-slug>/e2e/login.spec.ts` | `happy-path login` | passing |
| Req-003 | User Stories §3 | Unit | `tests/<run-slug>/unit/dateMath.test.ts` | `correctly handles DST` | passing |
| Req-004 | AI Outputs §1 | LLM-Judge | `tests/<run-slug>/judge/helpfulness.ts` | `responses meet helpfulness threshold` | passing |
| ... | ... | ... | ... | ... | ... |

## Layer values

- `Static` — covered by TS/lint config (no specific test row needed but noted here)
- `Integration` — primary investment; one row per PRD user story
- `E2E` — Playwright browser tests for critical journeys (3-5 total)
- `Unit` — pure-logic functions only (dates, money, parsing, business rules)
- `LLM-Judge` — for AI-output features only

## Status values

- `passing` — last run was green
- `failing` — last run was red (must be fixed before run can be marked done)
- `pending` — test scaffolded but not yet run
- `superseded` — replaced by a newer run's test (archived; excluded from live suite)

## Coverage report (auto-regenerated on each `/eddie:evaluate` run)

**PRD Reqs without a live test row:**
- (list any uncovered Req IDs here; should be empty before the run is marked done)

**Tests not mapped to any PRD Req:**
- (list any orphan tests here; should be empty)

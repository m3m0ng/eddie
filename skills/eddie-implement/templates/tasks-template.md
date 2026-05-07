# <Run name> — Tasks

Vertical-slice task list. **Each user-story slice is built start-to-finish across all layers (DB → backend → UI) before moving to the next.** Never layer-by-layer.

---

## Bucket 1: Setup

(Boring "clean the workshop" tasks. Tiny.)

### TASK-S001 — <short title>

- **Req IDs covered:** N/A (setup)
- **Files touched:** `<exact paths>`
- **Scope:** 2-5 min
- **Implementation:**
  ```bash
  <complete commands>
  ```
- **Verify:** `<exact command>` should output `<expected>`
- **Status:** TODO

---

## Bucket 2: Foundational (Walking Skeleton)

(One task: stand up the full deployment pipeline end-to-end with "Hello World" at every integration point. Proves infrastructure before any feature exists.)

### TASK-F001 — Walking skeleton

- **Req IDs covered:** N/A (foundational)
- **Files touched:** `<exact paths covering all layers>`
- **Scope:** ~1 task per integration boundary
- **Implementation:**
  ```<lang>
  <complete code spanning all layers — DB stub, backend route, UI component>
  ```
- **Verify:** `<command that exercises end-to-end>` should output `Hello, EDDIE`
- **Status:** TODO

---

## Bucket 3: User Story Slices

(One slice per PRD user story, ordered by user-story-map top row. Slices marked `[P]` can run in parallel with the previous slice.)

### Slice — Req-XXX: <user story title>

**Tasks within the slice (sequential — DB → backend → UI):**

#### TASK-U001 — <DB layer for this slice>

- **Req IDs covered:** Req-XXX
- **Files touched:** `<exact paths>`
- **Scope:** 2-5 min
- **Implementation:**
  ```<lang>
  <complete code, no placeholders>
  ```
- **Verify:** `<exact command>` should output `<expected>`
- **Status:** TODO

#### TASK-U002 — <backend layer for this slice>

- **Req IDs covered:** Req-XXX
- ...

#### TASK-U003 — <UI layer for this slice>

- **Req IDs covered:** Req-XXX
- ...

**Slice exit criteria:**
- All slice tasks `DONE`
- `/eddie:evaluate --slice Req-XXX` reports the integration test passing
- RTM updated

---

(repeat for each PRD user story slice)

---

## Bucket 4: Polish

(Performance, cleanup, final UX. Small scope.)

### TASK-P001 — <short title>

- **Req IDs covered:** ...
- ...

---

## Status legend

- **TODO** — not started
- **DOING** — in progress (one task should hold this at a time)
- **DONE** — task complete, verify command passed
- **BLOCKED** — needs user input or external dependency

---
name: eddie-define
version: 0.2.0
description: Second phase of EDDIE. Drafts the PRD from the Explore interview, then probes edge cases (anti-patterns, YAGNI, out-of-scope items) and fills in blanks. Output is prd.md with EARS acceptance criteria (5 fixed shapes) so requirements are directly test-scaffoldable downstream. Hard gate at the end. Use when invoked by /eddie or directly via /eddie:define after Explore is complete.
---

# EDDIE — Define phase

You are the Define phase. Your job is to turn the Explore interview into a PRD with EARS-shaped acceptance criteria, then probe edge cases the user hasn't thought about, then gate to Design.

## Operating rules

- **Draft first, probe second.** Don't blank-page interrogate. Generate a first-draft PRD, then probe the gaps.
- **EARS acceptance criteria for every requirement.** Each AC is exactly one of 5 fixed shapes: ubiquitous (`The <system> shall <response>.`), event-driven (`When <trigger>, the <system> shall <response>.`), state-driven (`While <state>, the <system> shall <response>.`), unwanted-behavior (`If <trigger>, then the <system> shall <response>.`), or optional-feature (`Where <feature>, the <system> shall <response>.`). Closed grammar at fixed positions, regex-checkable, one assertion per line.
- **Append-only IDs.** `REQ-###` in prd.md, `AC-###.#` under each REQ, `Q-###` in interview.md (written back by this skill when quoting). 3-digit zero-padded, append-only — never renumber; gaps are fine.
- **Verbatim quotes for anti-goal and out-of-scope.** Never paraphrase those — they are constraints.
- **At-a-glance section at the top of prd.md.** Operator-readable, no-jargon prose for the human reader. The rest of the file is structured spec for the downstream AI reader.
- **File-first.** Write `prd.md` as you draft and update.

## Interview discipline

<!-- SHARED-CANONICAL — must remain byte-identical across every eddie
     phase skill that runs interviews (currently eddie-explore,
     eddie-define, eddie-design, and eddie-evaluate). Do not edit one
     copy without diffing the others. Drift here is a bug; tracked by
     the cross-skill label, not a runtime reference. -->

Non-negotiable for every interview interaction:

1. **One question at a time.** Never present a numbered list of questions. Ask one, wait, ask the next based on what they said.
2. **Recommend an answer with each question.** Especially when probing edge cases, YAGNI, or anti-patterns — say "I'd cut this from v1 because X. Push back if you disagree." Don't ask blank-canvas "what edge cases should we cover?"
3. **Skeptical tone, relentless within scope.** A weak answer ("I dunno, sure") gets one more probe — at minimum surface what *you* would pick and why.
4. **One decision at a time, within the current phase's scope.** Don't wander into other phases' decisions.
5. **Read instead of ask when possible.** If the codebase already shows what an existing module does, read it; only ask the user about behavior the code can't tell you.
6. **Rephrase based on prior answers.** "You said earlier you don't want to support mobile in v1 — does that change how the signup flow needs to work?"

**Anti-pattern:** Numbered question lists. Always one at a time.

## Inputs

- `eddie/<run-slug>/interview.md` (Explore output)
- `eddie/<run-slug>/research-findings.md` if present (Explore's market-research subagent output) — read in full; surface in the PRD any findings that affect user-story scope or out-of-scope cuts
- `eddie/<run-slug>/.eddie-config.json`
- Any referenced prior-run PRDs

## Step 1 — Draft the PRD from interview.md

The PRD opens with a `## At a glance` section: one short paragraph summarizing what + who, 3–5 plain-English bullets of top requirements (no EARS keywords, no IDs), and one paraphrased anti-goal line in third person. Omit sub-elements whose source data is empty. This section serves the operator skimming for scope confirmation; the rest of the file serves downstream AI readers.

Read the interview thoroughly. If `research-findings.md` exists, weave its findings into the PRD's Problem Statement and Out-of-Scope sections explicitly (do not replace operator intent with research — weave). Use the template at `templates/prd-template.md`. Fill in:

- Problem statement (the *why* in user's words)
- Solution (one paragraph, no implementation language)
- User stories with EARS acceptance criteria — **be extensive**: golden path, edge cases, admin/maintenance, failure modes. When you reference interview content verbatim, write the quote into `interview.md` as a `Q-###` anchor (append-only) and reference it from `prd.md` as `[Q-###]` — the quote text lives only in `interview.md`
- Anti-goal (verbatim quote from interview.md)
- Out-of-scope (verbatim quotes)
- Deferred items (anything Explore couldn't resolve, carried forward to Design; cut stories with reasons; linked follow-up issues)

Write the draft to `eddie/<run-slug>/prd.md` immediately.

## Step 2 — Show the user the draft and probe gaps

Show the user the draft (or summarize the major sections). Then probe:

**2.1 — YAGNI check.** Walk through the user stories. For each, ask: "Is this needed in v1, or can it wait?" Cut anything the user can't justify *now*.

**2.2 — Anti-pattern probe.** Look for common AI-build anti-patterns the PRD may have wandered into:
- Building a generic "platform" when a specific tool would do
- Multiple personas when one would suffice for v1
- Configuration / customization features no v1 user has asked for
- Premature abstraction layers

Surface each one you spot. Ask the user to keep or cut.

**2.3 — Edge case probe.** For each user story, ask "what happens when…":
- Input is empty / malformed / max length / unicode / etc.
- Network / DB / external service fails
- Two users (or two attempts) collide
- The action is repeated
- The action is undone

Capture the user's answers as additional acceptance criteria or as out-of-scope items.

**2.4 — Cross-run check** (only if `references_prior_runs` is non-empty). For each user story, ask: "Does this *replace* anything from a prior run? If yes, which Req ID?" Capture as `supersedes` in `.eddie-config.json` and add to the PRD.

## Step 3 — Update prd.md

Append all confirmed additions, cuts, and supersession declarations to `prd.md`. Re-show the major sections to the user.

## Step 3.5 — Advisory validation pass

Before the hard gate, run these checks and surface results as advisory warnings (not refusal-blocking — the operator chooses whether to proceed):

**EARS shape check.** Every AC line should match exactly one of:

| Shape | Regex |
|---|---|
| Ubiquitous | `^The .+ shall .+\.$` |
| Event-driven | `^When .+, the .+ shall .+\.$` |
| State-driven | `^While .+, the .+ shall .+\.$` |
| Unwanted | `^If .+, then the .+ shall .+\.$` |
| Optional | `^Where .+, the .+ shall .+\.$` |

For each line failing all five, surface it to the operator with the closest-matching shape as a hint.

**Anchor resolution check.** Every `[Q-###]` reference in `prd.md` should resolve to a `Q-###` anchor in `interview.md`. List any that don't.

## Step 4 — Hard gate

> Phase `define` complete. Output written to `eddie/<run-slug>/prd.md`. Three options:
> 1. **Proceed** to `design` (or to `implement` if Design is skipped for this project type)
> 2. **Revise** the current phase
> 3. **Stop** here

On proceed:
1. Update `.eddie-config.json`.
2. Hand off to next phase.

## Refusal conditions

Do not proceed if:
- Any user story lacks at least one EARS-shaped acceptance criterion.
- Anti-goal is missing or paraphrased instead of verbatim.
- Out-of-scope section is empty (every PRD has at least 3–5 explicit cuts).
- Deferred list contains items that Define could have resolved with one more probe.

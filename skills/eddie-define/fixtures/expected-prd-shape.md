# sample-run — PRD (expected shape after revision)

## At a glance

A CLI tool that summarizes word counts per section of a single markdown file. Built for a solo technical writer who wants to spot section-by-section growth in their docs without manually splitting files.

Top requirements (plain English, no IDs):
- Read one markdown file passed on the command line.
- Group word counts by heading level and emit a summary.
- Exit with a non-zero status and a clear error if the input isn't a markdown file.

Line we mustn't cross: the tool must remain a single-file, single-shot summarizer — no analytics platform, no dashboards, no historical tracking.

---

## Meta

- run_name: sample-run
- source: [interview.md](interview.md)

## Problem

A solo technical writer maintaining a docs.md file cannot spot which sections are growing because existing word-count tools count the whole file. Manually splitting the file before counting is friction the writer wants removed.

## Solution

A small CLI that reads a single markdown file, walks its heading structure, and emits a per-section word count summary. One file in, one summary out.

## Requirements

### REQ-001 — Read and parse a single markdown input file

**As** the technical writer, **I want** the tool to accept a markdown file path on the command line, **so that** I can run it against my docs without configuration.

Acceptance criteria (EARS):
- **AC-001.1** — When the operator runs the tool with a valid markdown file path as the first argument, the tool shall read the file and parse its heading structure.
- **AC-001.2** — If the first argument is missing or is not a readable file, then the tool shall exit with status 1 and a clear error message.
- **AC-001.3** — If the file is empty, then the tool shall exit with status 0 and emit an empty summary.

Source quotes: [Q-001], [Q-002]

### REQ-002 — Group word counts by heading level

**As** the technical writer, **I want** the summary grouped by heading, **so that** I can see which sections grew or shrank.

Acceptance criteria (EARS):
- **AC-002.1** — When the tool parses a file, the tool shall associate every word with the most recent heading at any level.
- **AC-002.2** — When emitting the summary, the tool shall list headings in document order with their word count.

Source quotes: [Q-003]

### REQ-003 — Emit a human-readable summary

**As** the technical writer, **I want** the output to be readable on the terminal, **so that** I can scan it without further processing.

Acceptance criteria (EARS):
- **AC-003.1** — The tool shall emit each heading and count as one line on stdout in the form `<heading> — <count> words`.
- **AC-003.2** — The tool shall emit a final line with the total word count.

Source quotes: [Q-004]

## Anti-goal

> "It must never become a full documentation analytics platform — no dashboards, no integrations, no multi-file support in v1. One file in, one summary out."

## Out-of-scope

> "No HTML rendering, no PDF support, no historical tracking, no diff-against-yesterday. Just current-state summary of a single markdown file."

Additional cuts:
1. No multi-file or directory input — single file only.
2. No configuration file or flags beyond the input path.
3. No coloured output, no progress indicators.

## Supersedes

None.

## Deferred

- Future: optional diff-against-previous-run if the writer asks for it (not in scope; would warrant its own run).

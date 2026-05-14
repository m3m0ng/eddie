# Explore — sample-run (fixture for define-skill-revision testing)

## Vision

A small CLI tool that takes a markdown file as input and outputs a word-count summary grouped by heading level. Built for technical writers who want to know which sections of their docs are growing or shrinking over time.

## Audience

Solo technical writer maintaining a single docs repo, comfortable on the terminal, working alone.

## Why now

Existing word-count tools count the whole file. The writer wants per-section counts so they can spot bloat in specific sections without manually splitting the file.

## Success picture

> "I run the command on my docs.md after each writing session, see which sections grew, and decide what to trim before the next session."

## Anti-goal

> "It must never become a full documentation analytics platform — no dashboards, no integrations, no multi-file support in v1. One file in, one summary out."

## What user brings

- Python 3.11
- A docs repo with a single `docs.md` file (no front-matter requirements)
- Terminal: bash on macOS

## Out-of-scope

> "No HTML rendering, no PDF support, no historical tracking, no diff-against-yesterday. Just current-state summary of a single markdown file."

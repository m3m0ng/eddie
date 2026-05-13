#!/usr/bin/env bash
# Stories 9, 11: verbatim anti-goal/out-of-scope capture + hard-gate template
set -e
F=skills/eddie-explore/SKILL.md

fail=0
# Story 9: verbatim capture rule
grep -qiE "verbatim|blockquote|exact wording|exact phrasing" "$F" || { echo "FAIL: missing verbatim-capture rule"; fail=1; }

# Story 11: hard-gate three-option template (Proceed/Revise/Stop options, may span multiple lines)
grep -q "Three options" "$F" && \
  grep -qE "\*\*Proceed\*\*" "$F" && \
  grep -qE "\*\*Revise\*\*" "$F" && \
  grep -qE "\*\*Stop\*\*" "$F" || { echo "FAIL: missing three-option hard-gate template"; fail=1; }
grep -qiE "phase.{0,5}explore.{0,5}complete" "$F" || { echo "FAIL: missing hard-gate completion phrase"; fail=1; }

[ "$fail" -eq 0 ] && echo "PASS: gates + verbatim capture" || exit 1

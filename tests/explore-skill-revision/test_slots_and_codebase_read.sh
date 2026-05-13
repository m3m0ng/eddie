#!/usr/bin/env bash
# Stories 4, 5, 10, 15: codebase-read-first + slot-as-output-template + refusal on empty load-bearing slots
set -e
F=skills/eddie-explore/SKILL.md

fail=0
# Story 4: codebase-read instruction near the top
head -80 "$F" | grep -qiE "read.*(README|codebase)" || { echo "FAIL: missing codebase-read instruction near top"; fail=1; }

# Story 10/5: all 9 slots present somewhere
for slot in "vision" "audience" "why now" "success picture" "build.{1,5}alternative" "anti.{0,1}goal" "what.*brings" "gaps" "out.of.scope"; do
  grep -qiE "$slot" "$F" || { echo "FAIL: missing slot '$slot'"; fail=1; }
done

# Story 15: refusal rule on empty anti-goal or success-picture
grep -qiE "refusal rule|do not write the hard gate|refuse.{0,40}gate" "$F" || { echo "FAIL: missing refuse-gate-on-empty-slot rule"; fail=1; }
grep -qiE "anti.{0,1}goal.{0,80}(empty|missing|unfilled)|(empty|missing|unfilled).{0,80}anti.{0,1}goal" "$F" || { echo "FAIL: missing anti-goal empty-slot refusal"; fail=1; }

[ "$fail" -eq 0 ] && echo "PASS: slots + codebase-read" || exit 1

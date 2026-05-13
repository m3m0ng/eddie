#!/usr/bin/env bash
# Story 14: trivial-mode operator-driven skip (no heuristic)
set -e
F=skills/eddie-explore/SKILL.md

fail=0
# Plain-language prompt with examples
grep -qiE "single.purpose script|trivial.{1,20}(skip|task)" "$F" || { echo "FAIL: missing trivial-mode prompt"; fail=1; }
grep -qiE "OCR|parse a CSV|standard tools" "$F" || { echo "FAIL: missing concrete trivial examples (OCR/CSV/etc.)"; fail=1; }

# Default is don't skip
grep -qiE "default.{1,15}(don.{0,2}t skip|not skip|spawn research)" "$F" || { echo "FAIL: missing 'default: don't skip' wording"; fail=1; }

# Anti-pattern: no keyword heuristic listed
if grep -qiE "(platform.*app.*system|dashboard.*backend.*database).*(detect|heuristic|signal)" "$F"; then
  echo "FAIL: SKILL.md appears to contain a keyword-based heuristic — must be operator-driven only"
  fail=1
fi

[ "$fail" -eq 0 ] && echo "PASS: trivial-mode" || exit 1

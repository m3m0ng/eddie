#!/usr/bin/env bash
# Story 8: build-vs-alternative as informational pushback with clean exit
set -e
F=skills/eddie-explore/SKILL.md

fail=0
# Informational framing
grep -qiE "informational|not adversarial|not.{1,5}push.{1,15}away" "$F" || { echo "FAIL: missing 'informational not adversarial' framing"; fail=1; }

# Both branches handled
grep -qiE "still.{1,10}(wish|want).{0,10}build" "$F" || { echo "FAIL: missing 'do you still wish to build' branch"; fail=1; }
grep -qiE "(alternative.{1,15}fine|operator chose.{1,15}alternative|use the alternative)" "$F" || { echo "FAIL: missing 'operator chose alternative' branch"; fail=1; }

# Knowledge-of-alternatives recording
grep -qiE "knowledge of alternatives|with knowledge of" "$F" || { echo "FAIL: missing 'with knowledge of alternatives' recording rule"; fail=1; }

[ "$fail" -eq 0 ] && echo "PASS: build-vs-alternative" || exit 1

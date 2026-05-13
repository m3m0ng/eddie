#!/usr/bin/env bash
# Stories 1, 2, 3: top-of-file non-negotiable conversation rules
set -e
F=skills/eddie-explore/SKILL.md
head -80 "$F" > /tmp/head.txt

fail=0
grep -qi "one question" /tmp/head.txt || { echo "FAIL: missing 'one question' rule"; fail=1; }
grep -qi "recommend" /tmp/head.txt || { echo "FAIL: missing 'recommend' rule"; fail=1; }
grep -qi "tradeoff" /tmp/head.txt || { echo "FAIL: missing 'tradeoff' instruction"; fail=1; }
grep -qiE "re-probe|probe again|push back" /tmp/head.txt || { echo "FAIL: missing weak-answer re-probe rule"; fail=1; }
grep -qiE "natural|free.form|not.*fixed order|opportunistic" /tmp/head.txt || { echo "FAIL: missing natural-conversation rule"; fail=1; }

# Anti-pattern: must NOT contain "Step 1 — Vision" / "Step 2 — Hidden" / "Step 3 — Scope" procedural framing
if grep -qE "^## Step [0-9]+ — (Vision|Hidden|Scope)" "$F"; then
  echo "FAIL: SKILL.md still uses procedural Step 1/Step 2/Step 3 framing (anti-goal E)"
  fail=1
fi

[ "$fail" -eq 0 ] && echo "PASS: non-negotiables" || exit 1

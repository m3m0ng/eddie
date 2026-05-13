#!/usr/bin/env bash
# Stories 5, 6, 7, 13: two-pass flow, research subagent invocation, contradiction handling
set -e
F=skills/eddie-explore/SKILL.md

fail=0
# Two-pass structure named explicitly
grep -qiE "two.{0,3}pass|first.pass.*second.pass|interrogate.{1,30}research.{1,30}interrogate" "$F" || { echo "FAIL: missing two-pass description"; fail=1; }

# Story 5: research not spawned until first-pass slots filled
grep -qiE "(after|once|when).*(first.pass|slots? filled|vision|raw intent)" "$F" || { echo "FAIL: missing first-pass-before-research rule"; fail=1; }

# Story 6: subagent output goes to research-findings.md
grep -q "research-findings.md" "$F" || { echo "FAIL: missing 'research-findings.md' reference"; fail=1; }

# Story 7: second-pass cites specific findings
grep -qiE "(cite|reference|weave|specific).*find|second.pass.{0,20}find" "$F" || { echo "FAIL: missing 'cite findings in second pass' rule"; fail=1; }

# Story 13: contradiction handling
grep -qiE "contradict|conflict" "$F" || { echo "FAIL: missing contradiction-handling instruction"; fail=1; }

# Subagent invocation mentioned
grep -qE "eddie-market-research|subagent_type" "$F" || { echo "FAIL: missing subagent invocation reference"; fail=1; }

[ "$fail" -eq 0 ] && echo "PASS: two-pass + research subagent" || exit 1

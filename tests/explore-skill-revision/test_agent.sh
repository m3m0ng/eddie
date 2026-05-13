#!/usr/bin/env bash
# Stories 18, 18a, 18b, 6: eddie-market-research agent.md content
set -e
F=skills/eddie-explore/agents/eddie-market-research.md

[ -f "$F" ] || { echo "FAIL: $F does not exist"; exit 1; }

fail=0
# Frontmatter
head -10 "$F" | grep -q "^name: eddie-market-research$" || { echo "FAIL: missing frontmatter 'name: eddie-market-research'"; fail=1; }
head -10 "$F" | grep -q "^description:" || { echo "FAIL: missing frontmatter 'description'"; fail=1; }
head -10 "$F" | grep -q "^tools:" || { echo "FAIL: missing frontmatter 'tools'"; fail=1; }
head -10 "$F" | grep -q "^model:" || { echo "FAIL: missing frontmatter 'model'"; fail=1; }

# Placeholder markers
for m in "{{PROBLEM_STATEMENT}}" "{{OPERATOR_STACK}}" "{{PRIOR_RESEARCH_SUMMARY}}" "{{GAP_LIST}}" "{{RESEARCH_MODE}}"; do
  grep -qF "$m" "$F" || { echo "FAIL: missing placeholder $m"; fail=1; }
done

# Required output sections
for s in "## Existing solutions" "## Composition options using your existing stack" "## Anti-patterns observed" "## Open gaps"; do
  grep -qF "$s" "$F" || { echo "FAIL: missing required output section '$s'"; fail=1; }
done

# Story 18a: prefer composition
grep -qiE "(prefer|favor).{1,15}composition|composition.{1,15}(over|first|before)" "$F" || { echo "FAIL: missing 'prefer composition' instruction"; fail=1; }

# Story 18b: gap-driven mode handling
grep -qiE "gap.driven|GAP_LIST" "$F" || { echo "FAIL: missing gap-driven mode handling"; fail=1; }

[ "$fail" -eq 0 ] && echo "PASS: agent.md content" || exit 1

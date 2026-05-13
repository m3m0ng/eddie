#!/usr/bin/env bash
# Story 16: zero interview-me references in revised eddie-explore SKILL.md
set -e
F=skills/eddie-explore/SKILL.md
count=$(grep -c "interview-me" "$F" || true)
if [ "$count" -ne 0 ]; then
  echo "FAIL: found $count 'interview-me' references in $F"
  exit 1
fi
echo "PASS: hygiene"

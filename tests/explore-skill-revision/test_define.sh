#!/usr/bin/env bash
# Story 19: eddie-define reads research-findings.md
set -e
F=skills/eddie-define/SKILL.md

grep -q "research-findings.md" "$F" || { echo "FAIL: eddie-define missing research-findings.md reference"; exit 1; }
echo "PASS: eddie-define adjustment"

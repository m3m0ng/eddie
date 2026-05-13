#!/usr/bin/env bash
# Story 17: orchestrator's user-facing description mentions Explore's two-pass shape
set -e
F=skills/eddie/SKILL.md

grep -qiE "two.{0,3}pass|research subagent.{1,30}(explore|between)" "$F" || { echo "FAIL: orchestrator missing Explore two-pass description"; exit 1; }
echo "PASS: orchestrator briefing"

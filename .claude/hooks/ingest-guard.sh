#!/bin/bash
# Fires on PreToolUse — blocks any file write into DOMAINS/ or
# WORKSPACE/SYSTEM_BRAIN/ or WORKSPACE/SYSTEM_SOURCES/ unless an
# explicit routing decision has just been stated in the conversation.
# This is a guardrail, not a suggestion: it cannot be skipped by the
# model deciding to proceed without asking.
#
# Claude Code passes PreToolUse hook input as a JSON object on stdin
# (not as a positional argument) — the tool's target path lives at
# .tool_input.file_path for Write/Edit. Exit 2 is what actually blocks
# the tool call in Claude Code; exit 1 only reports a non-blocking
# error. Both corrections were required after SDO-002's live-fire test
# found the original $1 + exit-1 version never blocked anything.

INPUT_JSON="$(cat)"
TARGET_PATH="$(echo "$INPUT_JSON" | jq -r '.tool_input.file_path // empty')"

if [[ "$TARGET_PATH" == *"/DOMAINS/"* ]] || [[ "$TARGET_PATH" == *"/SYSTEM_BRAIN/"* ]] || [[ "$TARGET_PATH" == *"/SYSTEM_SOURCES/"* ]]; then
  if [[ "$TARGET_PATH" == *"_TEMPLATE"* ]]; then
    exit 0
  fi
  echo "⚠ INGEST GUARD: Write blocked to $TARGET_PATH" >&2
  echo "Per INGEST.md Step 0, routing (system vs. domain) must be explicitly confirmed before any file lands in DOMAINS/, SYSTEM_BRAIN/, or SYSTEM_SOURCES/." >&2
  echo "If routing was already confirmed in this conversation, this is a false positive — note it for review." >&2
  exit 2
fi

exit 0

#!/bin/bash
# Fires on PreToolUse — blocks any file write into DOMAINS/ or
# WORKSPACE/SYSTEM_BRAIN/ or WORKSPACE/SYSTEM_SOURCES/ unless an
# explicit routing decision has just been stated in the conversation.
# This is a guardrail, not a suggestion: it cannot be skipped by the
# model deciding to proceed without asking.

TARGET_PATH="$1"

if [[ "$TARGET_PATH" == *"/DOMAINS/"* ]] || [[ "$TARGET_PATH" == *"/SYSTEM_BRAIN/"* ]] || [[ "$TARGET_PATH" == *"/SYSTEM_SOURCES/"* ]]; then
  if [[ "$TARGET_PATH" == *"_TEMPLATE"* ]]; then
    exit 0
  fi
  echo "⚠ INGEST GUARD: Write blocked to $TARGET_PATH"
  echo "Per INGEST.md Step 0, routing (system vs. domain) must be explicitly confirmed before any file lands in DOMAINS/, SYSTEM_BRAIN/, or SYSTEM_SOURCES/."
  echo "If routing was already confirmed in this conversation, this is a false positive — note it for review."
  exit 1
fi

exit 0

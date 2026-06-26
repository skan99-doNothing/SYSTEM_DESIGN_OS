#!/bin/bash
# Fires on SessionStart. Confirms the CLAUDE.md actually loaded is the
# real one for THIS project, not a stale copy or a different project's
# file picked up by mistake. Checks for the sync-marker comment added
# in CC-028 — if it's missing, something is wrong with which file
# loaded, and this surfaces that immediately instead of silently.

EXPECTED_MARKER="mirrored in AGENTS.md for agent-agnostic compatibility"
CLAUDE_MD_PATH="$(pwd)/CLAUDE.md"

if [ ! -f "$CLAUDE_MD_PATH" ]; then
  echo "⚠ SESSION START CHECK: No CLAUDE.md found at $CLAUDE_MD_PATH"
  exit 1
fi

if ! grep -q "$EXPECTED_MARKER" "$CLAUDE_MD_PATH"; then
  echo "⚠ SESSION START CHECK: CLAUDE.md at $CLAUDE_MD_PATH does not contain the expected SYSTEM_DESIGN_OS marker."
  echo "This may not be the correct CLAUDE.md for this project — verify before proceeding."
  exit 1
fi

echo "✓ CLAUDE.md verified: correct file for SYSTEM_DESIGN_OS loaded."
exit 0

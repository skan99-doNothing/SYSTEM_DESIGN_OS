#!/bin/bash
# Last live-fire tested: 2026-07-02 (SDO-017 creation test; re-exercised live on every real commit since, incl. this session's own commits)
# Fires on PreToolUse for Bash — blocks any `git commit` whose message
# references an SDO-XXX ID that has no corresponding entry in
# WORKSPACE/EVOLUTION_LOG.md yet.
#
# WHY THIS EXISTS (SDO-017): SDO-016 was committed (e45b3fe) with no
# EVOLUTION_LOG.md entry at all — CLAUDE.md's own non-negotiable ("log
# real decisions... as part of doing the work, not as a separate step
# afterward") was silently skipped, and the only way it was caught was
# an expensive manual cross-check of STATUS.md/EVOLUTION_LOG.md/git log
# during a `resume`. This is the same soft-rule failure shape SDO-015
# already flagged for Rule 9's checkpoint timing: a rule that depends on
# the model remembering under pressure will eventually get skipped.
# This hook converts the log-entry requirement into a mechanical
# forcing function, same category of fix as ingest-guard.sh (SDO-002/012).
#
# Claude Code passes PreToolUse hook input as JSON on stdin —
# tool_input.command for Bash. Exit 2 blocks the tool call.
#
# KNOWN, HONEST LIMITATION: this only checks that the SDO-ID string
# appears somewhere in EVOLUTION_LOG.md, not that the entry is
# well-formed or substantive — a bare mention would pass. It also only
# catches commits made via the Bash tool inside this harness; a commit
# made outside Claude Code (e.g. directly in a terminal) is not covered.

INPUT_JSON="$(cat)"
TOOL_NAME="$(echo "$INPUT_JSON" | jq -r '.tool_name // empty')"

if [[ "$TOOL_NAME" != "Bash" ]]; then
  exit 0
fi

CMD="$(echo "$INPUT_JSON" | jq -r '.tool_input.command // empty')"

if ! [[ "$CMD" =~ (^|[[:space:]\;\&\|])git[[:space:]]+commit([[:space:]]|$) ]]; then
  exit 0
fi

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
EVOLUTION_LOG="$PROJECT_DIR/WORKSPACE/EVOLUTION_LOG.md"

# SDO IDs referenced anywhere in the full commit command (covers both
# `-m "..."` and this repo's HEREDOC commit-message convention).
IDS="$(echo "$CMD" | grep -oE 'SDO-[0-9]+' | sort -u)"

if [[ -z "$IDS" ]]; then
  exit 0
fi

MISSING=""
while IFS= read -r ID; do
  if ! grep -qF -- "$ID" "$EVOLUTION_LOG" 2>/dev/null; then
    MISSING="$MISSING $ID"
  fi
done <<< "$IDS"

if [[ -n "$MISSING" ]]; then
  echo "⚠ SDO LOG GUARD: blocked — commit references$MISSING with no matching entry yet in WORKSPACE/EVOLUTION_LOG.md." >&2
  echo "Per CLAUDE.md's non-negotiable, the log entry must exist BEFORE the commit, not as a follow-up. Write it, then retry." >&2
  exit 2
fi

exit 0

#!/bin/bash
# Last live-fire tested: 2026-07-02 (SDO-018 creation test; confirmed firing organically and throttling correctly mid-session)
# Fires on PostToolUse (broad matcher) — Rule 9's 15-minute checkpoint rule,
# made mechanical instead of relying on the model noticing on its own.
#
# WHY THIS EXISTS (SDO-018, per SDO-015's flagged gap): Rule 9's mid-task
# checkpoint is judgment-triggered and already demonstrably failed once —
# it didn't fire on its own; the user had to ask "it's been 15 min, are
# checkpoints being practiced" before one was written. A rule that depends
# entirely on the model remembering under pressure will eventually get
# skipped, silently. Same soft-rule-to-hook fix pattern as ingest-guard.sh
# (SDO-002/012) and sdo-log-guard.sh (SDO-017) — but NON-BLOCKING, since
# unlike a bad write or an unlogged commit, "15 minutes passed" is not a
# discrete correctable action worth stalling the model's current tool call
# over. A hard block here would be the "absurd fix" this design explicitly
# avoids.
#
# THROTTLED, not fired every tool call: reminding on every single tool call
# while overdue would repeat identical text into context for no added
# safety past the first reminder — pure token cost. A small gitignored
# marker (.claude/.checkpoint-reminder-state, same precedent as
# .claude/.guard-override.json) records the last reminder time; a fresh
# reminder only fires after its own 15-minute cooldown. A real
# EVOLUTION_LOG.md write always takes precedence and silently clears the
# overdue state — no marker bookkeeping needed for that case.

INPUT_JSON="$(cat)"

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
EVOLUTION_LOG="$PROJECT_DIR/WORKSPACE/EVOLUTION_LOG.md"
MARKER="$PROJECT_DIR/.claude/.checkpoint-reminder-state"
THRESHOLD=900

[[ -f "$EVOLUTION_LOG" ]] || exit 0

LOG_MTIME="$(git -C "$PROJECT_DIR" log -1 --format=%ct -- "$EVOLUTION_LOG" 2>/dev/null)"
[[ -n "$LOG_MTIME" ]] || LOG_MTIME="$(stat -c %Y "$EVOLUTION_LOG" 2>/dev/null)"
[[ -n "$LOG_MTIME" ]] || exit 0

NOW="$(date +%s)"
SINCE_LOG=$(( NOW - LOG_MTIME ))

if [[ "$SINCE_LOG" -le "$THRESHOLD" ]]; then
  # Real work has been logged recently — nothing overdue. Clear any stale
  # marker so a future overdue window starts fresh, not still-throttled.
  rm -f "$MARKER"
  exit 0
fi

if [[ -f "$MARKER" ]]; then
  LAST_REMINDED="$(cat "$MARKER" 2>/dev/null)"
  if [[ -n "$LAST_REMINDED" ]]; then
    SINCE_REMINDER=$(( NOW - LAST_REMINDED ))
    if [[ "$SINCE_REMINDER" -lt "$THRESHOLD" ]]; then
      exit 0
    fi
  fi
fi

echo "$NOW" > "$MARKER"
MINUTES=$(( SINCE_LOG / 60 ))
echo "⏱ CHECKPOINT REMINDER (Rule 9): WORKSPACE/EVOLUTION_LOG.md has not been written to in ~${MINUTES} min. If real progress has happened, write a checkpoint entry now — do not wait to be asked. (Non-blocking; this reminder will not repeat for another ~15 min.)" >&2
exit 0

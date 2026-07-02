#!/bin/bash
# Fires on PreToolUse for Write, Edit, and Bash — blocks any write into
# DOMAINS/, WORKSPACE/SYSTEM_BRAIN/, or WORKSPACE/SYSTEM_SOURCES/ unless
# a genuine, logged override exists first. This is a guardrail, not a
# suggestion: it cannot be skipped by the model deciding to proceed.
#
# DESIGN (SDO-012): a block is not a bypass problem to route around — it
# is a CONFLICT between "the guard says no" and "the actor believes this
# write is legitimate." The only way past it is a single-use override
# that requires a matching WORKSPACE/EVOLUTION_LOG.md entry to already
# exist ON DISK before the override is honored — the paper trail is a
# precondition, not an afterthought. This is the same "never silently
# resolve a conflict" principle RULES.md already documents for content
# conflicts (new source vs. existing brain content), applied here one
# layer down, at the enforcement layer. See RULES.md's conflict-
# preservation section and FRAMEWORK.md's guardrail concept.
#
# Claude Code passes PreToolUse hook input as a JSON object on stdin —
# tool_input.file_path for Write/Edit, tool_input.command for Bash.
# Exit 2 blocks the tool call; exit 1 does not (confirmed SDO-002).
#
# KNOWN, HONEST LIMITATION: the Bash-tool check below is a best-effort
# heuristic over the raw command string, not a full shell parse. It
# looks for a guarded-path mention combined with a write-risk token
# (redirection, sed -i, cp/mv/tee, or a general-purpose interpreter that
# could write arbitrarily). It is deliberately broad — biased toward
# extra friction (a false positive just needs an override) over a
# silent miss (a false negative defeats the whole point). It cannot
# catch every conceivable way a shell command could write a file
# (e.g. a compiled binary, a symlink redirection) — this is a real,
# stated residual risk, not claimed as complete coverage.

INPUT_JSON="$(cat)"
TOOL_NAME="$(echo "$INPUT_JSON" | jq -r '.tool_name // empty')"

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
OVERRIDE_FILE="$PROJECT_DIR/.claude/.guard-override.json"
EVOLUTION_LOG="$PROJECT_DIR/WORKSPACE/EVOLUTION_LOG.md"

GUARDED_REGEX='/DOMAINS/|/SYSTEM_BRAIN/|/SYSTEM_SOURCES/'
WRITE_TOKEN_REGEX='>|sed[[:space:]]+-i|[[:space:]]tee([[:space:]]|$)|(^|[[:space:]])cp[[:space:]]|(^|[[:space:]])mv[[:space:]]|rsync|(^|[[:space:]])dd[[:space:]]|install[[:space:]]|(^|[[:space:]])rm[[:space:]]|rmdir|truncate|git[[:space:]]+mv|python3?([[:space:]]|$)|perl([[:space:]]|$)|ruby([[:space:]]|$)|node([[:space:]]|$)|php([[:space:]]|$)'

TARGET_PATH=""
IS_CANDIDATE=0

if [[ "$TOOL_NAME" == "Write" || "$TOOL_NAME" == "Edit" ]]; then
  TARGET_PATH="$(echo "$INPUT_JSON" | jq -r '.tool_input.file_path // empty')"
  if [[ "$TARGET_PATH" =~ $GUARDED_REGEX ]]; then
    IS_CANDIDATE=1
  fi
elif [[ "$TOOL_NAME" == "Bash" ]]; then
  CMD="$(echo "$INPUT_JSON" | jq -r '.tool_input.command // empty')"
  # Strip common non-write redirects (fd-to-fd merges, /dev/null discards)
  # before checking for a write token — these are near-universal diagnostic
  # patterns (2>&1, 2>/dev/null, etc.) that don't write anywhere near the
  # guarded path and would otherwise make the ">" token trigger constantly.
  CMD_SANITIZED="$(echo "$CMD" | sed -E 's/[0-9]?>&[0-9]//g; s/&?>[[:space:]]*\/dev\/null//g')"
  if [[ "$CMD" =~ $GUARDED_REGEX ]] && echo "$CMD_SANITIZED" | grep -qE "$WRITE_TOKEN_REGEX"; then
    IS_CANDIDATE=1
    TARGET_PATH="$CMD"
  fi
fi

if [[ "$IS_CANDIDATE" -eq 1 ]]; then
  if [[ "$TARGET_PATH" == *"_TEMPLATE"* ]]; then
    exit 0
  fi

  if [[ -f "$OVERRIDE_FILE" ]]; then
    OV_PATH="$(jq -r '.path // empty' "$OVERRIDE_FILE" 2>/dev/null)"
    OV_LOGREF="$(jq -r '.evolution_log_ref // empty' "$OVERRIDE_FILE" 2>/dev/null)"
    OV_CREATED="$(jq -r '.created // empty' "$OVERRIDE_FILE" 2>/dev/null)"

    MATCH=0
    if [[ -n "$OV_PATH" ]]; then
      if [[ "$TOOL_NAME" == "Bash" ]]; then
        [[ "$TARGET_PATH" == *"$OV_PATH"* ]] && MATCH=1
      else
        [[ "$OV_PATH" == "$TARGET_PATH" ]] && MATCH=1
      fi
    fi

    LOG_OK=0
    if [[ -n "$OV_LOGREF" ]] && grep -qF -- "$OV_LOGREF" "$EVOLUTION_LOG" 2>/dev/null; then
      LOG_OK=1
    fi

    FRESH_OK=0
    if [[ -n "$OV_CREATED" ]]; then
      CREATED_EPOCH="$(date -d "$OV_CREATED" +%s 2>/dev/null)"
      NOW_EPOCH="$(date +%s)"
      if [[ -n "$CREATED_EPOCH" ]]; then
        AGE=$(( NOW_EPOCH - CREATED_EPOCH ))
        if [[ "$AGE" -ge 0 && "$AGE" -le 900 ]]; then
          FRESH_OK=1
        fi
      fi
    fi

    if [[ "$MATCH" -eq 1 && "$LOG_OK" -eq 1 && "$FRESH_OK" -eq 1 ]]; then
      rm -f "$OVERRIDE_FILE"
      exit 0
    fi
  fi

  echo "⚠ INGEST GUARD ($TOOL_NAME): blocked — target involves a guarded path (DOMAINS/, SYSTEM_BRAIN/, or SYSTEM_SOURCES/)." >&2
  echo "This is a CONFLICT (guard says no, you believe this write is legitimate), not a routing gap — per RULES.md's conflict-preservation principle, it must be surfaced and explicitly resolved, never silently routed around." >&2
  echo "To override: (1) append a real WORKSPACE/EVOLUTION_LOG.md entry stating the reason FIRST, (2) create .claude/.guard-override.json: {\"path\": \"<exact target>\", \"evolution_log_ref\": \"<exact string from step 1>\", \"created\": \"<ISO8601 now>\"}, (3) retry. The override is single-use and expires after 15 minutes." >&2
  exit 2
fi

exit 0

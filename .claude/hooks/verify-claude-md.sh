#!/bin/bash
# Last live-fire tested: 2026-07-02 (SDO-027, first real 1f rotation run — positive case confirmed via this session's own SessionStart transcript; negative cases (missing CLAUDE.md, wrong-project marker) probed in /tmp, both correctly warned and exited 1, probes cleaned up and verified removed)
# Fires on SessionStart. Confirms the CLAUDE.md actually loaded is the
# real one for THIS project. Uses CLAUDE_PROJECT_DIR — the official
# environment variable Claude Code itself sets to the project root it
# already determined — rather than re-deriving that path independently
# (CC-033's walk-up loop duplicated logic Claude Code already does
# correctly, and could in principle disagree with it).

EXPECTED_MARKER="mirrored in AGENTS.md for agent-agnostic compatibility"

if [ -z "$CLAUDE_PROJECT_DIR" ]; then
  echo "⚠ SESSION START CHECK: CLAUDE_PROJECT_DIR is not set (known issue on some versions/platforms — see anthropics/claude-code #6023, #9567). Falling back to current directory."
  CLAUDE_PROJECT_DIR="$(pwd)"
fi

CLAUDE_MD_PATH="$CLAUDE_PROJECT_DIR/CLAUDE.md"

if [ ! -f "$CLAUDE_MD_PATH" ]; then
  echo "⚠ SESSION START CHECK: No CLAUDE.md found at $CLAUDE_MD_PATH"
  exit 1
fi

if ! grep -q "$EXPECTED_MARKER" "$CLAUDE_MD_PATH"; then
  echo "⚠ SESSION START CHECK: CLAUDE.md at $CLAUDE_MD_PATH does not contain the expected SYSTEM_DESIGN_OS marker."
  exit 1
fi

echo "✓ CLAUDE.md verified at $CLAUDE_MD_PATH — correct file for SYSTEM_DESIGN_OS."
exit 0

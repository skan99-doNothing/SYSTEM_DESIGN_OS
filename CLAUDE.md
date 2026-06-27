<!-- This file is mirrored in AGENTS.md for agent-agnostic compatibility (e.g. Codex). Keep both in sync. -->
# CLAUDE.md

The full system reference lives in README.md at the project root — read
it before doing substantive work. It covers architecture, every file's
role, both skills in full depth, both hooks, and the DNA statement.

WORKSPACE/STATUS.md has the current state right now.

## The two files referenced most often during real work

- **WORKSPACE/OPERATING_CONTRACT.md** — how Claude behaves: 9 rules,
  the division-of-labor statement, and what counts as a real decision.
- **WORKSPACE/INGEST.md** — the protocol for any new source. Always
  follow from Step 0. Do not improvise a similar-sounding process.

## Non-negotiable behavioral rules (kept here so they load automatically)

- Every prompt handed to the user to run in Claude Code gets an ID
  (CC-XXX). No exceptions.
- Log real decisions to WORKSPACE/DECISIONS.md and WORKSPACE/EVOLUTION_LOG.md
  as part of doing the work, not as a separate step afterward.
- Never claim a file was created, edited, or verified without running
  the check in that same turn.
- When asked to ingest something: read WORKSPACE/INGEST.md in full and
  follow it from Step 0. Produce the verification artifacts it requires.
  Do not report INGESTED without them.

## Ending a session

Say "chalo" — it runs audit first, then refreshes STATUS.md, confirms
the log, and commits everything in one pass.

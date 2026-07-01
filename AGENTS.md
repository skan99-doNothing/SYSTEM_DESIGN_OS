<!-- This file mirrors CLAUDE.md for Claude Code compatibility. Keep both in sync. -->
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
  (SDO-XXX). No exceptions.
- Log real decisions to WORKSPACE/DECISIONS.md and WORKSPACE/EVOLUTION_LOG.md
  as part of doing the work, not as a separate step afterward.
- Never claim a file was created, edited, or verified without running
  the check in that same turn.
- When asked to ingest something: read WORKSPACE/INGEST.md in full and
  follow it from Step 0. Produce the verification artifacts it requires.
  Do not report INGESTED without them.

## Answering knowledge questions

If asked what this system knows about something — a concept, a
mechanism, a prior decision — check WORKSPACE/SYSTEM_BRAIN/index.md
(and any active domain's BRAIN/index.md) BEFORE answering from
general knowledge or guessing. Cite the specific concept or source
page the answer came from. If the brain genuinely doesn't cover it,
say so plainly rather than filling the gap with inference — this is
the same no-overclaim standard INGEST.md already requires for
ingesting a source, applied here to answering FROM what's already
ingested.

## Ending a session

Say "chalo" — it runs audit first, then refreshes STATUS.md, confirms
the log, and commits everything in one pass.

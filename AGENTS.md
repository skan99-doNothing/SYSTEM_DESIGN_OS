<!-- This file mirrors CLAUDE.md for Claude Code compatibility. Keep both in sync. -->
# CLAUDE.md

The full system reference lives in README.md at the project root — read
it before doing substantive work. It covers architecture, every file's
role, both skills in full depth, both hooks, and the DNA statement.

WORKSPACE/STATUS.md has the current state right now.

## The two files referenced most often during real work

- **WORKSPACE/OPERATING_CONTRACT.md** — how Claude behaves: 10 rules,
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
(and any active domain's BRAIN/index.md) FIRST, before taking ANY
other action: before answering from general knowledge, before
guessing, and before spawning an agent or fetching an external source
to verify. Checking the brain is the first move, not just a step
before the final sentence — a knowledge question answered by going
straight to an external check, with the brain read only afterward to
explain the miss, still counts as a violation of this rule (confirmed
real instance: SDO-020).

Cite the specific concept or source page the answer came from. If the
brain genuinely doesn't cover it, say so plainly rather than filling
the gap with inference — this is the same no-overclaim standard
INGEST.md already requires for ingesting a source, applied here to
answering FROM what's already ingested.

**If external verification turns out to be genuinely needed** (the
brain doesn't cover it and the answer matters enough to check for
real): that verification is not just a one-off answer to hand back and
forget. Treat what was found as a candidate for WORKSPACE/INGEST.md's
real protocol — Step 0 onward — so the brain actually grows from the
gap instead of the same external check being needed again next time.
This closes the "transfer gap": an external fact that answers today's
question but never enters the brain has not actually made the system
smarter, only answered one question (confirmed real instance:
SDO-021/022, where this loop was followed correctly after being missed
once at SDO-020).

## Starting fresh (machine restart, session-limit reset, new chat)

Say "resume" (or /resume) — reads WORKSPACE/STATUS.md's baton, then
EVOLUTION_LOG.md's newest entries, cross-checks git log, states back
what's done/open/unstarted before proceeding. Cheap — a few file reads,
not a full audit.

## Mid-session, if uncertainty is ahead (session limit, unstable connection)

Say "checkpoint" — forces an immediate, minimal write-commit-push of
real progress. On-demand backstop to the ~15-min judgment rule in
OPERATING_CONTRACT.md Rule 9 (SDO-015: that rule is known-soft and not
yet mechanically enforced — don't rely on it alone).

## Ending a session

Say "chalo" — it runs audit first, then refreshes STATUS.md, confirms
the log, and commits everything in one pass.

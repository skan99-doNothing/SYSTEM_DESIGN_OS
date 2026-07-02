---
name: resume
description: Recover full working context after a fresh session start —
machine restart, session-limit reset, or any new chat with no memory of
prior work. Trigger on "resume," "pick up where we left off," or explicit
invocation. Distinct from chalo (session close) — this is session START.
---

# Resume

A fresh session has zero memory. This skill is the deliberate, ordered
set of reads that reconstruct real state cheaply — not a full audit, not
chalo. Cost: a handful of targeted file reads, not a re-derivation.

## Steps, in order

1. **Read WORKSPACE/STATUS.md in full**, including the Handoff Baton.
   Note its "Last manually confirmed accurate" date and any explicit
   staleness note near the top (e.g. "KNOWN STALE AS OF SDO-XXX").

2. **Read the most recent entries in WORKSPACE/EVOLUTION_LOG.md** (the
   top of the file — newest-first) — specifically, any entry dated AFTER
   STATUS.md's own confirmed-accurate date. This closes exactly the gap
   a staleness note flags. If EVOLUTION_LOG.md itself has been rotated
   (check for a "Log rotation notice" near its top), that notice tells
   you where older history lives — you do not need to read the archive
   to resume, only to research history.

3. **Cross-check git log** (`git log --oneline -10`) against what
   STATUS.md/EVOLUTION_LOG.md claim is committed and pushed. If the log
   entries reference commit hashes, confirm they exist. This is the same
   discipline as the transmission-verification concept in FRAMEWORK.md —
   a claim of "committed and pushed" gets checked, not assumed.

4. **State back, explicitly, before doing anything else:** what's done,
   what's open, what was NOT started, and whether the prior session
   closed cleanly (chalo ran) or ended mid-work (a checkpoint or a
   session-limit cutoff). Do not silently proceed on an assumption if
   any of this is unclear — ask, per OPERATING_CONTRACT.md Rule 6.

## What this does NOT do

Does not re-run audit's checks, does not re-verify ingestion records,
does not regenerate STATUS.md. It only reconstructs context cheaply. If
the user's next request needs a fuller self-check, invoke audit or chalo
separately, as their own decision — resume is not a substitute for either.

## Why this exists

A prior session found that "just say resume" is ambiguous by itself —
CLAUDE.md points to STATUS.md but doesn't force a read of it, and a
fresh session could otherwise guess wrong about what's current. This
skill removes the guesswork: an explicit, ordered, cheap recovery
sequence, named so it can be invoked directly instead of relying on
inference (SDO-014).

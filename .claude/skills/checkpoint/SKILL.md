---
name: checkpoint
description: Force an immediate, on-demand checkpoint write when the user
knows of real uncertainty ahead — a session limit approaching, an unstable
connection, or any moment work should not be trusted to survive without
being written down. Trigger on "checkpoint," "do a checkpoint now," or
explicit invocation. Distinct from OPERATING_CONTRACT.md Rule 9's
~15-minute mid-task rule — that one is judgment-triggered by Claude; this
one is forced, on demand, by the user, right now, no waiting.
---

# Checkpoint

An immediate, minimal write-and-push — not a full chalo close, not an
audit. The goal is speed: capture what's real, get it on disk and pushed,
stop.

## Steps, in order — do these, nothing more

1. **Ask nothing, do not re-derive.** Identify what has happened since
   the last real write to EVOLUTION_LOG.md or a dialogue file in THIS
   session — real decisions, real fixes, real designs agreed on, not
   narration of activity.

2. **Write one EVOLUTION_LOG.md entry** (next free SDO-XXX number,
   grepped first, never assumed) covering what's real so far: what's
   done, what's mid-flight, what's explicitly NOT done yet. If nothing
   real has happened since the last write, say so plainly — an empty
   checkpoint is noise, not safety (same standard as Rule 9's mid-task
   rule).

3. **If a dialogue-derived insight exists that isn't in the log entry
   already** (a design reasoning, a corrected assumption), add it to the
   relevant BRAIN/dialogue/conversational.md in the same pass — but do
   not block the checkpoint on this if it would meaningfully slow things
   down; the log entry is the priority.

4. **Update STATUS.md only if doing so is fast and low-risk** — a short,
   explicit staleness note (what's not reflected yet) is enough; do not
   attempt a full STATUS.md rewrite under time pressure. A flagged-stale
   STATUS.md is honest; a rushed, half-correct rewrite is not.

5. **Commit and push immediately.** `git add` the specific files touched
   (never `-A` under time pressure — know what you're staging), commit
   with a message naming the SDO ID, push. If the push fails, report
   that explicitly — do not treat a local-only commit as safe.

6. **Report back in one or two sentences:** what got checkpointed, what's
   still open, confirm pushed. No further action unless asked.

## What this is NOT

Not chalo (no audit, no full session review, no promotion checks). Not a
substitute for a proper session close when time actually permits one —
run chalo later for that. This exists specifically for the moment
between "something real just happened" and "the session might not survive
long enough to close properly" (SDO-014).

# Conversational Context — SYSTEM_BRAIN

Insights derived from live dialogue with the user — things that emerged
through conversation rather than from ingesting a document.

## When to update this file

Add an entry when a session surfaces a non-obvious constraint, a
corrected assumption, a clarification of intent, or a design decision
that isn't traceable to any specific source in sources/. If the insight
came from a file, it belongs in overview.md or a concepts/ page; if it
came from talking, it belongs here.

## Distinction from overview.md

`overview.md` synthesizes what the ingested documents say and how the
pillars connect. This file records what became clear through use —
things the documents don't say but experience revealed.

## Entries

### 2026-06-27 — CC-045 pattern: known principle not self-applied (second instance)
When conversational.md was created (CC-063), no promotion path back to
overview.md was built in — even though LLM Wiki's source material
explicitly describes filing outputs back as compounding value, and that
principle was correctly applied elsewhere in the same session. The gap
was caught by the user, not by Claude noticing on its own (CC-064/CC-065).

**Constraint this reveals:** Claude applies known principles to
structures it's explicitly working on, but does not reliably audit new
structures it creates for compliance with the same principles. The
failure mode is not ignorance — it's incomplete self-application at
creation time. Two data points now (CC-045 was the first). Watch for
this: when creating any new file or structure, explicitly check whether
known system principles (compounding value, lint passes, promotion paths)
apply to the new thing.

### 2026-06-27 — P002 pattern: user distrust of post-self-correction clean pass is a reliable catch signal

This session saw the same shape twice. Audit self-corrected a check (4b
wording fixed after CC-076 missed SYSTEM.md; then 4b re-run after
CC-077). Each time the corrected check immediately reported clean. Each
time the user asked for independent verification anyway. Each time the
gap was still present. Both catches came from the user's instinct, not
from anything audit was built to do at that point.

**Constraint this reveals:** "User requesting independent verification
right after a clean pass" is a reliable diagnostic signal, not
overcaution. The key asymmetry: a fix to a check mechanism means the
first run of the corrected check is exactly when under-scoping is most
likely — the check hasn't been stress-tested yet in its new scope. The
right response is active falsification on at least one different angle,
not acceptance.

The P002 pattern and its countermeasure (audit's 6b) are now in
PATTERNS.md and audit/SKILL.md. This entry records the behavioral
evidence behind why that rule exists — a user instinct confirmed twice
in one session, now made automatic.
### 2026-06-28 — Deterministic structural gaps vs. behavioral failure patterns (CC-109)

PATTERNS.md's two-instance confirmation threshold is correct for
behavioral failures that might not recur — whether or not a second
instance occurs is genuinely uncertain. But some gaps are structurally
deterministic: every future ingestion that adds a source would produce
the same overview.md staleness, not occasionally but every time,
because nothing in the protocol checked it.

**Design decision surfaced:** These two categories need different
responses. Behavioral failures → PATTERNS.md, watch for second
instance before building a countermeasure. Deterministic structural
gaps → fix immediately, in the protocol itself, without waiting for
a second occurrence. Waiting for the second instance of a
deterministic gap means deliberately letting the known failure happen
again. The distinction: the gap recurs with certainty vs. might recur.

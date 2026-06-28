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

### 2026-06-28 — Evaluation criteria are valid when they produce both positive and negative results (CC-116, CC-120)

Two honest evaluations tonight produced opposite outcomes: CC-116
checked the Growth Engine concept page against its ingestion record's
specific claims and found it GENUINELY RICH — all five verification
artifacts present at comparable or greater specificity, no expansion
needed. CC-120 applied the same evaluation methodology to
ingest-validate itself and found a REAL GAP — the FRAMEWORK.md
portable concept entry documented only the lightweight mode, missing
deep mode entirely.

**Constraint this reveals:** An evaluation check is only trustworthy
when it can produce both results. If it always finds "good" it's
validation-seeking, not evaluation. CC-116's clean result is more
credible because CC-120's gap finding was real and came from the
same methodology applied honestly. The value of check 1c isn't that
it found something tonight — it's that it could have, and when
applied to a different scope (skills vs. ingested sources) it did.

Also surfaced: applying the system's own evaluation criteria to its
own components (self-evaluation, not just external source evaluation)
is a distinct high-value operation. It's currently done by exception
(CC-120 was explicitly requested), not by any standing check.
Whether this warrants becoming a standing audit step after more
instances is an open question — one deliberate self-evaluation isn't
a confirmed pattern yet.

### 2026-06-28 — The two-channel problem: CLAUDE.md vs the baton (CC-129/CC-130)

CC-129 closed the knowledge-routing gap by adding an instruction to
CLAUDE.md. CC-130 revealed this was incomplete: CLAUDE.md auto-loads
only in Claude Code sessions; claude.ai chat sessions start from the
baton only, with no file system access and no CLAUDE.md.

**Constraint this reveals:** Any behavioral rule that needs to work in
BOTH Claude Code AND claude.ai must be written into BOTH delivery
channels — CLAUDE.md for Claude Code, baton for claude.ai. These are
parallel channels, not redundant copies. Fixing one doesn't fix the
other. This is a structural property of the system, not a one-off
oversight: every future behavioral rule should be checked against
which channel(s) it needs to reach and whether all of those are covered.

### 2026-06-28 — Self-report distrust as a standing verification principle (CC-130)

User explicitly distrusted CC-129's own report of its cold-read test
result — not because the report seemed wrong, but because a confident
description of a test passing is not the same as the test passing with
real output shown. CC-130 re-ran the verification independently and
confirmed the result was genuine.

**Constraint this reveals:** A session verifying its own prior work
can produce a correctly-worded but ungrounded claim. The correct
response to any self-report of a test passing is to re-run it with
visible output — not to accept the description as evidence. This is
the same principle as OPERATING_CONTRACT.md Rule 1 (no claim without
a check), applied recursively: the claim "the test passed" is itself
a claim that needs a check, not a terminus. This aligns with P002's
countermeasure applied one level up: distrust a clean pass, especially
one that is itself a report of having verified a prior step.

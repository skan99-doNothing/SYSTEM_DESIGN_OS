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

### 2026-06-28 — NOTED IDEA: Auto-research (query-only synthesis from already-ingested knowledge)

**Status: GOOD-TO-HAVE, NOT MUST-HAVE.** Explicitly placed here,
not as a SUGGESTION RECORD, because it has never been run through
ingest-validate's actual deep mode — this entry documents the
reasoning that led to this placement, not a completed evaluation.

**How the idea surfaced:** While discussing a different system
(claude-obsidian) found via web search, which has an "autoresearch"
skill — query a knowledge base, synthesize an answer, cite sources.
The user asked whether SYSTEM_DESIGN_OS needs an equivalent.

**The real distinction drawn:** auto-RESEARCH (query and synthesize
from knowledge already ingested and verified) is fundamentally
different from auto-DISCOVERY (the system finding and proposing new
sources on its own, without the user bringing them). The user
explicitly chose to consider only the former, to preserve
OPERATING_CONTRACT.md's existing division of labor — the user
originates new knowledge, the system reasons from what's already
verified. Auto-discovery would change WHO originates ideas in this
system; that's a much bigger, unexamined decision, correctly not
conflated with this one.

**What was tested, and what it revealed:** a live test (CC-128)
showed the underlying knowledge already exists and is already
correctly synthesized when asked — the gap was never "the system
can't reason from its own brain," it was "nothing automatically
routes a cold session to check the brain first." That gap was
closed separately and directly (CC-129/130/132) by adding one
routing instruction to CLAUDE.md/AGENTS.md and the STATUS.md baton —
a much smaller fix than a dedicated skill.

**Why this still isn't fully resolved, and shouldn't be force-closed
tonight:** the routing fix solves "find the right page once told to
look." It does not solve a genuinely separate, harder question
auto-research would actually need to answer well: synthesizing across
MULTIPLE pages/sources into one answer, with honest
confidence-weighting when sources partially conflict or only partially
cover a question. That's a real design problem, not yet worked
through, and conflating "the routing works" with "auto-research is
solved" would be premature.

**Why GOOD-TO-HAVE rather than MUST-HAVE:** the system currently has
exactly one real domain's worth of knowledge analog (SYSTEM_BRAIN/,
5 sources) and zero active business domains. A multi-source synthesis
tool is speculative value against a brain that hasn't yet grown large
enough to need it — the same over-engineering risk RULES.md's
Obsidian/vector-search threshold was built to catch. This should be
revisited once a real domain exists with enough real, varied sources
that a single retrieval question would plausibly need synthesizing
across more than one or two pages.

**Concrete trigger to revisit:** when a real domain's BRAIN/concepts/
has enough genuinely varied sources that a query would plausibly span
3+ pages with partial, possibly-conflicting coverage — not on a
calendar, not preemptively.

**Process note, logged honestly:** earlier attempts to record this
(CC-124, CC-125, CC-126) were drafted but never actually executed in
this session — this is the first real, run instance of documenting
this idea. A separate process violation (designing the proposal
directly in conversation rather than running it through
ingest-validate's deep mode first) was caught and corrected in
principle, but the actual deep-mode run never happened either.
Tonight's honest conclusion: the idea is real and worth keeping
visible, the rigorous evaluation of it is not yet done, and that's
stated plainly rather than implied to be further along than it is.

**Date:** 2026-06-28

### 2026-06-28 — Updating a source record ≠ updating everything that cites it (CC-145)

CC-140/144 updated the ICM concept page with three concepts from the
full paper re-read. CC-145's separate consistency check then found
FRAMEWORK.md was still at the old, abstract-only version — the concept
page was correct but the document citing it hadn't caught up.

**Constraint this reveals:** updating a source record and its concept
page is not sufficient on its own. Documents that CITE those sources
(FRAMEWORK.md, README.md, RULES.md) can silently remain at the prior
version with no trigger to fix them. Without the explicit consistency
check (CC-145's Part B), the gap would have been invisible — the brain
would have known the right thing while the architectural reference
still described the old, incomplete understanding.

**The standing implication:** any time a concept page is substantively
updated (new mechanisms, corrected claims, additional detail from a
re-read), the documents that reference that concept — particularly
FRAMEWORK.md and README.md — should be checked in the same pass, not
assumed to be current. This is the same discipline INGEST.md's
reconciliation step (Step 6) applies to ingestion records; it needs
to apply equally to citation chains between living documents.

### 2026-07-01 — Scope a corrective rule to where its underlying risk actually exists, not to everything it superficially resembles (CC-151)

While setting up fork/upstream tracking for two personal repos
(gbrain, gstack) outside SYSTEM_DESIGN_OS, a "never commit directly on
the default branch" rule was written into memory as a universal
git-hygiene practice for any repo. The user corrected this
immediately: the rule exists to keep a FORK's default branch
fast-forwardable against its upstream remote — a repo with no upstream
has no mirror to protect, so the same restriction there is process
defending against a risk that doesn't exist.

**Constraint this reveals:** a fix that's correct for the case that
prompted it can still be wrong once stated as a general principle, if
the general form drops the specific precondition that made the
original risk real. The overgeneralization felt like tidiness (“a
consistent rule everywhere”) but was actually unscoped reasoning.

**The standing implication:** before writing any new rule as a general
practice, name the specific precondition that makes the underlying
risk real, and state the rule as conditional on that precondition —
not as a blanket default with the precondition left implicit. Applies
well beyond git: any "we got burned once, so always do X" fix should
carry its triggering condition explicitly, or it will eventually get
applied somewhere it doesn't belong.

### 2026-07-01 — A received prompt's embedded state assumptions can go stale mid-session, not just across a transmission gap (CC-152/154)

A prompt drafted with ID "CC-152" was executed later in the same
session, after CC-153 had already been assigned and committed in the
interim. Its embedded assumption ("the next number is 152") was
correct when written but stale by the time it actually ran — not
because it was never transmitted (P003's shape), but because
sequential state changed between drafting and execution within one
continuous session.

**Constraint this reveals:** P003 already covers a prompt that never
crosses from chat into execution. This is a different failure mode: a
prompt that DOES execute, correctly, but carries a state assumption
(a number, a count, a "current" anything) that was only ever a
snapshot at draft time. A well-formed, internally consistent prompt
provides no guarantee its embedded assumptions still hold at run time.

**The standing implication:** any embedded sequential or "current
state" assumption in a prompt (an ID, a count, "the latest X") should
be re-verified mechanically at execution time, not trusted because the
prompt reads as internally consistent. This is exactly why
OPERATING_CONTRACT.md Rule 9's collision check specifies grepping for
the real current number rather than trusting what the prompt says it
should be — this entry generalizes that same fix beyond CC-XXX
numbers to any stateful assumption in a delegated task. One instance
so far — watch for a second before considering a PATTERNS.md entry.

### 2026-07-01 — A concept page can overclaim beyond its own raw source, not just under-represent it (SDO-001 chalo, 1d rotation)

Audit's 1d rotation on autonomous-ai-growth-engine.md found something
new: the concept page stated three specifics that do not appear
anywhere in the 301-line raw source - a fabricated-sounding CLI
command (`bun cli.ts evals promote <runId>`), an itemized breakdown of
VoC Synthesis's outputs the source never states, and a claim about
"F-grade agents called out explicitly" the source doesn't make. The
ingestion record itself was fully accurate; only the concept page had
drifted into unsupported specificity.

**Constraint this reveals:** check 1c (and 1d's concept-page
comparison) has so far only ever looked for the concept page being
THINNER than what the record verified - richer verified content
sitting unused. This is the opposite direction: a concept page can
also be RICHER than what's actually verifiable, if specific-sounding
detail gets added during synthesis without being checked against the
raw source. A confident, specific-sounding false detail is more
dangerous than an honestly thin one, because it reads as verified
knowledge with no signal that it isn't.

**The standing implication:** when writing or reviewing a concept
page, treat added specificity with the same suspicion INGEST.md
already applies to the original read - a concrete detail (an exact
command, an exact list) is a claim that needs a traceable source, not
just plausible-sounding elaboration. One instance so far - watch for a
second before considering whether 1c/1d's check needs an explicit
over-claim direction, not just the under-claim direction it currently
covers.

### 2026-07-02 — A guardrail's absence of failures is not evidence it works

An independent adversarial review tested ingest-guard.sh empirically for
the first time since its build (CC-027) — instead of trusting its
self-description, it attempted a real blocked write. Found: the hook read
its target path from a positional argument and exited 1 on match; Claude
Code actually delivers PreToolUse input as JSON on stdin and only exit
code 2 blocks a tool call. The hook had silently exited 0 on every real
invocation for its entire history. A grep for "INGEST GUARD" across all of
EVOLUTION_LOG.md returned zero hits — and that absence was itself
available evidence nobody had read as a finding. Zero blocked-write events
in a system that writes to guarded folders regularly should have been a
standing question ("why has this never fired?"), not a quiet assumption
that it simply hadn't needed to.

**The pattern:** P002 (fix declared clean without independent verification)
already covers a check being wrong right after a correction. This is the
same shape one level down — a guardrail's total silence over its whole
life was treated as proof of good behavior instead of a candidate
symptom of never having run at all. The absence of a failure log is not
neutral evidence; for a mechanism that should occasionally fire under
normal system use, sustained silence is itself a data point worth
checking.

**Standing implication:** any future guardrail or hook should have its
blocking behavior live-fire tested at build time (a real attempted
violation, confirmed refused, logged) — not just its logic reviewed —
and a hook with zero logged firings after a reasonable period of real use
should be treated as a candidate for "verify this still works," not
assumed fine by default. Fixing this one (SDO-002) also surfaced a second,
narrower limit worth watching for a second instance before generalizing
further: SDO-002's fix exposed that the hook's matcher only covers the
Write/Edit tools, not Bash-based writes, and that it has no override path
for a legitimate blocked action (SDO-005, logged as a deferred design
item, not yet a second confirmed instance of anything).

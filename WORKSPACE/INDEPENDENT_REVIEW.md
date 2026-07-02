# INDEPENDENT_REVIEW.md — Adversarial Review Protocol (reusable, self-improving)

**Purpose:** a periodic, adversarial architectural review and self-consistency
audit of SYSTEM_DESIGN_OS — distinct from the audit skill (which checks the
system against its OWN stated rules, from inside the system's own beliefs
about itself) and distinct from chalo (single-session review). This protocol
is designed to be run cold, by a session with zero prior context, so it
isn't biased by whatever the current working session already believes is
true. It exists because the first run (v1, 2026-07-02) found real,
significant gaps — including a mechanical guardrail that had silently done
nothing since it was built — that neither audit nor chalo had ever surfaced,
precisely because both operate from inside the system's own self-description.

**How to invoke:** paste the "Review Prompt" section below (in full) into a
FRESH session — a new chat, a new Claude Code session, or an isolated
worktree/agent — with NO prior context from any other session. Do not run it
mid-session inside an already-informed conversation; that defeats the
adversarial premise.

**NON-NEGOTIABLE standing rule:** every run of this protocol MUST end with a
non-empty Prompt Improvement Log appended to THIS FILE's Revision History
section below (not left in a separate, disconnected artifact) — this is a
required deliverable, not optional commentary. An empty log is itself a red
flag: a review that produced no prompt learnings was not paying close enough
attention to its own execution. This file is the single, evolving artifact
that accumulates every cycle's learnings, so the review protocol itself
compounds over time — the same LLM-Wiki principle (read once, integrate,
never re-derive from scratch) already applied to every other kind of
knowledge in this system, applied here to the review process about itself.

---

## Revision History

### v1 — 2026-07-02 (original run)
Ran cold via an inline prompt passed through `/goal` (failed — exceeded the
4000-character limit; executed as a plain instruction instead). Found 8 red
flags, including one CRITICAL: `ingest-guard.sh` had been a complete no-op
since its original build (CC-027) — wrong input source (`$1` instead of
stdin JSON), wrong exit code (1 instead of 2) — meaning it had silently
allowed every write it was supposed to block, for the system's entire
history, with zero blocked-write events ever logged. Produced prompt
improvement notes PIL-01 through PIL-07 (see below).

### v2 — 2026-07-02 (this revision, same day)
All 8 red flags from v1 were fixed in a separate execution pass (SDO-002
through SDO-010, same day) — not by this protocol itself, but by a
follow-up session executing v1's findings. That fix pass surfaced FOUR
further lessons a static review alone could not produce (PIL-08 through
PIL-11), because they only became visible once a fix was actually applied
and tested against reality. This revision folds ALL eleven PIL entries
(01–11) directly into the Review Prompt and Fix-Execution Guidance below,
so the next cycle starts from a sharper baseline instead of re-deriving
these lessons from a separate log file.

**Open, unresolved from v1, carried into this cycle's likely scope:**
structural items the v1 review recommended but explicitly did not fix —
EVOLUTION_LOG.md log rotation, a closure lifecycle for audit findings that
currently just get re-reported indefinitely (Rule 2/Rule 7), capping
audit's own unbounded read scope, shrinking README's duplication surface —
plus SDO-005, a live blocker discovered during the fix pass (the
newly-fixed guardrail has no override path and only covers Write/Edit, not
Bash writes). These are NOT re-discoveries for the next review to find —
they are already known and logged in STATUS.md/EVOLUTION_LOG.md. The next
review's value is in finding what ISN'T already known, not re-confirming
what is.

<!-- Next cycle: append a new ### v3 section here, in this same format,
     with its own PIL entries — do not create a separate file. -->

---

## Part 1: Review Protocol (paste this section into a fresh session)

You are conducting an independent architectural review and self-consistency
audit of SYSTEM_DESIGN_OS. This is NOT a routine audit pass — it is an
adversarial review designed to find what the system misses about itself,
including what its own audit skill gets wrong or skips. You have full
filesystem access. Read before you claim anything.

This prompt is also a living document — WORKSPACE/INDEPENDENT_REVIEW.md,
where you are reading it right now. As you work, maintain a running log of
improvements to this prompt itself. That log is a REQUIRED deliverable
(see NON-NEGOTIABLE above), appended as a new dated Revision History entry
in this same file at the end of your run — not a separate artifact, not
optional, not skippable even on a clean run.

### Setup, checkpoint, and task decomposition

1. Read WORKSPACE/OPERATING_CONTRACT.md, WORKSPACE/STATUS.md, README.md,
   WORKSPACE/FRAMEWORK.md, WORKSPACE/SYSTEM_BRAIN/index.md, and this file's
   Revision History above (so you know what's already fixed and what's
   already open — don't re-discover it).
2. Write a checkpoint file to WORKSPACE/ARTIFACTS/review-checkpoint.md
   (this REPLACES the prior cycle's checkpoint — it is a per-run working
   artifact, not append-only history; the accumulating history belongs in
   THIS file's Revision History, not in review-checkpoint.md).
   Decide the checkpoint file's own fate (commit as-is / register in
   ARTIFACTS/index.md / delete after the report) EARLY, in this setup step
   — flag it to the user once, immediately, rather than letting a later
   `git add -A` decide it implicitly (PIL-05).
3. Decompose into named, sequential tasks (see Task List below), written
   to the checkpoint file before starting any of them.

### Task List

TASK-01: DNA quality checks — each of the six DNA qualities against its
  real enforcement mechanism.

TASK-02: OPERATING_CONTRACT.md rule exercise checks — for each of the 9
  rules, find at least one EVOLUTION_LOG.md entry proving it was
  exercised, not just declared. Grep by rule number/keyword FIRST; only
  read matched sections in full (PIL-03 — EVOLUTION_LOG.md already exceeds
  a single read and will keep growing). Audit's own self-reports in
  EVOLUTION_LOG.md are evidence a rule/check RAN, not evidence its result
  was CORRECT — treat those as two separate questions (PIL-06).

TASK-03: PATTERNS.md countermeasure checks — verify each entry's
  countermeasure is actually present in the relevant skill file, not just
  described.

TASK-04: INGEST.md gate check — test the binding gate against real source
  records, including a literal, mechanical read of the gate fields
  (grep-able "Nothing", not prose containing "nothing remaining" mixed
  with history — see SDO-004's fix for what this looks like when it drifts).

TASK-05: audit skill self-check — for each audit check, ask whether it
  could silently fail or produce a false clean result.

TASK-05b (NEW, added v2 — PIL-02): Hook empirical live-fire test. For
  EVERY hook in .claude/hooks/, do not trust its logic on inspection alone:
  (a) confirm its actual input source matches what the harness really
  sends (e.g. PreToolUse hooks receive JSON on stdin, not positional
  args — verify this for the CURRENT harness version, don't assume it
  from a prior review); (b) confirm its blocking exit code actually blocks
  (in Claude Code, exit 2 blocks, exit 1 does not); (c) attempt a real,
  scoped probe action that SHOULD be blocked, confirm the harness actually
  refuses it, and confirm the probe left no trace; (d) grep
  EVOLUTION_LOG.md for that hook's own name/warning text — if it has never
  once fired in the system's real history, treat that silence itself as a
  candidate symptom worth investigating, not neutral evidence (this
  specific check is what v1 was missing, and it's what caught the
  CRITICAL finding). Probe writes for this test are pre-authorized as long
  as they are scoped and immediately reverted, with the reversion verified
  via `ls`/`git status` in the same turn (PIL-07) — you do not need to ask
  permission to run this specific test, only to report what you found.

TASK-06: Token efficiency audit — per-skill token load estimate; flag any
  skill whose reads scale unboundedly with system growth. EVOLUTION_LOG.md's
  own unbounded growth is itself now a known, open finding (v1) — confirm
  its current size rather than re-deriving whether it's a problem.

TASK-07: update-readme trigger check — test whether it fires on content
  edits to EXISTING files, not just structural additions, against its
  CURRENT wording (this was found broken in v1, fixed as SDO-003, and
  exercise-tested for the first time by chalo's own audit in SDO-009 —
  confirm it's still correct, don't assume the v1 finding is permanently
  resolved).

TASK-08: Transferability test — read ONLY CLAUDE.md and README.md cold;
  could a competent agent orient from these two files alone? (Reads may be
  batched across tasks — TASK-01/03/05 all need audit/SKILL.md,
  TASK-02/05/07 all need EVOLUTION_LOG.md; batch the reads, keep the
  FINDINGS sequential (PIL-04).)

TASK-09: Architectural review synthesis — synthesize Job 1 findings into
  concrete recommendations.

### Your mandate

**JOB 1 — External architectural review:** agent-agnosticism, knowledge
isolation, single source of truth, transferability, scalability threshold
honesty, governance completeness, token efficiency as a design principle.

**JOB 2 — Self-consistency audit:** does the system actually do what it
claims? Every DNA quality, every contract rule, every PATTERNS.md
countermeasure, INGEST.md's gate, audit's own checks, update-readme's
trigger, and (new in v2) every hook's real, tested behavior — not its
described behavior.

### How to work

Read first, claim second. Self-distrust after every clean finding (6b
discipline) — actively try to disprove a clean result from a different
angle before reporting it clean. Token-disciplined: grep/head before a
full read, log what you've read in the checkpoint so you never re-read
unnecessarily.

### Exit conditions

You are done when: every DNA quality has a real pass/fail/partial result
with file evidence; every contract rule has been checked for real exercise
evidence; every PATTERNS.md countermeasure has been checked against real
skill-file content; you've attempted to break at least three clean
findings via 6b; you've produced a finding on the audit skill itself, not
just what it checks; all tasks are marked COMPLETED in the checkpoint; you
have run TASK-05b's live-fire test on every existing hook, not just
inspected their logic; and the Prompt Improvement Log (Part 3 below) has
at least one new entry appended to THIS file's Revision History, even on
a clean run.

### Output format

Four sections: RED FLAGS (numbered, severity-tagged, file-cited);
ARCHITECTURAL RECOMMENDATIONS (include token efficiency and context
scoping specifically); AUDIT SKILL IMPROVEMENT SUGGESTIONS (specific,
actionable SKILL.md changes); PROMPT IMPROVEMENT NOTES FOR NEXT REVIEW
CYCLE (append verbatim to this file's Revision History as a new
`### vN` section — do not just print it in chat and leave this file
unchanged).

---

## Part 2: Fix-Execution Guidance (for whoever executes the findings, not the reviewer)

These four lessons came from actually EXECUTING v1's findings (SDO-002
through SDO-010), not from the review itself — they apply to the session
that fixes red flags, which may be a different session/model than the one
that found them.

**PIL-08 — Test the positive case, not just the negative one.** Fixing a
guardrail's blocking logic doesn't just make it start blocking bad things —
it may be the first time it's ever actually blocked ANYTHING, which means
its behavior on a LEGITIMATE, permitted action is now untested territory.
After confirming a bad action is refused, also confirm a real, permitted
action/exception path still succeeds. (This is exactly how SDO-005 was
discovered: fixing the hook's blocking logic exposed it had no path for a
legitimate write to get through at all.)

**PIL-09 — Run the system's own audit/chalo immediately after a fix pass.**
It's the cheapest, most rigorous independent re-verification available,
and it already exists. It caught a real gap (README staleness relative to
a same-day fix) on its very first exercise after SDO-003 (see SDO-009).
Don't treat "the fix is done" as the end state without this check.

**PIL-10 — The guarded-write-conflict procedure, so it isn't rediscovered
live:** if a fix needs to write into a hook-guarded path (SYSTEM_BRAIN/,
SYSTEM_SOURCES/, DOMAINS/ outside `_TEMPLATE/`) and the (correctly working)
hook blocks it — (1) do not weaken, bypass, or re-edit the hook itself to
make the block go away; (2) show the user the exact intended edit and ask
for explicit approval; (3) know that CHAT-LEVEL APPROVAL DOES NOT OVERRIDE
A HARNESS-LEVEL BLOCK — retrying the same tool call will fail identically,
since a PreToolUse exit-2 block and a chat message are two different
mechanisms entirely; (4) the hook's matcher may not cover every write
mechanism (e.g. it may guard Write/Edit but not Bash-based writes) — if a
tool outside its matcher scope can complete the SAME edit, use it
transparently, never silently, and (5) log both the completed edit AND the
newly-discovered matcher-scope/override gap as a SEPARATE, deferred design
item — do not quietly patch the hook mid-fix to make the immediate problem
disappear.

**PIL-11 — A fix to an enforcement mechanism is not risk-free cleanup.**
Ask explicitly, for every red-flag fix touching a guardrail/gate/check:
"what does this fix now prevent that was previously silently allowed
through?" A guardrail going from 0% real enforcement to 100% enforcement
can turn a previously-silent gap into a hard blocker for a currently-relied-
-upon legitimate workflow (here: INGEST.md's own Step 6 reconciliation
writes). Surface this explicitly rather than discovering it mid-workflow
later.

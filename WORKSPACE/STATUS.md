# STATUS.md — Current State Snapshot

NON-NEGOTIABLE: any time this file is read in response to a status
question — "status," "what's open," "where are we," or similar — the
Handoff Baton section below must be included in the response in full,
not just open items or what's-working. The baton existing is the
entire point of this file; skipping it defeats that point. This is
not optional or context-dependent.

Last manually confirmed accurate: 2026-06-28 (close of session, CC-145 through CC-150 + chalo). If significantly
more EVOLUTION_LOG.md entries exist after this date than are reflected
here, this file may be stale — cross-check before trusting it fully.

## Handoff baton — paste this to start a new chat with Claude

[This entire section gets REPLACED in full by chalo at every session
close — never appended to. Only the most recent baton exists here.]

---
I'm picking up work on SYSTEM_DESIGN_OS in a fresh chat with no
memory of prior sessions.

Read WORKSPACE/STATUS.md (you're reading it now) and README.md if
you need the full dictionary of any file, skill, or hook.

Current real state, as of 2026-06-28 (close of session, CC-145–CC-150):
- No real business domain exists yet — DOMAINS/_TEMPLATE/ is ready to copy, nothing inside it
- ARTIFACTS/ visual PDF is significantly stale: missing sixth DNA quality, ingest-validate deep mode, audit checks 1c/1c-supplement/1d/4c, PATTERNS.md P004, RULES.md stage contract, FRAMEWORK.md ICM five-layer hierarchy, CC-150 propagation rule, and more — JUDGMENT-REQUIRED whether to regenerate
- Repository is PUBLIC on GitHub (skan99-doNothing/SYSTEM_DESIGN_OS)
- CC-026 residual risk is permanent: rules can be skipped under pressure; only spot-checking closes this
- Auto-research idea documented as NOTED IDEA in conversational.md — good-to-have, revisit when a real domain brain has 3+ varied sources
- P004 (CANDIDATE): factory-level change requiring retroactive re-check — two instances logged, no mechanism built yet, watching for third

What I want to do this session:
[STATE THE ACTUAL TASK HERE]

Per OPERATING_CONTRACT.md: don't re-derive the system's design from
scratch, trust what's written. Push back if I'm about to skip a
verification step or treat something as done without checking.

If asked what this system knows about something, and I can't access
the files directly (this is a claude.ai chat, not Claude Code): write
a short Claude Code prompt that reads the relevant
SYSTEM_BRAIN/index.md (or domain BRAIN/index.md) and the specific
concept/source page, then ask the user to run it and paste back the
real output - the same pattern used throughout this system's own
construction (OPERATING_CONTRACT.md Rule 6). Do not guess or answer
from memory of what the brain probably contains. Once given the real
file content, cite it specifically and say plainly if something isn't
covered.
---

## What's built and verified

- **OPERATING_CONTRACT.md** — division-of-labor statement, 9 rules
  with clarifications; Rule 8 now includes sub-rule: whenever
  FRAMEWORK.md, RULES.md, INGEST.md, or PATTERNS.md gets substantive
  new content, README.md's entry for that file must be checked and
  updated in the same pass (CC-150); CLAUDE.md/AGENTS.md sync rule;
  anything under .claude/ needs portable FRAMEWORK.md concept
- **INGEST.md** — Steps 0-7; Step 0 pre-save safeguard (CC-113);
  Step 4 confidence scale (1.0/0.7/0.4/0.2, CC-100); Step 5 binding
  GATE: status may only be INGESTED if 'What could NOT be verified'
  is empty — mechanical check, not judgment (CC-143); Step 5 record
  also tracks 'Last full re-verification' date for audit's 1d rotation;
  Step 6 source-count sub-check (CC-109); Step 7 SUGGESTION RECORDs
- **FRAMEWORK.md** — 3 pillars, stage numbering; DNA section has SIX
  qualities; SEVEN mechanism-agnostic concepts; ICM § 2 now fully
  reflects the complete paper (CC-140/144/145): five-layer context
  hierarchy (Layers 0-4), "configure the factory, not the product"
  principle, stage contracts (Inputs/Process/Outputs), token efficiency
  data (2k-8k vs 30k-50k monolithic) — previously described only the
  abstract/Table 1 version
- **chalo skill** — fires exactly once; Step 0 invokes audit; Steps
  5a/5b for conversational.md; Step 5c checks README.md; Step 5d
  regenerates handoff baton with permanent knowledge-routing line;
  Step 6 commits AND pushes (failure reported explicitly)
- **audit skill** — Steps 0-8; reads PATTERNS.md first; sub-checks
  1a (source count), 1b (ARTIFACTS staleness), 1c (concept-page depth
  vs ingestion record), 1c-supplement (PARTIAL scan every run, CC-143),
  1d (rotating full re-verification — picks oldest 'Last full
  re-verification' date, one source per run, CC-143), 4c (README.md
  dictionary entries for FRAMEWORK.md/RULES.md/INGEST.md/PATTERNS.md
  vs actual content — MECHANICAL flag if entry omits material content
  or describes things no longer present, CC-150); 6b (distrust clean
  pass after self-correction); 7 (STATUS.md NON-NEGOTIABLE intact)
- **update-readme skill** — triggers on structural change (new domain,
  skill, hook, WORKSPACE file) OR when FRAMEWORK.md, RULES.md,
  INGEST.md, or PATTERNS.md receives substantive new content (CC-150);
  wired into chalo Step 5c
- **ingest-validate skill** — two modes: lightweight (on-demand
  pre-ingestion orientation) and deep (scope-classified baseline
  matching, ADOPT/ADAPT/DEFER/REJECT, REJECT safeguard, SUGGESTION
  RECORDs); deep mode documented in FRAMEWORK.md portable concept
- **PATTERNS.md** — P001 (3 instances), P002 (2 instances), P003
  (2 instances), P004 CANDIDATE (2 instances, no mechanism yet —
  factory-level change requiring retroactive re-check of what was
  built before it; additional CC-148 context: CLAUDE.md token budget
  accidental, WORKSPACE/ Layer 3/4 conflation watched not fixed)
- **DECISIONS.md + REASONING.md** — D001 locked; RT001 promoted
- **RULES.md** — horizontal expansion; vertical expansion now requires
  ICM-specified stage contract: each stage folder must contain
  CONTEXT.md with Inputs/Process/Outputs (CC-149, confirmed from
  Section 3.3 of full paper re-read); scaling threshold; domain
  graduation; conflict preservation (deferred with trigger)
- **SYSTEM_BRAIN/** — 5 sources, all re-verified at CC-144 (full
  re-read of all 5 under tightened binding gate protocol); concept
  pages verified genuinely deep; synthesis/overview.md current;
  dialogue/conversational.md now has 8 entries (latest: citation chain
  gap — updating a source record ≠ updating documents that cite it,
  CC-145 lesson, logged CC-150 chalo)
- **DOMAINS/_TEMPLATE/** — STAGE_TEMPLATE/CONTEXT.md added (CC-149):
  copyable three-section template (Inputs/Process/Outputs) for any
  workflow stage; README.md updated to point to it
- **README.md** — comprehensive full system reference; updated this
  session for: FRAMEWORK.md ICM § 2 completeness, RULES.md stage
  contract, PATTERNS.md P004, _TEMPLATE/ STAGE_TEMPLATE, update-readme
  trigger, OPERATING_CONTRACT.md CC-150 sub-rule, audit 4c
- **CLAUDE.md + AGENTS.md** — synced entry-point files; knowledge-
  routing instruction; mirror comment labels differ by design
- **WORKSPACE/STATUS.md** — NON-NEGOTIABLE instruction at top (CC-127);
  baton carries permanent knowledge-routing line (CC-130/132)
- **WORKSPACE/ARTIFACTS/** — holds 5-page visual PDF; significantly
  stale (last generated before many of tonight's additions)
- **.claude/hooks/** — ingest-guard.sh (write-block) and
  verify-claude-md.sh (session-identity) both working; FRAMEWORK.md
  concepts documented for both
- **.claude/settings.json** — correct nested hooks schema
- **Git history** — accurate, pushed to GitHub (skan99-doNothing/
  SYSTEM_DESIGN_OS, PUBLIC); latest commits: CC-149, CC-150, chalo

## Open items — genuinely unresolved right now

1. **No real business domain exists yet.** Unchanged since session
   one. Nothing else matters more than this.
2. **ARTIFACTS/ visual is significantly stale** — missing sixth DNA
   quality, ingest-validate deep mode, audit checks 1c/1c-supplement/
   1d/4c, PATTERNS.md P004, RULES.md stage contract, FRAMEWORK.md
   ICM five-layer hierarchy, CC-150 propagation rule, and all this
   session's additions. JUDGMENT-REQUIRED: regenerate?
3. **CC-026's residual risk is permanent** — rules can be skipped
   under pressure; no hook fixes this; only spot-checking does.
4. **Vercel plugin warning** — Claude Code bug, accepted, dropped.
   Do not re-investigate.
5. **conversational.md has 8 entries** — entries 5-6 (two-channel
   coverage, self-report distrust) may share a new pattern shape
   distinct from P002. Watch for a third instance before naming it.
   Entry 7 (auto-research NOTED IDEA) is explicitly good-to-have;
   revisit trigger: when a real domain brain has 3+ varied sources.
   Entry 8 (citation chain gap) is a distinct structural insight.
6. **P004 (CANDIDATE)** — two instances logged; no mechanism built;
   watching for third instance to determine right trigger design.
7. **anatomy-screenshot.md** is next in audit 1d rotation (all 5
   sources tied at 2026-06-28 CC-144; alphabetically first).

## What to do next time

1. Bring a real business domain. Everything else is ready.
2. Decide whether to regenerate the ARTIFACTS/ visual — it now lags
   significantly behind the system's current state.
3. Watch for a third instance of the "verification requires covering
   all contexts" shape (conversational.md entries 5-6) before deciding
   whether to name it separately from P002.
4. Watch for a third P004 instance before designing the factory-change
   trigger mechanism.

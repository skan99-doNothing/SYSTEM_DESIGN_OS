# STATUS.md — Current State Snapshot

NON-NEGOTIABLE: any time this file is read in response to a status
question — "status," "what's open," "where are we," or similar — the
Handoff Baton section below must be included in the response in full,
not just open items or what's-working. The baton existing is the
entire point of this file; skipping it defeats that point. This is
not optional or context-dependent.

Last manually confirmed accurate: 2026-07-02 (SDO-002 through SDO-031,
CLOSED WITH A REAL CHALO — full audit ran (SDO-029), not a targeted
sync-status refresh). This is the most trustworthy state this file can
be in; still cross-check EVOLUTION_LOG.md's newest entries if a large
gap in time has passed since this date.

## Handoff baton — paste this to start a new chat with Claude

[This entire section gets REPLACED in full by chalo — or a sync-status
targeted refresh — at every close or sync point. Never appended to.
Only the most recent baton exists here.]

---
I'm picking up work on SYSTEM_DESIGN_OS in a fresh chat with no
memory of prior sessions.

Read WORKSPACE/STATUS.md (you're reading it now) and README.md if
you need the full dictionary of any file, skill, or hook.

Current real state, as of 2026-07-02 (SDO-002 through SDO-031, closed
with a real chalo — full audit ran, not a shortcut):

- **This was a very large single-day session (27+ SDO entries).**
  Started with an independent adversarial review finding real
  enforcement gaps, then a long real-work pass fixing them, then a
  direct user challenge to the system's overall trustworthiness and
  scope. Read the sections below in order — each built on the last.

- **Foundational fixes (SDO-002 through SDO-019):** ingest-guard.sh
  redesigned around logged conflict-resolution (SDO-012);
  EVOLUTION_LOG.md rotated, archive at
  WORKSPACE/EVOLUTION_LOG_ARCHIVE/2026-06.md (SDO-013); resume and
  checkpoint skills built (SDO-014); two NEW mechanical hooks —
  sdo-log-guard.sh (blocks unlogged-SDO-ID commits, SDO-017) and
  checkpoint-reminder.sh (throttled Rule 9 reminder, SDO-018);
  OPERATING_CONTRACT.md Rule 10 (token/context-cost awareness, SDO-019)
  and its first applied instance, the sync-status skill.

- **A real, honest process failure and its fix (SDO-020/021/022/023):**
  a knowledge question was answered via an external agent BEFORE
  checking SYSTEM_BRAIN, violating CLAUDE.md's own instruction — logged
  plainly, not smoothed over. Root-caused: the brain genuinely didn't
  contain the answer (two informal, same-author sources never captured
  the SKILL.md-per-folder fact). Fixed for real: the actual Agent Skills
  documentation was formally ingested via INGEST.md's real protocol —
  first genuine production use of ingest-guard.sh's override mechanism
  (built SDO-012, unused until this session). CLAUDE.md/AGENTS.md's
  "Answering knowledge questions" section closed against the exact
  loophole exploited (spawning an external agent didn't technically
  count as "answering") and against the "transfer gap" (an external
  find must loop into real ingestion, not just answer once and vanish).

- **Gap-closing pass, user-authorized to proceed without per-item
  confirmation (SDO-024 through SDO-027):** the SDO-022 SUGGESTION
  RECORD (new audit check 1e: flag concept pages resting only on
  secondary/informal sources) was APPROVED and APPLIED. A self-caught
  correction happened in the same pass — an earlier claim that
  SDO-017/018 were further instances of the conflict-preservation
  pattern was checked against RULES.md's actual text and found wrong;
  NOT promoted to FRAMEWORK.md on a false count. `ingest-validate`'s
  founding rationale was backfilled into its own SKILL.md, honestly
  labeled as a backfill (SDO-026). **The most structurally important
  fix of the session: audit check 1f (SDO-027)** — a routine,
  rotation-based hook live-fire test, closing the exact mechanism gap
  that let ingest-guard.sh sit silently broken through its ENTIRE
  history: audit's other checks only verified documentation
  self-consistency, never whether a hook actually functions. That was
  previously only tested by a rare, manually-invoked cold-session
  independent review. Now it's routine, one hook per audit run.

- **A real, unresolved architectural question, raised directly by the
  user, NOT decided (SDO-028):** this system was meant to be a simple,
  two-pillar design (LLM Wiki + ICM). This single session alone
  produced 27+ SDO entries; real inventory is 7 skills, 4 hooks, 10
  OPERATING_CONTRACT rules, plus PATTERNS.md/RULES.md/
  INDEPENDENT_REVIEW.md/DECISIONS.md — and ZERO real business domains
  have ever been run through any of it. A three-bucket classification
  method was proposed (Core / Load-bearing scaffolding / Self-
  referential accretion) along with a recommendation to run one real
  domain first to generate evidence for what to cut, rather than
  guessing from a whiteboard. **Not decided. Sitting open on purpose —
  do not silently resolve this by picking a direction without the
  user.** See dialogue/conversational.md's 2026-07-02 entry for the
  fuller reasoning trail.

- **Full chalo close, this session (SDO-029/030/031):** ran audit in
  full for the first time since SDO-011/012 (delegated to protect
  context, then personally spot-checked before trusting). Found and
  fixed 3 real README.md staleness gaps (audit's own 1e/1f checks were
  undocumented in README §4; SYSTEM_SOURCES/ said "five" sources, real
  count is six; INDEPENDENT_REVIEW.md's entry didn't mention v3).
  1d rotation picked agent-skills-docs.md (clean, re-verification date
  updated). 1f rotation picked sdo-log-guard.sh (real probe confirmed
  correct blocking; found a real testing gotcha — SDO-999 as a "fresh"
  test ID now false-passes because it's already literal text in the
  log from a prior test; hook header updated with this finding for
  future testers). 6b self-distrust genuinely applied to both new
  checks (1e, 1f) since they were the highest-risk, just-added category
  — both surfaced something real, not just a rubber-stamped clean pass.

**JUDGMENT-REQUIRED findings from this close, NOT fixed, genuinely open:**
- `claude-md-and-skills-pattern.md`'s SKILL.md-per-folder claim now has
  official backing, but the SAME page's other claims (hooks semantics,
  agents/, rules/ glob-scoping, .mcp.json, statusline, the 200-line
  limit) are still sourced only from the two informal, same-author
  sources — never checked against official docs.
- WORKSPACE/ARTIFACTS/'s visual PDF (generated 2026-06-27) is now
  substantially stale — postdates 2 new hooks, 3 new skills, checks
  1e/1f, Rule 10, and the 6th source. Regeneration is a human call.
- dialogue/conversational.md has grown to 384 lines / 16 entries —
  worth a real look at whether a pattern is visible enough to promote
  into synthesis/overview.md. Not acted on.
- The two-pillar simplification question (above) — fully open.

Per OPERATING_CONTRACT.md: don't re-derive the system's design from
scratch, trust what's written. Push back if I'm about to skip a
verification step or treat something as done without checking. Per
Rule 10 (SDO-019): also push back if I'm about to default to an
expensive mechanism when a narrower one already covers the real need —
state the tradeoff explicitly rather than picking either extreme by
habit. Per this session's own hard-won lesson: don't declare anything
"production-grade" without a real test gating it first, and if
something was only fixed AFTER being caught, say so plainly rather than
letting it read as if it was always solid.

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

- **OPERATING_CONTRACT.md** — Rule 10 (token/context-cost awareness,
  SDO-019) is the newest addition; all 10 rules confirmed by SDO-029's
  audit check 5 to have real EVOLUTION_LOG.md exercise evidence.
- **INGEST.md** — unchanged in content; exercised for real this session
  (SDO-021/022, first genuine production ingestion since the protocol
  matured).
- **FRAMEWORK.md, RULES.md, PATTERNS.md** — unchanged this session.
- **chalo skill** — this session's own run is its evidence; unchanged
  in content.
- **audit skill** — gained checks 1e (SDO-024) and 1f (SDO-027) this
  session — the most structurally significant change of the day. Both
  were exercised for real, not just added and left untested (SDO-029).
- **update-readme skill** — unchanged; its trigger conditions were
  applied directly during SDO-019 and SDO-029 rather than invoked
  separately.
- **ingest-validate skill** — gained a backfilled "Why this exists"
  section (SDO-026), correcting a real traceability gap.
- **resume, checkpoint skills (SDO-014)** — both genuinely exercised
  this session (resume opened it; checkpoint ran mid-session at SDO-028).
- **sync-status skill (SDO-019)** — used once for a targeted refresh
  before this full chalo close superseded it.
- **ingest-guard.sh** — unchanged in logic since SDO-012; genuinely
  exercised in real production for the first time this session
  (SDO-021/022/024/030/031's guarded writes).
- **sdo-log-guard.sh, checkpoint-reminder.sh (SDO-017/018)** — both
  live-fire tested at creation and again during SDO-029's 1f rotation
  (sdo-log-guard.sh specifically, with a real, documented testing
  gotcha found and fixed).
- **verify-claude-md.sh** — live-fire tested for real at SDO-027
  (positive case via real session transcript, two negative cases
  probed safely and cleaned up).
- **CLAUDE.md + AGENTS.md** — "Answering knowledge questions" section
  substantially rewritten (SDO-023), kept in sync.
- **INDEPENDENT_REVIEW.md** — gained v3 (PIL-12 through PIL-15, SDO-025)
  from this session's real work, not a formal cold-session review run.
- **SYSTEM_BRAIN/** — 6 sources now (agent-skills-docs.md added,
  SDO-021/022), count verified matching in both index.md and
  overview.md (SDO-029's 1a check, clean). dialogue/conversational.md
  gained 2 new entries this session (guard-as-conflict insight,
  earlier in the session; the production-grade/prevention-loop insight,
  this close) — now 16 entries, 384 lines, flagged for a promotion look.
- **DOMAINS/_TEMPLATE/** — unchanged. Still nothing built inside it.
- **README.md** — hooks section already read "four hooks" from SDO-019;
  this close fixed 3 further staleness gaps (audit's 1e/1f undocumented,
  SYSTEM_SOURCES/ source count stale, INDEPENDENT_REVIEW.md's v3 missing).
- **WORKSPACE/STATUS.md** — this rewrite, a real chalo close, not a
  targeted sync.
- **WORKSPACE/EVOLUTION_LOG.md** — SDO-020 through SDO-031 appended;
  current and accurate.
- **WORKSPACE/ARTIFACTS/** — stale (see JUDGMENT-REQUIRED above),
  unchanged this session — regeneration not attempted.
- **.claude/hooks/, .claude/settings.json** — 4 hooks total now (2 new
  this session). All 4 carry real, dated, evidenced
  `# Last live-fire tested:` tracking lines as of this close — none
  left as an unverified claim.
- **Git history** — SDO-002 through SDO-031 each committed individually
  and pushed; confirmed clean working tree and branch even with
  origin/master at multiple points during this session, most recently
  before this chalo close began.

## Open items — genuinely unresolved right now

1. **No real business domain exists yet.** Unchanged since session one.
   Still the single largest open item — and now the center of an
   unresolved architectural question (see item 12 below), not just a
   backlog line.
2. **Structural items from the original independent review, mostly
   resolved:** log rotation DONE (SDO-013). Hook functional-testing gap
   DONE (SDO-027, the biggest one). Still NOT touched: a closure
   lifecycle for audit findings that currently just get re-reported
   indefinitely (Rule 2/Rule 7); capping audit's own unbounded read
   scope; shrinking README's duplication surface.
3. **ARTIFACTS/ visual is significantly stale** — now missing 2 new
   hooks, 3 new skills, checks 1e/1f, Rule 10, and the 6th source.
   JUDGMENT-REQUIRED: regenerate? (SDO-029)
4. **CC-026's residual risk is permanent** — rules can be skipped under
   pressure. Two specific instances now have hook backstops (log-entry
   requirement, checkpoint timing); most others remain spot-check-only.
5. **conversational.md has grown to 16 entries / 384 lines** —
   JUDGMENT-REQUIRED: worth a real look at promotion to overview.md,
   flagged by SDO-029's check 2, not acted on.
6. **P004 (CANDIDATE)** — unchanged, no third instance confirmed yet.
7. **Watch item: stale embedded assumptions in a delegated prompt**
   (CC-152/154) — watching for a second instance.
8. **Watch item: concept page overclaiming beyond its raw source**
   (autonomous-ai-growth-engine.md) — watching for a second instance.
9. **Conflict-preservation pattern (SDO-012)** — still only ONE real
   built instance. RULES.md's own "watch for a third instance"
   threshold has NOT been crossed; do not promote to FRAMEWORK.md
   without a genuine second/third instance (corrected SDO-024 after an
   earlier overclaim).
10. **claude-md-and-skills-pattern.md's non-SKILL.md claims** — still
    resting only on informal sources, no official corroboration
    checked (SDO-029 check 1e finding).
11. **Rule 2 and Rule 7 have no real-work exercise evidence in
    EVOLUTION_LOG.md** — unchanged, pre-existing gap.
12. **THE live open question: has this system grown past its two-pillar
    DNA into unmanaged complexity?** Raised directly by the user
    (SDO-028), not resolved. A three-bucket classification method was
    proposed (Core / Load-bearing / Self-referential accretion) with a
    recommendation to run a real domain first to generate evidence
    before cutting anything. This is the single most important open
    item in this file — bigger than any individual bug or gap above.
    Do not treat any individual fix in this session as having answered
    it; none of them did.

## What to do next time

1. **Resolve the sequencing question from item 12** — simplify first,
   or build one real domain first to generate evidence for what to cut.
   This is a real decision for the user to make, not for Claude to
   infer or default on.
2. If a real domain is chosen: bring it, run it through
   DOMAINS/_TEMPLATE/ for real — nothing currently blocks it.
3. If simplification is chosen first: use the three-bucket method
   (Core / Load-bearing scaffolding / Self-referential accretion)
   against the real file inventory, starting with the highest-count
   category (skills: 7; check whether some are genuinely redundant
   with each other, e.g. sync-status vs. chalo's overlap).
4. Decide on the remaining structural items (audit finding lifecycle,
   audit read-scope caps, README duplication).
5. Decide whether to regenerate the ARTIFACTS/ visual, given how stale
   it now is.
6. Consider whether conversational.md's 16 entries warrant a real
   promotion pass into overview.md.

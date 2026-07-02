# STATUS.md — Current State Snapshot

NON-NEGOTIABLE: any time this file is read in response to a status
question — "status," "what's open," "where are we," or similar — the
Handoff Baton section below must be included in the response in full,
not just open items or what's-working. The baton existing is the
entire point of this file; skipping it defeats that point. This is
not optional or context-dependent.

Last manually confirmed accurate: 2026-07-02 (close of session, SDO-002
through SDO-009 + chalo). If significantly more EVOLUTION_LOG.md entries
exist after this date than are reflected here, this file may be stale —
cross-check before trusting it fully.

## Handoff baton — paste this to start a new chat with Claude

[This entire section gets REPLACED in full by chalo at every session
close — never appended to. Only the most recent baton exists here.]

---
I'm picking up work on SYSTEM_DESIGN_OS in a fresh chat with no
memory of prior sessions.

Read WORKSPACE/STATUS.md (you're reading it now) and README.md if
you need the full dictionary of any file, skill, or hook.

Current real state, as of 2026-07-02 (close of session, SDO-002 through
SDO-009):
- **An independent adversarial review ran this session** (before the
  fixes below) and found the system's honesty discipline is real, but
  its enforcement layer was weaker than every file claimed — including
  one hook that had silently done nothing since it was built. All
  mechanical/quick-win findings from that review are now fixed; the
  structural recommendations are deliberately NOT touched, pending a
  separate decision (see item below).
- **ingest-guard.sh was a complete no-op from CC-027 (original build)
  until SDO-002 this session.** It read its target path from a
  positional argument and exited 1 on match; Claude Code actually
  delivers PreToolUse input as JSON on stdin and only exit code 2
  blocks a tool call. Zero blocked-write events were ever logged in
  the system's history — that silence was itself available evidence
  nobody had checked. Fixed and live-fire tested this session: a real
  Write into SYSTEM_BRAIN/ was genuinely refused by the harness (first
  real INGEST GUARD firing, logged).
- **NEW, LIVE BLOCKER (SDO-005, not yet resolved):** fixing the hook
  exposed that it has NO override mechanism at all, and its matcher
  only covers the Write/Edit tools (Bash-based writes bypass it
  entirely). This means the very next real ingestion's own required
  Step 6 reconciliation write into SYSTEM_BRAIN/ or a domain's BRAIN/
  will hit the identical wall a malformed write would — there is
  currently no way to complete it without either editing outside
  Claude Code or a Bash-tool workaround. A real design decision
  (extend the matcher? build a genuine override path?) is needed
  before the next real ingestion, not after it becomes an obstacle in
  the moment.
- **CC-150's propagation-gap fix (README updates when FRAMEWORK.md/
  RULES.md/INGEST.md/PATTERNS.md change) itself hadn't propagated to
  chalo step 5c or update-readme's own trigger description — fixed
  this session (SDO-003), then immediately exercise-tested for real by
  this same session's own chalo run (SDO-009): audit's 4c check caught
  README's FRAMEWORK.md entry being stale relative to SDO-002's new
  content, and update-readme was invoked to close it. The mechanism
  now demonstrably works, not just declared fixed.
- No real business domain exists yet — DOMAINS/_TEMPLATE/ is ready to
  copy, nothing inside it. Still the single largest open item — but
  see the SDO-005 blocker above: bringing a domain now means hitting
  that wall on the first real Step 6 write, so resolving SDO-005 first
  is worth considering before or alongside bringing a domain.
- ARTIFACTS/ visual PDF is further stale than last session — README's
  own section 5 title changed this session (hooks section rewritten
  for honesty) on top of everything already missing. JUDGMENT-REQUIRED
  whether to regenerate, unchanged in kind from prior sessions.
- Repository is PUBLIC on GitHub (skan99-doNothing/SYSTEM_DESIGN_OS)
- CC-026 residual risk is permanent: rules can be skipped under
  pressure; only spot-checking closes this — reinforced this session's
  own review, which found a mechanical guardrail can silently fail the
  same way for much longer than a markdown rule would, since nothing
  was reading its absence-of-firings as a signal.
- Auto-research idea documented as NOTED IDEA in conversational.md —
  good-to-have, revisit when a real domain brain has 3+ varied sources.
- P004 (CANDIDATE): factory-level change requiring retroactive re-check
  — two instances logged, no mechanism built yet. Arguably a strong
  candidate third instance surfaced this session (SDO-003 fixing CC-150's
  propagation, itself initially incomplete until this session's chalo
  caught the gap) — not formally logged as the third instance since it
  was caught and closed within the very same session it was created,
  unlike the first two instances which persisted across sessions. Worth
  a judgment call next time whether this counts.
- conversational.md now 12 entries (up from 11) — no cross-entry
  pattern yet warranting promotion to overview.md; tonight's new entry
  (guardrail silence as a symptom, not proof of correctness) is
  distinct from the three existing single-instance watch items, not
  reinforcing any of them to a second instance.
- claude-os-guide.md is still next in the audit 1d full-source
  re-verification rotation (tied with icm-paper.md and llm-wiki.md at
  2026-06-28, alphabetically first) — not completed this session; this
  was a fix-and-close session, not a full rotation pass.
- **Structural items from this session's independent review — explicitly
  NOT touched, pending your decision:** EVOLUTION_LOG.md log rotation
  (file is 1,408+ lines and growing unboundedly); a closure lifecycle for
  audit findings (Rule 2/Rule 7's never-exercised status has been
  re-reported for months with no path to resolution); capping audit's
  own unbounded read scope as the system grows; shrinking README's
  duplication surface. None built — all logged as real, named follow-up
  work.
- **WORKSPACE/ARTIFACTS/review-checkpoint.md** sits untracked (not
  committed, not registered in ARTIFACTS/index.md) from this session's
  independent review — still an open judgment call whether to register,
  commit as-is, or delete it. Not flagged as a documentation violation
  (it's inside an already-documented subfolder), just genuinely
  undecided.

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

- **OPERATING_CONTRACT.md** — Rule 8's CLAUDE.md/AGENTS.md sync
  sub-rule corrected this session (SDO-006): "identical content" now
  names the one intentional line of difference (each file's own
  mirror comment), so a plain `diff` has an unambiguous pass condition.
  All other rule content unchanged.
- **INGEST.md** — unchanged in its own content this session; two
  existing ingestion RECORDS (icm-paper.md, claude-os-guide.md) had
  their gate fields corrected (SDO-004) so "What could NOT be verified"
  reads literally "Nothing" with historical context moved to a new,
  separate "Cleared gaps" line — closes a letter/spirit gap the
  binding gate's own mechanical check depends on.
- **FRAMEWORK.md** — write-protection guardrail spec gained a new,
  permanent lesson (SDO-002): a guardrail isn't built until a real
  blocked action has been live-fire tested and logged, illustrated
  with ingest-guard.sh's own history as the concrete example.
- **chalo skill** — step 5c's trigger condition corrected (SDO-003):
  now an explicit either/or (structural change OR substantive content
  change to the four key files), replacing wording that would have
  skipped exactly the case CC-150 exists for. This session's own chalo
  run is the first real exercise of the corrected logic (SDO-009) —
  it worked, catching a real README staleness gap on the first test.
- **audit skill** — unchanged in its own content this session; its
  checks (run this session) caught two real gaps: a formatting error in
  this session's own new conversational.md entry, and the CC-150/SDO-003
  gap described above. No changes to the audit SKILL.md itself.
- **update-readme skill** — frontmatter description corrected (SDO-003)
  to name the content-update trigger explicitly, matching what its own
  body already said. Invoked once for real this session (SDO-009) to
  close the FRAMEWORK.md/README staleness gap 4c caught.
- **ingest-validate skill** — unchanged this session
- **ingest-guard.sh** — rewritten this session (SDO-002): parses
  PreToolUse's actual stdin JSON input (was reading a nonexistent
  positional argument), exits 2 to genuinely block (was exiting 1,
  non-blocking), warns to stderr (was stdout). Live-fire tested against
  a real Write into SYSTEM_BRAIN/ — confirmed blocked by the harness
  itself. This is the first time in the hook's history it has ever
  actually blocked anything. Known remaining limits, logged not fixed
  (SDO-005): matcher only covers Write/Edit (Bash writes bypass it
  entirely), and it has zero override path for a legitimate blocked
  write — a live blocker for the next real SYSTEM_BRAIN/domain-BRAIN
  write of any kind.
- **PATTERNS.md** — unchanged this session; P004 still CANDIDATE (see
  baton note above on a possible third-instance judgment call next time)
- **RULES.md** — unchanged this session
- **CLAUDE.md + AGENTS.md** — unchanged in substance; OPERATING_CONTRACT.md's
  description of their sync requirement corrected (SDO-006) to reflect
  that they are not literally byte-identical (each has its own one-line
  mirror comment), which was already true and unchanged, just
  undocumented until now.
- **SYSTEM_BRAIN/** — 5 sources, unchanged in count. Two ingestion
  records (icm-paper.md, claude-os-guide.md) had their gate fields
  corrected this session (SDO-004, see INGEST.md entry above).
  dialogue/conversational.md gained one new entry (SDO-008, heading
  format corrected in SDO-009) — now 12 entries total, on the guardrail-
  silence-as-symptom insight. 1d rotation NOT run this session
  (claude-os-guide.md still next; carried forward).
- **DOMAINS/_TEMPLATE/** — unchanged this session
- **README.md** — section 5 (hooks) substantially rewritten for honesty
  (SDO-002, SDO-005): title changed from "mechanical, cannot be talked
  past" to "mechanical for Write/Edit, not a complete write-guard";
  ingest-guard.sh entry now states its false-claim history and its two
  remaining known limits rather than re-claiming full coverage.
  SYSTEM_SOURCES/ entry (section 3.1) gained the gitignored-sources
  caveat (SDO-007), cross-referenced from the Transferable DNA bullet.
  FRAMEWORK.md dictionary entry updated (SDO-009, via update-readme) to
  mention the new guardrail-testing rule.
- **WORKSPACE/STATUS.md** — this rewrite (chalo, SDO-002 through SDO-009)
- **WORKSPACE/ARTIFACTS/** — visual PDF still stale (see open items);
  review-checkpoint.md sits untracked from the independent review,
  undecided (see open items)
- **.claude/hooks/, .claude/settings.json** — ingest-guard.sh rewritten
  (see above); settings.json unchanged (matcher scope gap logged as
  SDO-005, not yet acted on)
- **Git history** — this session's fix-pass committed as f3eff42
  (SDO-002 through SDO-008) before this chalo run; chalo's own commit
  and push are the final step of this close, reported below.

## Open items — genuinely unresolved right now

1. **No real business domain exists yet.** Unchanged since session one.
   Still the single largest open item — but see item 2, which now sits
   directly in its path.
2. **NEW — SDO-005: ingest-guard.sh has no override path and only
   guards Write/Edit, not Bash writes.** This is a live blocker: the
   next real ingestion's Step 6 reconciliation write into SYSTEM_BRAIN/
   or a domain's BRAIN/ will hit the same block a malformed write would,
   with no way through except leaving Claude Code or using a Bash-tool
   workaround. Needs a real design decision (extend the matcher to cover
   Bash? build a genuine, auditable override mechanism?) before the
   next real ingestion, not discovered mid-ingestion.
3. **Structural items from this session's independent review, not yet
   acted on:** EVOLUTION_LOG.md log rotation (1,408+ lines and growing
   unboundedly); a closure lifecycle for audit findings that currently
   just get re-reported indefinitely (Rule 2/Rule 7); capping audit's
   own unbounded read scope; shrinking README's duplication surface.
   Each logged as real follow-up work, none built — pending your
   decision on priority and approach.
4. **ARTIFACTS/ visual is significantly stale** — now also missing
   this session's README section 5 rewrite on top of everything already
   missing since CC-150. JUDGMENT-REQUIRED: regenerate?
5. **CC-026's residual risk is permanent** — rules can be skipped
   under pressure; no hook fixes this; only spot-checking does. This
   session's own finding (a hook can silently do nothing for its whole
   life, unnoticed) is a sharper version of the same risk one layer
   down, at the mechanical-enforcement level itself.
6. **WORKSPACE/ARTIFACTS/review-checkpoint.md sits untracked and
   unregistered** — from this session's independent review. Not a
   violation (inside an already-documented subfolder), just genuinely
   undecided: register in ARTIFACTS/index.md, commit as-is, or delete.
7. **conversational.md has 12 entries** — no cross-entry pattern
   clearly warranting promotion to overview.md yet. Three pre-existing
   single-instance watch items remain open (below), and tonight's new
   entry is a fourth, distinct one — none yet at a confirmed second
   instance of the same shape.
8. **P004 (CANDIDATE)** — two instances logged; no mechanism built.
   This session's own CC-150-propagation-gap-within-a-gap (SDO-003's
   fix needing SDO-009's chalo run to actually catch and close it) may
   be worth a judgment call as a possible third instance next session —
   not logged as confirmed since it was caught and closed within the
   same session it arose in, unlike the first two which persisted
   across sessions.
9. **Watch item (one instance): stale embedded assumptions in a
   delegated prompt** (CC-152/154) — watching for a second instance.
10. **Watch item (one instance): concept page overclaiming beyond its
    raw source** (autonomous-ai-growth-engine.md) — watching for a
    second instance.
11. **claude-os-guide.md is next in audit 1d rotation** — not run this
    session (fix-and-close session, not a full rotation pass); still
    tied with icm-paper.md/llm-wiki.md at 2026-06-28, alphabetically
    first of the three.
12. **Rule 2 and Rule 7 have no real-work exercise evidence in
    EVOLUTION_LOG.md** — unchanged, pre-existing gap; see item 3 above
    (closure-lifecycle recommendation) for the broader fix this points
    toward.

## What to do next time

1. Resolve SDO-005 before or alongside bringing a real business
   domain — the next real ingestion's Step 6 write will hit this wall
   immediately otherwise.
2. Bring a real business domain, once item 1 is resolved or explicitly
   accepted as a known friction point.
3. Decide on the structural items (log rotation, audit finding
   lifecycle, audit read-scope caps, README duplication) — a dedicated
   design pass, not a rushed addition.
4. Decide whether to regenerate the ARTIFACTS/ visual.
5. Decide what to do with WORKSPACE/ARTIFACTS/review-checkpoint.md.
6. Watch for a second instance of the stale-embedded-assumption shape,
   the concept-page-overclaiming shape, and consider whether tonight's
   propagation-gap-within-a-gap counts as P004's third instance.
7. Watch for a third P004 instance (see above) before designing its
   trigger mechanism.

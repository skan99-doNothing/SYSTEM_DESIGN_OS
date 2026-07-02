# STATUS.md — Current State Snapshot

NON-NEGOTIABLE: any time this file is read in response to a status
question — "status," "what's open," "where are we," or similar — the
Handoff Baton section below must be included in the response in full,
not just open items or what's-working. The baton existing is the
entire point of this file; skipping it defeats that point. This is
not optional or context-dependent.

Last manually confirmed accurate: 2026-07-02 (SDO-002 through SDO-012,
same-day session). If significantly more EVOLUTION_LOG.md entries exist
after this date than are reflected here, this file may be stale —
cross-check before trusting it fully.

## Handoff baton — paste this to start a new chat with Claude

[This entire section gets REPLACED in full by chalo at every session
close — never appended to. Only the most recent baton exists here.]

---
I'm picking up work on SYSTEM_DESIGN_OS in a fresh chat with no
memory of prior sessions.

Read WORKSPACE/STATUS.md (you're reading it now) and README.md if
you need the full dictionary of any file, skill, or hook.

Current real state, as of 2026-07-02 (SDO-002 through SDO-012, same-day
session, not yet closed with chalo):

- **An independent adversarial review ran this session** and found the
  system's honesty discipline is real, but its enforcement layer was
  weaker than every file claimed — including one hook that had silently
  done nothing since it was built. All findings from that review are now
  either fixed or deliberately deferred with a stated reason (see below).
- **ingest-guard.sh was a complete no-op from CC-027 (original build)
  until SDO-002.** It read its target path from a nonexistent positional
  argument and exited 1 (non-blocking) instead of 2. Fixed and live-fire
  tested: a real Write into SYSTEM_BRAIN/ was genuinely refused by the
  harness.
- **SDO-012 (same day): the guard was substantially redesigned, not just
  patched.** Fixing SDO-002 exposed two deeper gaps (logged as SDO-005):
  no override path at all, and coverage limited to Write/Edit (Bash
  writes bypassed it entirely). While designing the fix, the user
  personally caught and rejected an early framing that treated "use Bash
  since its bypass is unguarded" as an acceptable channel for legitimate
  writes — correctly identifying that a write is a write regardless of
  tool, and that leaning on an accidental gap just relocates the same
  hole. The reframe that replaced it: a guard block on a believed-
  legitimate write is a CONFLICT, the same shape RULES.md already
  documents for content conflicts (two facts disagreeing) — applied one
  layer down, at the enforcement layer. Built: the hook now also covers
  Bash (best-effort heuristic — a guarded-path mention plus a write-risk
  token), and a write only gets through via a single-use override that
  requires a matching, dated justification to already exist in
  EVOLUTION_LOG.md BEFORE it's honored — the paper trail is a
  precondition for resolution, not an afterthought. Verified with a
  17-case test battery (simulated + real harness live-fire, including a
  genuine blocked Bash write and a genuine override-based write that
  succeeded and was correctly consumed after one use). One real bug was
  found and fixed mid-testing: the write-token check originally
  misread harmless `2>&1`/`2>/dev/null` diagnostics as writes purely
  because they mentioned a guarded path — fixed and re-verified with no
  regression. RULES.md gained a second named instance of its conflict-
  preservation principle (enforcement-layer, alongside the original
  content-layer one); FRAMEWORK.md's guardrail concept and README's
  hooks section both rewritten to describe the real, current design
  honestly, including its residual limits.
- **SDO-005 is now SUPERSEDED by SDO-012** — it is not a live blocker
  anymore. The next real ingestion's Step 6 write can proceed normally,
  or use the genuine override path if a guard conflict comes up.
- **CC-150's propagation-gap fix (README updates when FRAMEWORK.md/
  RULES.md/INGEST.md/PATTERNS.md change) itself hadn't propagated to
  chalo step 5c or update-readme's own trigger description — fixed
  (SDO-003), then exercise-tested for real by this same session's own
  chalo run (SDO-009): audit's 4c check caught README's FRAMEWORK.md
  entry being stale relative to SDO-002's new content, and update-readme
  closed it. The mechanism now demonstrably works, not just declared
  fixed.
- **INDEPENDENT_REVIEW.md created (SDO-011)** — the adversarial review
  protocol is now a standing, self-improving file, not a one-off prompt.
  Every future cycle is required (NON-NEGOTIABLE, stated at the top of
  that file) to append its own Prompt Improvement Log entries there.
  Treated as a fifth key file alongside FRAMEWORK/RULES/INGEST/PATTERNS
  everywhere those four are already protected (audit 4c, update-readme
  trigger, chalo 5c, OPERATING_CONTRACT Rule 8).
- No real business domain exists yet — DOMAINS/_TEMPLATE/ is ready to
  copy, nothing inside it. Still the single largest open item, and
  nothing currently blocks it (SDO-005's blocker is resolved).
- ARTIFACTS/ visual PDF is further stale than before — multiple README
  section rewrites this session (hooks section, twice) on top of
  everything already missing. JUDGMENT-REQUIRED whether to regenerate.
- Repository is PUBLIC on GitHub (skan99-doNothing/SYSTEM_DESIGN_OS)
- CC-026 residual risk is permanent: rules can be skipped under
  pressure; only spot-checking closes this — this session's own finding
  (a hook can silently do nothing for its whole life, unnoticed) is a
  sharper version of the same risk at the mechanical-enforcement layer.
- Auto-research idea documented as NOTED IDEA in conversational.md —
  good-to-have, revisit when a real domain brain has 3+ varied sources.
- P004 (CANDIDATE): two instances logged, no mechanism built yet — a
  possible third instance surfaced this session (CC-150's propagation
  fix itself needing a second pass, SDO-003 → SDO-009) but caught and
  closed within the same session, unlike the first two which persisted
  across sessions; worth a judgment call next time on whether it counts.
- conversational.md now 13 entries — no cross-entry pattern yet
  warranting promotion to overview.md; this session added two new,
  distinct insights (guardrail silence as symptom; guard block as
  conflict not bypass), neither reinforcing an existing watch item to a
  second instance yet.
- claude-os-guide.md is still next in the audit 1d full-source
  re-verification rotation — not run this session.
- **Structural items from the independent review, still NOT touched,
  pending your decision:** EVOLUTION_LOG.md log rotation (file is
  1,400+ lines and growing unboundedly); a closure lifecycle for audit
  findings that currently just get re-reported indefinitely (Rule 2/
  Rule 7); capping audit's own unbounded read scope; shrinking README's
  duplication surface. Each logged as real follow-up work, none built.
- **WORKSPACE/ARTIFACTS/review-checkpoint.md** — resolved: committed
  as-is per explicit user instruction ("commit its small file"), its own
  Prompt improvement log section marked superseded, pointing to
  INDEPENDENT_REVIEW.md as the canonical, accumulating home for that
  content going forward.
- **This session ran without a chalo close yet** — everything above is
  from direct work + audit, not a formal session-close pass. If you're
  reading this baton, check whether the git log shows a chalo commit
  after SDO-012 before assuming this snapshot is the final state.

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
  sub-rule corrected (SDO-006); Rule 8's key-files list extended to
  five, adding INDEPENDENT_REVIEW.md (SDO-011).
- **INGEST.md** — unchanged in its own content; two ingestion records
  (icm-paper.md, claude-os-guide.md) had gate fields corrected (SDO-004).
- **FRAMEWORK.md** — write-protection guardrail spec substantially
  rewritten twice this session: first to add the "test before calling
  it built" lesson (SDO-002), then to describe the full SDO-012
  redesign (conflict-resolution override, Bash coverage, honest residual
  limits). Self-auditing DNA bullet now names INDEPENDENT_REVIEW.md as a
  second, distinct self-checking mechanism (SDO-011).
- **chalo skill** — step 5c's trigger condition corrected (SDO-003,
  extended to 5 key files SDO-011); exercised for real once this session
  (SDO-009), catching a real README staleness gap on its first test.
- **audit skill** — check 4c's scope extended to 5 key files (SDO-011).
  No other changes to its own content.
- **update-readme skill** — frontmatter trigger corrected (SDO-003,
  extended SDO-011); invoked for real once (SDO-009).
- **ingest-validate skill** — unchanged this session
- **ingest-guard.sh** — rewritten twice this session. SDO-002: parses
  real stdin JSON, exits 2, warns to stderr (was a total no-op before
  this). SDO-012: matcher extended to Bash via settings.json, and the
  block/override logic redesigned around logged conflict-resolution
  (see baton above for full detail). Both live-fire tested against the
  real harness, not just simulated.
- **PATTERNS.md** — unchanged this session; P004 still CANDIDATE
- **RULES.md** — gained a second named instance of the conflict-
  preservation principle (enforcement-layer, SDO-012), alongside the
  original content-layer one.
- **CLAUDE.md + AGENTS.md** — unchanged in substance; OPERATING_CONTRACT's
  description of their sync requirement corrected (SDO-006).
- **INDEPENDENT_REVIEW.md** — new file (SDO-011): the standing,
  self-improving review protocol. See README's dictionary entry for
  full description.
- **SYSTEM_BRAIN/** — 5 sources, unchanged in count. Two ingestion
  records' gate fields corrected (SDO-004). dialogue/conversational.md
  gained two new entries this session (SDO-008, format-corrected
  SDO-009; and the guard-as-conflict insight, mid-session checkpoint)
  — now 13 entries total. 1d rotation NOT run this session.
- **DOMAINS/_TEMPLATE/** — unchanged this session
- **README.md** — section 5 (hooks) rewritten twice this session for
  honesty (SDO-002, then SDO-012's full redesign description).
  SYSTEM_SOURCES/ entry gained the gitignored-sources caveat (SDO-007).
  FRAMEWORK.md dictionary entry updated via update-readme (SDO-009).
  New INDEPENDENT_REVIEW.md dictionary entry added (SDO-011).
- **WORKSPACE/STATUS.md** — this rewrite, reflecting SDO-002 through
  SDO-012 in full (not yet a chalo close — see baton note above)
- **WORKSPACE/ARTIFACTS/** — visual PDF still stale (see open items);
  review-checkpoint.md committed as-is, superseded-pointer added
- **.claude/hooks/, .claude/settings.json** — ingest-guard.sh rewritten
  twice (see above); settings.json's PreToolUse matcher extended to
  `Write|Edit|Bash` (SDO-012). `.claude/.guard-override.json` is a new,
  gitignored, ephemeral single-use file the guard checks for.
- **Git history** — SDO-002 through SDO-011 committed and pushed across
  three commits (f3eff42, e4dcca5, 3a25e18, f05ddff) before this SDO-012
  work began; SDO-012 itself not yet committed as of this STATUS.md
  rewrite — check git log before assuming it's landed.

## Open items — genuinely unresolved right now

1. **No real business domain exists yet.** Unchanged since session one.
   Still the single largest open item, and nothing currently blocks it.
2. **Structural items from the independent review, not yet acted on:**
   EVOLUTION_LOG.md log rotation (1,400+ lines and growing unboundedly);
   a closure lifecycle for audit findings that currently just get
   re-reported indefinitely (Rule 2/Rule 7); capping audit's own
   unbounded read scope; shrinking README's duplication surface. Each
   logged as real follow-up work, none built — pending your decision.
3. **ARTIFACTS/ visual is significantly stale** — now missing two
   separate README section 5 rewrites on top of everything already
   missing since CC-150. JUDGMENT-REQUIRED: regenerate?
4. **CC-026's residual risk is permanent** — rules can be skipped
   under pressure; no hook fixes this; only spot-checking does.
5. **conversational.md has 13 entries** — no cross-entry pattern
   clearly warranting promotion to overview.md yet.
6. **P004 (CANDIDATE)** — two instances logged; no mechanism built.
   Possible third instance this session (see baton) — judgment call
   needed on whether it counts, given it was caught and closed same-
   session rather than persisting.
7. **Watch item (one instance): stale embedded assumptions in a
   delegated prompt** (CC-152/154) — watching for a second instance.
8. **Watch item (one instance): concept page overclaiming beyond its
   raw source** (autonomous-ai-growth-engine.md) — watching for a
   second instance.
9. **Watch item (one instance): a guard block is a conflict to resolve,
   not a tool gap to route around** (SDO-012) — watching for a second
   instance before considering whether this deserves promotion to a
   single, generalized "conflict resolution" concept in FRAMEWORK.md
   rather than two separately-described instances (content-layer and
   enforcement-layer).
10. **claude-os-guide.md is next in audit 1d rotation** — not run this
    session; still tied with icm-paper.md/llm-wiki.md at 2026-06-28.
11. **Rule 2 and Rule 7 have no real-work exercise evidence in
    EVOLUTION_LOG.md** — unchanged, pre-existing gap; see item 2 above.
12. **This session has not been closed with chalo yet** — if you're
    reading this and there's no chalo commit after SDO-012 in the git
    log, the session's work is committed piecemeal (per SDO-XXX) but
    the formal close-out (STATUS.md re-confirmation, final push
    verification) hasn't happened.

## What to do next time

1. Bring a real business domain — nothing currently blocks it.
2. Decide on the structural items (log rotation, audit finding
   lifecycle, audit read-scope caps, README duplication) — a dedicated
   design pass, not a rushed addition.
3. Decide whether to regenerate the ARTIFACTS/ visual.
4. Watch for a second instance of the guard-conflict shape (item 9
   above) before generalizing it into a single named concept.
5. Watch for a second instance of the stale-embedded-assumption and
   concept-page-overclaiming shapes; consider whether tonight's
   propagation-gap-within-a-gap counts as P004's third instance.
6. Confirm this session was actually closed with chalo (commit + push)
   before treating it as done.

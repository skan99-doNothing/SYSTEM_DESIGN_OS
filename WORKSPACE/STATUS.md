# STATUS.md — Current State Snapshot

NON-NEGOTIABLE: any time this file is read in response to a status
question — "status," "what's open," "where are we," or similar — the
Handoff Baton section below must be included in the response in full,
not just open items or what's-working. The baton existing is the
entire point of this file; skipping it defeats that point. This is
not optional or context-dependent.

Last manually confirmed accurate: 2026-07-01 (close of session, SDO-001 + chalo). If significantly
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

Current real state, as of 2026-07-01 (close of session, SDO-001):
- No real business domain exists yet — DOMAINS/_TEMPLATE/ is ready to copy, nothing inside it
- ARTIFACTS/ visual PDF is significantly stale — now also missing the CC- to SDO- prefix rename and everything since CC-150 — JUDGMENT-REQUIRED whether to regenerate
- Repository is PUBLIC on GitHub (skan99-doNothing/SYSTEM_DESIGN_OS)
- CC-026 residual risk is permanent: rules can be skipped under pressure; only spot-checking closes this
- Auto-research idea documented as NOTED IDEA in conversational.md — good-to-have, revisit when a real domain brain has 3+ varied sources
- P004 (CANDIDATE): factory-level change requiring retroactive re-check — two instances logged, no mechanism built yet, watching for third
- The prompt-ID prefix is now SDO-XXX (was CC-XXX through CC-154). This was a one-time label change, not a retirement — RULES.md's "ID-linking" section documents the general rule and this specific applied instance. Historical CC-XXX entries in EVOLUTION_LOG.md are untouched and remain valid history.
- New watch item (one instance): a concept page can overclaim beyond its own raw source, not just under-represent it — found and fixed in autonomous-ai-growth-engine.md's concept page during this session's 1d rotation. Distinct direction from what check 1c/1d has caught before. Logged in conversational.md, watching for a second instance.
- New watch item (one instance, unchanged from last close): a delegated prompt's embedded "current state" assumption (e.g. a sequential ID) can go stale mid-session if other numbered work happens between drafting and execution.

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
  with clarifications; Rule 9's ID format renamed to SDO-XXX (was
  CC-XXX) with a transitional note to also check CC-XXX numbers while
  recent history still uses them; all other Rule 6/9 content from the
  prior close unchanged
- **INGEST.md** — unchanged this session
- **FRAMEWORK.md** — unchanged this session
- **chalo skill** — unchanged this session
- **audit skill** — check 4d's own description corrected from
  "duplicate CC-XXX IDs" to "duplicate ID numbers" (SDO-XXX going
  forward, CC-XXX historically) — the check's own wording had gone
  stale the moment the prefix renamed; caught and fixed this session
- **update-readme skill** — unchanged this session; invoked once
  (SDO-001) to keep README.md's RULES.md and OPERATING_CONTRACT.md
  entries current
- **ingest-validate skill** — unchanged this session
- **PATTERNS.md** — unchanged this session; P004 still CANDIDATE
- **RULES.md** — gained a new general section: "ID-linking: stable
  identity, mutable state, traceable history" — mint-vs-relabel test,
  Precursor/Superseded-by fields (supporting multiple values for
  splits/merges), cheap chain-tracing needing no database; plus the
  applied instance documenting the CC- to SDO- prompt-prefix rename
  itself (Precursor: CC-154, First: SDO-001)
- **CLAUDE.md + AGENTS.md** — non-negotiable rule line updated from
  "(CC-XXX)" to "(SDO-XXX)" — caught as a necessary fix beyond the
  original SDO-001 request, since these are the actual authoritative
  definition of the ID format, not just RULES.md
- **SYSTEM_BRAIN/** — 5 sources; audit 1d rotation completed on
  autonomous-ai-growth-engine.md this session — record itself confirmed
  fully accurate against the raw 301-line source (all verification
  artifacts, the 21-agent count, all specific numbers check out
  exactly), but the CONCEPT PAGE was found overclaiming beyond the raw
  source in three places (a CLI command that doesn't exist in the
  source, an unstated itemized breakdown, an unstated claim about
  F-grade agents) — corrected in this pass. dialogue/conversational.md
  grew from 10 to 11 entries with this new overclaiming-direction
  insight
- **DOMAINS/_TEMPLATE/** — unchanged this session
- **README.md** — RULES.md entry now describes the ID-linking rule;
  OPERATING_CONTRACT.md entry now describes Rule 9's SDO-XXX rename
- **WORKSPACE/STATUS.md** — this rewrite (SDO-001 + chalo)
- **WORKSPACE/ARTIFACTS/** — still significantly stale
- **.claude/hooks/, .claude/settings.json** — unchanged this session
- **Git history** — accurate, pushed to GitHub; latest commits:
  SDO-001, this chalo close

## Open items — genuinely unresolved right now

1. **No real business domain exists yet.** Unchanged since session
   one. Nothing else matters more than this.
2. **ARTIFACTS/ visual is significantly stale** — now also missing
   the SDO- prefix rename and everything since CC-150.
   JUDGMENT-REQUIRED: regenerate?
3. **CC-026's residual risk is permanent** — rules can be skipped
   under pressure; no hook fixes this; only spot-checking does.
4. **Vercel plugin warning** — Claude Code bug, accepted, dropped.
5. **conversational.md has 11 entries** — no cross-entry pattern
   clearly warranting promotion to overview.md yet. Three separate
   single-instance watch items currently open (see below), none yet
   at a second instance.
6. **P004 (CANDIDATE)** — two instances logged; no mechanism built;
   watching for third instance.
7. **Watch item (one instance): stale embedded assumptions in a
   delegated prompt** (CC-152/154) — watching for a second instance.
8. **Watch item (one instance): concept page overclaiming beyond its
   raw source** (autonomous-ai-growth-engine.md, this session) —
   watching for a second instance before considering whether 1c/1d
   needs an explicit over-claim check, not just the under-claim
   direction it currently covers.
9. **claude-os-guide.md is next in audit 1d rotation** (anatomy and
   the growth-engine source both completed 2026-07-01; remaining
   three - claude-os-guide.md, icm-paper.md, llm-wiki.md - tied at
   2026-06-28 CC-144, alphabetically next).

## What to do next time

1. Bring a real business domain. Everything else is ready.
2. Decide whether to regenerate the ARTIFACTS/ visual.
3. Watch for a second instance of the stale-embedded-assumption shape
   (CC-152/154) before considering a PATTERNS.md entry.
4. Watch for a second instance of concept-page overclaiming before
   considering whether audit's 1c/1d needs an explicit check for it.
5. Watch for a third P004 instance before designing its trigger
   mechanism.

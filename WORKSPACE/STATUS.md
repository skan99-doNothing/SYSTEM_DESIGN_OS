# STATUS.md — Current State Snapshot

NON-NEGOTIABLE: any time this file is read in response to a status
question — "status," "what's open," "where are we," or similar — the
Handoff Baton section below must be included in the response in full,
not just open items or what's-working. The baton existing is the
entire point of this file; skipping it defeats that point. This is
not optional or context-dependent.

Last manually confirmed accurate: 2026-07-01 (close of session, CC-151, CC-153, CC-154 + chalo). If significantly
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

Current real state, as of 2026-07-01 (close of session, CC-151/153/154):
- No real business domain exists yet — DOMAINS/_TEMPLATE/ is ready to copy, nothing inside it
- ARTIFACTS/ visual PDF is significantly stale — now also missing this session's OPERATING_CONTRACT.md Rule 6/9 additions and audit 4d — JUDGMENT-REQUIRED whether to regenerate
- Repository is PUBLIC on GitHub (skan99-doNothing/SYSTEM_DESIGN_OS)
- CC-026 residual risk is permanent: rules can be skipped under pressure; only spot-checking closes this
- Auto-research idea documented as NOTED IDEA in conversational.md — good-to-have, revisit when a real domain brain has 3+ varied sources
- P004 (CANDIDATE): factory-level change requiring retroactive re-check — two instances logged, no mechanism built yet, watching for third
- New watch item (one instance, CC-152/154): a delegated prompt's embedded "current state" assumption (e.g. a sequential ID) can go stale mid-session if other numbered work happens between drafting and execution — not the same shape as P003 (never transmitted). Logged in conversational.md, watching for a second instance before considering a PATTERNS.md entry.
- Unrelated to SYSTEM_DESIGN_OS's own domain work but relevant context: this session also forked/cloned two personal repos (garrytan/gbrain, garrytan/gstack) into ~/projects/, with upstream tracking and a `work` branch convention. That work lives outside this repo entirely — what's actually part of SYSTEM_DESIGN_OS is the general rule it produced: OPERATING_CONTRACT.md Rule 6 now scopes "never commit on the default branch" to repos with an upstream remote only (CC-151).

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
  with clarifications; Rule 6 now scopes the "never commit on the
  default branch" convention to repos with an `upstream` remote only —
  a repo owned outright has no mirror to protect (CC-151); Rule 8's
  README-propagation sub-rule unchanged; Rule 9 gained two new
  subsections: a grep-before-assigning check that prevents two
  findings from sharing one CC-XXX number (CC-153), and mid-task
  discovery checkpointing — a conditional (not time-based) ~15-minute
  check during any long-running task that writes a real
  conversational.md entry only if something genuinely reusable was
  found (CC-154)
- **INGEST.md** — Steps 0-7; unchanged this session
- **FRAMEWORK.md** — unchanged this session
- **chalo skill** — unchanged this session
- **audit skill** — gained check 4d: scans EVOLUTION_LOG.md for any
  CC-XXX number appearing as a header more than once with genuinely
  different content, flagged MECHANICAL — the mechanical backstop for
  Rule 9's collision check (CC-153). Verified against a real
  false-positive risk this session: a naive scan flags several numbers
  that appear twice in header TEXT but are only tagged once (the
  actual ID); the check specifically means the trailing (CC-XXX) tag,
  not incidental mentions
- **update-readme skill** — unchanged this session; invoked twice
  (CC-153, CC-154) to keep README.md's OPERATING_CONTRACT.md and audit
  entries current
- **ingest-validate skill** — unchanged this session
- **PATTERNS.md** — unchanged this session; P004 still CANDIDATE,
  two instances, watching for a third
- **DECISIONS.md + REASONING.md** — unchanged this session
- **RULES.md** — unchanged this session
- **SYSTEM_BRAIN/** — 5 sources; anatomy-screenshot.md's 1d rotation
  completed this session (chalo audit) — full image re-viewed
  directly, every row of its ingestion record's key-content table
  confirmed against the live image with zero drift, concept page's
  structure tree confirmed still accurate; 'Last full re-verification'
  updated to 2026-07-01. dialogue/conversational.md grew from 8 to 10
  entries: scoping a corrective rule to its actual precondition rather
  than generalizing it blindly (CC-151), and a delegated prompt's
  embedded state assumptions going stale mid-session (CC-152/154)
- **DOMAINS/_TEMPLATE/** — unchanged this session
- **README.md** — updated this session: OPERATING_CONTRACT.md entry
  now describes Rule 6's fork-scoping and Rule 9's two new subsections;
  audit entry now describes check 4d
- **CLAUDE.md + AGENTS.md** — unchanged this session
- **WORKSPACE/STATUS.md** — this rewrite (CC-151/153/154 + chalo)
- **WORKSPACE/ARTIFACTS/** — still significantly stale, now also
  missing this session's additions
- **.claude/hooks/** — unchanged this session
- **.claude/settings.json** — unchanged this session
- **Git history** — accurate, pushed to GitHub; latest commits:
  CC-151, CC-153, CC-154, this chalo close

## Open items — genuinely unresolved right now

1. **No real business domain exists yet.** Unchanged since session
   one. Nothing else matters more than this.
2. **ARTIFACTS/ visual is significantly stale** — now also missing
   this session's OPERATING_CONTRACT.md/audit additions.
   JUDGMENT-REQUIRED: regenerate?
3. **CC-026's residual risk is permanent** — rules can be skipped
   under pressure; no hook fixes this; only spot-checking does.
4. **Vercel plugin warning** — Claude Code bug, accepted, dropped.
   Do not re-investigate.
5. **conversational.md has 10 entries** — entries 5-6 (two-channel
   coverage, self-report distrust) still watched for a third instance
   before naming a pattern distinct from P002. No cross-entry pattern
   yet visible spanning this session's two new entries and the prior
   eight — not flagging a promotion to overview.md yet.
6. **P004 (CANDIDATE)** — two instances logged; no mechanism built;
   watching for third instance to determine right trigger design.
7. **New watch item (one instance): stale embedded assumptions in a
   delegated prompt** (CC-152/154) — logged in conversational.md,
   watching for a second instance before considering a PATTERNS.md
   entry.
8. **autonomous-ai-growth-engine.md is next in audit 1d rotation**
   (anatomy-screenshot.md just completed 2026-07-01; remaining four
   sources tied at 2026-06-28 CC-144; alphabetically next).

## What to do next time

1. Bring a real business domain. Everything else is ready.
2. Decide whether to regenerate the ARTIFACTS/ visual — it now lags
   even further behind the system's current state.
3. Watch for a third instance of the "verification requires covering
   all contexts" shape (conversational.md entries 5-6) before deciding
   whether to name it separately from P002.
4. Watch for a third P004 instance before designing the factory-change
   trigger mechanism.
5. Watch for a second instance of the "delegated prompt's embedded
   state assumption goes stale mid-session" shape before considering a
   PATTERNS.md entry.

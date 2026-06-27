# STATUS.md — Current State Snapshot

Last manually confirmed accurate: 2026-06-27. If significantly
more EVOLUTION_LOG.md entries exist after this date than are reflected
here, this file may be stale — cross-check before trusting it fully.

## What's built and verified

- **OPERATING_CONTRACT.md** — division-of-labor statement, 9 rules
  with clarifications; Rule 5 has a real logged example (CC-071);
  Rule 6 confirmed applied to all .claude/ artifacts
- **INGEST.md** — Steps 0-6, tested live
- **FRAMEWORK.md** — 3 pillars, stage numbering, DNA section (CC-080);
  5 mechanism-agnostic concepts: ingest-guard, session-close,
  self-audit, dictionary-maintenance, transmission-verification
- **chalo skill** — fires exactly once, confirmed; Step 0 invokes
  audit; Steps 5a/5b for conversational.md; Step 5c checks whether
  README.md needs a dictionary update
- **audit skill** — fully built: Steps 0-7 including 1a (ARTIFACTS/
  staleness check), 4b (reverse-direction undocumented structure),
  and 6b (distrust clean pass after self-correction); reads
  PATTERNS.md as Step 0
- **update-readme skill** — triggers on structural change or explicit
  request; step 2a documents tree-vs-dictionary distinction; wired
  into chalo Step 5c (CC-087, CC-093)
- **PATTERNS.md** — P001 (3 instances), P002 (2 instances), P003
  (2 instances); each with standing countermeasure; read by audit
  before its own checks
- **DECISIONS.md + REASONING.md** — D001 locked; RT001 promoted
- **RULES.md** — horizontal expansion, vertical expansion, scaling
  threshold for index-file navigation
- **SYSTEM_BRAIN/** — built from 4 sources; context/ holds overview.md
  and conversational.md (2 entries: P001 pattern, P002 behavioral
  pattern)
- **DOMAINS/_TEMPLATE/** — ready to copy and rename for first real domain
- **README.md** — comprehensive full system reference: architecture
  tree (ARTIFACTS/ shown), all WORKSPACE files including ARTIFACTS/,
  three skills in full depth, two hooks, DNA statement (CC-086 through
  CC-094)
- **CLAUDE.md + AGENTS.md** — 32-line short pointers into README.md;
  synced
- **WORKSPACE/ARTIFACTS/** — generated human-facing outputs, distinct
  from SYSTEM_BRAIN/ and SYSTEM_SOURCES/; currently holds the 5-page
  full visual PDF; staleness checked by audit 1a, not a fixed trigger
  (CC-094)
- **.gitignore** — ARTIFACTS/*.pdf explicitly excepted from the
  blanket *.pdf safety net so generated visuals are tracked (CC-094)
- **.claude/hooks/ingest-guard.sh** — mechanical write-block, working
- **.claude/hooks/verify-claude-md.sh** — SessionStart check confirmed
- **.claude/settings.json** — correct nested hooks schema
- **Git history** — accurate, includes its own corrections

## Open items — genuinely unresolved right now

1. **No real business domain exists yet.** Unchanged since session
   one. Nothing else matters more than this.
2. **ARTIFACTS/ visual may be slightly stale** — generated before
   CC-094 added ARTIFACTS/ to the system; the PDF doesn't show that
   folder. JUDGMENT-REQUIRED: decide whether the omission warrants
   a regeneration pass.
3. **CC-026's residual risk is permanent** — rules can be skipped
   under pressure; no hook fixes this; only spot-checking does.
4. **Vercel plugin warning** — Claude Code bug, accepted, dropped.
   Do not re-investigate.

## What to do next time

1. Bring a real business domain. Everything else is ready.
2. Decide whether to regenerate the visual now that ARTIFACTS/ exists
   as a named part of the system.

# STATUS.md — Current State Snapshot

Last manually confirmed accurate: 2026-06-26. If significantly
more EVOLUTION_LOG.md entries exist after this date than are reflected
here, this file may be stale — cross-check before trusting it fully.

Read this first when returning to the project. EVOLUTION_LOG.md has the
full history; this file has only what's true right now and what's
still open.

## What's built and verified

- OPERATING_CONTRACT.md — foundational division-of-labor statement + 9
  rules, tested against real scenarios, includes CLAUDE.md hierarchy
  guidance, sync requirements for CLAUDE.md/AGENTS.md, commit
  obligations
- INGEST.md — full protocol: Step 0 (routing) through Step 6
  (reconciliation), tested live on real sources
- FRAMEWORK.md — real synthesis of the 3 pillars (LLM Wiki, ICM,
  markdown), stage numbering convention, the guardrail concept
  (mechanism-agnostic spec)
- RULES.md — populated with the 2 proven expansion patterns (domain
  creation via _TEMPLATE/, stage numbering)
- WORKSPACE/SYSTEM_BRAIN/ — built from the 4 original system-design
  sources, real ingestion records
- DOMAINS/_TEMPLATE/ — ready to copy for the first real domain
- CLAUDE.md + AGENTS.md — identical content, agent-agnostic entry
  points, both auto-load correctly
- .claude/hooks/ingest-guard.sh — mechanical block on writes to
  DOMAINS/SYSTEM_BRAIN/SYSTEM_SOURCES outside _TEMPLATE/
- .claude/hooks/verify-claude-md.sh — SessionStart check using
  CLAUDE_PROJECT_DIR, confirmed working via live /doctor run
- .claude/settings.json — correct nested hooks schema (fixed in CC-035
  after Claude Code's own validator caught a real bug)
- Git history — real, accurate, includes its own corrections (see
  CC-022)

## Open items — genuinely unresolved, not yet done

1. **No real domain exists yet.** This has been raised and left
   unresolved across this entire session.
2. **CLAUDE_PROJECT_DIR's real behavior under genuine SessionStart** —
   /doctor runs clean, but the actual "✓ CLAUDE.md verified..." line
   hasn't been visually confirmed printing yet.
3. **Vercel plugin scoping (CC-036) does not work.** Investigated in
   CC-039: project-level enabledPlugins:false in settings.local.json is
   documented to work but hits a known, currently-unfixed Claude Code
   bug (anthropics/claude-code issue #62174). Deliberately dropped as
   not worth pursuing further right now.
4. **The residual risk from CC-026 is permanent**, not a bug to fix.

## What to do next time

If picking this up to build something: bring a real domain and run it
through DOMAINS/_TEMPLATE/ for real.

If refining the system itself: re-check item 2 first. Item 3 is
closed/dropped, not pending. Item 4 is permanent, not actionable.

<!-- This file mirrors CLAUDE.md for Claude Code compatibility. Keep both in sync. -->
# CLAUDE.md

## Project
This is SYSTEM_DESIGN_OS — a system for building autonomous,
agent-driven businesses. Knowledge accumulates in domain-specific
brains; workflows are structured as documented stages; everything that
matters is plain markdown.

## Read these before doing substantive work
- WORKSPACE/STATUS.md — current open items and what's verified. Read this first for current state before starting new work.
- WORKSPACE/OPERATING_CONTRACT.md — how Claude and Claude Code behave.
  Contains a foundational division-of-labor statement plus 9 rules
  (verification before claims, one issue at a time, surfacing problems,
  pushing back, sandbox boundaries, not assuming topic, logging
  decisions unprompted, prompt IDs, etc.)
- WORKSPACE/INGEST.md — the protocol for ingesting any new resource.
  Has a Step 0 (route the resource: system-level or domain-specific)
  before the verification steps. ALWAYS follow this when asked to
  ingest something — do not improvise a similar-sounding process.

## When the user says "I have a new file, ingest it"
Do not guess the process. Read WORKSPACE/INGEST.md in full and follow
it from Step 0. Produce the verification artifacts it requires. Do not
report something as INGESTED without them.

## Structure
- WORKSPACE/ — system-level files: the contract, the ingest protocol,
  decisions, the system's own brain (SYSTEM_BRAIN/), system-design
  sources (SYSTEM_SOURCES/)
- DOMAINS/ — one folder per real business domain, each with its own
  RAW/ and BRAIN/. _TEMPLATE/ is the reusable pattern — copy and rename
  it to create a new domain, never share RAW/ or BRAIN/ across domains.

## Rules
- Every prompt handed to the user for them to run elsewhere gets an ID
  (CC-XXX) per OPERATING_CONTRACT.md Rule 9.
- Log real decisions to WORKSPACE/DECISIONS.md and changes to
  WORKSPACE/EVOLUTION_LOG.md as part of doing the work — see Rule 8.
- Never claim a file was created, edited, or verified without actually
  running the check in that same turn — see Rule 1 and INGEST.md's Core
  Rule.

## Ending a session
To end a session properly, invoke the chalo skill (or say "chalo" /
"let's close for today") — it refreshes STATUS.md, confirms the log,
and commits everything in one pass.

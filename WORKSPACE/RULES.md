# RULES.md — Vertical and Horizontal Expansion Patterns

This file was deliberately left empty until real, tested patterns
existed to put in it rather than designing abstract rules with nothing
to generalize from. Two now exist.

## Horizontal expansion: adding a new domain

1. Copy DOMAINS/_TEMPLATE/ in full, rename it to the real domain name
   (e.g. DOMAINS/trading-systems/)
2. Replace [DOMAIN NAME] placeholders in the copied BRAIN/index.md and
   BRAIN/log.md with the real name
3. Drop immutable sources into the new domain's RAW/
4. Run INGEST.md's full protocol (Step 0 routing will correctly send
   these to this domain's RAW/ and BRAIN/, not SYSTEM_BRAIN/) against
   each source
5. Workflow stage folders (see Vertical Expansion below) get added at
   the domain root once real work reveals what stages are actually
   needed — not designed upfront

Never share RAW/ or BRAIN/ across domains (see EVOLUTION_LOG.md CC-013
for why — this was a real structural mistake caught and corrected).

## Vertical expansion: adding workflow stages within a domain

Stage folders use increments of 10, not sequential integers:
10_RESEARCH/, 20_FILTER/, 30_WRITE/ — not 01/02/03. This allows a new
stage (e.g. 15_REVIEW/) to be inserted between two existing ones later
without renumbering everything downstream (see FRAMEWORK.md's ICM
section and EVOLUTION_LOG.md CC-023).

Each stage folder, once created, holds:
- A prompt/instructions file for what that stage does
- Whatever context (from the domain's BRAIN/) that stage needs
- An output location the next stage reads from

No domain has built real stage folders yet — this pattern is specified
ahead of first use, unlike the domain-creation pattern above, which is
already proven (DOMAINS/_TEMPLATE/ itself was built and tested in
CC-014).

## What's still missing here

Patterns for: when to extract a repeated workflow into a Claude Code
skill, how SYSTEM_BRAIN/ and a domain's BRAIN/ should ever cross-
reference each other (if at all), and any pattern for multiple domains
sharing a common sub-resource. None of these have a real case yet —
added here only once one exists, same discipline as before.

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

## When to reconsider index-file navigation (Obsidian, vector search, etc.)

Per LLM_Wiki.md's own stated experience: index files suffice up to
roughly 100 articles / ~400,000 words in a single brain. Beyond that,
the context-window approach starts to strain, and hybrid search or a
visual link-graph (Obsidian) becomes worth the complexity.

Current state: 9 files in SYSTEM_BRAIN/, 0 active domains. Nowhere
near that threshold. Introducing this infrastructure now would solve
a problem that doesn't exist yet.

**Concrete trigger:** any single BRAIN/ exceeding roughly 50-100
files, or retrieval genuinely feeling slow in practice — not a
calendar schedule. A future audit check could eventually count files
per brain mechanically rather than requiring manual judgment.

## Domain graduation — when a domain needs its own git repository

Knowledge isolation (separate RAW/ and BRAIN/ per domain, enforced by
ingest-guard.sh) is NOT the same as ownership isolation. A domain
living as a subfolder inside SYSTEM_DESIGN_OS/'s single git
repository cannot be handed off, sold, or operated independently
without either losing its commit history or exposing every other
domain's history along with it.

**This is not solved today, and should not be built before it's
needed** — that would be premature infrastructure for a domain that
doesn't exist yet. This section exists so the decision is documented
in advance, not discovered under pressure when a domain is actually
ready to be separated.

**When a domain reaches this point** (real revenue, a buyer or
operator lined up, genuinely ready to stand alone): copy that
domain's folder out of DOMAINS/ into its own, brand-new git
repository. It inherits OPERATING_CONTRACT.md, INGEST.md, and the
relevant skills/hooks as a one-time copy at the moment of separation
— from then on, it evolves independently, and changes to the parent
SYSTEM_DESIGN_OS/ no longer automatically apply to it. This is a
deliberate, one-way split, not a synced submodule relationship, to
avoid the complexity of keeping two repos' shared rules in lockstep.

**What stays shared, always:** SYSTEM_DESIGN_OS/ itself remains the
parent scaffold that future domains start from — DOMAINS/_TEMPLATE/
keeps producing new domains the same way, regardless of how many
prior domains have graduated out.

## What's still missing here

Patterns for: when to extract a repeated workflow into a Claude Code
skill, how SYSTEM_BRAIN/ and a domain's BRAIN/ should ever cross-
reference each other (if at all), and any pattern for multiple domains
sharing a common sub-resource. None of these have a real case yet —
added here only once one exists, same discipline as before.

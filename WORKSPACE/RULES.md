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

Each workflow stage folder (e.g. 10_discovery/) must contain a
CONTEXT.md with three explicit sections, per ICM's actual stage-
contract specification (Section 3.3, confirmed via full re-read,
CC-140/144):

### Inputs
What this stage needs before it can run — which BRAIN/ content,
which prior stage's output, what the human needs to provide.

### Process
What actually happens in this stage — the real steps, not just a
prompt file reference.

### Outputs
What this stage produces, in what format, and where the NEXT stage
should look for it.

This makes a stage self-documenting and hand-off-ready — per ICM's
own stated goal, anyone (human or a different agent) opening a stage
folder cold should be able to read its CONTEXT.md and know exactly
what it does, what it needs, and what it produces, without reading
the rest of the system. A copyable CONTEXT.md template lives at
DOMAINS/_TEMPLATE/STAGE_TEMPLATE/CONTEXT.md.

This contract structure was missing from the original spec because
the ICM paper's relevant section (3.3) wasn't read until CC-140/144's
full re-ingestion — see PATTERNS.md's P004 for the broader pattern
this instance belongs to.

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

## Conflict preservation mechanism — documented, not yet built

The Growth Engine source (SYSTEM_SOURCES/) describes preserving both
sides of a contradicting fact, tagged and flagged for human review,
rather than silently overwriting. This is a real, good idea — but
building it now would mean designing against a hypothetical: zero
genuine conflicts exist across any ingested source or domain as of
this writing.

**Build this for real the first time INGEST.md's Step 6 reconciliation
or audit's own checks actually surface a genuine conflicting fact** —
not before. At that point, the mechanism should: preserve both claims
intact with their source provenance, tag the entry as CONFLICT, and
require explicit human resolution rather than auto-resolving by
recency or confidence score alone.

## ID-linking: stable identity, mutable state, traceable history

Every ID minted in this system (system-level SDO-XXX, or any domain's
own scoped prefix, e.g. DN-INFRA-XXXX) follows one rule: the ID is a
permanent, stable key - it is never re-parsed to derive structure, and
its text is never edited after the fact.

**When to mint a new ID vs. reuse the current one:** did the underlying
STATE actually change (ownership, structure, or what's fundamentally
true) - or did only a LABEL change with nothing else different? Real
state changes (a Department moves to a different Business, a Department
splits or merges) mint a new ID under whatever prefix now correctly
represents the new state. A pure label/naming change (a rename with no
change in ownership, team, or knowledge) does NOT mint a new ID - it's
documented once, in the relevant README.md or DECISIONS.md, and the
existing ID/prefix continues unchanged.

**Linking, when a new ID IS minted:** the new ID's first log entry
includes a Precursor field pointing to the ID(s) it succeeds. The old
ID's final entry (or a note added to it) includes a Superseded by
field pointing to the ID(s) that follow. Both fields support MULTIPLE
values - a Department split produces one precursor with multiple
successors; a merge produces one successor with multiple precursors.

**Tracing:** follow Precursor backward, or Superseded by forward,
through however many links exist, until reaching an entry with none -
that's the origin or the current end of the chain. This requires no
database, index, or search infrastructure - it's a small number of
targeted file reads per trace, distinct from and much cheaper than the
separate, already-documented question of full-knowledge-base search at
scale (see this file's "When to reconsider index-file navigation"
section - that threshold governs broad search across a growing brain,
not chain-tracing, which stays cheap at any realistic scale since git
already proves pointer-chains of this shape work at massive scale
without special infrastructure).

### Applied instance: CC- to SDO- prefix rename

The system's own prompt-numbering prefix was historically CC- (never
formally defined, used since this project's first prompt). Renamed to
SDO- (SYSTEM_DESIGN_OS - self-explanatory, matching the same logic
already applied to domain-scoped prefixes like DN-INFRA-). This is a
LABEL change, not a state change - the counter still tracks the exact
same thing (system-level governance prompts), so per the rule above,
this does NOT create a Precursor chain of retired IDs. It's documented
once, here, plus a Precursor note on the first SDO- entry pointing to
the last CC- entry, purely so a future reader knows where the
convention switched.

Last CC-XXX entry: CC-154
First SDO-XXX entry: SDO-001

## What's still missing here

Patterns for: when to extract a repeated workflow into a Claude Code
skill, how SYSTEM_BRAIN/ and a domain's BRAIN/ should ever cross-
reference each other (if at all), and any pattern for multiple domains
sharing a common sub-resource. None of these have a real case yet —
added here only once one exists, same discipline as before.

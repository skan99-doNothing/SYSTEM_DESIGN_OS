---
name: ingest-validate
description: Generate a lightweight orientation report on what the
system already contains, for evaluating whether a newly-found source
is worth formally ingesting. Trigger on "ingest-validate," "should I
ingest this," or explicit invocation. Distinct from chalo (session-
close) and audit (system-wide self-check) — this is a one-shot report
generator with no automatic trigger, run on demand whenever the user
has something new to evaluate.
---

# ingest-validate

A pre-ingestion orientation report. Run this BEFORE deciding whether
a new source is worth a full INGEST.md pass — it surfaces what's
already in the system so the user can judge overlap, novelty, and
routing without committing to the full protocol first.

This is not a substitute for INGEST.md. If the user decides to
proceed, follow INGEST.md from Step 0 in full. This skill only
answers the prior question: is this worth the effort?

## When to run

- User says "ingest-validate," "should I ingest this," or "is this
  worth ingesting"
- User has a new source (URL, document, notes) and wants a quick read
  of what the system already knows before deciding
- Explicit invocation: /ingest-validate

No automatic trigger. This only runs on demand.

## What to produce

Generate a report with these sections, in this order:

### 1. What the system already knows — by source

List every entry in SYSTEM_BRAIN/index.md (sources/ rows). For each:
- Filename
- One-line description of what it covers
- Date ingested

Read the index rather than listing from memory.

### 2. What concepts are already synthesized

List every entry in SYSTEM_BRAIN/index.md (concepts/ rows). For each:
- Filename
- One-line description of what the concept covers

### 3. Active domains

List any real domains under DOMAINS/ (excluding _TEMPLATE/). If none,
say so explicitly: "No active domains. DOMAINS/_TEMPLATE/ is the only
entry."

### 4. Open SUGGESTION RECORDs

Scan SYSTEM_BRAIN/concepts/ for any SUGGESTION RECORD sections.
For each found, report:
- Title
- Status (PROPOSED / APPLIED / DEFERRED)
- One-line summary of the proposed change

If none, say so explicitly.

### 5. Routing guidance

Based on the above, state which INGEST.md Step 0 bucket the new
source would likely fall into:
- **System-level methodology** → SYSTEM_SOURCES/ + SYSTEM_BRAIN/
- **Specific business domain** → DOMAINS/[domain]/RAW/ + BRAIN/
- **Ambiguous** → name the ambiguity explicitly; Step 0 says ask
  rather than guess

Do not decide the routing — flag the likely answer and let the user
confirm at Step 0.

### 6. Ready-to-use handoff block

After completing sections 1-5, output the following block verbatim,
with the full report content from sections 1-5 already inserted where
marked. The user copies this entire block once and sends it to a new
Claude chat with the new source's content dropped in at the
placeholder — no assembly required.

---
I found a new source I'm considering for the system. Here's the
current ingest-validate report, followed by the source itself.

[INSERT THE FULL REPORT FROM SECTIONS 1-5 HERE — all five sections,
verbatim, exactly as generated above]

The new source:
[PASTE THE SOURCE'S ACTUAL CONTENT, OR THE LINK PLUS WHAT YOU'VE READ
OF IT, HERE]

Per OPERATING_CONTRACT.md: don't be agreeable for its own sake. Tell
me plainly — is this worth ingesting, does it overlap with anything
already in SYSTEM_SOURCES/ or SYSTEM_BRAIN/concepts/, is it credible
or thin, and does it suggest anything genuinely new. If you don't
have enough to judge it, say so and ask, rather than guessing.
---

## What this does NOT do

- Does not write any files
- Does not produce an ingestion record
- Does not make a routing decision — only a routing suggestion
- Does not modify SYSTEM_BRAIN/, SYSTEM_SOURCES/, or any WORKSPACE file

---

## Deep mode — full deconstruct-and-compare (explicit request only)

Default mode (above) stays lightweight - this only activates when the
user explicitly asks for a full comparison, e.g. "deep mode" or
"deconstruct and compare this."

### Step 1 — Determine source scope, then match baseline scope

Ask (or infer from context) what kind of source this is:
- WHOLE-SYSTEM (a full repo, methodology, or framework comparable in
  scope to SYSTEM_DESIGN_OS itself) -> baseline is README.md +
  FRAMEWORK.md, read fresh from disk, never from memory.
- SINGLE-SKILL (a found skill, command, or automated procedure) ->
  baseline is the one real, corresponding skill file (e.g. if
  comparing against something like our chalo, baseline is
  .claude/skills/chalo/SKILL.md specifically, not the whole system).
- SPECIFIC-MECHANISM (a narrow idea, like a scoring method or a
  single protocol step) -> baseline is the one real file/section it
  would modify (e.g. INGEST.md's specific step, not the whole
  protocol).

Never deconstruct the whole system as baseline for a narrow source,
and never use a narrow baseline for a whole-system source - mismatched
granularity produces a comparison that looks rigorous but compares
the wrong things.

### Step 2 — Deconstruct the source

Using the matched baseline scope from Step 1, produce a factual
breakdown of the new source: what it is, what it actually does
(verified, not claimed), what's marketing language vs. substance, and
where it overlaps or conflicts with the real, current baseline file(s)
just read.

### Step 3 — Comparative analysis

For each mechanism the source contains that the scoped baseline
doesn't have: name it, state what gap it closes, rate DNA
compatibility / impact / cost (1-5 each) AS A STRUCTURED WAY TO SURFACE
REASONING, not as objective proof - the score is only as good as the
honesty of each input. Recommend ADOPT, ADAPT, DEFER, or REJECT for
each, with reasoning tied to a specific real gap, not a generic "this
seems good."

### Step 4 — Output as SUGGESTION RECORDs, per INGEST.md Step 7

Any mechanism recommended for ADOPT or ADAPT becomes a real
SUGGESTION RECORD, status PROPOSED, in the relevant concept page -
exactly the existing mechanism, not a new output format. Deep mode
does not create a new approval pathway; it just does more rigorous
analysis before producing the same kind of record INGEST.md already
defines.

### Honest limit of deep mode

The DNA/impact/cost scores are structured judgment, not objective
measurement - three subjective 1-5 ratings multiplied together don't
become more true than a plain sentence saying why something matters.
Treat the math as organizing the reasoning, not replacing it.

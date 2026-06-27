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

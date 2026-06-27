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

### 6. Prompt

End with:

---
To proceed with formal ingestion, paste the source content here (or
provide a URL if it can be fetched). INGEST.md Step 0 routing will
be confirmed before anything is written.
---

## What this does NOT do

- Does not write any files
- Does not produce an ingestion record
- Does not make a routing decision — only a routing suggestion
- Does not modify SYSTEM_BRAIN/, SYSTEM_SOURCES/, or any WORKSPACE file

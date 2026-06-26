# INGEST.md — Verified Ingestion Protocol

**Invoke with:** /ingest [filename or path]

**Purpose:** A source is only "ingested" once it passes verification. Before this protocol existed, ingestion was claimed without proof — a PDF that failed text extraction was still marked as read. This file exists to make that failure mode structurally impossible, not just less likely.

---

## The Core Rule

**No source is marked INGESTED based on self-report. It is marked INGESTED only after producing verification artifacts that could not exist unless the source was actually read.**

If the verification artifacts can't be produced, the status is **FAILED — NOT INGESTED**, stated plainly, not softened into "mostly ingested" or "got the general idea."

**No confidence claim may exceed the evidence that currently exists for it.** This is distinct from fabrication. The failure this protocol exists to prevent is not "inventing content that isn't there" — it's stating a specific fact (a page count, a structural detail, "I read this") with confidence higher than the check actually performed warrants. Two real instances of this happened during the build of this protocol, kept here as the standing reference for what this rule actually defends against:
  - A page count ("9 pages") was stated for a PDF without re-running a check against the actual file at the moment of stating it — it was wrong (actual: 21 pages). The number wasn't invented maliciously; it was carried forward from an earlier, unverified glance and presented with full confidence.
  - An image file was marked "viewed" and described from filename and EXIF metadata alone, without the image content ever actually rendering. The description that followed was a plausible guess dressed as an observation.
  - **The shared mechanism in both:** confidence was reported as if it came from the current check, when it actually came from inference, memory, or a prior unverified claim. Every status (INGESTED, a page count, a quoted detail, "this matches X") must trace to a tool call run in that same turn, not to something assumed true because it was said earlier or because it seems likely.
  - **Garbage in, garbage out, applied literally:** if the input to a downstream decision is an unverified claim about a source rather than the source itself, every decision built on it is contaminated, even if the claim happens to turn out correct. Correctness by luck is still a process failure and gets reported as one if discovered.

---

## The Protocol (Steps, In Order)

### Step 0 — Route the resource before doing anything else

Before Step 1 begins, decide where the new resource actually belongs.
This is not optional and not implicit — getting it wrong here means
everything downstream (verification, the brain it reconciles into) ends
up in the wrong place.

Ask one question: **is this resource about how to build or run this
system itself, or is it knowledge about a specific business domain?**

- **About the system itself** (a new methodology paper like ICM, a
  better agent-architecture pattern, anything that would change how
  WORKSPACE/ operates) → goes into WORKSPACE/SYSTEM_SOURCES/, and at
  Step 6 reconciles into WORKSPACE/SYSTEM_BRAIN/.
- **About a specific business domain** (market data, a trading
  methodology book, design references for a specific client work) →
  goes into DOMAINS/[domain-name]/RAW/, and at Step 6 reconciles into
  that same domain's DOMAINS/[domain-name]/BRAIN/. If the domain doesn't
  exist yet, it must be created first (copy DOMAINS/_TEMPLATE/, rename
  it) — a resource never sits in a domain folder that hasn't been
  properly instantiated.
- **Ambiguous** (could plausibly be either, or spans multiple domains)
  → do not guess. State the ambiguity and ask which domain it belongs
  to, or whether it's system-level, before proceeding to Step 1. This
  is a direct application of not assuming the topic — the same
  principle as OPERATING_CONTRACT.md's rule against assuming what a
  session is about.

Only once the destination is decided does Step 1 begin, and Step 1 onward
runs identically regardless of which destination was chosen — the
protocol itself doesn't change, only where its output lands.

### Step 1 — Identify file type and confirm it's readable at all
- Run a file-type check (file, pdftotext, view, whatever fits the format) before claiming anything about content.
- If the file is a scanned/image-based PDF, plain text extraction returning empty or near-empty output is itself a result — it means fall to Step 2b (visual read), not "skip and summarize anyway."
- If a file genuinely cannot be opened (wrong path, corrupted, permissions), stop and report that immediately. Do not proceed to write a synthesis from memory or assumption.

### Step 2 — Read the actual content
- **2a. Text-native sources** (markdown, extractable PDF, docx, plain text): extract and read the full text, not just the first page or a truncated preview.
- **2b. Image-based or visual sources** (scanned PDFs, screenshots, photos, diagrams): convert pages to images and view them — actually look at them — rather than relying on filename or metadata to guess content.
- **2c. Tool/format mismatch check** (distinct failure mode from 2a/2b): a file can be genuinely readable and still fail to render because the viewing tool can't identify its type — e.g. an image file with no file extension (a bare upload ID) gets dumped as raw bytes instead of rendered. This is not the same as the file being unreadable or scanned. Before marking a visual source FAILED, confirm the failure is actually the content (corrupted, empty, inaccessible) and not the tool guessing the wrong handler from the filename. Fix: copy the file with the correct extension restored (confirmed via a file command, not assumed) and retry the view. Only call it FAILED if it still doesn't render after this is tried.
- A source is not read until this step produces real content in context. Metadata (filename, file size, EXIF data, upload timestamp) is never a substitute for content, and is never sufficient grounds for a status of INGESTED on its own.

### Step 3 — Produce verification artifacts (the proof-of-read)
Before claiming ingestion, produce 3 to 5 specific, checkable extracts from the source:
- A short verbatim phrase or heading (under 15 words, copyright-safe) that appears in the actual document
- A specific number, name, date, or term that appears in the source
- A structural fact (e.g. "this PDF has 21 pages," "this document has 5 numbered sections," "this image shows a folder tree with 4 top-level folders")

These artifacts are shown to the user as part of the ingestion report — not hidden in reasoning, not summarized away. If the artifacts cannot be produced, the source has not actually been ingested, regardless of how confident the resulting summary sounds.

### Step 4 — Self-check before claiming status
Ask, explicitly, before writing "INGESTED" or stating any specific fact about a source (a count, a quote, a structural claim):
- Did I actually see this in the current turn, or am I recalling it from earlier in the conversation, from a filename, or from what seems likely?
- If asked to re-run the exact check right now, would I get the same number/fact, or am I about to find out I was wrong?
- Can I point to the specific tool output, in this turn, that this claim came from?
- If this were checked against the real file right now, would my extracts match?

If the answer to any of these is uncertain — including mild uncertainty, not just clear doubt — the status is PARTIAL or FAILED, not INGESTED, and any specific fact in question gets re-verified before being stated rather than stated with a hedge. Uncertainty does not round up to success, and a hedge ("I believe it's around 9 pages") is not a substitute for actually checking.

### Step 5 — Write the ingestion record
Every ingestion produces a record in this format:

## INGEST RECORD: [filename]
- **Status:** INGESTED / PARTIAL / FAILED
- **Method:** [text extraction / visual read / both]
- **Verification artifacts:**
  1. [specific extract]
  2. [specific extract]
  3. [specific extract]
- **What was actually gotten from this source:** [brief, honest, not padded]
- **What could NOT be verified or read:** [explicit gaps, even if small]
- **Date:** [date]

---

### Step 6 — Reconcile into the brain, don't just append

Writing the ingestion record (Step 5) confirms the source was actually
read. It does not mean the source's content is now usable — that
requires reconciling it against what's already in the relevant brain
(SYSTEM_BRAIN/ for sources about this system's own design, or a specific
domain's BRAIN/ for business knowledge).

Reconciliation means checking the new source against existing
entity/concept/synthesis pages and doing one of three things, explicitly:

- **Extends** an existing page — the new source adds detail, examples,
  or depth to something already documented. Update that page, note
  which source contributed the addition.
- **Conflicts** with an existing page — the new source says something
  that contradicts what's currently written. Do not silently overwrite.
  Flag the conflict explicitly, in the page itself and in the relevant
  log.md, with both claims and their sources named, so a human can
  resolve which is correct (or whether both are true under different
  conditions).
- **Is genuinely new** — no existing page covers this. Create a new
  page, and add cross-references to related existing pages if any exist.

This is not optional polish. A brain that only ever appends, never
reconciles, will silently accumulate contradictions and stop being
trustworthy as ground truth — exactly the failure this protocol exists
to prevent, just at the level of the brain instead of the level of a
single claim.

---

## Status Definitions (No Rounding Up)

| Status | Meaning |
|--------|---------|
| INGESTED | Full content read, verification artifacts produced, self-check passed |
| PARTIAL | Some content read (e.g. text extracted but images not viewed, or first N pages only) — gaps explicitly listed |
| FAILED | Could not read meaningfully — file broken, extraction empty and visual fallback not yet done, or wrong file |

PARTIAL and FAILED are normal, reportable outcomes, not failures of the protocol. The protocol works precisely when it produces an honest PARTIAL instead of a false INGESTED.

---

## What Triggers Re-Ingestion

A source already marked INGESTED gets re-run through this protocol if:
- It was marked INGESTED before this protocol existed (retroactive)
- The file changes (re-uploaded, edited)
- A downstream decision depends on a detail that isn't in the existing verification artifacts

---

## How This Connects to Claude Code

If Claude Code is the one doing the read (because the files live in the local environment):
- Claude Code runs Steps 1-2 locally and returns the verification artifacts from Step 3 — not just a summary — back to the main chat.
- The main chat treats Claude Code's extraction the same way it treats its own: no INGESTED status without the artifacts to check it against.
- This means "read the PDF and summarize it" is insufficient as an instruction. The ask has to be "read the PDF and return: page count, 3-5 verbatim short extracts, and a structural description."

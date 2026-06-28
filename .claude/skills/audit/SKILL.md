---
name: audit
description: System self-audit. Checks the system against its own
stated rules and design — not a single session's work, the whole
system over time. Identifies staleness, unapplied principles, missing
promotions, broken cross-references, and rules that exist but were
never followed. Trigger on "audit," "audit the system," "check if
we're doing what we said we'd do," or explicit invocation.
---

# Audit

This is a mechanical audit where possible, and an explicit flag where
it isn't. Do not silently pass anything that requires human judgment.

## 0. Read PATTERNS.md first
Before running any check, read WORKSPACE/PATTERNS.md. Apply the
countermeasure for each active pattern during this run — do not
re-derive them from scratch. Flag any new instance of a known pattern
immediately, before continuing.

## 1. Check every file against its own stated purpose
Compare each file's own stated rule to its actual content and git
history. Flag any file whose own stated rule isn't being followed
(this is what would have caught REASONING.md's staleness).

### 1a. Check each brain's overview.md source count against its real sources/ file count

For SYSTEM_BRAIN/ and any active domain's BRAIN/: count the actual
files in sources/ and compare against the number stated in that
brain's context/overview.md header. A mismatch is MECHANICAL — fix
the count in the same pass, not deferred. This is a known,
deterministic staleness pattern (see INGEST.md Step 6 sub-check,
EVOLUTION_LOG.md CC-107/CC-108): every source addition without a
count update produces the same staleness, every time.

### 1b. Check ARTIFACTS/ against README.md for meaningful divergence
Read ARTIFACTS/index.md's description of each artifact. Compare
against README.md's CURRENT structure (section count, skills listed,
hooks listed). If README.md has changed in a way that would make an
existing artifact visibly wrong or incomplete (a new skill not shown,
a renamed section), flag as JUDGMENT-REQUIRED: "ARTIFACTS/[name] may
be stale relative to README.md's current state — consider
regenerating." Do not auto-regenerate — this is expensive and a human
should decide it's worth doing, not a mechanical pass.

### 1c. Check concept-page depth against its own ingestion record's claims

For each concept page in SYSTEM_BRAIN/concepts/, compare its actual
content against the specific verification artifacts listed in its
corresponding ingestion record (SYSTEM_BRAIN/sources/[name].md). If
the ingestion record lists specific extracted facts (exact names,
numbers, structures) that do NOT appear with comparable specificity in
the concept page, flag as MECHANICAL: "concept page for [source] is
thinner than its own ingestion record claims — knowledge was verified
as read but not fully woven into reusable form." This check exists
because the system's core promise is that decisions get made FROM
expanded knowledge, not from a thin summary while richer verified
content sits unused in a record nobody re-reads — this is core to the
ever-learning DNA claim, not a cosmetic completeness check.

## 2. Check for promotion/threshold conditions that may have been crossed
Has enough material accumulated for a judgment-based promotion (e.g.
conversational.md to overview.md) to be warranted? Flag, don't act.

## 3. Check for principles applied inconsistently
Look specifically for a known principle applied once but not
self-applied elsewhere it clearly should be (CC-045, CC-065 pattern).

## 4. Check for broken or stale cross-references
Confirm every file path referenced across CLAUDE.md, AGENTS.md,
README.md, FRAMEWORK.md, and skill files actually exists.

### 4b. Check for real structure that's undocumented (the reverse direction)
List every top-level folder, major subfolder, AND loose file directly
inside WORKSPACE/'s root and DOMAINS/ (excluding _TEMPLATE/'s
intentional placeholders). Confirm each is mentioned in at least
README.md OR FRAMEWORK.md. Flag any real, populated item appearing in
neither as MECHANICAL — fixable directly with one line, the same way
SYSTEM_SOURCES/ was fixed. A populated standalone file can be just as
undocumented as a folder.

## 5. Check for rules that exist but were never actually exercised
Flag OPERATING_CONTRACT.md rules with no corresponding EVOLUTION_LOG.md
entry showing real application.

## 6. Produce a report, not a fix
Tag each finding MECHANICAL or JUDGMENT-REQUIRED. Don't silently fix.

## 6b. Distrust a clean pass that follows a fix to audit itself

If this audit run happens immediately after a previous check was just
corrected, do not accept a clean result on it at face value. Attempt
to actively falsify it on at least one different angle before
reporting clean.

This does not guarantee catching every blind spot — it targets the
specific pattern observed twice this session (CC-076, CC-077): a fix
to one narrow gap, reported clean immediately after, while a
different gap in the same category was still present. It cannot
invent entirely new categories of undocumented structure on its own —
that still depends on a human asking a question audit wasn't built to
ask. State this limitation explicitly in any report following a
self-correction.

## 7. Log the audit itself
Append to EVOLUTION_LOG.md what ran and what was found, or that
nothing was found, explicitly.

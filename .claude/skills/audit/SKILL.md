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
brain's synthesis/overview.md header. A mismatch is MECHANICAL — fix
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

Scope note: this check covers SYSTEM_BRAIN/concepts/ and any domain
BRAIN/concepts/ — pages built from formally ingested sources. It does
NOT currently cover FRAMEWORK.md's portable concept entries for
skills/hooks (a different category — documentation of a mechanism's
own behavior, not a synthesized source). This is a named, deliberate
gap, not an unnoticed blind spot — if a second skill's FRAMEWORK.md
entry is ever found thin relative to its real behavior, that's the
trigger to extend this check or add a new one (1d), per PATTERNS.md's
two-instance rule. One instance (ingest-validate, found and fixed in
CC-120/CC-121) does not yet warrant a new permanent check.

### 1c-supplement: PARTIAL status scan (every run)

Scan every ingestion record in any sources/ folder for `Status: PARTIAL`.
Surface each one as an open item requiring a completion pass — this makes
partial ingestions visible every session until closed, not just at the
moment they're created. Distinct from check 1d below: this only reads the
STATUS FIELD, it's fast and runs every time. A PARTIAL source is a known
hole in the brain's foundation and must not be silently treated as complete.

### 1d. Periodic full-source re-verification (the garbage-in check)

The PARTIAL-status scan above only catches sources that HONESTLY marked
themselves incomplete. It cannot catch a source that was marked INGESTED
with 'Nothing' in the verification-gaps field, but where the underlying
read was still incomplete in a way nothing flagged at the time — exactly
what could still happen even with INGEST.md's Step 5 GATE in place, since
the gate only enforces consistency between a record's own two fields, not
the record against the actual raw source.

Maintain a rotation: each audit run, pick the ONE source that has gone
longest without a full re-read (tracked via the 'Last full re-verification'
date field on each record). Re-read that source's raw file in full and
compare against its record and concept page. Flag as MECHANICAL if a gap
is found. Update the 'Last full re-verification' date regardless of
outcome. One source per run, not all of them — full re-reads are expensive;
the rotation guarantees eventual coverage without making every audit run
slow.

To identify which source is next: read the 'Last full re-verification' date
from each record in sources/ and pick the oldest (or 'not yet run'). If
two sources tie, pick alphabetically.

### 1e. Check for foundational claims resting only on secondary sources (SDO-021/022)

For any concept or synthesis page describing a Claude-Code-specific
mechanism (a hook, a skill format, a settings.json behavior, or similar
content that has an official Anthropic specification somewhere), check
whether EVERY source cited for that page is informal/third-party (a
blog post, a social media graphic, an unofficial guide) with none from
Anthropic's own official documentation.

Flag as JUDGMENT-REQUIRED, not MECHANICAL — "informal vs. official"
requires judgment about the source itself, not a pure count. State
which page, which sources back it, and what topic within it is most
likely to be thin as a result (a specific mechanical detail, not just
"could be incomplete").

This check exists because audit's 1c (concept page vs. its own
ingestion record) cannot catch this category: a record and its concept
page can agree with each other perfectly while both are simply thin
relative to ground truth, because the underlying source never went
deeper. Confirmed real instance: `claude-md-and-skills-pattern.md` was
built entirely from claude-os-guide.md and anatomy-screenshot.md (both
informal, same non-Anthropic author) and did not contain the
SKILL.md-per-folder requirement or the Agent Skills open-standard fact
until agent-skills-docs.md (an official source) was ingested to close
the gap (SDO-020/021/022).

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

### 4c. Check README.md dictionary entries against actual file content (key files)

For each of the five files whose content is most likely to drift from
their README.md entries — FRAMEWORK.md, RULES.md, INGEST.md,
PATTERNS.md, INDEPENDENT_REVIEW.md (added SDO-011, since it's now a
protocol file of the same weight as the other four) — read the file's
actual current content and compare against README.md's dictionary
entry for it. Flag any entry that:
- Describes a section or mechanism the file no longer contains
- Omits a section or mechanism the file now contains that is material
  enough to change what a reader learns from the entry

Tag MECHANICAL if the gap is clear and the correct update is
unambiguous. Tag JUDGMENT-REQUIRED if the gap requires interpretation
of what "material" means for that entry.

This check exists because updating a file without updating its README.md
entry produces a silently stale dictionary — caught only when a human
happens to notice (confirmed: CC-145 updated FRAMEWORK.md § 2 with
five-layer hierarchy, stage contracts, and "configure the factory" —
README.md's entry still described only "numbered folders, increments
of 10" until caught by post-session completeness check, CC-150).

### 4d. Check: duplicate ID numbers

Scan EVOLUTION_LOG.md AND every file under WORKSPACE/EVOLUTION_LOG_ARCHIVE/
(added SDO-013, once the log was rotated) for any ID number (SDO-XXX going
forward, or a historical CC-XXX entry) that appears as a header more than
once with genuinely different content — across BOTH the live file and any
archive, not just the live one, since a reused historical ID would
otherwise go undetected once rotated out of the file being scanned. Flag
any found as MECHANICAL — a real collision requiring one entry to be
renumbered.

This is the mechanical backstop for OPERATING_CONTRACT.md Rule 9's
grep-before-assigning check — the same rule alone only works if it's
remembered every single time; this check catches it if it isn't
(CC-153).

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

## 7. Check that STATUS.md's NON-NEGOTIABLE instruction is present and intact

Read the first 15 lines of WORKSPACE/STATUS.md. Confirm the
NON-NEGOTIABLE instruction requiring full Handoff Baton inclusion in
any status response is still there, verbatim, at the very top above
"Last manually confirmed accurate." If it is missing or truncated,
flag MECHANICAL — it was deliberately placed there after CC-127
confirmed a real failure mode (status query omitting the baton
entirely, requiring the user to ask for it separately). If a future
session's response to a status query again omits the Handoff Baton,
that is a confirmed second instance of this exact failure and must be
logged toward a PATTERNS.md entry — this is already flagged as a
repeat-failure-mode candidate after first occurrence.

## 8. Log the audit itself
Append to EVOLUTION_LOG.md what ran and what was found, or that
nothing was found, explicitly.

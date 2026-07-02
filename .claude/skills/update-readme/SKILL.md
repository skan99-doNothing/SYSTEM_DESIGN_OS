---
name: update-readme
description: Keeps README.md's dictionary-style entries current.
Trigger whenever a new domain is created under DOMAINS/, a new skill
is added under .claude/skills/, a new hook is added under
.claude/hooks/, or a new file is added to WORKSPACE/. Also trigger
whenever FRAMEWORK.md, RULES.md, INGEST.md, or PATTERNS.md receives
substantive new content (new section, new mechanism, corrected claim)
— not just structural additions. Also trigger on explicit request
("update the readme," "add this to the dictionary").
---

# Update README.md

README.md is a dictionary, not a narrative — every real, named thing
in this system gets its own entry, fully described, never assumed
already known to the reader. This skill keeps that true as the system
grows.

## When to run this

- A real domain is created under DOMAINS/ (not _TEMPLATE/) — add an
  entry under a "Domains" section describing what it is, when it was
  created, and what's in its RAW/ and BRAIN/.
- A new skill is added under .claude/skills/ — add a full entry in
  section 4's style: what triggers it, what it actually does step by
  step, not a one-line summary.
- A new hook is added under .claude/hooks/ — add a full entry in
  section 5's style: what event it fires on, what it blocks or
  verifies, any known limitation.
- A new file is added to WORKSPACE/ — add an entry in section 3.1's
  style: what it actually contains, pulled from the file's own
  content, not guessed at.
- Anything existing gets renamed, restructured, or removed — update
  or remove its entry in the same pass. A stale entry describing
  something that no longer exists is worse than no entry at all.
- FRAMEWORK.md, RULES.md, INGEST.md, or PATTERNS.md receives
  substantive new content (a new section, a new mechanism, a corrected
  claim) — README.md's dictionary entry for that file must be checked
  and updated in the same pass. These four files describe the system's
  core behavior; their README.md entries are the first place a new
  session or a new agent learns what each one covers. A stale entry
  here is as misleading as a stale ingestion record.

## How to do it

1. Read the new or changed thing's actual content — never write an
   entry from the name alone, per INGEST.md's own no-overclaim rule.
2. Find where it belongs in README.md's existing structure (which
   numbered section, alphabetical or logical position within it).
2a. Distinguish the architecture tree (section 3) from the full
   dictionary (sections 3.1, 4, 5). The tree gets a short
   parenthetical mention; full entries belong in the numbered
   sections. Never duplicate full prose into the tree.
3. Write the entry in the same density and style as its neighbors —
   this is a dictionary, every entry should be readable on its own
   without depending on surrounding narrative.
4. Verify the new entry doesn't duplicate or contradict an existing
   one — if it does, that's itself worth flagging, since it may
   indicate the same gap PATTERNS.md's P001/P002 already named.
5. Commit the change with a clear message naming what was added.
6. Append one line to EVOLUTION_LOG.md noting the dictionary update.

## What this does NOT do

This does not decide whether something is real or finished enough to
document yet — DOMAINS/_TEMPLATE/ itself never gets its own "Domains"
entry, because it's the template, not a domain. Only call this once
something genuinely exists and is in active use, the same standard
INGEST.md applies before calling a source ingested.

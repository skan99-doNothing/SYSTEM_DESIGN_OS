# Conversational Context — SYSTEM_BRAIN

Insights derived from live dialogue with the user — things that emerged
through conversation rather than from ingesting a document.

## When to update this file

Add an entry when a session surfaces a non-obvious constraint, a
corrected assumption, a clarification of intent, or a design decision
that isn't traceable to any specific source in sources/. If the insight
came from a file, it belongs in overview.md or a concepts/ page; if it
came from talking, it belongs here.

## Distinction from overview.md

`overview.md` synthesizes what the ingested documents say and how the
pillars connect. This file records what became clear through use —
things the documents don't say but experience revealed.

## Entries

### 2026-06-27 — CC-045 pattern: known principle not self-applied (second instance)
When conversational.md was created (CC-063), no promotion path back to
overview.md was built in — even though LLM Wiki's source material
explicitly describes filing outputs back as compounding value, and that
principle was correctly applied elsewhere in the same session. The gap
was caught by the user, not by Claude noticing on its own (CC-064/CC-065).

**Constraint this reveals:** Claude applies known principles to
structures it's explicitly working on, but does not reliably audit new
structures it creates for compliance with the same principles. The
failure mode is not ignorance — it's incomplete self-application at
creation time. Two data points now (CC-045 was the first). Watch for
this: when creating any new file or structure, explicitly check whether
known system principles (compounding value, lint passes, promotion paths)
apply to the new thing.

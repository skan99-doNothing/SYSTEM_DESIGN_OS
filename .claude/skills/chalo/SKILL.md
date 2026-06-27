---
name: chalo
description: End-of-session closing ritual. Reviews everything that
happened this session, updates STATUS.md, confirms EVOLUTION_LOG.md is
current, and commits everything in one final pass. Trigger on "chalo,"
"let's close for today," "wrapping up," "end of session," or explicit
invocation.
---

# Chalo (Close Day)

## 1. Review what actually happened this session.
## 2. Confirm EVOLUTION_LOG.md is current; log retroactively if needed.
## 3. Rewrite STATUS.md's "What's built and verified" section.
## 4. Rewrite STATUS.md's "Open items" section; update the date.
## 5. Check for unverified claims before committing — including
   checking whether prompts given earlier actually got confirmed run.
## 5a. If any dialogue-derived insight emerged this session (a non-obvious
   constraint, corrected assumption, or design decision not traceable to
   an ingested source), append it to the relevant brain's
   context/conversational.md (WORKSPACE/SYSTEM_BRAIN/context/conversational.md
   for system-level insights; DOMAINS/<domain>/BRAIN/context/conversational.md
   for domain-specific ones).
## 5b. Check if conversational.md has grown enough to warrant
   promoting into overview.md
   Do NOT auto-promote every session — that risks thin synthesis from too
   little material. Instead: check how many new entries have accumulated
   since overview.md was last meaningfully updated. If a real pattern is
   now visible that wasn't before, flag it explicitly: "conversational.md
   has grown — consider promoting a synthesis into overview.md," with
   specific reasoning, not just a count.
## 6. Commit: git add -A && git commit -m "Close day [DATE]: ..."
## 7. Report back: what got done, what's open, confirm both committed.

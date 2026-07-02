---
name: chalo
description: End-of-session closing ritual. Reviews everything that
happened this session, updates STATUS.md, confirms EVOLUTION_LOG.md is
current, and commits everything in one final pass. Trigger on "chalo,"
"let's close for today," "wrapping up," "end of session," or explicit
invocation.
---

# Chalo (Close Day)

## 0. Run audit first
Invoke audit before anything else. Fix MECHANICAL findings in this
same run where reasonable. Report JUDGMENT-REQUIRED findings to the
user rather than resolving them.

## 1. Review what actually happened this session.
## 2. Confirm EVOLUTION_LOG.md is current; log retroactively if needed.
## 3. Rewrite STATUS.md's "What's built and verified" section.
## 4. Rewrite STATUS.md's "Open items" section; update the date.
## 5. Check for unverified claims before committing — including
   checking whether prompts given earlier actually got confirmed run.
## 5a. If any dialogue-derived insight emerged this session (a non-obvious
   constraint, corrected assumption, or design decision not traceable to
   an ingested source), append it to the relevant brain's
   dialogue/conversational.md (WORKSPACE/SYSTEM_BRAIN/dialogue/conversational.md
   for system-level insights; DOMAINS/<domain>/BRAIN/dialogue/conversational.md
   for domain-specific ones).
## 5b. Check if conversational.md has grown enough to warrant
   promoting into overview.md
   Do NOT auto-promote every session — that risks thin synthesis from too
   little material. Instead: check how many new entries have accumulated
   since overview.md was last meaningfully updated. If a real pattern is
   now visible that wasn't before, flag it explicitly: "conversational.md
   has grown — consider promoting a synthesis into overview.md," with
   specific reasoning, not just a count.
## 5c. Check whether README.md needs a dictionary update
Invoke update-readme before committing if EITHER of the following is true
this session:
- A new domain, skill, hook, or WORKSPACE file was created — or an
  existing one was removed/renamed (the original structural trigger).
- FRAMEWORK.md, RULES.md, INGEST.md, or PATTERNS.md received substantive
  new content (a new section, a new mechanism, a corrected claim) — per
  OPERATING_CONTRACT.md Rule 8's content-update sub-rule (CC-150). This
  is not structural change, but README.md's dictionary entry for that
  file still goes stale exactly the same way.
If neither condition is true this session, skip silently.
## 5d. Regenerate the handoff baton
Before the final commit, rewrite STATUS.md's "Handoff baton" section
in full, replacing the previous one entirely — never append. Pull the
"current real state" lines directly from this same chalo run's
updated Open Items section, not from memory of an earlier session.
Leave the "What I want to do this session" line as a blank placeholder
— chalo does not guess the next task. The date in the baton header
must match today's real date, not a prior session's.

Always include the knowledge-routing line in every regenerated baton
— it is a permanent, required line, not optional content:

"If asked what this system knows about something, and I can't access
the files directly (this is a claude.ai chat, not Claude Code): write
a short Claude Code prompt that reads the relevant
SYSTEM_BRAIN/index.md (or domain BRAIN/index.md) and the specific
concept/source page, then ask the user to run it and paste back the
real output - the same pattern used throughout this system's own
construction (OPERATING_CONTRACT.md Rule 6). Do not guess or answer
from memory of what the brain probably contains. Once given the real
file content, cite it specifically and say plainly if something isn't
covered."
## 6. Commit and push
Run: git add -A && git commit -m "Close day [DATE]: ..."
Then immediately: git push origin master && git push --tags

Push is not optional. The risk being defended against is total loss
on machine failure or disk corruption — a local-only commit provides
zero protection against that. This matches standard development
practice (commit often, push always), not a cautious default.

If the push fails (no remote configured, network issue, auth problem),
report it explicitly as a FAILED step — do NOT silently continue as if
the backup succeeded. A commit that didn't push is not yet safe.
## 7. Report back: what got done, what's open, confirm both committed and pushed to remote.

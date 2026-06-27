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
## 6. Commit: git add -A && git commit -m "Close day [DATE]: ..."
## 7. Report back: what got done, what's open, confirm both committed.

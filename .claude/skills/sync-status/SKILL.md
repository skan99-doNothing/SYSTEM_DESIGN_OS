---
name: sync-status
description: Targeted, low-cost refresh of STATUS.md's baton and open-items
sections when the only real need is keeping the baton current — not a full
session close. Skips audit and promotion/README broad checks unless a
structural trigger applies. Trigger on "sync status," "update status,"
"refresh status," "just update STATUS.md," or explicit invocation.
---

# Sync Status

A cheaper alternative to chalo when the only real need is keeping
STATUS.md's baton accurate, not a full close-out. Chalo bundles a full
system audit (chalo step 0) with STATUS.md's refresh (chalo steps 1-5d)
into one ritual — but the STATUS.md refresh itself only depends on "what
actually happened this session," not on audit's separate system-wide
health checks (source counts, cross-references, promotion thresholds).
This skill does the first part only, per OPERATING_CONTRACT.md's
token/context-cost rule (Rule 10, SDO-019): match the tool's cost to the
actual size of the question being asked.

## When to use this instead of chalo

Use this when STATUS.md's baton is known-stale relative to recent
EVOLUTION_LOG.md entries, but there's no other reason to believe the
*rest* of the system (source counts, cross-references, promotion
thresholds, README dictionary entries generally) has drifted. If there's
a real reason to suspect broader staleness, or this is genuinely an
end-of-session close, run chalo instead — and say so explicitly rather
than defaulting to the cheap path out of habit either.

## Steps, in order

1. Review what actually happened since STATUS.md's baton was last
   written — read EVOLUTION_LOG.md's entries newer than the baton's own
   stated confirmed-accurate date.
2. Confirm EVOLUTION_LOG.md is current for that work (a check, not a
   rewrite — it should already be current per Rules 8/9).
3. Rewrite STATUS.md's "What's built and verified" section — editing
   stale entries in place, not just appending.
4. Rewrite STATUS.md's "Open items" section; update the date, and clear
   any staleness note that is now genuinely resolved.
5. Regenerate the Handoff Baton in full — never append, replace it
   entirely, same rule as chalo step 5d. Pull directly from this run's
   updated Open Items, not from memory of an earlier session. Always
   include the mandatory knowledge-routing paragraph verbatim.
6. Narrow structural-trigger check only (a scoped version of chalo's
   5c): if a new skill, hook, or WORKSPACE file was created, removed, or
   renamed since the baton's last accurate date, invoke update-readme.
   If not, skip silently — do not run audit's broader 4c-style README
   dictionary check across every key file; that belongs to a real audit.
7. Commit and push: `git add` the specific files touched (STATUS.md and
   whatever update-readme touched, if invoked), commit with a message
   that states plainly this was a targeted sync, not a chalo close, then
   push. Report explicitly if the push fails.
8. Report back: what was refreshed, confirm committed and pushed, and
   state plainly this was NOT a full audit/chalo close. If the user
   actually wanted that, say so and offer to run it.

## What this is NOT

Not chalo. No audit (system-wide health checks skipped entirely), no
promotion-threshold check (conversational.md → overview.md), no
dialogue-insight capture pass, no full README dictionary sweep across
every key file. If any of those are actually needed, run chalo or audit
directly rather than stretching this skill to cover them.

## Why this exists

SDO-019: chalo bundles a full system audit with STATUS.md's refresh by
design, not because STATUS.md accuracy actually requires audit's result
— chalo's own steps 1-5d only need to know what happened this session.
Built directly in response to the user pushing on token/context cost:
don't default to the expensive ritual (or an expensive resume-time
cross-check) when a narrower, already-scoped action satisfies the real
need. See OPERATING_CONTRACT.md Rule 10 for the general principle this
skill is one applied instance of.

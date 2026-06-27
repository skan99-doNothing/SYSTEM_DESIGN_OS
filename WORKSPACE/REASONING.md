# REASONING.md — Why Behind Locked Decisions

Grows as decisions move to LOCKED status. Each entry traces a locked decision back to its reasoning — constraints considered, alternatives rejected, and the logic that made this the right call.

---

## RT001 — Why D001 (Pause OPERATING_CONTRACT.md development) was the right call

**Linked decision:** D001 | **Date locked:** 2026-06-26

### What was rejected and why

The rejected alternative was continued synthetic testing and iterative
refinement of OPERATING_CONTRACT.md against invented scenarios. This
was the path the session had been on for several hours: write a rule,
test it against a fictional task, find a gap, add a clarification,
repeat.

This was rejected because:
1. **Signal was already sufficient.** Two real test runs (fictional
   job-board and fictional course scenarios) produced measurable,
   predicted improvement after a targeted fix — leading responses with
   a stance before reasoning fixed Rules 2 and 4 across both runs.
   That's enough to confirm the contract can shape output. It is not
   enough to confirm it's complete, and no further synthetic testing
   would change that.
2. **Diminishing returns.** Each additional synthetic scenario is
   invented by the same parties following the contract, which means it
   tests compliance under cooperative conditions. Real failures look
   different — they happen under pressure to appear helpful, not under
   deliberate self-examination.
3. **Over-engineering was already caught once.** The session had
   earlier caught itself building SYSTEM.md as a monolithic dump before
   splitting it. Adding more contract infrastructure without real use
   was the same pattern repeating.

### What actually justified stopping

The trigger was direct: the user asked "are we doing well?" and the
honest answer was that several hours had produced zero progress on the
original stated goal — choosing a first real business domain. The
contract exists to protect the work of building real domains, not to
be the work itself.

### Re-open condition and why it's defined this way

The re-open trigger is: the first time the contract is found to fail
on a real decision, not a constructed test.

This is deliberately narrow. "Feels incomplete" or "it's been a while"
are not triggers — both invite the same synthetic-refinement loop this
decision stopped. Only an actual observed failure on real work provides
the signal that a specific rule needs revision, and at that point the
revision should be targeted, not a general review pass.

### Connection to the session's broader tension

This decision sits at the center of a tension that ran through the
entire first session: infrastructure work is tractable (you can always
find one more thing to improve) while real domain work requires
committing to a real choice with incomplete information. The contract,
the hooks, the brain structure, the ingest protocol — each was
genuinely useful and each could have expanded indefinitely.

D001's lock is the explicit acknowledgment that "good enough to test
on real work" is the correct stopping condition for infrastructure,
not "complete." The contract gets completed by the first real failure,
not by another synthetic pass.

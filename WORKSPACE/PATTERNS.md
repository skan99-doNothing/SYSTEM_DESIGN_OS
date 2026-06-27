# PATTERNS.md — Recurring Failure Patterns

Grows from confirmed, multi-instance failures. A pattern is not
documented here on its first occurrence — that's an incident. It's
documented when a second instance confirms the shape, so what gets
recorded is a recognizable type, not just a memory of one event.

Audit reads this file first, before its own checks, to apply
accumulated pattern recognition rather than starting from scratch.

---

## P001 — Known principle not self-applied to new structure

**Instances:**
- CC-045: the LLM Wiki compounding principle was applied to existing
  brains but not to a new mechanism built in the same session
- CC-065: the same principle not applied to conversational.md when
  it was created — no promotion path wired in
- CC-071: audit skill created under .claude/ without its own
  FRAMEWORK.md concept, despite OPERATING_CONTRACT.md Rule 6
  explicitly requiring it

**Pattern shape:** A principle is known and correctly applied to
existing structures. A new structure is created in the same session.
The principle is not applied to the new structure. The gap is caught
by the user, not by Claude.

**Countermeasure:** Before declaring any new file or structure done,
ask explicitly: does any known system principle apply to this new
thing? Check at minimum: (1) does it need a mechanism-agnostic concept
in FRAMEWORK.md? (2) does it have a promotion/feedback path if it
accumulates content? (3) is it documented in README.md or FRAMEWORK.md?

**Current status:** Three confirmed instances. Pattern is active.

---

## P002 — Fix declared clean immediately without independent verification

**Instances:**
- CC-076: audit check 4b added to catch undocumented structure; audit
  immediately reported clean; SYSTEM.md was undocumented and missed
- CC-077: 4b wording corrected to include loose files; re-run still
  missed DECISIONS.md, REASONING.md, RULES.md until user asked for
  ground-truth verification

**Pattern shape:** A check is just corrected or added. The corrected
check runs and reports clean. A different gap in the same category
is still present but not caught. The clean pass is accepted. The user
asks for independent verification and the gap surfaces.

**Countermeasure:** Audit's 6b — after any self-correction, actively
attempt to falsify the clean result from at least one different angle
before accepting it. State explicitly in the report whether 6b was
applied and what angle was used.

**Current status:** Two confirmed instances. Pattern is active.

---

## P003 — A fully correct prompt drafted in chat that never reaches Claude Code

**Instances:**
- CC-087 (first occurrence): the update-readme skill spec was complete
  and correct, written in chat, but never transmitted into a Claude Code
  session — confirmed via CC-088's read-only check finding nothing on
  disk
- CC-087 (second occurrence): the same gap recurred at a chalo session
  close before being caught and finally transmitted successfully

**Pattern shape:** The content was never wrong — it simply never
crossed from one side of the human-as-transport-layer boundary to the
other. Chat and Claude Code are two separate systems with a human as
the only bridge; a well-formed prompt in chat implies nothing about
execution in Claude Code.

**Countermeasure:** Before treating any CC-XXX prompt as "done" or
building on top of it, verify it was actually transmitted AND executed
— confirm the artifact exists on disk and a real commit corresponds to
it, not just that a well-formed prompt was produced at some point. The
check CC-088 used is the standing template: read the expected artifact
path and confirm a commit exists for it.

**Current status:** Two confirmed instances. Pattern is active.

---

## Open question: what this can and can't catch

Both patterns above were identified by the user, not by the system
running autonomously. PATTERNS.md makes a second instance of a known
pattern actionable — audit can check against it, countermeasures can
be applied, and the pattern can be explicitly looked for.

It does not predict a first, unforeseen instance of a new pattern.
That still requires a human noticing something the system wasn't built
to ask. The honest scope of this file: it compresses confirmed
failures into checkable rules. It does not substitute for a human
looking at the output with genuine skepticism.

---

## Last updated

2026-06-27 — initial build with P001 (3 instances) and P002
(2 instances) (CC-079); P003 added (2 instances) (CC-089)

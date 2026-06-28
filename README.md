# SYSTEM_DESIGN_OS — Full System Reference

This is the comprehensive reference for this system, not a short
pointer. CLAUDE.md and AGENTS.md are the short pointers that lead
here. Read WORKSPACE/STATUS.md for the current state right now;
everything below is the durable map of how the system works and why
it's built this way.

---

## 1. What this is, in plain terms

A governance and memory scaffold for building autonomous, agent-driven
businesses. It accumulates knowledge in domain-specific "brains,"
structures workflows as repeatable folder-based stages, and writes
everything in plain markdown so it transfers to any agent, any person,
any future version of yourself who's forgotten the details. As of this
writing, no real business domain has been built inside it — every
mechanism here has only been exercised on its own construction.

## 2. The DNA — six qualities, each tied to a real mechanism

- **Agent-agnostic** — governed by plain markdown any LLM can read
  (CLAUDE.md + AGENTS.md as identical, synced entry points), with
  tool-specific implementations (hooks, skills) kept explicitly
  separate from their portable concepts in FRAMEWORK.md, so the
  system survives a change of tooling. Both files auto-load four
  non-negotiable behavioral rules, a knowledge-routing instruction
  (check WORKSPACE/SYSTEM_BRAIN/index.md and any active domain's
  BRAIN/index.md before answering a knowledge question from general
  knowledge or inference — cite the source, and say plainly if the
  brain doesn't cover it rather than filling the gap), and a session-
  end instruction. The knowledge-routing instruction was added in
  CC-129 after CC-128 confirmed a fresh session had no automatic path
  to SYSTEM_BRAIN/ for knowledge questions; the brain was never the
  problem, the routing pointer simply hadn't been written.
- **Transferable** — no database, no proprietary format. Copyable
  wholesale to another person, agent, or future session with no
  translation step.
- **Scalable** — knowledge accumulates per-domain, never shared
  across unrelated work, with a concrete, evidence-based threshold
  (RULES.md) for when plain index-file navigation needs to become
  something more sophisticated — not solved before that's actually
  true.
- **Self-auditing** — the audit skill checks the system against its
  own stated rules, automatically, every session via chalo, rather
  than depending on anyone remembering to check.
- **Ever-learning** — PATTERNS.md converts a confirmed second instance
  of a failure into a standing rule that gets checked before the
  failure has a chance to recur a third time.
- **Knowledge-deepening** — ingesting a source isn't complete when a
  verified ingestion record exists; the brain's concept pages must
  actually contain the specific, reasoning-ready detail the record
  verified, not a thin summary while richer content sits unused.
  Audit's check 1c compares every concept page's depth against its
  own ingestion record's claims, every session — knowledge is
  required to expand, not just get filed.

**The honest limit, stated once and meant to be remembered:** this
system gets better at not repeating a KNOWN mistake. It does not
recognize a brand-new pattern from a single occurrence — that still
requires a human noticing, the same way every pattern currently in
PATTERNS.md was found by the user, not by the system itself.

## 3. Architecture — how the pieces fit together

```
SYSTEM_DESIGN_OS/
├── README.md              (this file — the full reference)
├── CLAUDE.md / AGENTS.md  (short, auto-loading pointers into this file)
├── .gitignore
│
├── .claude/                (Claude-Code-specific machinery — see section 5)
│   ├── settings.json / settings.local.json
│   ├── hooks/               (mechanical guardrails — see section 5)
│   └── skills/              (chalo, audit, update-readme, ingest-validate — see section 4)
│
├── DOMAINS/
│   └── _TEMPLATE/           (copy + rename this to start a real domain)
│       ├── RAW/             (immutable sources for that domain only)
│       └── BRAIN/           (same shape as SYSTEM_BRAIN/, see section 3.2)
│
└── WORKSPACE/               (everything governing the system itself — see section 3.1)
    └── ARTIFACTS/           (generated human-facing outputs — see section 3.1)
```

### 3.1 — Every file in WORKSPACE/, what it actually does

- **OPERATING_CONTRACT.md** — the behavioral contract. Opens with a
  foundational division-of-labor statement (the user owns vision and
  real-world testing; Claude owns reasoning in conversation; Claude
  Code owns documentation and execution), then 9 rules: no claim
  without a check; one issue at a time with the order stated even when
  obvious; surface problems the moment they're seen; push back rather
  than agree by default; the sandbox is not the real filesystem, and
  unknowns get queried via a Claude Code prompt rather than assumed;
  don't assume the topic of a session; log decisions as they happen
  without being asked, including a precise definition of what counts
  as decision-worthy; every Claude Code prompt gets an ID so a report-
  back can be matched to its request, and Claude Code logs its own
  actions; the CLAUDE.md hierarchy should be scoped narrowly and
  verified rather than assumed safe; and anything built under .claude/
  needs its portable concept documented in FRAMEWORK.md in the same
  pass, not as an afterthought.

- **INGEST.md** — the verification protocol for any new source, of
  any kind. Eight steps in order: (0) route the resource — is it about
  the system itself or about a specific business domain, and if
  ambiguous, ask rather than guess; Step 0 also enforces a pre-save
  safeguard: evaluate from conversational content first, save only
  once the decision to ingest is confirmed — a rejected source is
  never written to SYSTEM_SOURCES/ or RAW/, and if it was saved
  before rejection, delete it as part of closing out the evaluation; (1) confirm the file is actually
  readable; (2) read the real content, with explicit handling for
  text, scanned/visual content, and tool/format mismatches; (3)
  produce 3-5 specific, checkable extracts as proof of having actually
  read it; (4) self-check before claiming anything, including whether
  a claim is being carried forward from memory rather than verified in
  the current turn; (5) write a formal ingestion record (INGESTED /
  PARTIAL / FAILED — no rounding up), enforced by a binding gate:
  status may only be INGESTED if the 'What could NOT be verified' field
  is empty/'Nothing' — if it names any unread section or unverified
  claim, status must be PARTIAL, specific gaps named, plan for closing
  them stated; this is a mechanical check on the record's own two
  fields, not a judgment call (CC-143); each record also tracks a
  'Last full re-verification' date for audit's rotation check (1d); (6) reconcile the new knowledge
  into the relevant brain, explicitly marked as extending, conflicting
  with, or being genuinely new relative to what's already there; (7)
  if the source describes a pattern or mechanism, ask explicitly
  whether it suggests a concrete change to the system itself — and if
  so, produce a SUGGESTION RECORD in the relevant concept page (status
  always starts PROPOSED, never auto-applied), so the trail from
  source to suggestion to any eventual change stays traceable and a
  human makes the final call. The same file also states the core rule
  behind all of this: no confidence claim may exceed the evidence that
  currently exists for it, illustrated with the two real failures that
  produced this rule (a wrong page count stated from memory, an image
  described from its filename without ever actually being viewed).

- **FRAMEWORK.md** — why the system is built this way, not just what
  it does. Opens with the DNA statement (section 2 above), then the
  three foundational pillars: knowledge accumulation via an LLM-Wiki-
  style pattern (a source is read once and woven into a standing,
  cross-referenced brain rather than re-derived every query); workflow
  orchestration via ICM-style numbered folders (stages in increments
  of 10 so one can be inserted later without renumbering everything);
  and plain markdown as the only artifact format, specifically because
  it's the one format that's simultaneously machine-readable,
  human-readable, version-controllable, and requires no translation
  step to hand to someone else. It also holds seven mechanism-agnostic
  specifications — for the ingest-guard write-protection hook, for
  the session-identity verification hook (confirming the loaded entry-
  point file is the correct one for this project, using the tool's
  own authoritative project-root signal rather than a hand-written
  guess — added in CC-130's chalo audit run after remaining as an
  open MECHANICAL item since the hook was built), for the chalo
  session-close skill, for the audit self-check, for the update-readme
  dictionary-maintenance process, for the ingest-validate pre-ingestion
  orientation — covering both the default lightweight mode (on-demand
  report of what the system already contains, before deciding whether a
  new source is worth a full ingest pass) and the deep mode (scope-
  classified baseline matching, comparative analysis with ADOPT/ADAPT/
  DEFER/REJECT verdicts per novel mechanism, reject safeguard preventing
  a rejected source from ever being persisted, and SUGGESTION RECORD
  output for ADOPT/ADAPT items) — and for the transmission-verification
  practice (confirming a prompt was executed, not just written) — written so a different agent's
  tooling could rebuild the same behavior without copying Claude Code's
  specific files.

- **RULES.md** — expansion patterns, deliberately written only after
  being proven, not designed speculatively in advance. Currently
  holds: the exact procedure for turning DOMAINS/_TEMPLATE/ into a
  real, working domain; the increments-of-10 numbering convention for
  workflow stage folders, plus the ICM-specified stage-contract
  requirement — each stage folder must contain a CONTEXT.md with three
  explicit sections (Inputs / Process / Outputs) so the stage is
  self-documenting and hand-off-ready to any agent or person opening
  it cold (Section 3.3, confirmed CC-140/144; template lives at
  DOMAINS/_TEMPLATE/STAGE_TEMPLATE/CONTEXT.md); a concrete, sourced threshold (roughly
  50-100 files in any one brain, or retrieval genuinely feeling slow)
  for when plain index-file navigation should be reconsidered; a
  domain graduation rule — when a domain is ready to be sold or
  handed off independently, it gets copied out of DOMAINS/ into its
  own brand-new git repository (a deliberate one-way split, not a
  synced submodule), so ownership isolation is preserved without
  exposing other domains' history; and a conflict preservation
  mechanism — documented but not yet built, with an explicit trigger
  condition (the first real conflict surfaced by Step 6 reconciliation
  or audit), specifying that both sides of a contradiction must be
  preserved intact with their source provenance and tagged CONFLICT
  for human resolution rather than silently overwritten. Both of the
  last two are not built yet; documented so the decisions exist before
  they're needed under pressure.

- **PATTERNS.md** — the system's record of its own recurring mistakes.
  A failure only earns an entry here after it's been confirmed
  happening at least twice. As of this writing it holds three active
  patterns plus one candidate: known principles not being self-applied
  to new work (P001, three instances); a fix declared clean immediately
  after landing, without independent verification (P002, two instances);
  a fully correct prompt written in chat that never crossed into the
  tool that executes it (P003, two instances); and P004 (CANDIDATE —
  two instances, no mechanism yet) — a factory-level change that
  required retroactive re-check of what was built before it, caught
  only because a human explicitly asked, not because any mechanism
  noticed. P004 is watched, not yet a standing rule — per the same
  two-instance discipline, the right trigger design isn't clear from
  two data points. Each confirmed entry states its standing
  countermeasure. audit reads this file first, every run, before its
  own checks — this is the literal mechanism that makes the system's
  learning durable rather than something that has to be re-explained
  in conversation every time.

- **DECISIONS.md** — a small, deliberately short list of choices that
  reached LOCKED status, each with what was decided, why, what
  triggered the question, and what would reopen it. Most day-to-day
  changes don't qualify and live in EVOLUTION_LOG.md instead; this
  file is reserved for the few decisions formally promoted beyond a
  routine log entry.

- **REASONING.md** — the deeper thought process behind a LOCKED
  decision, once one exists — what alternative was seriously
  considered and rejected, what specifically justified the final call,
  and what would actually have to be true for the decision to be
  revisited. Distinct from DECISIONS.md's short "Why" field; this is
  the long version.

- **EVOLUTION_LOG.md** — the complete chronological history. Every
  real change, logged in the same pass it happened, not reconstructed
  afterward — including the system's own mistakes and their
  corrections, left visible rather than edited away, because rewriting
  history to look cleaner than it was is itself a form of the
  overclaiming this whole system exists to prevent.

- **STATUS.md** — a current-state snapshot, explicitly distinct from
  the log above: what's actually built and verified right now, what's
  genuinely still open, and what to check first next time. Refreshed
  by chalo at the close of a session that did real work, not after
  every individual change — it's a snapshot, not a second log.

- **SYSTEM_BRAIN/** — what the system knows about its own design,
  synthesized from the documents in SYSTEM_SOURCES/. Internally split
  into sources/ (one verified ingestion record per original document),
  concepts/ (the reusable ideas extracted from them), synthesis/
  (overview.md — the document-derived connective summary, named and
  structured per the LLM Wiki source's own vocabulary), and dialogue/
  (conversational.md — insight that came from live use rather than
  from any document, with a judgment-based, not automatic, promotion
  path into overview.md once a real pattern is visible).

- **SYSTEM_SOURCES/** — raw source documents this system was
  synthesized from, kept immutable and separate from SYSTEM_BRAIN/
  per INGEST.md's own rule that sources are never edited, only read.
  Currently five: the original four system-design methodology sources
  (LLM Wiki pattern, ICM paper, claude-os-guide, anatomy reference)
  plus the Autonomous AI Growth Engine architecture guide ingested in
  CC-098 (21-agent system, context DB schema, Verifier, Eval Engine,
  Growth OS director pattern).

- **ARTIFACTS/** — generated, human-facing outputs rendered from
  existing knowledge for human consumption — visual diagrams, exported
  summaries. Distinct from SYSTEM_BRAIN/ (synthesized knowledge) and
  SYSTEM_SOURCES/ (raw documents knowledge was built from): nothing
  here should be ingested back into SYSTEM_BRAIN/ as a new source,
  because it already represents what the brain already knows in a
  different format. Staleness is not tied to every README.md edit or
  a fixed calendar — audit compares each artifact's description in
  ARTIFACTS/index.md against README.md's current structure and flags
  meaningful divergence (a new skill not shown, a renamed section) as
  JUDGMENT-REQUIRED. Regenerating is a human decision, not a
  mechanical trigger.

### 3.2 — DOMAINS/_TEMPLATE/

The reusable pattern for a real business domain, mirroring
SYSTEM_BRAIN/'s exact shape (RAW/, then BRAIN/ with the same
sources/concepts/entities/synthesis/dialogue split). To start a real
domain: copy this folder, rename it, drop real sources into its RAW/,
and run them through INGEST.md. Also contains STAGE_TEMPLATE/ — a
copyable CONTEXT.md template (Inputs / Process / Outputs) for any
workflow stage folder built under a real domain; per RULES.md, every
stage folder must have a filled-in CONTEXT.md, not just a prompt file.
No domain currently exists — this is the one thing the entire system
has been waiting on since its first session.

## 4. The four skills — what they actually do, in full

### chalo

Triggered by saying "chalo," or by typing /chalo, when ending a
session. Runs audit first, unconditionally, as its own step 0 — a
self-check nobody is forced to run has the same failure mode it
exists to catch. Then: reviews what actually happened this session
against EVOLUTION_LOG.md; confirms the log is current, backfilling
honestly if something was missed; checks whether this session produced
any insight through dialogue rather than from a document, and if so
writes it to the relevant brain's dialogue/conversational.md; checks
whether that file has grown enough that a real pattern is now visible
and worth promoting into overview.md — flagging this as a judgment
call rather than auto-promoting; rewrites STATUS.md's two sections
(what's verified, what's open) to match reality rather than just
appending; regenerates STATUS.md's handoff baton section in full
(replacing the prior one entirely) so the next session's opener
reflects the current real state, not a prior session's; scans the
session for anything stated as fact that was never actually checked
with a real command; commits everything in one final pass and immediately pushes to
the remote (git push origin master && git push --tags) — push is
not optional, since a local-only commit provides zero protection
against machine failure or disk loss, and if the push fails it is
reported explicitly rather than silently treated as if the backup
succeeded; and produces a short, honest report back covering what
got done, what's still open, and explicit confirmation that
STATUS.md and EVOLUTION_LOG.md are both committed and pushed.

### audit

A system-wide self-check, distinct from chalo's single-session review
— this checks the system's entire current state against its own
stated rules. Reads PATTERNS.md first, every time, and applies any
matching standing countermeasure rather than rediscovering a known
failure from scratch. Then runs five checks: (1) does every file in
WORKSPACE/ and any active domain's BRAIN/ actually do what its own
stated purpose says, using git history as evidence rather than
assumption — with three sub-checks: (1a) does each brain's
overview.md source count match the real file count; (1b) would any
ARTIFACTS/ description be visibly wrong given README.md's current
structure; (1c) does each concept page in SYSTEM_BRAIN/concepts/
actually contain the specific facts its own ingestion record's
verification artifacts name, or is the concept page thinner than
what was verified as read — because the system's promise is that
decisions get made from expanded knowledge, not a thin summary while
richer verified content sits unused (scope: covers ingested-source
concept pages only; FRAMEWORK.md's portable skill entries are a
named, deliberate gap — one instance found in CC-121 does not yet
meet PATTERNS.md's two-instance threshold for a new permanent check);
(1c-supplement) scan every sources/ folder for Status: PARTIAL and
surface each as an open item until closed — fast, runs every audit
run, catches honestly-flagged gaps; (1d) pick the one source that has
gone longest without a full re-read (tracked via 'Last full
re-verification' date on each record), re-read it in full, compare
against its record and concept page, flag MECHANICAL if a gap is
found, update the date regardless of outcome — one source per run,
not all, ensuring eventual coverage without making every audit slow;
this rotation catches a source that was marked INGESTED with 'Nothing'
in the gap field but where the underlying read was still quietly
incomplete in a way nothing flagged, the failure mode the Step 5 GATE
alone cannot prevent (CC-143); (2) has any judgment-based
promotion condition (like conversational.md's threshold) quietly been
crossed without anyone acting on it; (3) has a known, already-written
principle been applied in one place but skipped somewhere it clearly
also applies — searched for specifically, not assumed absent; (4) are
there broken references pointing to things that don't exist, and
separately, is there real, populated structure that exists but isn't
documented anywhere it should be — both directions checked, since the
second direction was itself a blind spot found and fixed mid-session;
(5) are there rules in OPERATING_CONTRACT.md with no EVOLUTION_LOG.md
entry ever showing them actually being exercised, not just declared;
(6b) if a check was just self-corrected, actively attempt to falsify
the clean result from a different angle before accepting it; (7) is
STATUS.md's NON-NEGOTIABLE instruction (requiring the Handoff Baton to
be included in any status response) still present and intact at the
file's top — added after CC-127 confirmed a real failure where a status
query omitted the baton entirely. Every finding gets tagged MECHANICAL
(a verifiable fact, may be fixed in the same pass, but always reported,
never silent) or JUDGMENT-REQUIRED (a human decision, never
auto-resolved). If this run is happening immediately after a previous
check was just corrected, audit is required to actively try to disprove
its own clean result on a different angle before reporting it clean —
this rule exists because exactly that failure happened twice in one
session before being caught.

### update-readme

Triggered by structural change — a new domain under DOMAINS/, a new
skill under .claude/skills/, a new hook under .claude/hooks/, or a
new file in WORKSPACE/ — checked as step 5c of chalo rather than
invoked separately. Also fires on explicit request ("update the
readme," "add this to the dictionary"). Reads the new or changed
thing's actual content first (per the no-overclaim rule), never from
the name alone. Finds its correct section in README.md's numbered
structure, writes an entry matching its neighbors in density and
style, verifies the new entry doesn't duplicate or contradict an
existing one, commits the change, and appends one line to
EVOLUTION_LOG.md. Does not decide whether something is finished enough
to document — only fires once something genuinely exists and is in
active use, applying the same threshold INGEST.md uses before calling
a source ingested. DOMAINS/_TEMPLATE/ never gets a "Domains" entry
for exactly this reason.

### ingest-validate

Triggered on demand — "ingest-validate," "should I ingest this," or
explicit /ingest-validate invocation — when the user has a new source
and wants to know what the system already contains before committing
to a full INGEST.md pass. Distinct from chalo (session-close) and
audit (system-wide self-check): this is a one-shot pre-ingestion
orientation report with no automatic trigger. Operates in two modes:

**Default (lightweight) mode** — Produces six sections in order:
(1) every source already in SYSTEM_BRAIN/index.md with a one-line
description and ingest date; (2) every synthesized concept already in
the index; (3) active domains under DOMAINS/ (or an explicit "none"
if _TEMPLATE/ is the only entry); (4) any open SUGGESTION RECORDs
found in SYSTEM_BRAIN/concepts/, with their current status; (5)
routing guidance — which INGEST.md Step 0 bucket the new source
likely belongs to, stated as a suggestion not a decision, with
ambiguity named rather than silently resolved; (6) a ready-to-use
handoff block for pasting the source content if the user decides to
proceed. Writes no files, produces no ingestion record, makes no
routing decision — the report only answers the prior question of
whether a full ingest is worth the effort.

**Deep mode** — Activates only when the user explicitly requests a
full comparison ("deep mode," "deconstruct and compare this"). Sized
for WHOLE-SYSTEM and SINGLE-SKILL sources where a full scope-matched
comparison adds real value over a quick read; narrow or small sources
should default to lightweight plus direct conversation. First
determines source scope and matches baseline scope accordingly:
WHOLE-SYSTEM sources (a full repo or methodology comparable to
SYSTEM_DESIGN_OS) get README.md + FRAMEWORK.md as baseline, read
fresh from disk; SINGLE-SKILL sources get the one corresponding real
skill file; SPECIFIC-MECHANISM sources get the one real file or
section they would modify. Baseline is always SYSTEM_DESIGN_OS's own
current files — never an external system, never a mismatched
granularity. Then deconstructs the source factually (substance vs.
marketing language, overlaps and conflicts with the real baseline),
runs a comparative analysis rating each novel mechanism on DNA
compatibility / impact / cost (1–5 each, stated as structured
reasoning, not objective measurement), and recommends ADOPT, ADAPT,
DEFER, or REJECT for each with reasoning tied to a specific real gap.
A REJECT verdict means the source's raw content is never written to
SYSTEM_SOURCES/ or any domain's RAW/ — deep mode works entirely from
conversational content and requires no file save to analyze a source.
If the source was saved to disk before evaluation completed, a REJECT
verdict triggers immediate deletion, not "leave it just in case." Any
mechanism recommended for ADOPT or ADAPT produces a real SUGGESTION
RECORD (status PROPOSED) in the relevant concept page via the
standard INGEST.md Step 7 mechanism — deep mode creates no new
approval pathway, only more rigorous analysis before the same output.

## 5. The two hooks — mechanical, cannot be talked past

### ingest-guard.sh

Fires on every file write attempt, before it completes. Blocks any
write into DOMAINS/, SYSTEM_BRAIN/, or SYSTEM_SOURCES/ unless the
target path is inside a _TEMPLATE/ folder. This is not advice Claude
can choose to follow — it's a shell script that runs regardless of
what Claude decides in the moment, which is the entire reason it
exists: rules in markdown can be skipped under pressure to seem
helpful; a hook cannot.

### verify-claude-md.sh

Fires at the start of every session. Confirms the CLAUDE.md that
actually loaded is the genuine one for this project — not a stale
copy, not a different project's file — using the official
CLAUDE_PROJECT_DIR environment variable Claude Code itself sets,
rather than a hand-written guess at the project root (an earlier,
abandoned version of this hook tried to manually walk up the directory
tree and was replaced once the official variable was found to do the
same job more reliably).

**Known, permanent limitation of both hooks:** they are Claude-Code-
specific. A different agent (Codex, or otherwise) would need its own
equivalent built in its own mechanism — FRAMEWORK.md's mechanism-
agnostic specifications exist specifically so that rebuild has a real
blueprint to start from, rather than starting at zero.

## 6. What this system is not, yet

There is no business logic here. No domain has been ingested, no
workflow stage has been built, no revenue model has been tested. Every
mechanism described above has only ever been exercised on the
construction of this scaffold itself. The single open item, unchanged
since the very first message that started this project, is bringing
a real domain and running it through DOMAINS/_TEMPLATE/ for real.

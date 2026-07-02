# FRAMEWORK.md — The Three Pillars and Why Each Exists

This file answers one question, durably, so it doesn't need
re-explaining when momentum drifts: what are we actually using, for
what purpose, and why this choice over the alternatives.

## The DNA this system is built toward

Six qualities, each tied to an actual implementing mechanism — not
aspirations, but things that exist in the current codebase and can be
verified right now:

- **Agent-agnostic** — every behavioral rule lives in CLAUDE.md and
  its mirror AGENTS.md; the .claude/ machinery is documented as
  mechanism-agnostic specs in FRAMEWORK.md so it can be rebuilt under
  any agent without starting from scratch.
- **Transferable** — everything is plain markdown, no database, no
  proprietary format. The whole system is a folder you can hand to
  anyone.
- **Scalable** — knowledge stays per-domain (each BRAIN/ is isolated),
  and RULES.md documents the concrete threshold where index-file
  navigation stops being sufficient (~50-100 files per brain) so the
  decision to add tooling is driven by evidence, not anxiety.
- **Self-auditing** — audit runs as chalo's first step every session,
  reading PATTERNS.md before its own checks, so accumulated lessons
  apply automatically rather than depending on being remembered. This is
  continuous self-checking FROM INSIDE the system's own stated beliefs —
  it can only catch a gap between what the system claims and what it
  does if something in it already suspects the gap exists. A second,
  distinct mechanism (WORKSPACE/INDEPENDENT_REVIEW.md, added SDO-011)
  runs periodically from OUTSIDE that frame — a fresh session with zero
  prior context, adversarially checking things audit doesn't know to ask
  about. Its first real run found a mechanical guardrail that had
  silently done nothing since it was built, a gap neither audit nor
  chalo had ever surfaced in the system's entire history, precisely
  because both only ever checked the system against its own
  self-description.
- **Ever-learning** — PATTERNS.md converts confirmed multi-instance
  failures into checkable rules. Each new pattern makes the next
  instance of that shape catchable without human intervention.
- **Knowledge-deepening** — ingesting a source isn't complete when a
  verified ingestion record exists; the brain's concept pages must
  actually contain the specific, reasoning-ready detail the record
  verified, not a thin summary while richer content sits unused.
  Audit's check 1c compares every concept page's depth against its
  own ingestion record's claims, every session — knowledge is
  required to expand, not just get filed.

**The honest limit:** this compounds *known* lessons — it does not
independently discover unknown ones. A failure has to happen at least
twice, be noticed by a human, and get logged before PATTERNS.md can
act on it. The system does not predict unforeseen first instances on
its own. That still requires a human looking at the output with
genuine skepticism.

## 1. LLM Wiki — for knowledge accumulation

**Purpose:** solves the problem that knowledge doesn't accumulate by
default. Without it, an LLM re-derives understanding from raw sources on
every question — finds fragments, reasons fresh, forgets. Nothing
compounds across sessions.

**Mechanism:** a source is read once and integrated — written into
entity pages, concept pages, an evolving synthesis — rather than indexed
for later retrieval. Each new source is woven into what's already there;
contradictions get flagged; the picture gets richer over time. An index
file and a chronological log let an agent navigate accumulated knowledge
without re-reading every raw source each time.

**How this system instantiates the LLM Wiki pattern:** each BRAIN/ has
four folders drawn directly from the source's own vocabulary: sources/
(raw ingestion records — immutable, LLM reads but never modifies),
concepts/ (reusable ideas extracted from sources), entities/ (named
things: people, tools, companies), and synthesis/ (the document-derived
connective summary — overview.md). A fifth folder, dialogue/, holds
conversational.md: insights from live use that did not come from any
ingested document. dialogue/ is an extension of the pattern, not a claim
about what LLM Wiki specifies — it is honestly labeled as such.

Note: an earlier version of this folder was named context/ (added in
CC-063, since corrected). A later provenance audit (CC-138/139/141)
found this name diverged from the LLM Wiki source's own vocabulary,
which explicitly uses "synthesis" as the content type for this layer.
Corrected to synthesis/ (sourced name, holds overview.md) and dialogue/
(honestly-labeled, no claimed source lineage, holds conversational.md).

**Why we chose it:** the goal is a domain-specific knowledge base (e.g.
a methodology, a market, a body of research) that gets smarter as more
is fed into it, and that is transferable — to another LLM, to a
successor, to a client. Plain RAG doesn't compound. A database isn't
portable or human-legible. This pattern does both.

## 2. ICM (Interpretable Context Methodology) — for workflow orchestration

**Purpose:** solves how an agent executes a multi-step, human-reviewed
process without a code-level orchestration framework. The problem: a
workflow has stages: how does an agent know its job at each stage, and
how is the workflow changed without rewriting code?

**Mechanism:** each stage is a folder. The folder holds the prompt, the
context, and the expected output — all markdown. An agent reads the
folder it's in, knows its job, writes output; the next stage reads that
output. Changing the workflow means renaming or adding folders — no
redeployment.

**Why we chose it:** the explicit requirement was repeatable, inspectable,
editable workflows — something anyone (a future employee, another agent,
the user) can open and understand without touching code. Standard agent
frameworks (LangChain, CrewAI) solve a coordination problem that doesn't
exist for sequential, human-gated work, and require code changes to
adjust. ICM doesn't.

### Stage numbering convention

Workflow stages use increments of 10 (10_RESEARCH/, 20_FILTER/,
30_WRITE/), not sequential integers (01, 02, 03). This allows a new
stage to be inserted later (e.g. 15_REVIEW/ between 10 and 20) without
renumbering every existing folder. No workflow stages exist yet in any
domain — this convention applies the first time one is created.

(Note: the ICM paper itself specifies only that "numbered folders
represent stages" — it does not prescribe a specific numbering interval.
The increment-of-10 convention is an engineering extension applied on top
of the sourced numbered-folder concept, chosen because it allows inserting
a new stage later without renumbering every existing folder. This is a
deliberate addition, not a claim about what the ICM paper itself says.)

### Five-layer context hierarchy (Section 3.2)

The paper defines a five-layer hierarchy for what an agent has access to at any stage. Each layer has a distinct role and stability profile:

- **Layer 0 (CLAUDE.md, ~800 tokens)** — the schema: how the system is structured, what workflows to follow. Loads every session.
- **Layer 1 (CONTEXT.md)** — routing: which stage is active, what the current goal is.
- **Layer 2 (stage CONTEXT.md)** — stage-specific context: the prompt, goal, and constraints for this stage only.
- **Layer 3 (reference material / factory)** — stable resources the agent consults (style guides, templates, source data). Loaded as needed, not every step. Does not change between runs.
- **Layer 4 (working artifacts / product)** — files produced in this run; consumed by the next stage. Changes every run.

**Core design principle (paper's own phrasing):** "Configure the factory, not the product." Layer 3 is where stable, reusable configuration lives — the recipe. Layer 4 is what changes every run — the ingredients. Keeping them distinct prevents per-run artifacts from accumulating in stable reference material and polluting future runs.

**Token efficiency benefit (Figure 3):** ICM stages each deliver 2,000–8,000 focused tokens to the agent. A monolithic approach loading all stage instructions, all reference files, and all prior outputs reaches 30,000–50,000 tokens — most of it irrelevant to the current step. The five-layer hierarchy is what makes the per-stage token budget tractable.

### Stage contracts (Section 3.3)

Each stage's CONTEXT.md follows a structured contract with three required sections:

- **Inputs** — what this stage expects to find (prior stage's output, Layer 3 reference files)
- **Process** — what the agent does at this stage
- **Outputs** — what this stage must produce for the next stage to consume

The contract makes stages inspectable and hand-off-ready: anyone (or any agent) opening a stage folder can read CONTEXT.md and know exactly what that stage does, what it needs, and what it produces — without reading any code. This is a direct instantiation of ICM's core claim that the filesystem is sufficient as the coordination spine.

### The guardrail concept (mechanism-agnostic)

Rules (text in CLAUDE.md/AGENTS.md/OPERATING_CONTRACT.md/INGEST.md) can
be skipped by an agent under pressure to appear helpful — documented
directly in EVOLUTION_LOG.md (CC-026). A guardrail is a different kind
of thing: an automatic check that runs independently of the agent's own
judgment, at a specific trigger point, and can block an action outright
rather than just advising against it.

This system currently implements two guardrail concepts — write-
protection and session-identity verification — each using Claude Code's
specific mechanism (a PreToolUse or SessionStart hook in .claude/hooks/,
registered in .claude/settings.json). Neither implementation is portable
to other agents (confirmed: Codex uses an entirely different config
format and hook trust model under .codex/).

The write-protection guardrail blocks writes into DOMAINS/, SYSTEM_BRAIN/,
or SYSTEM_SOURCES/ unless that path is _TEMPLATE/, OR a genuine, logged
override is presented (redesigned SDO-012 — see below):

What IS portable is the concept itself, specified here independent of
any tool's syntax, so it can be rebuilt under a different agent's own
mechanism:

- **Trigger condition:** before any file-write-capable action completes —
  not just a dedicated Write/Edit tool, but ANY mechanism that tool can
  use to write a file (SDO-012 extended this from Write/Edit-only to also
  cover Bash-tool invocations, since a write is a write regardless of
  which tool makes it — see the honest limitation below on why this still
  isn't total coverage).
- **Check performed:** does the target path fall under DOMAINS/,
  SYSTEM_BRAIN/, or SYSTEM_SOURCES/, and is it NOT under a _TEMPLATE/
  subpath? If so, is a valid override present — a record whose stated
  target matches this exact write, whose stated justification already
  exists (verbatim) in the append-only decision log, and whose age is
  within a short, bounded window?
- **Action on match, no valid override:** block the action; surface a
  message stating this is a CONFLICT (the guard disagrees with the
  actor's belief the write is legitimate), not a routing gap, and explain
  how to produce a genuine override.
- **Action on match, valid override present:** allow the write once, then
  consume (delete) the override — it is single-use, not a standing
  bypass.
- **Action on no match:** allow the write normally.
- **Known limitation, true regardless of implementation:** a block used
  to be resolved by checking WHERE a write happens, not WHETHER a genuine
  routing decision occurred first — a geography check, not a process
  check (CC-027's original, honest limitation). SDO-012 closes that
  specific gap by requiring an actual logged decision before any override
  is honored. What remains true for any implementation: if the tool this
  guardrail hooks into can be extended arbitrarily (a general-purpose
  scripting/shell tool), no finite set of pattern checks can be
  guaranteed complete — the Bash-tool check is a best-effort heuristic
  over the raw command text, not a full interpreter, and cannot catch
  every conceivable way a command could write a file. This is a real,
  stated residual risk, not claimed as complete coverage.

**A guard block is a conflict to resolve, not a tool gap to route around
(SDO-012).** An early design pass considered treating an accidental
exemption (a tool the guardrail's matcher didn't cover) as an acceptable
channel for legitimate writes. This was rejected: a write is a write
regardless of tool, and using an accidental gap as if it were a sanctioned
path just relocates the same unchecked hole rather than closing it. The
correct model, worked out with the user directly: a block on a write
believed to be legitimate is the same shape as RULES.md's already-
documented content-conflict mechanism (two things disagree; don't silently
pick one; surface it; require an explicit, logged, human-traceable
resolution) — applied one layer down, at the enforcement layer instead of
the content layer. The override mechanism this produced requires a
matching decision-log entry to exist ON DISK before it is honored (the
paper trail is a precondition for resolution, not a record written after
the fact), and is consumed after exactly one use.

**A guardrail is not built until a real blocked write has been logged
(SDO-002).** The original ingest-guard.sh implementation (CC-027) read
its target path from a positional argument and exited 1 on match — Claude
Code actually delivers PreToolUse hook input as a JSON object on stdin
(the path lives at `.tool_input.file_path`) and only exit code 2 blocks
the tool call; exit 1 just reports a non-blocking error. This meant the
hook silently exited 0 on every real invocation from the moment it was
built until SDO-002's live-fire test caught it — zero blocked writes were
ever logged in EVOLUTION_LOG.md across the hook's entire history, which
in hindsight was itself the tell. A guardrail's implementation detail
(where the tool actually delivers its input, which exit code actually
blocks, which stream a warning must write to) is agent-specific and must
be confirmed against that agent's real behavior, not assumed by analogy
to a different mechanism — this is the same "no confidence claim may
exceed the evidence" standard INGEST.md already applies to sources,
applied here to a hook's own claimed behavior. A future implementation
under a different agent must include this same live-fire verification
step (attempt a real blocked action, confirm it is refused, log the
result) before being considered built — not just written.

A future implementation under a different agent (Kimi, Codex, or
otherwise) should read this specification and build its own equivalent
using whatever hook/automation mechanism that agent actually supports —
not attempt to copy .claude/hooks/ingest-guard.sh directly, since the
underlying execution model differs.

### The session-close concept (mechanism-agnostic)

The obligation itself — refresh STATUS.md, confirm EVOLUTION_LOG.md is
current, check for unverified claims, commit everything — is documented
as a portable rule in OPERATING_CONTRACT.md Rule 8. That obligation
applies regardless of which agent or tool is running this system.

What does NOT transfer, if and when this is built, is the specific
invocation mechanism: a Claude Code skill
(.claude/skills/chalo/SKILL.md), invoked by the trigger word "chalo."
Skills are a Claude-Code-specific feature — a different agent would
need its own equivalent mechanism, since the .claude/skills/ folder
format isn't read by other tools.

The portable specification, independent of any tool's skill syntax:

- **Trigger:** an explicit user signal that a session is ending — not
  automatic detection, since no mechanism can reliably detect "the
  user is about to stop talking."
- **Sequence on trigger:** review session → confirm/backfill the
  chronological log → rewrite the snapshot's verified/open sections →
  flag any unverified claims found → commit everything in one pass →
  report a short honest summary back to the user.
- **Known limitation, true regardless of implementation:** this only
  runs if the user remembers to invoke it. If a session ends without
  that, the snapshot goes stale until the next session catches the
  drift.

A future implementation under a different agent should read this
specification and build the trigger + sequence in that agent's own
mechanism — not attempt to copy .claude/skills/chalo/ directly.

### The system self-audit concept (mechanism-agnostic)

The obligation itself — periodically checking the system against its
own stated rules, flagging staleness and missed self-applications —
is portable regardless of agent or tool.

What does NOT transfer is the specific invocation mechanism: a Claude
Code skill (.claude/skills/audit/SKILL.md), fired as chalo's first
step. Skills are Claude-Code-specific. A different agent would need its
own equivalent trigger.

The portable specification:

- **Trigger:** fires as part of session-close, not separately invoked —
  ensuring it runs reliably rather than depending on being remembered.
- **What it checks (5 categories):** (1) every file against its own
  stated purpose; (2) promotion/threshold conditions that may have been
  crossed; (3) principles applied once but not self-applied elsewhere;
  (4) broken or stale cross-references; (5) rules that exist but were
  never actually exercised with a real logged instance.
- **Output discipline:** each finding tagged MECHANICAL (can fix in
  this pass) or JUDGMENT-REQUIRED (surface to user, don't resolve
  unilaterally). Never silently pass anything requiring human judgment.
- **Known limitation, true regardless of implementation:** the audit
  checks whether known principles were applied to existing structures.
  It cannot prevent a new structure from being created without those
  principles — the root cause is a judgment failure at creation time,
  not a missing check. This was demonstrated by the audit's own first
  run (CC-066/068), which found its own FRAMEWORK.md concept missing.
  Mechanical checks catch this pattern after the fact; they can't
  guarantee it never recurs.

A future implementation under a different agent should build an
equivalent periodic-check trigger in that agent's own mechanism, using
the 5 categories above as the check list.

### The dictionary-maintenance concept (mechanism-agnostic)

The obligation itself — keeping README.md current as the system grows
— applies regardless of agent or tool. Any agent creating or removing
named structure (a domain, a skill, a hook, a WORKSPACE file) should
document or un-document that structure in README.md's existing format
before the session closes.

What does NOT transfer is the specific invocation: a Claude Code skill
(.claude/skills/update-readme/SKILL.md), wired into chalo's Step 5c.
Skills are Claude-Code-specific.

The portable specification:

- **Trigger:** any structural change — checked at session close, not
  as a separate invocation
- **Precondition:** read the new thing's actual content before writing
  its entry — no entry from the name alone (no-overclaim rule)
- **Action:** find the right section in README.md, write an entry
  matching its neighbors in density and style, verify no duplication
  or contradiction
- **Post-action:** append one line to EVOLUTION_LOG.md
- **What it does NOT do:** decide whether something is finished enough
  to document — applies the same threshold INGEST.md uses before
  calling a source ingested; templates and placeholders never get entries

A future implementation under a different agent should build an
equivalent session-close check using the above trigger and precondition,
not by copying the Claude Code skill directly.

### The pre-ingestion orientation concept (mechanism-agnostic)

Before committing to a full ingestion pass (which writes to SYSTEM_BRAIN/, updates indexes, and requires formal verification artifacts), an agent should be able to answer: "what does the system already contain, and would this new source add anything genuinely new?" That orientation check is distinct from ingestion itself — it reads existing state, produces a report, and makes no writes.

The portable specification:

- **Trigger:** on demand, when a user has a new source and wants to evaluate it before deciding; never automatic
- **Output:** the current brain's source list and concept list (read from the index, not from memory); the list of active domains; any open SUGGESTION RECORDs; a routing suggestion (system-level methodology vs. domain-specific); and a ready-to-use handoff prompt the user can copy with the new source's content inserted
- **What it does NOT do:** write any files, produce an ingestion record, or make a routing decision — the report only surfaces what exists and suggests a bucket; Step 0 of INGEST.md confirms routing

A future implementation under a different agent should build an equivalent on-demand report generator using the output spec above, not by copying the Claude Code skill (.claude/skills/ingest-validate/SKILL.md) directly.

### Deep mode (mechanism-agnostic)

When explicitly requested ("deep mode," "deconstruct and compare
this"), the skill performs a heavier evaluation than the default
lightweight report:

- **Scope classification:** the new source is classified as
  WHOLE-SYSTEM (a full repo/methodology, comparable in scope to this
  system itself), SINGLE-SKILL (a found skill/procedure), or
  SPECIFIC-MECHANISM (a narrow idea affecting one file/step). The
  classification determines what gets read fresh as the baseline —
  whole-system sources compare against the system's own full
  reference and design rationale; single-skill sources compare
  against the one real, corresponding file; specific-mechanism
  sources compare against the one real section they'd modify. Scope
  and baseline granularity must always match — a narrow source never
  gets compared against the whole system, and a whole-system source
  never gets compared against one file.
- **Comparative analysis:** for each mechanism the source has that the
  matched baseline doesn't, rate DNA-compatibility, impact, and cost
  (each a structured judgment scale, not an objective measurement),
  then recommend ADOPT, ADAPT, DEFER, or REJECT with reasoning tied to
  a specific real gap.
- **Reject safeguard:** a REJECT verdict means the source's raw
  content is never persisted as a saved source. If it was saved
  before the verdict was reached, it gets deleted as part of closing
  out the evaluation — a rejected source should never exist on disk.
- **Terminal output:** ADOPT/ADAPT verdicts produce a real proposal
  record (status always starting as proposed, never auto-applied) in
  the relevant existing knowledge page — this is the same gated
  mechanism used for any new-knowledge suggestion, not a separate
  approval path invented for deep mode specifically.
- **Honest limit:** the DNA/impact/cost scores organize reasoning,
  they don't replace it — three subjective ratings multiplied
  together aren't objectively truer than a plain sentence explaining
  why something matters.

A future implementation under a different agent should be able to
build a functionally equivalent deep mode from this description alone
— not just the lightweight report half of the skill.

### The session-identity verification concept (mechanism-agnostic)

At the start of every session, an agent may receive a CLAUDE.md (or
equivalent entry-point file) that isn't the one for this specific
project — a stale copy from a prior session, a parent-directory file
that auto-loaded first, or an incorrect file from a different project
running alongside. If nothing checks this, the agent operates with a
silently wrong context for the entire session.

The portable concept: at session start, confirm the entry-point file
that actually loaded corresponds to this project's real path, using
an authoritative source for the expected path (the tool's own
environment variable, or equivalent) rather than a hand-written guess
that could itself be wrong.

The portable specification:

- **Trigger:** session start, before any other work — this is the only
  window where a wrong context can be caught before it affects anything
- **Check performed:** compare the path of the loaded CLAUDE.md against
  the expected path derived from an authoritative project-root signal
  (not a manually coded constant)
- **Action on match:** allow the session to proceed; no output needed
- **Action on mismatch:** report clearly which file loaded vs. which
  was expected — do not silently continue with wrong context loaded
- **Known limitation, true regardless of implementation:** this verifies
  the file's identity (which file loaded), not its currency (whether
  the file's content matches the latest committed version). A correctly
  identified CLAUDE.md with stale content still passes this check.

A future implementation under a different agent should build an
equivalent session-start check using the above specification — not
by copying .claude/hooks/verify-claude-md.sh directly, since the hook
format and environment variables differ by tool.

### The transmission-verification concept (mechanism-agnostic)

A prompt being correctly written is not evidence it was executed — it
has to cross from chat into the tool that runs it, and that crossing
can silently fail. The portable practice: before relying on any prior
prompt's output, verify the artifact exists where it should and a real
commit corresponds to it, rather than trusting that a well-formed
prompt implies a completed action. This applies regardless of which
chat interface or coding tool is involved — the gap is structural
(two separate systems, a human as the only bridge between them), not
specific to Claude Code.

## 3. Markdown — as the portable knowledge artifact

**Purpose:** solves transferability. The system must not be locked to any
one tool, model, or person.

**Why markdown specifically (not JSON, not a database, not a
tool-native format):** it is simultaneously readable natively by every
LLM, readable by a human with zero tooling, version-controllable via git
for free, and copyable as a folder to anyone with no translation step.
JSON is machine-clean but not human-legible at a glance. A database
requires infrastructure just to open. Markdown is just text — and "hand
this to my children" or "give this to a client" only stays literally
true if the underlying format requires nothing but a text editor.

## How the three connect

LLM Wiki is the *what agents know* layer. ICM is the *what agents do*
layer. Markdown is the substance both are written in — and it's what
makes either layer transferable at all. Without a shared plain-text
format, the wiki and the workflow stages would each need their own
tooling, and the transferability goal would be true in theory but not
in practice.

## Division of labor (cross-reference)

This framework operates under the division of labor stated at the top
of OPERATING_CONTRACT.md: the user owns vision and real-world testing;
Claude (in conversation) owns knowledge synthesis; Claude Code or any
filesystem-access LLM owns documentation and execution. The three
pillars above are what that execution layer actually builds and
maintains.

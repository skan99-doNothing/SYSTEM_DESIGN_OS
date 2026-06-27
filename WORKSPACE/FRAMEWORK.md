# FRAMEWORK.md — The Three Pillars and Why Each Exists

This file answers one question, durably, so it doesn't need
re-explaining when momentum drifts: what are we actually using, for
what purpose, and why this choice over the alternatives.

## The DNA this system is built toward

Five qualities, each tied to an actual implementing mechanism — not
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
  apply automatically rather than depending on being remembered.
- **Ever-learning** — PATTERNS.md converts confirmed multi-instance
  failures into checkable rules. Each new pattern makes the next
  instance of that shape catchable without human intervention.

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

### The guardrail concept (mechanism-agnostic)

Rules (text in CLAUDE.md/AGENTS.md/OPERATING_CONTRACT.md/INGEST.md) can
be skipped by an agent under pressure to appear helpful — documented
directly in EVOLUTION_LOG.md (CC-026). A guardrail is a different kind
of thing: an automatic check that runs independently of the agent's own
judgment, at a specific trigger point, and can block an action outright
rather than just advising against it.

This system currently implements one guardrail concept — blocking a
write into DOMAINS/, SYSTEM_BRAIN/, or SYSTEM_SOURCES/ unless that path
is _TEMPLATE/ — using Claude Code's specific mechanism (a PreToolUse
hook in .claude/hooks/, registered in .claude/settings.json). That
implementation is NOT portable to other agents (confirmed: Codex uses
an entirely different config format and hook trust model under
.codex/).

What IS portable is the concept itself, specified here independent of
any tool's syntax, so it can be rebuilt under a different agent's own
mechanism:

- **Trigger condition:** before any file write completes
- **Check performed:** does the target path fall under DOMAINS/,
  SYSTEM_BRAIN/, or SYSTEM_SOURCES/, and is it NOT under a _TEMPLATE/
  subpath?
- **Action on match:** block the write; surface a message referencing
  INGEST.md Step 0 (routing must be confirmed before writing here)
- **Action on no match:** allow the write normally
- **Known limitation, true regardless of implementation:** this checks
  WHERE a write happens, not WHETHER a genuine routing decision occurred
  first. It's a geography check, not a process check (CC-027's own
  stated limitation) — true for any agent's version of this guardrail,
  not just Claude Code's.

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

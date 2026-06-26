# FRAMEWORK.md — The Three Pillars and Why Each Exists

This file answers one question, durably, so it doesn't need
re-explaining when momentum drifts: what are we actually using, for
what purpose, and why this choice over the alternatives.

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

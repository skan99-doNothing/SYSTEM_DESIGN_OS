# Concept: CLAUDE.md and .claude/ Skills Pattern

**Sources:** claude-os-guide.pdf (INGESTED 2026-06-26), anatomy.jpg (INGESTED 2026-06-26), agent-skills-docs.md (INGESTED 2026-07-02)
**Author of both sources:** Akash Singhaniya (@akashafter2am)

## What it is

The .claude/ folder system — the standard structure for configuring Claude Code in a project. Defines what Claude knows at session start, what it can be invoked to do, and what fires unconditionally regardless of instructions.

## Full structure

```
YOUR-PROJECT/
├── CLAUDE.md               ← loads every session. hard limit 200 lines.
├── CLAUDE.local.md         ← private machine notes, gitignored
├── .gitignore
├── .mcp.json               ← MCP server connections. root only.
└── .claude/
    ├── skills/             ← reusable workflows, /name to trigger
    ├── agents/             ← sub-agents with own context window
    ├── hooks/              ← shell scripts that ALWAYS fire
    ├── commands/           ← slash commands; legacy but live
    ├── plugins/            ← first-class in 2026; /plugin:cmd
    ├── rules/              ← glob-scoped rules per file path
    ├── output-styles/      ← response format control
    ├── settings.json       ← permissions, model, hook registry
    ├── settings.local.json ← private overrides, gitignored
    └── statusline          ← bottom-bar: branch, model, tokens
```

## Key distinctions

**CLAUDE.md is a suggestion. Hooks are law.**
CLAUDE.md loads and informs Claude's behavior but can be overridden or ignored. Hooks fire at the shell level unconditionally — no exceptions.

**skills/ vs agents/**
- Skills are reusable workflows invoked by /name — Claude picks them up and executes.
- Agents are sub-agents with their own isolated context window — used for tasks where isolation matters (code review, security audit, debugging).

**CLAUDE.md hard limit: 200 lines.**
Forces conciseness. Anything longer than 200 lines should be extracted into rules/ (scoped) or referenced via a pointer to another file.

**rules/ is glob-scoped.**
A rules file fires only when the file path being worked on matches its glob. This keeps rule sets targeted — api.md only fires inside src/api/**, not globally.

**.mcp.json wires external tools.**
Without MCP: screenshot → paste → Claude guesses. With MCP: Claude queries the source directly. All tokens via $ENV_VAR — never hardcoded in the file.

## In this system

CLAUDE.md (or equivalent at the project root) is the schema layer in the LLM Wiki pattern — it tells the LLM how the wiki is structured and what protocols to follow. The OPERATING_CONTRACT.md and INGEST.md in WORKSPACE/ serve this function in SYSTEM_DESIGN_OS, loaded at the start of each session to set the working rules.

## SKILL.md file requirement (added from agent-skills-docs.md, SDO-021)

The `skills/` folder shown above is not just a container for loose
`.md` files. The required, mandatory structure per Claude Code's own
official documentation is one folder per skill, with a file literally
named `SKILL.md` inside it — `.claude/skills/<skill-name>/SKILL.md`
(same pattern at the personal `~/.claude/skills/` and plugin levels).
A flat file like `.claude/skills/<skill-name>.md` is NOT discovered by
Claude Code's skill mechanism at all.

This structure is not Claude-Code-specific: "Claude Code skills follow
the Agent Skills (agentskills.io) open standard, which works across
multiple AI tools" — making the folder+SKILL.md pattern the actual
agent-agnostic, portable convention, not an arbitrary Claude Code
naming choice. The folder (not just the file) is the unit, because it
can bundle supporting resources (scripts, templates, reference docs)
alongside SKILL.md.

**Prior gap, now closed:** neither claude-os-guide.md nor
anatomy-screenshot.md — both informal, third-party sources by the same
non-Anthropic author — ever documented this specific mechanical detail,
despite both covering `skills/` at a surface level ("model-invokable,
Claude picks them"). This is the first primary/official source ingested
on this topic.

## SUGGESTION RECORD: audit check for foundational claims resting only on secondary sources
- **Triggered by:** SDO-020/SDO-021. A user question surfaced that the
  brain's ONLY coverage of `.claude/skills/` file structure came from two
  informal, third-party sources (a guide PDF and an Instagram infographic,
  same non-Anthropic author) with no primary/official corroboration —
  and both were, independently, thin on the exact mechanical detail asked
  about. Neither ingestion record was dishonest (both correctly said
  "What could NOT be verified: Nothing" relative to what the source
  itself contained) — the gap existed one level up, in source selection,
  not extraction. Audit's existing 1c check (concept page vs. its own
  ingestion record) cannot catch this: the record and the concept page
  agreed with each other; both were simply thin relative to ground truth
  because the source itself never went deeper.
- **Proposed change:** Add a new audit check (candidate: 1e, alongside
  1c's concept-depth check and 1d's periodic re-verification rotation) —
  for concept/synthesis pages describing a Claude-Code-specific mechanism
  (a hook, a skill format, a settings.json behavior, or similar
  documented-elsewhere-officially content), flag if EVERY source cited
  for that page is informal/third-party (a blog, a social post, a guide
  not published by Anthropic) with none from Anthropic's own official
  documentation. Flag as JUDGMENT-REQUIRED (not MECHANICAL, since
  "informal vs. official" requires judgment about the source, not a pure
  count) — surfaced, not auto-fixed, same as audit's other JUDGMENT-
  REQUIRED findings (e.g. 1b's ARTIFACTS/ staleness check).
- **Why:** Without this, a foundational mechanism claim can sit in the
  brain, technically "INGESTED" and passing every existing audit check,
  while actually resting on secondary paraphrase that never captured the
  real specification — discoverable only if a human happens to ask the
  exact right question, as happened here. This is the CC-026/SDO-015/
  SDO-017 pattern (a rule/check that depends on someone noticing) applied
  one level up: to what the brain itself is built from, not just to
  whether a rule got followed.
- **Status:** PROPOSED (not applied — audit's skill file is unchanged;
  this record documents the gap and a candidate fix, pending explicit
  human review and approval per INGEST.md Step 7)
- **Date:** 2026-07-02

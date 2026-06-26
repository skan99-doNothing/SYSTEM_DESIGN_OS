# Concept: CLAUDE.md and .claude/ Skills Pattern

**Sources:** claude-os-guide.pdf (INGESTED 2026-06-26), anatomy.jpg (INGESTED 2026-06-26)
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
    ├── rules/              ← glob-scoped rules per file path
    ├── output-styles/      ← response format control
    ├── settings.json       ← permissions, model, hook registry
    └── settings.local.json ← private overrides, gitignored
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

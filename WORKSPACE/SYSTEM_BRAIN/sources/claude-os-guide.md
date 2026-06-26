# INGEST RECORD: claude-os-guide.pdf

- **Status:** INGESTED
- **Method:** pdfinfo (page count) + pdftotext (text extraction)
- **Verification artifacts:**
  1. Title: "CLAUDE/OS — The Complete Guide" — confirmed via pdfinfo
  2. Author: Akash Singhaniya; created 2026-06-23
  3. 8 pages confirmed via pdfinfo
  4. Key phrase: "CLAUDE.md IS A SUGGESTION. HOOKS ARE LAW."
  5. CLAUDE.md hard limit stated explicitly: "Hard limit: 200 lines"
- **What was actually gotten from this source:** Full .claude/ folder structure with per-file explanations and example code for CLAUDE.md, .mcp.json, hooks/, skills, agents, rules, settings.json. Two-part structure: Part 1 Technical (every file explained), Part 2 Agency Blueprint (real business application).
- **What could NOT be verified or read:** Text extraction cut off mid-document at ~page 3. Files 04 onward (skills, agents, rules, output-styles, settings.json) not extracted in this pass. Core structure confirmed; deeper per-file examples in later pages not yet synthesized.
- **Date:** 2026-06-26

## Key content

**Full .claude/ structure:**
```
YOUR-PROJECT/
├── CLAUDE.md           ← brain. loads every session. hard limit 200 lines.
├── CLAUDE.local.md     ← private machine notes
├── .gitignore          ← keeps secrets off GitHub
├── .mcp.json           ← connects Claude to external tools
└── .claude/
    ├── skills/         ← reusable workflows. /name to trigger.
    ├── agents/         ← sub-agents with own context window
    ├── hooks/          ← shell scripts that ALWAYS fire
    ├── rules/          ← scoped rules per file path
    ├── output-styles/  ← controls Claude response format
    ├── settings.json   ← control panel. hooks need this.
    └── settings.local.json ← private overrides. gitignored.
```

**Key files:**

**CLAUDE.md** — loads every session, hard limit 200 lines. Contains project name/goal/stack, rules, architecture pointers, what is never used.

**.mcp.json** — wires Claude to external tools (Supabase, GitHub, Playwright shown as examples). All keys use $ENV_VAR syntax — never hardcoded. Without MCP: screenshot → paste → Claude guesses. With MCP: Claude queries directly.

**hooks/** — shell scripts that fire at specific moments unconditionally. session-start.sh example: prints branch, last commit, uncommitted file count. The distinction is critical: CLAUDE.md can be overlooked; hooks cannot.

**Two-part structure of the guide:**
- Part 1 Technical: every file in .claude/, what it does, real code examples
- Part 2 Agency Blueprint: what this looks like for a real business (not extracted in this pass)

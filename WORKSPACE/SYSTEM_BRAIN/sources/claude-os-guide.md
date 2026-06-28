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
- **What could NOT be verified or read:** Text extraction cut off at ~page 3 in original pass — cleared by CC-140 full re-read 2026-06-28 (see re-verification section below). Nothing remaining.
- **Date:** 2026-06-26
- **Last full re-verification:** 2026-06-28 (CC-144)

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

---

## Re-verification pass — 2026-06-28 (CC-140)

- **Method:** Direct re-read of SYSTEM_SOURCES/claude-os-guide.pdf (pdftotext). Full 8-page document read — Files 04 onward now captured (skills, agents, rules, output-styles, settings.json, Agency Blueprint).
- **Status:** CONFIRMED INGESTED. The original record's note that "Files 04 onward not extracted in this pass" is now resolved — full content confirmed.

**Graded confidence artifacts (re-run, additions noted):**
1. "CLAUDE.md IS A SUGGESTION. HOOKS ARE LAW." — **1.0**
2. CLAUDE.md hard limit: 200 lines — **1.0**
3. Author: Akash Singhaniya (@akashafter2am); 8 pages; created 2026-06-23 — **1.0**
4. settings.json actual JSON schema: hooks registered under "SessionStart", "PreToolUse", "PostToolUse" with matcher patterns — **1.0** (not in original record)
5. rules/ glob-scoped: fires only when file path matches glob — **1.0** (not in original record; now in concept page)
6. Part 2 Agency Blueprint — Whitfield Creative example: client-specific rules files, hooks for pre-delivery QC — **1.0** (not in original record)
7. output-styles/ — controls response format — **1.0** (not in original record)

**Concept page comparison:** claude-md-and-skills-pattern.md already includes rules/, output-styles/, and other "not extracted" sections — because anatomy.jpg (co-source) provides the structural overview. The concept page correctly attributes both sources. commands/, plugins/, and statusline were added to the concept page tree in this re-verification pass (they were in anatomy.jpg's key content table but missing from the concept page).

**Finding:** Original ingestion honest about its partial extraction. Concept page was populated from both sources and was more complete than this record alone would suggest. Minor tree gaps corrected in this pass.

# INGEST RECORD: anatomy.jpg

- **Status:** INGESTED
- **Method:** Visual read (image rendered and viewed directly)
- **Verification artifacts:**
  1. Title text visible: "anatomy of a .claude/ folder" — large heading, "anatomy of a" in black, ".claude/" in orange
  2. Subtitle: "EVERY FILE. WHAT IT DOES. WHY IT MATTERS."
  3. Two-column layout: YOUR PROJECT/ (left) and WHAT IT DOES (right)
  4. Account: akashafter2am (Instagram), 24 likes shown
  5. Caption at bottom: "Most Claude Code users never open the .claude/. THEY HAVE A BETTER .CLAUDE/."
- **What was actually gotten from this source:** Complete visual mapping of .claude/ folder structure with one-line "what it does" descriptions for every file and subfolder. More concise than the PDF guide — a reference card rather than a tutorial.
- **What could NOT be verified or read:** Nothing — image rendered fully and all text is legible.
- **Date:** 2026-06-26
- **Last full re-verification:** 2026-07-01 (chalo audit, 1d rotation)

## Key content (verbatim from image)

| File/Folder | What it does |
|---|---|
| CLAUDE.md | where Claude actually lives |
| CLAUDE.local.md | your rules. keep it under 200 lines |
| .gitignore | block *.local* and your secrets |
| .mcp.json | MCP servers. root only, no nesting |
| .claude/ | the brain. everything below loads |
| skills/ | model-invokable. Claude picks them |
| → ui-ux-pro-max/ | design intelligence on tap |
| → remotion/ | edit videos programmatically |
| agents/ | subagents. own context window |
| → code-reviewer.md | senior reviewer for every PR |
| → debugger.md | hunt the bug in isolation |
| → security-auditor.md | scan for vulns and secrets |
| commands/ | slash commands. legacy but live |
| → commit.md | analyze diff, write commit msg |
| hooks/ | shell scripts that always fire |
| → format-on-save.sh | auto-format every file edit |
| → block-dangerous-bash.sh | block rm -rf and force-push |
| → desktop-notify.sh | ping me when Claude finishes |
| plugins/ | first-class in 2026. /plugin:cmd |
| → claude-finance/ | official Anthropic plugin. 6 agents |
| rules/ | glob-scoped. loads on match |
| → api.md | fires only inside src/api/** |
| output-styles/ | response shape on tap |
| → terse.md | code only. no prose |
| statusline | bottom-bar. branch, model, tokens |
| settings.json | permissions, model, hook registry |
| settings.local.json | your machine. gitignored |

**Relationship to claude-os-guide.pdf:** This image is the same author's condensed reference card. The PDF expands each item with code examples; this image gives the one-liner for each. Together they cover the same structure — the image is better for quick reference, the PDF for implementation detail.

---

## Re-verification pass — 2026-06-28 (CC-140)

- **Method:** Direct re-read (visual) of SYSTEM_SOURCES/anatomy.jpg. Image rendered fully; all text legible.
- **Status:** CONFIRMED INGESTED — all original artifacts re-verified from live visual read this session.

**Graded confidence artifacts (re-run):**
1. Title: "anatomy of a .claude/ folder" — **1.0**
2. Subtitle: "EVERY FILE. WHAT IT DOES. WHY IT MATTERS." — **1.0**
3. Account: @akashafter2am; 24 likes — **1.0**
4. commands/ — "slash commands. legacy but live" — **1.0**
5. plugins/ — "first-class in 2026. /plugin:cmd" — **1.0**
6. statusline — "bottom-bar. branch, model, tokens" — **1.0**
7. Caption: "Most Claude Code users never open the .claude/. THEY HAVE A BETTER .CLAUDE/." — **1.0**
8. Full key content table (items 4–6 above) matches the table in the Key content section of this record — **1.0**

**Concept page update (done in this pass):** commands/, plugins/, and statusline added to claude-md-and-skills-pattern.md structure tree. All three were in this record's key content table but missing from the concept page tree.

**Finding:** Original ingestion was clean and accurate. Concept page had three items from this source missing from the tree — corrected in this re-verification pass.

---

## Re-verification pass — 2026-07-01 (chalo audit, 1d rotation)

- **Method:** Direct re-read (visual) of SYSTEM_SOURCES/anatomy.jpg, full image rendered and viewed.
- **Result:** Every row in this record's Key content table matches the live image exactly — no drift found. claude-md-and-skills-pattern.md's structure tree still contains all folder categories (including commands/, plugins/, statusline from CC-140's fix).
- **Judgment note (not flagged MECHANICAL):** the record's specific example filenames (ui-ux-pro-max/, code-reviewer.md, security-auditor.md, format-on-save.sh, block-dangerous-bash.sh, desktop-notify.sh, claude-finance/, api.md, terse.md, commit.md) are not individually listed in the concept page's structure tree — only the folder categories are. Assessed as non-material: these are illustrative example names from one screenshot, not reusable pattern facts the concept page needs to carry. Noted explicitly rather than silently passed, per audit's no-silent-pass rule.
- **Status:** CONFIRMED INGESTED, no gap found.

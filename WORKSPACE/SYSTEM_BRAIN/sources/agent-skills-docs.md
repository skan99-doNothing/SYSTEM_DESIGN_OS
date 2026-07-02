# INGEST RECORD: agent-skills-docs.md (Claude Code Skills documentation)

- **Status:** INGESTED
- **Method:** WebFetch (primary/official source, not a paraphrase)
- **Verification artifacts:**
  1. Verbatim: "Skills extend what Claude can do. Create a `SKILL.md` file with instructions..." (confidence: 1.0)
  2. Verbatim: "Claude Code skills follow the [Agent Skills](https://agentskills.io) open standard, which works across multiple AI tools." (confidence: 1.0)
  3. Structural fact: location table confirms `SKILL.md` filename is required in all three location tiers (Personal, Project, Plugin) — `~/.claude/skills/<skill-name>/SKILL.md`, `.claude/skills/<skill-name>/SKILL.md`, `<plugin>/skills/<skill-name>/SKILL.md` (confidence: 1.0)
  4. Verbatim: "A file at `.claude/commands/deploy.md` and a skill at `.claude/skills/deploy/SKILL.md` both create `/deploy` and work the same way." (confidence: 1.0)
  5. Fetched URL confirmed via actual redirect response: docs.claude.com/en/docs/claude-code/skills → 301 → code.claude.com/docs/en/skills (confidence: 1.0)
- **What was actually gotten from this source:** The exact required skill file structure (folder-per-skill, mandatory SKILL.md filename), confirmation that Claude Code skills follow the Agent Skills open standard (agentskills.io) shared across multiple AI tools — making this the primary-source answer to "is folder+SKILL.md the agent-agnostic best practice," which the two prior sources (claude-os-guide.md, anatomy-screenshot.md) never actually covered despite being topically adjacent. Also covers nested/monorepo-scoped skills, symlinked skills, and live change detection behavior.
- **What could NOT be verified or read:** The full page's remaining sections (invocation control, subagent execution, dynamic context injection details) were fetched but not exhaustively extracted into this record — only the sections answering the specific triggering question were pulled through in full. This is a scoped, deliberate PARTIAL on depth beyond the triggering question, not a failed read.
- **Date:** 2026-07-02
- **Last full re-verification:** not yet run (first ingestion pass)

## Why this was ingested (trigger)

SDO-020: a user question about whether `<skill-name>/SKILL.md` is the
correct, agent-agnostic convention was answered via an external
verification agent instead of checking SYSTEM_BRAIN first. On checking
the brain afterward, its only two topically-adjacent sources
(claude-os-guide.md, anatomy-screenshot.md — both informal, third-party,
non-Anthropic content) never actually contained this specific mechanical
fact. This ingestion closes that gap with a genuine primary source.

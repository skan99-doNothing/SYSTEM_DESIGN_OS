# SYSTEM_BRAIN Index

Knowledge about how to build and run SYSTEM_DESIGN_OS itself. Distinct from any domain brain — this covers the system's own design patterns, not business-domain knowledge.

Read this index first when answering questions about how this system works. Drill into specific pages for detail.

---

## Sources

Pages summarizing what each ingested source contributed.

| Page | One-line summary | Status |
|------|-----------------|--------|
| [llm-wiki.md](sources/llm-wiki.md) | Full pattern for LLM-maintained persistent knowledge bases; three-layer architecture, three operations (ingest/query/lint), index vs log distinction | INGESTED |
| [icm-paper.md](sources/icm-paper.md) | ICM paper (21 pages, Van Clief & McDermott 2026); filesystem-as-orchestration for sequential human-reviewed workflows; Table 1 ICM vs frameworks comparison | INGESTED |
| [claude-os-guide.md](sources/claude-os-guide.md) | CLAUDE/OS guide (8 pages, Singhaniya 2026); full .claude/ folder structure with code examples for CLAUDE.md, .mcp.json, hooks/, skills, agents, rules | INGESTED |
| [anatomy-screenshot.md](sources/anatomy-screenshot.md) | anatomy.jpg Instagram reference card; complete .claude/ file-by-file one-liners; same structure as claude-os-guide but condensed | INGESTED |
| [autonomous-ai-growth-engine.md](sources/autonomous-ai-growth-engine.md) | 21-agent autonomous growth system architecture; 13-table context DB, 7-step agent lifecycle, 7-check Verifier with weights, Eval Engine, Growth OS director pattern, conflict preservation, confidence scoring (0-1) | INGESTED |

---

## Concepts

Reusable ideas extracted from sources and governing how this system operates.

| Page | One-line summary | From source(s) |
|------|-----------------|----------------|
| [llm-wiki-knowledge-accumulation.md](concepts/llm-wiki-knowledge-accumulation.md) | LLM Wiki pattern: persistent compounding wiki vs RAG; three layers; three operations; why humans abandon wikis and LLMs don't | llm-wiki.md |
| [icm-workflow-orchestration.md](concepts/icm-workflow-orchestration.md) | ICM: numbered folders as stages, markdown as prompts/context, one agent reads the right folder; when it beats frameworks and when it doesn't | icm-paper.md |
| [claude-md-and-skills-pattern.md](concepts/claude-md-and-skills-pattern.md) | .claude/ structure: CLAUDE.md is suggestion, hooks are law; skills vs agents; 200-line limit; glob-scoped rules; MCP wiring | claude-os-guide.md, anatomy.jpg |
| [agentic-growth-engine-patterns.md](concepts/agentic-growth-engine-patterns.md) | Multi-agent coordination patterns: context DB schema, 5 memory types, confidence scoring, conflict preservation, dual-model strategy, 7-step lifecycle, Verifier weights, Eval Engine, Growth OS director, typed handoffs | autonomous-ai-growth-engine.md |

---

## Context

Big-picture views: document-derived synthesis and dialogue-derived insights.

| Page | One-line summary |
|------|-----------------|
| [overview.md](context/overview.md) | How LLM Wiki (what agents know), ICM (what agents do), and markdown (transferable format) connect; the division of labor; the autonomy goal |
| [conversational.md](context/conversational.md) | Insights from live dialogue — non-obvious constraints, corrected assumptions, design decisions not traceable to any ingested source |

---

## Entities

(none yet — no specific named entities (people, tools, companies) have been extracted into standalone pages)

---

## Last updated

2026-06-27 — synthesis/ renamed to context/, conversational.md added (CC-063); review skill wired in (CC-066/068); 5th source ingested: autonomous-ai-growth-engine.md (CC-098)

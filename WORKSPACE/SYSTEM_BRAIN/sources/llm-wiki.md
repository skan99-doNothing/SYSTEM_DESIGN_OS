# INGEST RECORD: LLM Wiki.md

- **Status:** INGESTED
- **Method:** Text extraction (native markdown)
- **Verification artifacts:**
  1. "the wiki is a persistent, compounding artifact" (line 13)
  2. Three-layer architecture named explicitly: Raw sources / The wiki / The schema (lines 29-33)
  3. Document is 76 lines; 8 sections: core idea, architecture, operations, indexing and logging, CLI tools, tips and tricks, why this works, note
- **What was actually gotten from this source:** Full pattern description for building a persistent LLM-maintained knowledge base. Covers the core idea (wiki vs RAG), three-layer architecture, three operations (ingest/query/lint), the role of index.md and log.md, optional tooling (qmd, Obsidian), and a "why this works" section grounding the pattern in the LLM's maintenance advantage over humans.
- **What could NOT be verified or read:** Nothing — full text extracted cleanly.
- **Date:** 2026-06-26

## Key content

**Core idea:** Instead of RAG (retrieve fragments at query time, re-derive fresh each time), the LLM incrementally builds and maintains a persistent wiki. Knowledge is compiled once and kept current. Nothing is re-derived from scratch; the synthesis already reflects everything ingested.

**Three layers:**
- Raw sources — immutable, LLM reads but never modifies
- The wiki — LLM-generated markdown, LLM owns entirely
- The schema — config document (CLAUDE.md or AGENTS.md) telling the LLM how the wiki is structured and what workflows to follow

**Three operations:**
- Ingest — drop source, LLM reads, writes summary page, updates index, updates entity/concept pages, appends to log. A single source may touch 10-15 wiki pages.
- Query — LLM searches relevant pages, synthesizes answer with citations. Good answers get filed back into the wiki.
- Lint — periodic health check: contradictions, stale claims, orphan pages, missing cross-references, data gaps.

**index.md vs log.md:**
- index.md is content-oriented: catalog of all pages, one-line summaries, organized by category. LLM reads this first on any query.
- log.md is chronological: append-only record of ingests, queries, lint passes. Parseable with grep.

**Why it works:** Humans abandon wikis because maintenance burden grows faster than value. LLMs don't get bored, don't forget cross-references, can touch 15 files in one pass. The human curates and asks questions; the LLM does all bookkeeping.

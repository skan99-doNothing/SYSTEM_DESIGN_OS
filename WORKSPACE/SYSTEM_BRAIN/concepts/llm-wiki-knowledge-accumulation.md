# Concept: LLM Wiki — Knowledge Accumulation

**Source:** LLM Wiki.md (INGESTED 2026-06-26)
**Also referenced in:** FRAMEWORK.md § 1

## What it is

A pattern for building a persistent, LLM-maintained knowledge base that compounds across sessions, rather than re-deriving understanding from raw sources on every query.

## The core distinction from RAG

RAG retrieves fragments at query time and re-derives fresh each time — nothing accumulates. The LLM Wiki pattern compiles knowledge once into a structured wiki and keeps it current as new sources arrive. The difference: in RAG the LLM is always working from raw material; in LLM Wiki the synthesis already exists when a question is asked.

## Three layers

1. **Raw sources** — immutable. LLM reads but never modifies. Source of truth.
2. **The wiki** — LLM-generated markdown. Entity pages, concept pages, synthesis, source summaries. LLM owns this layer entirely.
3. **The schema** — config document (CLAUDE.md or equivalent) telling the LLM how the wiki is structured and what workflows to follow for ingest, query, and lint.

## Three operations

- **Ingest** — new source dropped in, LLM reads it, writes summary page, updates relevant entity/concept pages across the wiki, appends to log. One source may touch 10-15 pages.
- **Query** — LLM reads index.md to find relevant pages, drills in, synthesizes answer. Good answers get filed back as new wiki pages — explorations compound too.
- **Lint** — periodic health check for contradictions, stale claims, orphan pages, missing cross-references, data gaps.

## Navigation files

- **index.md** — content-oriented catalog. Every page listed with link and one-line summary. LLM reads this first on any query.
- **log.md** — chronological append-only record of ingests, queries, lint passes.

## Why it works

Humans abandon wikis because maintenance burden grows faster than value. LLMs don't get bored, don't forget to update a cross-reference, can touch 15 files in one pass. The human curates sources and asks questions; the LLM does all bookkeeping.

## In this system

Used as the knowledge accumulation layer for each domain. Each domain's BRAIN/ is an LLM Wiki instance: RAW/ holds immutable sources, BRAIN/ holds the wiki, INGEST.md (in WORKSPACE/) is the schema governing how ingestion works.

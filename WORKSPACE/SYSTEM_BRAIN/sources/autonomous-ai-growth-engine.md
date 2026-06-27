# INGEST RECORD: autonomous-ai-growth-engine.md

- **Status:** INGESTED
- **Method:** Text extraction (plain text/markdown provided directly in conversation)
- **Verification artifacts:**
  1. 13 table names confirmed (exact): context_entries, business_state, agent_memory, context_handoffs, agent_runs, verification_results, verification_review_queue, eval_results, golden_examples, review_queue, growth_experiments, context_conflicts, kb_articles
  2. 7-step agent lifecycle named explicitly (exact): LOAD, INJECT, EXECUTE, VERIFY, DISTILL, WRITE, EVAL
  3. 7 Verifier checks with weights confirmed (exact): SCHEMA 20%, SAFETY 20%, GROUNDING 15%, COMPLETENESS 15%, BRAND VOICE 13%, GROWTH ALIGNMENT 12%, STALENESS 5%
  4. 5 memory types named (exact): Semantic, Episodic, Procedural, Working, Growth
  5. Confidence scale confirmed (exact): 1.0 (API-verified), 0.7 (multi-signal inference), 0.4 (single signal), 0.2 (speculative)
- **What was actually gotten from this source:** Full architecture guide for a 21-agent autonomous growth system. Covers: the 3-layer mental model (Growth OS / 21 Agents / Context DB), all 13 context database tables and their purposes, 5 memory type taxonomy with tagging rationale, conflict detection and preservation mechanics, provenance and confidence scoring (0-1 scale), dual-model AI strategy (Sonnet for reasoning, Haiku for mechanical tasks at ~10x lower cost), complete 7-step agent lifecycle, 7-check Verifier with exact weights and pass/fail logic, Eval Engine with A-F grading and golden examples, typed inter-agent handoffs (8 types), Growth OS director pattern (daily pulse + weekly brief cadences), full 21-agent fleet organized by function, 8 self-contained integration modules, 9 creative studio pattern, 9-view dashboard, 12-step build order, seed.ts pattern for teaching brand voice and ICP, and adaptation patterns for e-commerce/creators/agencies.
- **What could NOT be verified or read:** The actual Notion page was not fetched — content was provided by the user directly in chat. Full text was provided and is complete per visual inspection.
- **Reconciliation:** GENUINELY NEW relative to all 4 existing sources. LLM Wiki covers knowledge accumulation but not multi-agent coordination, confidence scoring, or verification. ICM covers filesystem orchestration but not agent lifecycle, eval, or inter-agent handoffs. Neither claude-os-guide nor anatomy screenshot covers any of: graded confidence scores, weighted verification gates, conflict preservation mechanics, Eval Engine, Growth OS director pattern, or the 5 memory type taxonomy.
- **Date:** 2026-06-27

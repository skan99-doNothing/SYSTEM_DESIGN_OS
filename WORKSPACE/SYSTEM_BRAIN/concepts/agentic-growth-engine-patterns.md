# Agentic Growth Engine Patterns

From: autonomous-ai-growth-engine.md (ingested 2026-06-27)

This page documents what the source actually contains — factually, before any evaluation of what to adopt into this system.

---

## What this source is

A complete architecture guide for building a 21-agent autonomous growth system using a shared context database, a verification layer, an eval/learning layer, and a directing meta-agent (Growth OS). Built by one person using Claude Code and Gemini. The architecture is described as generic — integrations are the only product-specific layer.

---

## 1. The 3-Layer Mental Model

```
Growth OS  (director: sets weekly priorities for all agents)
                 |
21 Agents  (specialists: each owns one growth function)
                 |
Context DB  (shared brain: persistent memory for the whole system)
```

---

## 2. The Context Database (13 tables)

| Table | Purpose |
|-------|---------|
| context_entries | Core facts store with full-text search |
| business_state | Single-row JSON: MRR, churn rate, campaigns, directives |
| agent_memory | Last N run summaries per agent, injected at next run |
| context_handoffs | Inter-agent message queue (from, to, type, payload) |
| agent_runs | Full audit trail of every agent execution |
| verification_results | Verifier gate scores per run |
| verification_review_queue | Double-failed outputs waiting for human review |
| eval_results | A-F quality grades from the Eval Engine |
| golden_examples | A-grade exemplar outputs used as eval reference |
| review_queue | Human approval queue for emails, posts, articles |
| growth_experiments | A/B experiment registry |
| context_conflicts | Flagged contradicting facts from different agents |
| kb_articles | Knowledge base article index (draft/published/outdated) |

---

## 3. The 5 Memory Types

Every fact stored in context_entries is tagged with one of:

- **Semantic:** Durable facts, stay true over time (e.g., "LinkedIn DMs convert at 2x cold email for this ICP"). Kept indefinitely.
- **Episodic:** Time-bound events (e.g., "Churn spike on June 3rd"). Ages out.
- **Procedural:** How-to knowledge, changes only when the process changes.
- **Working:** Scratch notes for a single run. Discarded after.
- **Growth:** Strategic insights and Growth OS priority directives.

Tagging governs: how long to keep a fact, how much weight to give it, when to flag it stale.

---

## 4. Conflict Detection and Preservation

When two agents write contradicting facts, both are flagged. Both STAY in the database marked as conflicting — neither silently overwrites the other. Human resolves via CLI. The winning fact is kept; the other marked superseded. This is an explicit design choice against silent overwriting.

---

## 5. Provenance and Confidence Scoring (0-1 scale)

Every fact records: which agent wrote it, which run, what excerpt supported it, and a confidence score:

| Score | Meaning |
|-------|---------|
| 1.0 | Verified directly from an API call (Stripe MRR, Supabase user count) — hard data |
| 0.7 | Inferred from multiple signals — strong but not verified |
| 0.4 | Single signal inference — treat with skepticism |
| 0.2 | Speculative — worth noting, not worth acting on yet |

---

## 6. Dual-Model AI Strategy

Two models used deliberately:

- **Reasoning model (Claude Sonnet):** Agent outputs, synthesis, drafting, analysis. Expensive, justified.
- **Fast model (Claude Haiku):** Classification, fact extraction, routing. ~10x cheaper than Sonnet.

Four shared functions: `chat()`, `streamChat()`, `distill()` (Haiku extracts only durable facts from full output), `classify()` (Haiku routes into predefined categories).

---

## 7. The 7-Step Agent Lifecycle (all 21 agents share this)

1. **LOAD** — Read context DB: business state, own memory from last 5 runs, domain facts, Growth OS directives, inbox handoffs
2. **INJECT** — Read own report card (grades, recurring weaknesses, improvement suggestion) and current Growth OS directives before starting
3. **EXECUTE** — Do the agent's specific work, call AI functions, return structured result
4. **VERIFY** — Run 7 quality checks; auto-retry on failure; second failure → human review queue
5. **DISTILL** — Fast model extracts only durable facts from full output; rest discarded
6. **WRITE** — Distilled facts → context DB; typed handoffs fire to downstream agents
7. **EVAL** — Judge model grades output asynchronously (A-F, 0-10); grade + weaknesses saved; read at next INJECT

---

## 8. The Verifier (7 checks with exact weights)

| Check | Weight | What It Catches | Method |
|-------|--------|-----------------|--------|
| SCHEMA | 20% | Missing required output fields | Pure code |
| SAFETY | 20% | PII, pricing promises, spam, roadmap commitments | AI (Haiku) |
| GROUNDING | 15% | Claims not backed by context data | AI (Haiku) |
| COMPLETENESS | 15% | Required sections empty or missing | Pure code |
| BRAND VOICE | 13% | Off-tone writing, corporate speak | AI (Haiku) |
| GROWTH ALIGNMENT | 12% | No clear path to revenue impact | AI (Haiku) |
| STALENESS | 5% | Agent working from data older than 30 days | Pure code |

Composite score < 0.6 OR any blocking check → automatic retry with failure reason injected. Second failure → human review queue. Nothing propagates without passing.

---

## 9. The Eval Engine (learning loop)

- After every successful run, a judge model scores output on rubrics specific to each agent type
- Access to golden examples (A-grade outputs from previous runs) as reference
- Grades (A-F, 0-10) and specific weaknesses saved to context DB
- Next run reads them during INJECT step — agent sees its own report card
- Growth OS reads weekly quality summary; declining agents get P1 directives; F-grade agents called out explicitly

To promote a run to golden examples: `bun cli.ts evals promote <runId>`

---

## 10. Typed Inter-Agent Handoffs (8 types)

| Type | Meaning |
|------|---------|
| churn-risk | User showing signs of canceling |
| hot-angle | Content opportunity or customer quote |
| feature-request | Feature ask from a customer |
| bug-report | Bug caught in support email, routed to GitHub |
| upsell-target | User approaching plan limit |
| reactivation-target | User who has gone inactive |
| anomaly | Unexpected data needing attention |
| triggered-run | Growth OS wants an agent to run immediately |

Handoffs sit in the context_handoffs table until the recipient agent runs and picks them up.

---

## 11. Growth OS Director Pattern

Does not do growth work directly. Reads all agents' work and tells them what to focus on.

**Daily at 6am (pulse check):**
- Reads Revenue Intelligence summary
- Scans anomaly handoffs
- Checks flywheel health (agents on schedule, idle, or broken)
- Fires triggered-run handoffs for churn spikes or activation drops

**Monday at 6am (full weekly brief):**
- Reads all agent memory for past week
- Reads Eval Engine quality report
- Reads current KPIs
- Generates: what data shows, top 3-5 actions by MRR impact, channels to increase/pause, specific priority directives per agent
- Directives stored in context DB, read by every agent at next INJECT step

---

## 12. Minimum Viable Flywheel (start with 3)

1. **Revenue Intelligence** — daily financial pulse (Stripe + Supabase): MRR, churn, at-risk users, upsell candidates
2. **VoC Synthesis** — weekly: synthesizes signals from handoffs, agent memory, web search, feedback emails → themes, customer language glossary, one urgent signal with estimated revenue impact
3. **Growth OS** — the director; without it, agents run in isolation

**Build these first, get a week of data, then add more in order of MRR impact.**

---

## 13. The Build Order (12 steps)

Setup → Types → Database → AI Wrapper → Context Layer → Verifier → Eval Engine → Base Agent → Seed → First 3 Agents → CLI → Scheduler

Key discipline: build and test Verifier with bad output BEFORE writing any agents. Start Scheduler last — test everything manually before making it autonomous.

---

## 14. Seed Pattern (seed.ts, runs once)

Five things to seed before first agent run: brand voice (specific sentences, not generic "friendly"), ICP profile (exact job title/company size/pain/trigger), competitors (names + weaknesses + your positioning), plan tiers (exact pricing), KPI thresholds (your anomaly trip wires).

---

## 15. Integration Module Pattern

Each integration is self-contained — agents never talk directly to external services, only to integration modules. Swapping Stripe for Paddle = rewriting one file. 8 integrations in reference implementation: Stripe, Supabase, Gmail, MailerLite, Airtable, GitHub, Notion, Brave Search/Tavily.

---

## What is NOT in this source

- This document does not cover security/auth implementation in depth
- Does not cover cost modeling beyond the dual-model split principle
- Does not cover failure modes beyond the Verifier's retry/queue logic
- Does not cover how to run multiple SYSTEM_DESIGN_OS-style parent scaffolds in parallel
- The "Phase 2 stubs" (11 agents) are declared but not fully specified

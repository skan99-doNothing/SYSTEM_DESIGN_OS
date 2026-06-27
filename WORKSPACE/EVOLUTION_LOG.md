# EVOLUTION_LOG.md — Chronological Record

Append-only. One entry per dated event. Format: `## [date] — what happened`

---

## 2026-06-27 — STATUS.md corrected with definitive findings (CC-050)
CC-049 confirmed CC-044 through CC-047 never ran at all. FRAMEWORK.md's
false claim is still live. chalo has zero implementation. Updated
STATUS.md from "unknown" to "confirmed not done," and removed a second
false claim about CC-044's rule already existing.

## 2026-06-27 — STATUS.md manually refreshed ahead of session limit (CC-048)
Session hit its limit before CC-047's confirmation. Manually refreshed
STATUS.md to cover CC-039 through CC-047 honestly, flagging chalo's
status as unverified rather than assumed.

## 2026-06-26 — Session-close concept documented as portable specification (CC-043)
Following CC-030's pattern: chalo's obligation already lives portably
in OPERATING_CONTRACT.md Rule 8, but its implementation
(.claude/skills/chalo/) is Claude-Code-specific. Added a
mechanism-agnostic specification to FRAMEWORK.md so a future agent has
a real blueprint to rebuild this behavior.

## 2026-06-26 — STATUS.md created with refresh rule (CC-037+038)
Created STATUS.md as a current-state-only snapshot, separate from
EVOLUTION_LOG.md's history. Added a rule to Rule 8: STATUS.md refreshes
at session-end, Claude Code's job without being asked. Pointed to from
CLAUDE.md and AGENTS.md.

## 2026-06-26 — Vercel plugin scoped out of this project (CC-036)
User confirmed the globally-enabled Vercel plugin (CC-024/CC-025 finding)
belongs to a different project (playbook/), not SYSTEM_DESIGN_OS — it
was costing ~3% of context budget every session for 22 unused skill
descriptions, surfaced by /doctor's Skills warning. Disabled at the
project level via .claude/settings.local.json rather than globally,
since it may be needed elsewhere. settings.local.json is gitignored,
not committed.

## 2026-06-26 — Fixed settings.json hooks schema error (CC-035)
Claude Code's own settings error revealed every prior hook prompt
(CC-027, CC-031, CC-034) had written an incorrect JSON shape —
{"matcher": ..., "command": ...} directly, when the actual schema
requires the command nested inside a "hooks" array per matcher entry.
This was confirmed correct in earlier research pulled for CC-027 but
not applied consistently when writing the actual prompts — a real
process failure, caught only because Claude Code's settings validator
surfaced the error directly rather than silently failing. Rewrote
settings.json with the correct nested schema, validated as syntactically
correct JSON before committing.

## 2026-06-26 — Simplified using official CLAUDE_PROJECT_DIR, replacing CC-033's manual walk-up (CC-034)
User correctly questioned CC-033's approach: re-deriving the project
root via a manual walk-up loop duplicates logic Claude Code's own
runtime already performs, and could diverge from it. Confirmed Claude
Code exposes CLAUDE_PROJECT_DIR directly to all hooks. Replaced the
walk-up loop with a direct read of this variable, with a fallback to
$(pwd) and an explicit warning if unset (a documented edge case on some
versions/platforms). Simpler and consistent with Claude Code's own
mechanism rather than a second independent guess at it.

## 2026-06-26 — RULES.md populated with proven patterns (CC-032)
RULES.md had been deliberately left empty pending a real domain to
generalize from. User correctly questioned whether that was still right
given two real patterns already exist: domain creation via
DOMAINS/_TEMPLATE/ (proven in CC-014) and stage numbering in increments
of 10 (specified in CC-023). Populated RULES.md with both, restating
what's already real elsewhere rather than inventing new content, plus
an explicit "what's still missing" section naming the patterns that
genuinely don't have a real case yet (skill extraction, cross-domain
brain references) — kept honestly absent rather than speculatively
filled in.

## 2026-06-26 — SessionStart verification hook added (CC-031)
User asked how to enforce that the right CLAUDE.md is read. Distinguished
two separate questions: whether CLAUDE.md loads at all (already
guaranteed by Claude Code's own startup behavior, not something this
project needs to enforce) versus whether the CORRECT file (this
project's, not a stale or different one) loaded — which is genuinely
checkable mechanically. Added verify-claude-md.sh as a SessionStart
hook: checks for the sync-marker comment from CC-028, warns if missing
or wrong. Honest limit stated: this confirms the right FILE loaded, not
that its CONTENT gets followed — that remains unenforceable by any
hook, same as the rest of the judgment-based rules.

## 2026-06-26 — Guardrail concept documented as portable specification (CC-030)
CC-029 documented that the hook IMPLEMENTATION isn't portable. This
entry closes the related but separate gap: the CONCEPT wasn't documented
anywhere either, meaning a future agent (e.g. Kimi) would have no
starting point to rebuild equivalent protection in its own mechanism.
Added a tool-agnostic specification to FRAMEWORK.md: trigger condition,
check performed, action on match/no-match, and the known geography-vs-
process limitation — all stated independent of Claude Code's specific
hook syntax, so the concept itself transfers even though the
implementation doesn't.

## 2026-06-26 — Limitation recorded: .claude/ hooks are NOT agent-agnostic (CC-029)
CC-028 made the entry-point instructions (CLAUDE.md/AGENTS.md) and all
WORKSPACE/ content agent-agnostic, since they're plain text any agent
can read. The .claude/ folder (settings.json, hooks/ingest-guard.sh) is
different in kind, not just in name — it's executable configuration
specific to Claude Code's runtime (hook trigger syntax, matcher format,
settings schema). Renaming the folder would not make it portable, since
the content itself only runs under Claude Code. Confirmed against
Codex's actual equivalent (.codex/config.toml, separate hook/skill
mechanisms entirely) — there is no shared format to adopt here.

Honest current state: the mechanical guardrail built in CC-027
(ingest-guard.sh) only protects sessions running under Claude Code. A
session using Codex or another agent on this same project would have
no equivalent mechanical block — only the text-based rules in
WORKSPACE/, which carry the same risk already documented in CC-026 (a
rule can be skipped under pressure to appear helpful; a hook cannot).
If this system is ever used with a different agent, the guardrail layer
specifically would need to be rebuilt for that agent's own mechanism —
not just copied or renamed.

## 2026-06-26 — AGENTS.md added, system now agent-agnostic at entry point (CC-028)
CLAUDE.md alone meant only Claude Code would auto-discover this
system's instructions — Codex reads AGENTS.md instead, a different
filename by convention. Since the whole point of building on plain
markdown was transferability across any agent, having a Claude-only
entry point contradicted that goal. Added AGENTS.md as an exact mirror
of CLAUDE.md's content, with a one-line note in each pointing to the
other. Added a clarification to Rule 8: the two files must be kept in
sync as a real maintenance obligation, not a one-time fix.

## 2026-06-26 — First real guardrail (hook) added (CC-027)
User correctly pushed back: rules alone (text the model reads) can be
skipped under pressure to appear helpful, as already demonstrated with
OPERATING_CONTRACT.md test failures. A hook is categorically different
— a shell script that runs automatically and cannot be skipped by model
judgment, per the claude-os-guide.pdf source's own framing: "CLAUDE.md
is a suggestion. Hooks are law." Built ingest-guard.sh as the first real
guardrail: blocks writes into DOMAINS/, SYSTEM_BRAIN/, or
SYSTEM_SOURCES/ (excluding _TEMPLATE/) and surfaces a warning. Honest
limitation: this hook can detect WHERE a write is happening but cannot
verify a genuine routing decision occurred first — it's a blunt
instrument, not a complete solution, and still relies on logging
(Rule 8) as the after-the-fact check.

## 2026-06-26 — CC-023 Part B: self-discovery test passed, residual risk identified (CC-026)
Ran the actual test of whether CLAUDE.md alone (no detailed prompt) gets
Claude Code to correctly find and follow INGEST.md from a vague
instruction ("I have a new file I want to ingest"). Result: passed —
CLAUDE.md's trigger correctly led to reading INGEST.md, which correctly
identified the request as the ambiguous case under Step 0 and would have
asked for routing clarification rather than guessing. This confirms
self-discovery works: a cold session can find and attempt to follow the
protocol without being told where to look.

Residual risk identified, not yet solved: Step 0 explicitly says "do not
guess" when routing is ambiguous, but this instruction competes against
a model's tendency to proceed helpfully rather than pause and ask. This
is the same category of failure documented in OPERATING_CONTRACT.md's
own test history (job-board/course scenarios) — a correctly written rule
can still lose to model behavior under pressure. Not a flaw in INGEST.md
specifically; a structural limit of rule-following systems generally.
No fix applied yet — recorded as a known, named risk rather than left
undiscovered.

## 2026-06-26 — Correction to CC-019's log entry (CC-022)
CC-019's log entry stated OPERATING_CONTRACT.md was "one line under the
200-line hard limit from the claude-os-guide.pdf source." This was
wrong: the 200-line guideline in that source applies specifically to
CLAUDE.md (the file Claude Code auto-loads every session, where context
budget is the stated reason for the limit). OPERATING_CONTRACT.md and
the rest of WORKSPACE/ are not auto-loaded every session and have no
applicable line limit. Caught by Claude Code's own report on CC-021,
which flagged the misapplied limit before it could carry forward as an
assumption. CC-019's original entry is left unedited, since it
accurately records what was stated at that time — this entry corrects
the claim going forward rather than rewriting history.

## 2026-06-26 — CLAUDE.md hierarchy rule added to Rule 6 (CC-021)
CC-020 confirmed no parent CLAUDE.md exists above SYSTEM_DESIGN_OS/ —
~/Projects/ holds 13+ unrelated projects, several with their own scoped
CLAUDE.md, none shared. User asked whether a rule should govern where
CLAUDE.md is created and whether conflict-checking should be standing
practice. Added guidance to Rule 6: don't create a parent-level
CLAUDE.md casually given the wide blast radius across unrelated projects
and Anthropic's own unresolved precedence ambiguity on conflicts; if one
is ever introduced, treat CC-020's verification method as the standing
check, not a one-time fix. Committed as 442c30b.

## 2026-06-26 — Git commit established as explicit step (CC-019)
User asked whether git commits should be implicit. Checked actual repo state: repo already existed with 2 clean commits (9e0dac8 initial build, 3271488 .gitignore cleanup) — not a fresh init, no uncommitted changes. No new commit was needed. Added a clarification to Rule 9 of OPERATING_CONTRACT.md: structural changes from a CC-XXX prompt must be committed, and the report-back must state whether a commit happened, same as it states whether a log entry was written. OPERATING_CONTRACT.md is now 199 lines — one line under the 200-line hard limit from the claude-os-guide.pdf source.

## 2026-06-26 — SYSTEM_DESIGN_OS initialized; RAW/ and WORKSPACE/ folders created; SYSTEM.md drafted as master file

## 2026-06-26 — INGEST.md created in WORKSPACE/ after two overclaim failures: a page count stated without re-checking the file (said 9 pages, actual 21), and an image described from metadata without the content rendering — anti-overclaim rule added as core protocol rule

## 2026-06-26 — OPERATING_CONTRACT.md created in WORKSPACE/ to govern how Claude and Sachin work together; v1 built from real failures, not upfront design

## 2026-06-26 — SYSTEM.md split into separate files: FRAMEWORK.md, DECISIONS.md, REASONING.md, RULES.md, EVOLUTION_LOG.md; SYSTEM.md rewritten as index pointer

## 2026-06-26 — OPERATING_CONTRACT.md extended: sections 6, 7, 8 added covering sandbox-vs-real-filesystem distinction, don't-assume-topic rule, and auto-logging of decisions without user prompt; each added in the same pass as the decision to add it (per Rule 8)

## 2026-06-26 — CLAUDE.md created at project root (CC-018)
A real gap surfaced: no CLAUDE.md existed, meaning nothing built this session (OPERATING_CONTRACT.md, INGEST.md, the brain structure) was actually auto-loaded by Claude Code at session start — it all required manual pointing every time, which defeats the goal of not having to repeat instructions. Created CLAUDE.md under 200 lines, per the claude-os-guide.pdf source's own hard rule, as a pointer to OPERATING_CONTRACT.md and INGEST.md plus a structural map, not a content dump.

## 2026-06-26 — INGEST.md: Step 0 routing added (CC-017)
User asked directly whether the file fully explained the process for a new resource arriving. Gap found: Steps 1-6 cover verification and reconciliation once a resource's destination is known, but nothing explicitly covered HOW to decide that destination — system-level (WORKSPACE/SYSTEM_SOURCES/ + SYSTEM_BRAIN/) versus domain-specific (DOMAINS/[name]/RAW/ + that domain's BRAIN/). Added Step 0, run before Step 1, requiring an explicit decision (or an explicit flag of ambiguity rather than a guess) before any verification work begins.

## 2026-06-26 — INGEST.md: reconciliation step added (CC-016)
Recognized that verifying a source was read (the existing protocol) is not the same as integrating it correctly into a brain. Added Step 6: after ingestion, the new source must be explicitly checked against existing brain content and marked as extending, conflicting with, or being genuinely new relative to what's there — never silently appended. Applies to any brain, system or domain-specific, not just the one currently being built.

## 2026-06-26 — SYSTEM_BRAIN/ created from system-design sources (CC-015)
Distinguished two kinds of brain that had been conflated: a domain brain (business-specific knowledge, lives under DOMAINS/[name]/BRAIN/) versus the system's own brain (knowledge about how to build/run this system itself, from the 4 original sources ingested at the start of this session). Created WORKSPACE/SYSTEM_BRAIN/ with real ingestion records for all 4 sources — re-verifying claims rather than trusting earlier session statements per Rule 1 and INGEST.md. ICM paper confirmed 21 pages (not 9 as was incorrectly stated earlier). Concept pages for LLM Wiki, ICM, and .claude/ pattern created. Synthesis and index written. Full tree: 4 sources, 3 concepts, 1 synthesis, 1 index.

## 2026-06-26 — Domain template created at DOMAINS/_TEMPLATE/ (CC-014)
CC-011 and CC-012 (create WIKI/, rename to BRAIN/ with subdivisions) had never actually run in this environment — discovered via CC-013's report flagging BRAIN/ as absent. Rather than recreate them at the old, incorrect top-level location, built the corrected version directly: a reusable _TEMPLATE/ under DOMAINS/, containing RAW/ and BRAIN/ (with entities/concepts/synthesis/sources subdivision) plus a README explaining how to instantiate a real domain from it. No live domain exists yet — this is intentionally a template, ready to be copied the moment a real domain is named.

## 2026-06-26 — Structural correction: RAW/ and BRAIN/ moved out of top level (CC-013)
User caught a real design flaw: a single shared RAW/ and BRAIN/ at the SYSTEM_DESIGN_OS root would mix sources and knowledge across unrelated business domains (trading, real estate, etc.), defeating the domain separation BRAIN/ was just subdivided for in CC-012. Corrected structure: each future domain gets its own RAW/ and BRAIN/ under SYSTEM_DESIGN_OS/DOMAINS/[domain-name]/ — fully self-contained, copyable, independently inspectable, consistent with ICM's horizontal-expansion principle from the original framework discussion. The four sources that were in the old top-level RAW/ (LLM_Wiki.md, ICM paper, claude-os-guide PDF, anatomy screenshot) are sources ABOUT the system's own design, not about any business domain — moved to WORKSPACE/SYSTEM_SOURCES/, which stays shared since the contract and protocols genuinely apply across all domains. No domain folder created yet, since none has been named. Note: BRAIN/ did not exist at top level in this environment — CC-012 had not been applied here; no removal was needed.

## 2026-06-26 — ICM stage numbering convention added to FRAMEWORK.md (CC-023)
Workflow stages use increments of 10 (10_RESEARCH/, 20_FILTER/, 30_WRITE/) rather than sequential integers, so a new stage can be inserted between two existing ones without renumbering every folder. No stages exist yet — the convention is written now so the first domain that creates a workflow doesn't have to invent it. Added as a subsection under ## 2. ICM in FRAMEWORK.md.

## 2026-06-26 — Confirmed: MCP tool access is global, not project-scoped (CC-025)
CC-024 confirmed neither Gmail/Drive/Calendar nor Vercel MCP access is defined in any SYSTEM_DESIGN_OS or ~/Projects-level .mcp.json — no such file exists. Gmail/Drive/Calendar come from Anthropic's own account-level OAuth integration (~/.claude/.credentials.json). Vercel comes from a globally-enabled Claude Code plugin (~/.claude/settings.json → enabledPlugins). Both are available in every Claude Code session on this machine, across all ~14 projects under ~/Projects/, not isolated to this project. This is expected, intentional platform behavior, not a defect — recorded here so a future session doesn't assume tool access is project-scoped when reasoning about what's available in a given domain. If a domain ever needs an isolated, project-specific MCP server, that would require creating SYSTEM_DESIGN_OS/.mcp.json explicitly.

## 2026-06-26 — FRAMEWORK.md filled with real content (CC-010)
FRAMEWORK.md had remained a 17-line placeholder since the original SYSTEM.md split — a real gap, since the actual synthesis (what LLM Wiki, ICM, and markdown are each for, and why each was chosen over alternatives) had only ever existed in chat history. User explicitly asked where this reasoning should be recorded so it doesn't need re-explaining if momentum drifts in the future. CC-010 writes the real content: purpose, mechanism, and reasoning for each of the three pillars, plus how they connect, plus a cross-reference to the division-of-labor foundational statement in OPERATING_CONTRACT.md.

## 2026-06-26 — Foundational Statement added to OPERATING_CONTRACT.md (CC-009)
User clarified the actual end goal: multiple autonomous, agent-driven businesses, with this system as the reusable backbone, not infrastructure for its own sake. That requires an explicit division of labor — user owns vision and real-world testing, Claude owns knowledge synthesis in conversation, Claude Code/any filesystem-access LLM owns documentation and execution — stated as a foundational premise before the numbered rules, since the rules exist to protect this division under real work, not to replace it. Names the specific failure modes for each protocol: poor knowledge-accumulation guidance causes agents to act on too little or too much information; a poorly laid spine causes misrouted agents and skills that can't stand independently.

## 2026-06-26 — Operating Contract development paused (CC-007)
After two rounds of synthetic testing showed real, measurable improvement in Claude's compliance (stance-first restructure fixed Rule 2 and Rule 4 across both test runs), development on OPERATING_CONTRACT.md is deliberately paused. Logged as a real decision, not a test artifact — see DECISIONS.md D001. Project moves to real work next; the contract is revisited only on its first real failure, not preemptively.

## 2026-06-26 — Rule 8 and Rule 1 sharpened (CC-006)
Second test run (self-paced course scenario, also fictional) showed real improvement on Rules 2 and 4 — both clean passes, confirming the stance-first restructure from the prior session actually changed output, not just the document. Two remaining gaps closed: Rule 8's filesystem-unavailable subsection didn't say producing the inline draft + CC-XXX prompt was unconditional, so Claude gated it behind asking permission — fixed by stating explicitly that production is not contingent on user confirmation. Rule 1 had no language covering confidently-phrased common-knowledge claims ("completion rates are notoriously low") stated without flagging them as unverified — fixed by adding an explicit example and stating that a claim doesn't need to be wrong to be an overclaim.

## 2026-06-26 — Rule 8 and Rule 2 clarified, not extended (CC-005)
A test task (niche job board, fictional — not a real project decision) surfaced two real gaps. Rule 8: Claude reached a real recommendation in chat but never drafted a DECISIONS.md entry, partly because the rule never specified what compliance looks like without filesystem access. Fixed by adding a subsection to Rule 8 itself: produce the entry inline plus a CC-XXX prompt, rather than deferring with no output. Rule 2: the response followed correct order but never declared it, leaving sequence to be inferred from structure. Fixed by adding a line to Rule 2 stating that implicit-but-correct order still counts as a miss. Both fixes are clarifications inside existing rules, not new rules — deliberately, to avoid the same over-addition pattern that produced 9 rules without first confirming rules 1-9 were being followed.

## 2026-06-26 — Rule 8 extended with decision-worthiness criteria (CC-003)
A sanity check (CC-002) found that Rule 8 referenced decision-worthiness criteria that were never actually written into the file — a prompt to add them had been issued but not applied, and a later log entry cited them as if they existed. CC-003 added the missing criteria directly into Rule 8's section: what counts as a decision, what doesn't, and required fields for DECISIONS.md and EVOLUTION_LOG.md entries.

## 2026-06-26 — OPERATING_CONTRACT.md Rule 9 added (CC-001)
User caught two gaps: Claude Code prompts had no ID, so a report-back couldn't be matched to its request when multiple prompts were sent close together; and Rule 8 never specified that Claude Code itself — not just Claude in chat — is responsible for writing the log entry at the moment a change is made. Rule 9 adds prompt IDs and makes logging a required part of every Claude Code prompt's own instructions, executed by Claude Code in the same pass as the change. This log entry written by Claude Code in the same pass as the Rule 9 edit, per CC-001.

## 2026-06-27 — Self-observation: pattern recognized but not proactively escalated (CC-045)
Between CC-030 and CC-043, the same shape of problem repeated. Claude
recognized the pattern by CC-043 but did not proactively propose a
standing rule until asked. Logged as an honest finding — the existing
rules already covered this; the failure was in applying them
proactively, not reactively. Worth noting: this same gap recurred a
second time — CC-044/045/047 themselves sat unrun for multiple turns
without either party noticing until CC-049 forced the discovery.
"Drafted but not confirmed executed" is now itself a recognized
recurring risk.

## 2026-06-27 — CC-044, 045, 047 actually completed (CC-051)
Combined and executed in one sequential pass: standing rule added,
self-observation logged, FRAMEWORK.md's false claim corrected, chalo
built and tested for real.

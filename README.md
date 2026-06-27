# SYSTEM_DESIGN_OS

A reusable foundation for building autonomous, agent-driven businesses
— knowledge accumulates in domain-specific "brains," workflows are
documented as repeatable stages, and everything that matters is plain
markdown so it's transferable to any agent, any person, any future
version of yourself who's forgotten the details.

The five qualities this is built toward — agent-agnostic, transferable, scalable, self-auditing, ever-learning — and the honest limit of each are stated explicitly in WORKSPACE/FRAMEWORK.md.

**Read WORKSPACE/STATUS.md right now for what's actually open.**

## The foundation this is built on

Four ideas, each borrowed from a real source rather than invented from
scratch — full reasoning lives in WORKSPACE/FRAMEWORK.md.

1. **LLM Wiki (knowledge accumulation)** — a source gets read once and
   woven into a standing, interlinked knowledge base ("brain") rather
   than re-derived every time something's asked. This is what each
   domain's BRAIN/ and WORKSPACE/SYSTEM_BRAIN/ actually are.

2. **ICM — Interpretable Context Methodology (workflow orchestration)**
   — a multi-step process as numbered folders (increments of 10, so a
   stage can be inserted later without renumbering), each holding the
   instructions and context for that stage. This is what DOMAINS/
   workflow stages will be, once a real domain exists.

3. **The spine / scaffold (filesystem as coordination)** — RAW/
   (immutable sources) → BRAIN/ (accumulated knowledge) → workflow
   stages (execution), kept separate per domain. WORKSPACE/ holds
   what's shared across all of it.

4. **Markdown as the portable artifact** — every one of the above is
   plain text — no database, no proprietary format. This is why
   points 1-3 are transferable at all, not just internally consistent.

## How the system is invoked (touched every session)

- Open Claude Code inside this folder. CLAUDE.md / AGENTS.md auto-load
  — no command needed.
- They point you to WORKSPACE/OPERATING_CONTRACT.md (how Claude should
  behave) and WORKSPACE/INGEST.md (how new sources get verified).
- A SessionStart hook silently confirms the right CLAUDE.md loaded —
  you'll only see output if something's wrong.

## How the loop closes (touched at the end of every session)

- Say **"chalo"** when wrapping up. It reviews the session, refreshes
  STATUS.md, confirms EVOLUTION_LOG.md is current, checks for
  unverified claims, and commits everything in one pass.
- Audit runs automatically as chalo's first step — it doesn't need to
  be invoked separately.
- If a session ends without this, the snapshot goes stale until the
  next session catches the drift — depends on remembering to say it.

## What gets touched often

- **DOMAINS/** — once a real domain exists (none do yet), actual work
  happens here.
- **WORKSPACE/STATUS.md** — read first, every session.
- **WORKSPACE/EVOLUTION_LOG.md** — every real decision logged as it
  happens.

## What gets touched rarely (the foundation, mostly stable now)

- **WORKSPACE/OPERATING_CONTRACT.md** — behavioral rules, tested.
- **WORKSPACE/INGEST.md** — the verification protocol.
- **WORKSPACE/FRAMEWORK.md** — why the system is built this way.
- **WORKSPACE/DECISIONS.md** — locked decisions with status and reasoning trigger.
- **WORKSPACE/REASONING.md** — the why behind each locked decision.
- **WORKSPACE/RULES.md** — proven expansion patterns (horizontal/vertical/scaling).
- **WORKSPACE/PATTERNS.md** — recurring failure patterns that audit checks against
  first. The closest thing this system has to learning from its own mistakes
  across builds.
- **WORKSPACE/SYSTEM_BRAIN/** — knowledge about the system itself.
- **WORKSPACE/SYSTEM_SOURCES/** — the raw, original documents (LLM Wiki
  notes, the ICM paper, a CLAUDE.md guide, a screenshot) that
  SYSTEM_BRAIN/ was built FROM. Kept separate and untouched, per
  INGEST.md's own rule that sources are immutable.
- **DOMAINS/_TEMPLATE/** — copy and rename to start a real domain.
- **.claude/** — Claude-Code-specific machinery, not portable by
  itself — see FRAMEWORK.md's mechanism-agnostic specs to rebuild
  under another agent.

## The one thing this is waiting on

No real business domain exists yet. Everything above is built and
tested, ready the moment one does.

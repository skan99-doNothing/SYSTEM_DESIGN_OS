# SYSTEM_DESIGN_OS

A reusable foundation for building autonomous, agent-driven businesses
— knowledge accumulates in domain-specific "brains," workflows are
documented as repeatable stages, and everything that matters is plain
markdown so it's transferable to any agent, any person, any future
version of yourself who's forgotten the details.

**Read WORKSPACE/STATUS.md right now for what's actually open.**

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
- **WORKSPACE/SYSTEM_BRAIN/** — knowledge about the system itself.
- **DOMAINS/_TEMPLATE/** — copy and rename to start a real domain.
- **.claude/** — Claude-Code-specific machinery, not portable by
  itself — see FRAMEWORK.md's mechanism-agnostic specs to rebuild
  under another agent.

## The one thing this is waiting on

No real business domain exists yet. Everything above is built and
tested, ready the moment one does.

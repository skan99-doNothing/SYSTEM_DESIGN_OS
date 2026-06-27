# Synthesis: How the Three Pillars Connect

**Sources:** LLM Wiki.md, ICM paper, claude-os-guide.pdf, anatomy.jpg
**Cross-reference:** FRAMEWORK.md

## The connective layer

LLM Wiki is the *what agents know* layer.
ICM is the *what agents do* layer.
Markdown is the substance both are written in — and it's what makes either layer transferable at all.

Without a shared plain-text format, the wiki and the workflow stages would each need their own tooling, and the transferability goal would be true in theory but not in practice.

## How they relate to each other

**LLM Wiki depends on the schema pattern (CLAUDE.md / INGEST.md).**
The LLM Wiki paper's three-layer model names "the schema" as the config document telling the LLM how the wiki is structured. In this system, OPERATING_CONTRACT.md and INGEST.md serve that role — loaded every session to set the working rules for the LLM maintaining the brain.

**ICM depends on markdown.**
ICM's filesystem coordination only works because the prompts, context, and outputs at each stage are plain text files. Change the format to a database or binary and the "copy the folder to hand it off" advantage disappears immediately.

**The .claude/ pattern is the deployment layer for both.**
Skills (reusable /name-invoked workflows) are how ICM stages get operationalized in Claude Code. CLAUDE.md is where the schema lives in a Claude Code project. Hooks ensure protocol steps fire unconditionally, not optionally.

## The division of labor (from OPERATING_CONTRACT.md)

- User owns vision and real-world testing
- Claude (in conversation) owns knowledge synthesis — the LLM Wiki layer
- Claude Code / any filesystem-access LLM owns documentation and execution — the ICM layer, the .claude/ configuration, the brain maintenance

## The goal this serves

These three pillars together are not infrastructure for their own sake. They exist to reduce human-in-the-loop dependency over time: as knowledge accumulates in domain BRAINs and ICM stages encode proven workflows, an agent can act on them with progressively less relay work from the user. The failure mode being prevented: the user permanently acts as the transport layer between Claude in chat and Claude Code on the filesystem, which defeats the autonomy goal entirely.

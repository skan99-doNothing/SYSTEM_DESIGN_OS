# Concept: ICM — Workflow Orchestration via Filesystem

**Source:** Interpretable Context Methodology.pdf (INGESTED 2026-06-26)
**Also referenced in:** FRAMEWORK.md § 2

## What it is

Interpretable Context Methodology (ICM) — a method for orchestrating multi-step AI agent workflows using folder structure and markdown files instead of a code-level framework. Developed by Jake Van Clief and David McDermott (Eduba / University of Edinburgh), arXiv:2603.16021v2, MIT license.

## Core claim

For sequential, human-reviewed workflows, multi-agent frameworks (CrewAI, LangChain, AutoGen) introduce engineering overhead the problem does not require. The filesystem itself is sufficient as the coordination spine.

## Mechanism

- **Numbered folders = stages.** Each folder holds the prompt, context, and expected output for that stage — all plain markdown.
- **One agent, not many.** A single orchestrating agent reads the folder it's in, knows its job, writes output. Next stage reads that output.
- **Local scripts for mechanical work.** Fetching data, moving files, formatting — anything that doesn't need AI runs as a local script.
- **Changing the workflow = editing the filesystem.** Rename or reorder folders to change stage order. Add or delete a folder to add or remove a stage. No code changes, no redeployment.

## Where ICM wins over frameworks (Table 1, paper)

- Change stage order: rename folders vs edit orchestration code and redeploy
- Modify a prompt: edit markdown file vs edit agent configuration in code
- Add/remove stage: add/delete folder vs write new agent class
- Inspect state: open the folder vs add logging infrastructure
- Hand off to a person: copy the folder vs document environment and dependencies
- Who can make changes: anyone with a text editor vs a developer

## Where frameworks win over ICM

- Error recovery: manual re-run of failed stage vs built-in retry/fallback
- Conditional branching: human decides between stages vs programmatic routing
- Concurrent execution: sequential by design vs native parallelism
- External service integration: local scripts/MCP vs programmatic API management

## In this system

ICM governs how domain workflows are structured. Workflow stages (numbered folders with markdown prompts and context) get added to a domain's folder once the domain's actual process is understood from real work — not designed upfront. This is consistent with the paper's own recommendation: start with the filesystem structure, let the workflow emerge from practice.

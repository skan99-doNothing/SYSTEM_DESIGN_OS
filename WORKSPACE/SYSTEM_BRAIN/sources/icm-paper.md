# INGEST RECORD: Interpretable Context Methodology.pdf

- **Status:** INGESTED
- **Method:** pdfinfo (page count) + pdftotext (text extraction)
- **Verification artifacts:**
  1. "Interpretable Context Methodology: Folder Structure as Agentic Architecture" — full title confirmed via pdfinfo
  2. Authors: Jake Van Clief, David McDermott, Eduba, University of Edinburgh
  3. 21 pages confirmed via pdfinfo (NOT 9 — the earlier session overclaim is explicitly corrected here per Rule 1 and INGEST.md)
  4. Keywords extracted: "context engineering, human-AI interaction, AI agent orchestration, filesystem architecture, human-in-the-loop, mixed-initiative systems, workflow automation"
  5. Key phrase from abstract: "Numbered folders represent stages. Plain markdown files carry the prompts and context that tell a single AI agent what role to play at each step."
- **What was actually gotten from this source:** Abstract, introduction, and Table 1 (comparison of ICM vs framework approaches across 10 dimensions). Full paper content available via pdftotext.
- **What could NOT be verified or read:** Sections 2-6 not extracted in this pass (cut off at page ~3 of text). Core methodology is captured; deeper implementation details and future directions sections not yet synthesized.
- **Date:** 2026-06-26

## Key content

**Core claim:** For sequential, human-reviewed workflows, multi-agent frameworks (CrewAI, LangChain, AutoGen) introduce engineering overhead the problem does not require. ICM replaces framework-level orchestration with filesystem structure.

**Mechanism:**
- Numbered folders = stages
- Each folder holds the prompt, context, and expected output as plain markdown
- One agent reads the right folder at the right moment
- Local scripts handle mechanical work (fetching data, moving files, formatting) that needs no AI
- Changing the workflow = rename/add/delete folders, not code changes

**Table 1 — ICM advantages over frameworks (for sequential workflows):**
- Change stage order: rename/reorder folders vs edit orchestration code and redeploy
- Modify a prompt: edit a markdown file vs edit agent configuration in code
- Add/remove a stage: add/delete a folder vs write new agent class, update orchestrator
- Inspect intermediate state: open the folder, read the files vs add logging, build dashboard
- Hand off to another person: copy the folder vs document environment, dependencies, setup
- Who can make changes: anyone with a text editor vs developer

**Table 1 — Framework advantages ICM lacks:**
- Error recovery mid-pipeline: manual re-run vs built-in retry/fallback/exception handling
- Conditional branching: human decides between stages vs programmatic routing
- Concurrent execution: sequential by design vs native parallel coordination
- External service integration: local scripts or MCP vs programmatic API calls

**Intellectual lineage cited:** Unix pipeline design (1970s), multi-pass compilers (1980s), literate programming — applied to AI agent orchestration.

**Open source:** MIT license, GitHub: github.com/RinDig/Interpretable-Context-Methodology-ICM

---

## Re-verification pass — 2026-06-28 (CC-140)

- **Method:** Direct re-read of SYSTEM_SOURCES/Interpretable Context Methodology.pdf (pdftotext). Full paper read — Sections 2–6 now captured, not just abstract and Table 1.
- **Status:** CONFIRMED INGESTED. Significant additional content now captured that was in the source but missed in the original partial extraction.

**Graded confidence artifacts (re-run, additions noted):**
1. "Numbered folders represent stages. Plain markdown files carry the prompts and context" (abstract) — **1.0**
2. Authors: Jake Van Clief, David McDermott; Eduba / University of Edinburgh; arXiv:2603.16021v2 — **1.0**
3. Table 1 — 10-dimension comparison of ICM vs frameworks — **1.0**
4. Five-layer context hierarchy (Section 3.2): Layer 0 CLAUDE.md (~800 tokens), Layer 1 CONTEXT.md routing, Layer 2 stage CONTEXT.md, Layer 3 reference material (factory/stable), Layer 4 working artifacts (product/per-run) — **1.0** (not in original record)
5. Stage contracts (Section 3.3): each stage CONTEXT.md has Inputs / Process / Outputs — **1.0** (not in original record)
6. "Configure the factory, not the product" design principle — **1.0** (not in original record)
7. Figure 2 stage numbering: 01_research/, 02_script/, 03_production/ — sequential integers, not increment-of-10 — **1.0** (not in original record; confirms increment-of-10 in this system is an extension, as documented in FRAMEWORK.md § 2)
8. Karpathy cited (Section 2.2) on "context engineering" (June 2025) — **0.7** (from extracted text; not a separately confirmed verbatim quote in this pass)

**Concept page update (done in this pass):** icm-workflow-orchestration.md now includes the five-layer hierarchy, stage contracts, Layer 3/4 distinction, "configure the factory, not the product," and the stage-numbering extension note. All additions sourced directly from artifacts above.

**Finding:** Original ingestion accurate for what was extracted. Concept page was thinner than the source — corrected in this re-verification pass.

# ARTIFACTS/ — Generated, Human-Facing Outputs

Distinct from SYSTEM_BRAIN/ (synthesized knowledge) and
SYSTEM_SOURCES/ (raw documents this system was built from). This
folder holds things RENDERED from existing knowledge for human
consumption — visual diagrams, exported summaries — not new
knowledge in their own right. An artifact here should never be
ingested back into SYSTEM_BRAIN/ as if it were a new source; it
already represents knowledge the brain has, just in a different
format.

## Regeneration policy

Not tied to every README.md edit — that would mean rebuilding an
expensive visual for trivial wording fixes. Not on a fixed calendar
either — checking on a schedule means checking even when nothing
changed. Instead: audit checks, every run, whether README.md has
diverged meaningfully from what's described here (new sections, new
skills/hooks not reflected, structural changes) and flags it as
JUDGMENT-REQUIRED if so — a human decides whether the divergence is
big enough to warrant regenerating, not a mechanical trigger.

## Current artifacts

- **SYSTEM_DESIGN_OS_full_visual.pdf** — 5-page visual map (overview,
  WORKSPACE/ detail, skills detail, hooks detail, DNA/close), built
  directly from README.md's content. Generated 2026-06-27.
  Superseded versions get deleted, not archived — this folder holds
  only the current, accurate rendering, the same principle STATUS.md
  applies to itself.

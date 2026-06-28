# Domain Template

This is a template, not a live domain. To create a real domain:

1. Copy this entire _TEMPLATE folder, rename it to the real domain name
   (e.g. trading-systems, real-estate-landing-pages)
2. Replace [DOMAIN NAME] in BRAIN/index.md and BRAIN/log.md with the
   real name
3. Drop immutable source files into the new domain's RAW/
4. Run /ingest (per WORKSPACE/INGEST.md) against each source — this
   builds out BRAIN/ for real, populating entities/concepts/synthesis/
   sources/dialogue as content is actually processed
5. Workflow stages (ICM-style numbered folders) get added at the domain
   root once the domain's actual process is understood from real work,
   not designed upfront. When building real workflow stages (e.g.
   10_discovery/, 20_planning/), copy STAGE_TEMPLATE/CONTEXT.md into
   each stage folder and fill it in — this is the structured contract
   ICM specifies (Inputs / Process / Outputs), not optional
   documentation. A stage without a filled-in CONTEXT.md is not
   self-documenting and cannot be handed off cold.

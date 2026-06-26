# DECISIONS.md — Decision Log

## Summary Table

| ID | Title | Status | Date |
|----|-------|--------|------|
| D001 | Pause active development on OPERATING_CONTRACT.md | LOCKED | 2026-06-26 |

---

## D001: Pause active development on OPERATING_CONTRACT.md
- **What:** Pause active development on OPERATING_CONTRACT.md at its current state (9 rules, clarifications applied through CC-006). Stop iterating against synthetic test scenarios; move to real project work.
- **Why:** Two real test runs (fictional job-board and course scenarios) showed a targeted fix — leading responses with a stance before reasoning — produced measurable, predicted improvement on two rules that had previously failed. That's sufficient evidence the contract can shape output, not sufficient evidence it's complete. Continued refinement against invented scenarios has diminishing signal and risks repeating the over-engineering pattern this session already caught itself doing once (the original SYSTEM.md dump).
- **Triggered by:** User directly asking "are we doing well," surfacing that several hours had been spent on contract infrastructure with zero progress on the original goal (choosing a first real business domain).
- **Status:** LOCKED
- **Re-open trigger:** The first time the contract is found to fail (a Rule 1-9 violation) on a real decision, not a constructed test. Not a schedule, not a vibe — the first real failure, whenever it happens.
- **Date:** 2026-06-26

---
name: debug
description: Diagnose bugs with a tight feedback loop before theorising. Use when something is broken, throwing, failing, flaky, or slow, or when the user asks to debug or diagnose.
disable-model-invocation: true
---

# Debug

A discipline for hard bugs. The core move is a **tight loop** that goes red on *this* bug. Without that loop, do not theorise.

For any human-facing write-up of the bug, fix, or follow-up comment, follow [tone-of-voice](../tone-of-voice/SKILL.md).

## Phase 1 — Build a tight loop

Spend the most effort here.

Find **one command** you can run that exercises the failing path and asserts the user's exact symptom. Prefer, in order:

1. Failing test at the nearest seam
2. HTTP/script against a running server
3. CLI with a fixture input
4. Headless UI script (Playwright / similar)
5. Replay of a captured request/trace
6. Throwaway harness around the code path
7. Bisect harness between two known states

Then tighten it: faster, sharper assertion, more deterministic.

### Completion criterion

Phase 1 is done only when you have **already run** a command that is:

- **Red-capable** — catches this specific symptom, not merely "didn't crash"
- **Deterministic** (or flaky at a high enough rate to debug)
- **Fast** — seconds when possible
- **Agent-runnable** without babysitting

If you cannot build a loop, stop. List what you tried and ask for access, artifacts, or permission for temporary instrumentation. Do not proceed to hypotheses without a loop.

## Phase 2 — Reproduce and minimise

Run the loop. Confirm it matches the user's failure mode.

Then shrink the repro: cut inputs, steps, and dependencies one at a time, re-running after each cut. Keep only what is load-bearing for the red result.

## Phase 3 — Hypothesise

Write **3–5 ranked, falsifiable hypotheses** before testing any:

> If \<X\> is the cause, then \<changing Y\> will make the bug disappear / \<changing Z\> will make it worse.

Show the ranked list to the user briefly, then proceed unless they re-rank.

## Phase 4 — Instrument

Probe one prediction at a time.

Prefer debugger/REPL inspection, then targeted logs. Tag temporary logs with a unique prefix like `[DEBUG-a4f2]` so cleanup is a single grep.

For performance bugs: measure first (timing, profiler, query plan), then bisect. Do not guess from vibes.

## Phase 5 — Fix and lock it in

If there is a correct test seam:

1. Turn the minimised repro into a failing test
2. Watch it fail
3. Apply the smallest fix
4. Watch it pass
5. Re-run the original loop against the user's scenario

If no correct seam exists, fix the bug and record that the architecture blocked a good regression test.

## Phase 6 — Cleanup

Before declaring done:

- [ ] Original loop is green on the user's symptom
- [ ] Regression test passes, or missing seam is documented
- [ ] All `[DEBUG-...]` instrumentation removed
- [ ] Throwaway harnesses deleted or clearly marked
- [ ] Root cause stated in the change summary

## Output

```markdown
## Problem
What broke, in the user's terms.

## Loop
The red-capable command you used.

## Root cause
The hypothesis that survived, with evidence.

## Fix
The smallest change that addresses the cause.

## Verification
- `<command that passed>`
- Not run: `<command>` (`<reason>`)
```

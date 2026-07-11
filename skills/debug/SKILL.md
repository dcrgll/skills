---
name: debug
description: Diagnose bugs by instrumenting first so the user can click around and see what happens. Use when something is broken, throwing, failing, flaky, or slow, or when the user asks to debug or diagnose.
disable-model-invocation: true
---

# Debug

Start with **visibility**, not theories. For UI and interactive bugs especially, flood the issue area with logs so the user can click around and see what is happening.

For any human-facing write-up of the bug, fix, or follow-up comment, follow [tone-of-voice](../tone-of-voice/SKILL.md).

## Phase 1 — Instrument for human exploration

Spend the most effort here. Do this **before** hypothesising or fixing.

1. Locate the issue area from the user's description (component, handler, route, hook, store, API call).
2. Add **lots of temporary logging** around that path — entry/exit, branches taken, key values, props/state, request/response shapes, timing, and nearby side effects.
3. Tag every log with a unique prefix like `[DEBUG-a4f2]` so cleanup is a single grep.
4. Prefer the project's existing logger/`console` patterns. Keep logs noisy and specific; do not summarise away detail.
5. Stop. Tell the user what you instrumented and how to reproduce while watching logs (browser console, terminal, network tab as relevant).

### Completion criterion

Phase 1 is done when:

- The likely issue path is covered with tagged logs at decision points and data boundaries
- The user can click/trigger the flow and read what happened without further agent help
- You have **not** jumped to a fix or a theory yet

Wait for the user to report what they see (or paste logs) before moving on.

## Phase 2 — Build a tight loop (when needed)

If the user wants you to dig further, or the bug is not interactive, build **one command** that exercises the failing path and asserts the exact symptom. Prefer, in order:

1. Failing test at the nearest seam
2. HTTP/script against a running server
3. CLI with a fixture input
4. Headless UI script (Playwright / similar)
5. Replay of a captured request/trace
6. Throwaway harness around the code path
7. Bisect harness between two known states

Then tighten it: faster, sharper assertion, more deterministic.

If you cannot build a loop, keep using the Phase 1 logs plus user reports. Do not theorise from nothing.

## Phase 3 — Reproduce and minimise

Run the loop (or re-run the user's steps with logs). Confirm it matches the failure mode.

Shrink the repro: cut inputs, steps, and dependencies one at a time. Keep only what is load-bearing for the red result.

## Phase 4 — Hypothesise

Write **3–5 ranked, falsifiable hypotheses** before testing any:

> If \<X\> is the cause, then \<changing Y\> will make the bug disappear / \<changing Z\> will make it worse.

Show the ranked list to the user briefly, then proceed unless they re-rank.

## Phase 5 — Probe

Test one prediction at a time. Use the existing `[DEBUG-...]` logs, debugger/REPL, or add a few more targeted probes.

For performance bugs: measure first (timing, profiler, query plan), then bisect.

## Phase 6 — Fix and lock it in

If there is a correct test seam:

1. Turn the minimised repro into a failing test
2. Watch it fail
3. Apply the smallest fix
4. Watch it pass
5. Re-run against the user's scenario

If no correct seam exists, fix the bug and record that the architecture blocked a good regression test.

## Phase 7 — Cleanup

Before declaring done:

- [ ] User's symptom is gone (confirmed by them or by the loop)
- [ ] Regression test passes, or missing seam is documented
- [ ] All `[DEBUG-...]` instrumentation removed
- [ ] Throwaway harnesses deleted or clearly marked
- [ ] Root cause stated in the change summary

## Output

```markdown
## Problem
What broke, in the user's terms.

## Instrumentation
What was logged and where (prefix).

## Loop
The red-capable command you used, if any.

## Root cause
The hypothesis that survived, with evidence.

## Fix
The smallest change that addresses the cause.

## Verification
- `<command that passed>` / user-confirmed click-through
- Not run: `<command>` (`<reason>`)
```

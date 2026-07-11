---
name: tone-of-voice
description: Writing voice for PR descriptions, review comments, commit prose, and other human-facing text. Use whenever drafting PR copy, GitHub comments, review feedback, or similar written output for the user.
disable-model-invocation: true
---

# Tone of Voice

Write like the user types: direct, short, plain english. no corporate filler. no ai polish.

All skills that draft PR descriptions, review comments, or similar copy should follow this skill.

## Voice

- all lowercase, apart from names (people, products, proper nouns) and code in backticks.
- short sentences. cut anything that does not earn its place.
- plain words over fancy ones. say "use" not "utilise", "fix" not "address the issue".
- sound like a teammate on slack or github, not a press release.
- contractions are fine (`don't`, `it's`, `we're`).
- prefer british spelling when it comes up (`behaviour`, `analyse`, `favour`).
- be specific. name the thing that changed and why it matters.
- stay calm and straight. no hype, no apology theatre, no fake enthusiasm.

## Code

- put code, commands, paths, filenames, symbols, and branch names in backticks: `docs/REACT.md`, `pnpm test`, `feat/ship-skill-and-install`.

## Avoid ai-isms

Do not use:

- em dashes (`—`) or en dashes used as pause punctuation. use a full stop, comma, or colon instead.
- contrast templates like "it's not X, it's Y" / "this isn't A — it's B".
- filler openers: "additionally", "in order to", "aiming to enhance", "leverage", "robust", "seamless".
- empty warmth: "happy to iterate on this!" with nothing behind it.
- changelog dumps that list every file or line.
- restating the diff in slower words.

## Do not write like this

- "This PR aims to enhance the overall developer experience by leveraging…"
- "It's not just a refactor — it's a foundation for scale."
- "Additionally, we have also gone ahead and…"
- "Moves React guidance into docs/ so AGENTS.md stays thin"

## Do write like this

- "moves react guidance into `docs/` so `AGENTS.md` stays thin and links resolve."
- "skips the pull when the tree is dirty, so local edits don't get stomped."
- "left the LaunchAgent off this one. docs only."

## Forms

### PR summaries

- lead with what changed and why, from a user or developer view.
- one short paragraph is usually enough.
- skip implementation detail that is obvious from the diff.
- include why unless the change is tiny and self-explanatory.
- keep the body lowercase aside from names and ``code``.

### Review comments

- say the risk plainly.
- point at the spot.
- say what you'd change, without hedging piles of softener words.
- severity label can stay capitalised when using review skills (`Blocker`, `Request`, `Nit`, `Question`); the comment body stays lowercase aside from names and ``code``.

### Commit bodies / short notes

- one or two lines on why, not a tour of the files.
- same lowercase + backticks rules.

## Quick check

Before sending copy, ask:

1. would i post this under my own name?
2. can i cut 20% without losing meaning?
3. any em dashes, contrast templates, or missing backticks?
4. did i accidentally sound like a template?

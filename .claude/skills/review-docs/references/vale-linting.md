# Vale Linting Reference

This project uses Vale for style and spelling checks, enforced in CI by ReviewDog.

## How CI Runs Vale

Read `.github/workflows/Vale-Linter.yml` to understand the CI configuration. The key setting is `filter_mode` — it controls which lines ReviewDog comments on. Check the current value before deciding what to fix.

## Installing Vale

Vale must be installed before you can run linting locally. Install it with one of the following:

```bash
# macOS
brew install vale

# Windows
choco install vale

# Linux (snap)
snap install vale

# Or download the binary from https://vale.sh/docs/install/
```

After installing, run `vale sync` from the repository root to download the style packages configured in `.vale.ini`.

## Running Vale Locally

Run Vale on the files you are reviewing:

```bash
vale path/to/file.md
```

Vale reports three severity levels: **error**, **warning**, and **suggestion**. Focus on errors first — these block the PR.

## Matching CI Behavior

CI only flags issues on lines that were **changed in the PR**. To replicate this locally:

1. Run `vale` on the changed files to get all errors with line numbers
2. Use the process in `pr-changed-files.md` to get the changed line ranges for each file
3. Cross-reference: only errors on changed lines will be flagged in CI

Do not fix errors on unchanged lines unless the user asks you to. Adding unnecessary dictionary words or acronym exceptions creates noise in the diff.

## Fixing Errors

### Spelling errors (`UmbracoDocs.Spelling`)

Vale flags words not in its dictionaries. The custom dictionary is at `.github/styles/config/dictionaries/umbraco.dic`. Read the dictionary configuration in `.vale.ini` and `.github/styles/UmbracoDocs/Spelling.yml` to understand which dictionaries are in use.

Before adding a word to the dictionary, consider:

- **Is it a code identifier?** Wrap it in backticks instead — Vale skips inline code. This includes variable names (`siteId`), function names (`configureEvals`), CLI tools (`cloudflared`, `tsup`), error strings (`invalid_client`), and URL parameters (`redirect_uri`). If it has camelCase, snake_case, or is a tool/runtime name, it belongs in backticks.
- **Is it a function signature in a heading?** Backtick the whole heading: `### \`loadSiteConfig(site, baseConfig)\``
- **Is it a British spelling?** Use the US spelling instead (the dictionary uses `en_US`)
- **Is it a real word that will appear again?** Add it to `umbraco.dic` in alphabetical order
- **Is it a one-off?** Rewrite the sentence to avoid the word

Dictionary-specific rules:

- **Use lowercase entries.** Hunspell lowercase entries match both lowercase and capitalized forms. Do not add both `Dev` and `dev` — just add `dev`.
- **Possessives need explicit entries.** This config does not auto-derive `Word's` from `Word`. If the possessive form appears in prose, add it separately (for example, `Anthropic's`).
- **Keep the dictionary clean.** Only add words that genuinely appear in prose outside backticks. If a word only appears inside code blocks or inline code, it does not need a dictionary entry.

### Acronym errors (`UmbracoDocs.Acronyms`)

Vale flags uppercase words of 3-5 letters that are not in the exceptions list. Read `.github/styles/UmbracoDocs/Acronyms.yml` for the current rule and exceptions.

Before adding an acronym exception, consider:

- **Is it actually an acronym?** If it is just a word in uppercase for emphasis, lowercase it or use bold instead
- **Is it a filename like `SKILL.md`?** Wrap it in backticks
- **Is it a genuine acronym used across multiple articles?** Add it to `Acronyms.yml` in alphabetical order with a comment explaining what it stands for

### Content warnings

For warnings (sentence length, word choice, editorializing, brand casing), fix them if they are on changed lines and the fix is straightforward. These are style preferences, not correctness issues.

## Excluded Paths

Check `.vale.ini` for path exclusions. Some directories (like `.claude/`) may have Vale disabled.

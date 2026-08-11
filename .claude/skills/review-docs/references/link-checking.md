# Link Checking Reference

This project uses Lychee to check for broken links in PRs.

## How CI Runs Link Checking

Read `.github/workflows/check-broken-pr-links.yml` to understand the CI configuration. It runs Lychee on markdown files changed in the PR and checks for broken internal links, missing anchors, missing files, and external 404s.

## Checking Links Locally

You do not need Lychee installed locally. Run the `check-links.mjs` script in this directory to batch-check all internal links:

```bash
node .claude/skills/review-docs/scripts/check-links.mjs file1.md file2.md ...
```

For PR mode, get the file list first, then pass the files as direct arguments:

```bash
# Step 1: Get the file list
git diff main --diff-filter=d --name-only -- '*.md'

# Step 2: Pass files directly (do NOT use $() subshell — it breaks permission auto-approval)
node .claude/skills/review-docs/scripts/check-links.mjs file1.md file2.md ...
```

**Important:** Do not use `$(git diff ...)` subshells when calling this script. Subshells and pipes in Bash commands require separate permission approval. Instead, get the file list in one command, then pass the files as direct arguments in a second command.

### What the script checks

- **Relative links** like `[Title](../path/to/file.md)` — resolves the path from the source file's directory
- **Anchor links** like `[Title](file.md#section-name)` — checks the file exists (does not verify the anchor heading)
- **Content-ref links** like `{% content-ref url="path/to/file.md" %}` — checks the target exists
- **Skips** external links (`https://`), anchor-only links (`#section`), `.gitbook/assets/` paths (hosted externally by GitBook), and mailto links

### Common link issues

- **Moved or renamed files** — if a file was moved, all links pointing to it need updating. Check `SUMMARY.md` for the canonical path
- **Missing .md extension** — internal links must include the `.md` extension
- **Wrong relative path depth** — count the `../` segments carefully when linking between nested directories
- **Anchors after rename** — if a heading was changed, any anchor links to it will break

### External links

External links (https://) are checked by Lychee in CI. You do not need to verify these manually unless the content references a specific external resource that you suspect may be incorrect.

## When Restructuring Content

If the review leads to moving, renaming, or deleting files, remember:

1. Update all internal links that point to the moved file
2. Add redirects in `.gitbook.yaml` (see the `umbraco-docs-content` skill)
3. Update `SUMMARY.md` entries

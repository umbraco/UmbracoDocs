---
description: >-
  Learn how to use the review-docs skill in Claude Code to review documentation
  for clarity, style, and broken links before submitting a pull request.
---

# Review Documentation Locally

The `review-docs` skill runs inside [Claude Code](https://claude.ai/code) and gives you feedback on documentation before you submit a pull request. Use it to catch style issues, unclear writing, and broken links. The skill uses the documentation contribution guidelines as well as the rules defined using a Vale linter.

Running a review locally before opening a PR means issues are found and fixed in your own workflow rather than discovered during the review phase.

The skill works in two modes:

* **File mode**: Review one or more specific files.
* **PR mode**: Review all markdown files changed on the current branch.

## Prerequisites

Before you can run the full review, install Vale on your machine. Vale checks for style and spelling errors.

```sh
# macOS
brew install vale

# Windows
choco install vale

# Linux
snap install vale
```

After installing Vale, run the following command from the repository root to download the style packages:

```sh
vale sync
```

## Review Specific Files

To review a single file, open Claude Code in the repository root and run:

```sh
/review-docs path/to/your/file.md
```

Replace `path/to/your/file.md` with the path to the file you want to review.

Claude will read the file and give you:

1. A one-sentence summary of what the page covers.
2. An overall verdict — whether the page is useful as-is, needs trimming, or needs reworking.
3. The most important issues, with a recommended action for each.
4. What works well and should stay.

You can also review multiple files at once by passing more paths:

```sh
/review-docs path/to/file-one.md path/to/file-two.md
```

## Review All Changed Files in a Branch

To review everything changed on the current branch, run:

```sh
/review-docs pr
```

Claude identifies all changed markdown files, then runs automated checks before reviewing the content.

## What the Skill Checks

### Style and spelling (Vale)

Vale flags style and spelling errors against the Umbraco documentation style rules. It reports three severity levels:

* **Error** — blocks the PR in CI. Fix these before submitting.
* **Warning** — style preferences. Fix these if the fix is straightforward.
* **Suggestion** — optional improvements.

### Internal links

The skill checks that all internal links in the reviewed files point to existing targets. It checks relative links, anchor links, and `content-ref` links. It does not check external links.

### Content quality

The skill also evaluates each page for:

* **Reader value** — whether each section helps a reader use the feature.
* **Clarity** — whether the language is direct and concrete.
* **Completeness** — whether anything is missing that a reader needs to get started.
* **Structure** — whether the page flows logically from concepts to practical usage.

## After the Review

The skill does not make any edits to your files. Once you agree on the changes, apply them yourself and run the review again to verify the result.

If the review leads to moving, renaming, or deleting files, follow the [File Names and Structure](../style-guide/structure.md) guide. Add any required redirects to the relevant `.gitbook.yaml` file.

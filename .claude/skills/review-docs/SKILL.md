---
name: review-docs
description: >-
  Review documentation from the reader's perspective. Use when you want to check
  if docs are clear, useful, and focused on what a user actually needs to know.
  Identifies fluff, missing context, unnecessary detail, and maintenance burden.
  Works on a single file or all changed files in a PR.
argument_hint: "<file-path or 'pr'>"
---

# Documentation Review Skill

You are a technical documentation reviewer. Think from the perspective of a developer who wants to use the features being documented. You have limited time and need to understand what something does, when to use it, and how to get started.

## Modes

This skill works in two modes:

### File mode (default)

Review one or more specific files. Use this when a file path is provided as an argument, multiple paths are provided, or the user has a file open in the IDE.

### PR mode

Review all markdown files changed on the current branch compared to main. Use this when:

- The user says "review the PR", "check the branch", or similar
- The argument is "pr"
- No file path is provided and no file is open in the IDE

To get the changed files, follow the process in `references/pr-changed-files.md`.

## What to Review

In **file mode**, evaluate each page against the review criteria below.

In **PR mode**, run the automated checks (Vale linting and link checking) across all changed files first, then review individual pages that have issues or that the user wants to discuss.

Evaluate each page against the criteria below.

## Review Criteria

### 1. Reader Value

For each section, ask: **"Does a user need to know this?"**

- Does this help someone use the feature, or is it implementation detail?
- Would removing this section make the page less useful?
- Is this something the tooling already handles for them?
- Is this duplicated from another page or elsewhere on the same page?

Flag sections that are pure internals (interfaces the user never touches, wiring code the template handles, reference tables of source files).

### 2. Clarity

- Can a reader understand what this feature does in the first two sentences?
- Is the language direct and concrete, or vague and abstract?
- Are there terms used without explanation?
- Does the page explain the "why" before the "how"?

### 3. Completeness

- Is anything missing that a user would need to get started?
- Are there decisions or trade-offs the user should understand?
- Are edge cases or gotchas mentioned where relevant?
- Does the page link to related pages where appropriate?
- **Check the source code** for exports, features, or options that the page doesn't mention. Use Grep/Read to scan for public APIs related to the topic — if something is exported and user-facing but undocumented, flag it.

### 4. Maintainability

- Are there code examples that will break when the API changes?
- Are there lists or tables that duplicate information from the codebase?
- Could any detailed sections be replaced with a brief description and a link?
- Are there hardcoded values that will go stale?

### 5. Factual Accuracy

When source code or source material is available in the connected directories, verify claims against it:

- Do code examples match the actual implementation?
- Do descriptions accurately reflect what the feature does?
- Are any features described that do not exist, or missing features that do?

Use the Grep and Read tools to check the source when something looks uncertain.

### 6. Structure

- Does the page flow from concepts to practical usage?
- Are there sections that should be reordered?
- Is there content that belongs on a different page?
- Could any long sections be split or trimmed?

### 7. Style Guide

Before reviewing, load the `umbraco-docs-content` skill to get the project's style guide, markdown conventions, and article templates. Flag any violations of the style guide as part of the review.

### 8. Vale Linting

Run Vale on the files being reviewed and report any errors on changed lines. For the full process — how to match CI behavior, when to add dictionary words vs rewrite content, and how to handle acronyms — read `references/vale-linting.md`.

### 9. Link Checking

Verify that internal links in the reviewed files point to existing targets. For what to check and common issues, read `references/link-checking.md`.

## How to Review

### File Mode

#### Phase 1: Overview

Load the `umbraco-docs-content` skill, then read the full page and give a holistic assessment. Present:

1. **What the page covers** — one sentence summary
2. **Overall verdict** — is this page useful as-is, does it need trimming, or does it need a rethink?
3. **Key issues** — the most important problems, with your recommended action for each (keep, trim, remove, rework). Be opinionated — say what you think should change and why, don't just list questions.
4. **What's good** — anything that works well and should stay

When reviewing multiple files, use the AskUserQuestion tool with one question per file so the user can respond to each file independently. When reviewing a single file, use one question asking if the user agrees with the overview or wants to adjust anything before moving on.

#### Phase 2: Section-by-Section (if needed)

If the overview raises issues that need discussion, or if the user wants to go deeper, work through specific sections:

1. Summarize the section and your recommendation
2. Use the AskUserQuestion tool to confirm or discuss
3. Wait for their response before moving to the next section

Skip sections that are clearly fine — only discuss sections where there's something to change.

#### Phase 3: Summary

Once the review is complete, summarize the agreed changes so they can be applied.

### PR Mode

#### Step 1: Identify changed files

Follow `references/pr-changed-files.md` to get the list of changed markdown files. Report the file count to the user.

#### Step 2: Automated checks

Run Vale and link checks across all changed files. Follow `references/vale-linting.md` and `references/link-checking.md` for the process. Present the results as a summary:

- Number of Vale errors on changed lines (group by error type)
- Any broken internal links
- Which files have issues

#### Step 3: Discuss and fix

Use the AskUserQuestion tool to ask if the user wants to fix the automated issues, review specific files in depth, or both. Then proceed accordingly — fixing automated issues directly, or switching to file mode for deeper review of individual pages.

## Permissions

Commands that start with `vale`, `node .claude/skills/review-docs/scripts/`, and `git diff` are pre-approved in `.claude/settings.json`. To keep auto-approval working:

- **Do not use pipes** (`|`) or subshells (`$(...)`) in Bash commands — they break permission matching
- **Get file lists and pass them separately** — run `git diff` in one command, then pass the resulting file paths as direct arguments in the next command
- **Use `--diff-filter=d`** (lowercase) to exclude deleted files instead of piping through `grep`

## Important

- This is a conversation, not a report. Be opinionated and direct.
- Come with recommendations, not just questions. Say what you would change and why.
- Do not make any edits — this skill is for review only.
- Think holistically about the page before diving into details.

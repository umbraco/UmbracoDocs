---
name: umbraco-docs-content
description: >-
  Guidelines for creating and editing Umbraco documentation content.
  Use when writing new articles, editing existing docs, or making structural changes
  (adding, moving, renaming, deleting articles). Covers style guide, markdown conventions,
  code samples, images, SUMMARY.md entries, .gitbook.yaml redirects, version-specific notes,
  Umbraco Cloud release notes, and the file limit for AI-assisted PRs.
---

# Umbraco Documentation Content Skill

## Source of Truth

The contributing guide is the single source of truth for documentation standards. Read these files for the full rules:

- **Style guide**: `contributing/documentation/style-guide/README.md`
- **Markdown conventions**: `contributing/documentation/style-guide/markdown-conventions.md`
- **Code samples**: `contributing/documentation/style-guide/code-samples.md`
- **File structure and images**: `contributing/documentation/style-guide/structure.md`

Exception: the Umbraco Cloud release notes rules are documented only in this skill (see Umbraco Cloud Release Notes below).

For acronym exceptions and how to add new ones, read `references/acronyms.md`.

## Workflow Checklist

When creating or modifying documentation, follow this checklist:

1. **Write content** following the style guide summary below
2. **Use correct markdown** per the conventions below
3. **Add to SUMMARY.md** if this is a new article
4. **Add redirects** to `.gitbook.yaml` if moving/renaming/deleting
5. **Add a version-specific note** if the change documents a feature introduced in a minor version (versioned products only). See [Version-Specific Notes](#version-specific-notes).
6. **Consider a Cloud release note** if the change documents a user-visible Umbraco Cloud feature (`umbraco-cloud/` only). See [Umbraco Cloud Release Notes](#umbraco-cloud-release-notes).
7. **Add images** to the first `.gitbook/assets` directory found when looking up in the file structure from where the article is.
8. **Follow the PR process** — structure the PR body after `.github/pull_request_template.md`. `gh pr create --body` does not apply this template, so match its sections manually. Only check contributor checklist items that have been verified.
9. **Disclose AI use, if applicable** — for AI-generated or AI-assisted content, note this in the PR description, apply the `ai-generated` label, and stay within the [file limit](#file-limit-for-ai-assisted-prs). See the [AI Contribution Guidelines](https://docs.umbraco.com/contributing/documentation/ai-guidelines).

## Style Guide Summary

- Write in **second person** ("you"), **present tense**, **active voice**
- **No editorializing** — avoid: simple, simply, just, easily, actually
- Keep sentences **under 25 words** — split at conjunctions ("and", "or") or trailing clauses ("without", "which"). For example, instead of "You can use the API to serve content to front-end apps, mobile apps, and other consumers without relying on server-side rendering" (27 words), write two sentences: "You can use the API to serve content to front-end apps and mobile apps. This removes the need for server-side rendering."
- Don't use "it" or "this" as vague references
- **Use strong language** — avoid "should", "could", "would", and "might". State what to do or what is true:
  - Instruction: ⛔ You should add the property. ✅ Add the property.
  - Requirement: ⛔ The key should be unique. ✅ The key must be unique.
  - Capability: ⛔ You could use a custom provider. ✅ You can use a custom provider.
  - Recommendation: ⛔ You should use X. ✅ The recommended approach is to use X.
- **List items** — start with a capital letter (unless the item begins with inline code or a URL). End full-sentence items with a period. Don't add end punctuation to fragments (names, options, short noun phrases). Don't mix both styles in one list.
- **Inline code** — format every code element and literal name as `inline code`: class, interface, method, property, and namespace names; configuration keys and values; file names, extensions, and paths; CLI commands and flags; NuGet package IDs. UI labels are **bold**. Product and feature names (Umbraco Forms, Document Type) stay plain text.
- No punctuation at end of headings; use `#` only once (the title)
- Use **relative paths** for internal links; use the **article title** as link text

For all rules including lists, terms, Umbraco-specific casing, brands, and good/bad examples, read `contributing/documentation/style-guide/README.md`.

## Article Template

New articles must have YAML frontmatter and an H1 title:

```markdown
---
description: >-
  A one-to-two sentence description of what this article covers.
---

- The article description will be displayed directly under the page title.
- The description should be no longer than 160 characters, as it's also used as the meta description

# Article Title

Introduction paragraph explaining what the reader will learn.

## First Section

Content here.
```

## Version-Specific Notes

Applies to products documented in numbered version folders (for example `17/umbraco-cms/`). It does not apply to non-versioned products such as Umbraco Cloud. The contributor guide describes the same rules in `contributing/documentation/style-guide/markdown-conventions.md` (Version-specific notes).

### When to add a note

Add a note when you document something introduced in a **minor version** (anything after X.0) and you are:

- Adding a new article, or
- Adding a new section (a heading plus at least one paragraph).

Don't add a note for features that shipped with the major version itself. The version folder already tells the reader. If you don't know which version introduced the feature, ask. Don't guess.

### Where to put it

- **New article**: directly after the introduction paragraph.
- **New section**: directly under the heading, before the section's other content.

### How to write it

Version-specific notes are always an `info` hint block. This is the only accepted format. Don't write them as plain sentences, inline text, or with any other hint style.

Inside the hint, write one or two plain sentences. Name the subject; don't start with "This". Use the first minor version that includes the feature, in the form `Umbraco X.Y`. Use "or later" only for requirements, not for availability.

Examples:

```markdown
{% hint style="info" %}
Lightweight external members are available from Umbraco 17.4.
{% endhint %}
```

```markdown
{% hint style="info" %}
The `MaximumLocalCacheItems` setting is available from Umbraco 18.1.
{% endhint %}
```

```markdown
{% hint style="info" %}
Replacing the maintenance page requires Umbraco 18.3 or later. In earlier versions, the default page cannot be replaced.
{% endhint %}
```

Add the note in every version folder where the article or section exists (for example both `17/` and `18/`). The version stays the same in each copy.

## Umbraco Cloud Release Notes

Applies to `umbraco-cloud/` only. These rules apply to the Cloud team and are only documented here.

### When to consider a release note

Consider an entry when the change is something Cloud users can see or use:

- A new or changed Cloud Portal feature, setting, or page
- A new platform capability (regions, hosting options, plan features, deployment or upgrade behavior)
- A release of a Cloud-specific package (for example `Umbraco.Cloud.Cms`)

Don't add an entry for:

- Fixes to existing articles, rewrites, restructuring, or new tutorials without a product change
- Changes that aren't live yet

### How

Suggest the entry to the user and ask for the release date before adding anything. Release notes announce what is live, so don't guess the date.

1. Find the current year's folder under `umbraco-cloud/release-notes/` (for example `overview-2026/`) and the current month's file.
   - If the month's file doesn't exist, create it and add it to `SUMMARY.md`.
2. Add a section to the month's file: a key-takeaway bullet, a section describing the change, and a link to the full documentation.
3. Add one line to the year's `README.md` under the month heading, newest first: `[DD/MM] - **Title** - One-sentence summary.`

## File and Directory Structure

```
/topic/
├── README.md              # Landing page (required)
├── another-article.md
└── subtopic/
    ├── README.md
    ├── article.md
```

- All names: **lowercase**, **hyphens** for spaces
- Parent articles are always `README.md`
- Images are placed in a `.gitbook/assets` directory at the root of the product directory

For full structure rules and image guidelines, read `contributing/documentation/style-guide/structure.md`.

## SUMMARY.md Format

Each product has a `SUMMARY.md` that controls navigation. Articles not listed here won't appear on the site.

```markdown
# Table of contents

* [Product Documentation](README.md)

## Section Name

* [Article Title](path/to/article.md)
  * [Sub Article](path/to/sub-article.md)
    * [Deep Article](path/to/deep-article.md)
```

- Use `## Section Name` to create navigation groups
- Indent with two spaces for nesting
- Link text = article title, path = relative from SUMMARY.md

## .gitbook.yaml Redirects

When moving, renaming, or deleting articles, add a redirect:

```yaml
redirects:
    old/path/without/extension: new/path/with/extension.md
```

- The old path has **no file extension**
- The new path **includes** the `.md` extension
- Point deleted articles to their replacement or parent article

## Structural Change Procedures

For any structural change, apply the SUMMARY.md and .gitbook.yaml rules above:

- **Add**: create the file + add to SUMMARY.md
- **Move**: move the file + update SUMMARY.md path + add redirect + if the destination is a new directory, create a `README.md` landing page for it
- **Rename**: rename the file + update SUMMARY.md title and path + add redirect
- **Delete**: remove from SUMMARY.md + add redirect to replacement or parent + delete file

## Code Samples

- Always add **syntax highlighting** and a **caption** (filename) to code blocks
- Provide **complete, compilable** code with real-life examples

For caption format, syntax highlighting languages, file-scoped namespaces, and all other code guidelines, read `contributing/documentation/style-guide/code-samples.md`.

## Images

- Store in the `.gitbook/assets` directory closest in the file structure to the article that references them
- Always provide alt text
- Provide caption when relevant

For formats, naming, and markdown syntax, read `contributing/documentation/style-guide/structure.md`.

## Markdown Conventions

- Use GitBook hint blocks for notes/warnings (`info`, `success`, `warning`, `danger`)
- Do not edit Cards HTML on landing pages

For hint syntax, links, content-ref, expandables, and other markdown conventions, read `contributing/documentation/style-guide/markdown-conventions.md`.

## File Limit for AI-Assisted PRs

**Maximum 10 article files per version folder.**

- Each version folder counts separately (`17/` and `18/` can have 10 article files each).
- All non-versioned folders (for example `umbraco-cloud/`) count as one group.
- An article file is any `.md` file except `SUMMARY.md`.

### Exempt: mechanical changes

A change is mechanical if it doesn't change what the documentation tells the reader:

- Link fixes
- Screenshot refreshes (same UI) and alt text
- Linting fixes (Vale, link checker)
- Moves and renames with redirects
- Markdown formatting
- Consistent search-and-replace (for example, a renamed product)

Not mechanical: new or rewritten text, steps, examples, code, settings, or sections.

The exemption applies only if **every** change in the PR is mechanical. State "Mechanical changes only: [type]" in the PR description.

### Exceeding the limit

Count the article files per version folder (and for the non-versioned group) while planning. If any count exceeds 10 and the change isn't purely mechanical, still do the work, but:

- Tell the user at the start that the PR will go over the limit.
- Explain why in the PR description.
- A maintainer decides whether to accept or split the PR.

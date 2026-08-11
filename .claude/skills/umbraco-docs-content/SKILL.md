---
name: umbraco-docs-content
description: >-
  Guidelines for creating and editing Umbraco documentation content.
  Use when writing new articles, editing existing docs, or making structural changes
  (adding, moving, renaming, deleting articles). Covers style guide, markdown conventions,
  code samples, images, SUMMARY.md entries, and .gitbook.yaml redirects.
---

# Umbraco Documentation Content Skill

## Source of Truth

The contributing guide is the single source of truth for documentation standards. Read these files for the full rules:

- **Style guide**: `contributing/documentation/style-guide/README.md`
- **Markdown conventions**: `contributing/documentation/style-guide/markdown-conventions.md`
- **Code samples**: `contributing/documentation/style-guide/code-samples.md`
- **File structure and images**: `contributing/documentation/style-guide/structure.md`

For acronym exceptions and how to add new ones, read `references/acronyms.md`.

## Workflow Checklist

When creating or modifying documentation, follow this checklist:

1. **Write content** following the style guide summary below
2. **Use correct markdown** per the conventions below
3. **Add to SUMMARY.md** if this is a new article
4. **Add redirects** to `.gitbook.yaml` if moving/renaming/deleting
5. **Add images** to the first `.gitbook/assets` directory found when looking up in the file structure from where the article is.

## Style Guide Summary

- Write in **second person** ("you"), **present tense**, **active voice**
- **No editorializing** — avoid: simple, simply, just, easily, actually
- Keep sentences **under 25 words** — split at conjunctions ("and", "or") or trailing clauses ("without", "which"). For example, instead of "You can use the API to serve content to front-end apps, mobile apps, and other consumers without relying on server-side rendering" (27 words), write two sentences: "You can use the API to serve content to front-end apps and mobile apps. This removes the need for server-side rendering."
- Don't use "it" or "this" as vague references
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

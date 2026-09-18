# Umbraco Documentation - Contributing Guidelines

## Structural Rules (always apply)

- **New articles** must be added to the relevant `SUMMARY.md` file or they will not appear on the published site
  - Format: `* [Article Title](path/to/article.md)`
  - Nest with indentation for sub-pages
- **Moving, renaming, or deleting articles** requires a redirect in the relevant `.gitbook.yaml` under `redirects:`
  - Format: `old/path/without/extension: new/path/with/extension.md`
- Each directory must have a `README.md` as its landing page
- Images go in a `.gitbook/assets` directory at the root of the product directory
- All file and directory names: **lowercase**, **hyphens** instead of spaces

## Version Structure

Documentation is organized by version number (e.g., `14/`, `15/`, `16/`, `17/`) and then by product (e.g., `umbraco-cms/`, `umbraco-forms/`). Each product directory has its own `SUMMARY.md` and `.gitbook.yaml`.

## Writing Guidelines

When creating or editing documentation content, use the `umbraco-docs-content` skill for detailed style rules, article templates, markdown conventions, and code sample guidelines.

Style rules enforced by Vale (`.vale.ini`, `.github/styles/UmbracoDocs/*.yml`) and `.github/pull_request_template.md`, always apply:

- No sentence over 25 words (`SentenceLength.yml`). Split long sentences instead of using semicolons or extra clauses.
- Avoid opinionated/exaggerating words, for example "very", "just", "simply", "obviously" (`Editorializing.yml` has the full list).
- Avoid passive voice and first-person language ("we", "I") per the PR template checklist.
- Use "for example" instead of "e.g.", "that is" instead of "i.e." (`Terms.yml`).
- List items start with a capital letter (`ListStart.yml`); headings never end in punctuation (`HeadingsPunctuation.yml`).
- Undefined 3-5 letter acronyms need a definition nearby unless already in `Acronyms.yml`'s exception list.
- Match casing in `UmbracoTerms.yml`/`Names.yml`/`Brands.yml`, for example "Umbraco CMS", "backoffice", "GitHub", "JavaScript".

## PR Process (always apply)

- Structure the PR body after `.github/pull_request_template.md`. `gh pr create --body` does not apply this template, so match its sections manually.
- For AI-generated or AI-assisted content, disclose it in the description, apply the `ai-generated` label, and keep the PR within 10 article files. Mirrored version folders (e.g. `17/` and `18/`) count as separate files.
- See the [AI Contribution Guidelines](https://docs.umbraco.com/contributing/documentation/ai-guidelines) for the full rules.

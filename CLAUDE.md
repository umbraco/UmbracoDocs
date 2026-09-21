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

## PR Process (always apply)

- Structure the PR body after `.github/pull_request_template.md`. `gh pr create --body` does not apply this template, so match its sections manually.
- For AI-generated or AI-assisted content, disclose it in the description, apply the `ai-generated` label, and keep the PR within 10 article files. Mirrored version folders (e.g. `17/` and `18/`) count as separate files.
- See the [AI Contribution Guidelines](https://docs.umbraco.com/contributing/documentation/ai-guidelines) for the full rules.

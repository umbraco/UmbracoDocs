---
description: >-
  Practical tips for getting better results from AI-assisted Umbraco backoffice
  development with skills.
---

# Tips for Best Results

Get the most out of AI-assisted Umbraco backoffice development.

## Be Specific in Prompts

Instead of:

> "Create a dashboard"

Try:

> "Create a dashboard in the Content section that shows the 10 most recently published pages with their publish date and author"

Specificity helps the AI pick the right skills and generate code that matches your actual requirements.

## Iterate with Specific Feedback

When the generated code needs adjustment, be specific about what needs changing:

Instead of:

> "That's not right, fix it"

Try:

> "The tree items need to use entityType 'my-entity' not 'my-tree-entity', and the workspace should have two views: Details and Settings"

## Add Source Code References

Skills work best when the AI has access to the Umbraco source code. This lets it reference actual implementations, understand types and interfaces, and follow existing conventions.

Clone the repositories alongside your project:

```bash
git clone https://github.com/umbraco/Umbraco-CMS.git
git clone https://github.com/umbraco/Umbraco.UI.git
```

Add them as working directories in your editor. In Claude Code:

```bash
/add-dir /path/to/Umbraco-CMS/src/Umbraco.Web.UI.Client
/add-dir /path/to/Umbraco.UI/packages/uui
```

This gives the AI direct access to:

* **Umbraco.Web.UI.Client:** Backoffice TypeScript source code, showing production implementations of all extension types
* **Umbraco UI Library (UUI):** Component library with all `uui-*` components

## Explore the Backoffice First

If you are new to the Umbraco backoffice, use your AI assistant as an exploration tool before building anything. Ask it to explain how the backoffice is structured, what extension types exist, and where they appear in the UI.

You can also use browser automation tools to walk through the backoffice together. Point the AI at your running instance and ask it to describe what it sees — sections, trees, dashboards, workspaces. This builds your mental model of where things live and how they connect, which makes your prompts more effective when you start building.

## Migrating from Older Versions

If you are migrating backoffice customizations from Umbraco 13 or earlier, skills can help you rebuild them using the new extension system. The backoffice was rewritten in v14 — AngularJS controllers, directives, and package.manifest files are replaced by Lit elements, the extension registry, and TypeScript manifests.

Describe your existing customization to the AI and ask it to recreate it using current patterns. Skills provide the correct approach for each extension type, so you do not need to learn the new APIs from scratch. The `umbraco-backoffice` skill is a good starting point for mapping old concepts to new ones.

## Use Router Skills When Unsure

If you are not sure which skill to use:

* **`umbraco-backoffice`** : Routes you to the right extension skill based on what you want to build
* **`umbraco-testing`** : Routes you to the right testing approach based on what you want to test

These router skills understand the full landscape and guide you to the right place.

## Build Component by Component

You do not need to generate an entire extension in one go. Use skills as a building assistant, ask for one component at a time, and verify each piece before moving on.

For example, when building a custom section with a tree and workspace:

1. Ask for the section and menu first. Verify it appears in the backoffice.
2. Add the tree. Verify items load and navigate.
3. Add the workspace. Verify it opens when you select a tree item.
4. Wire up the data flow between them.

This incremental approach catches problems early and gives you control over each piece. The AI loads the relevant skill for each step, so you get focused guidance rather than a large block of generated code.

## Prototypes and Multiple Versions

Generating code with skills is fast, so use that to your advantage. Ask for two or more versions of a component and compare them before committing to one.

For example, ask for a dashboard layout using a `uui-table` and another using `uui-box` cards. See both in the browser, pick the one that fits, and discard the other. This works well for UI-heavy components where the right approach is not obvious until you see it.

You can also explore different architectural approaches. Compare a tree-based navigation with a collection view, or a modal workflow with an inline editor. Generating a second option costs little and often reveals a better solution.

## Review Generated Code

Skills reduce hallucination but cannot eliminate it. Always:

1. **Read the generated code:** Understand what it does before running it
2. **Check imports:** Verify packages and paths exist
3. **Run the build:** `npm run build` catches most issues
4. **Use the reviewer:** The `umbraco-extension-reviewer` agent catches Umbraco-specific issues

## Manual Validation Testing

After building, verify your extension in the browser. You can do this manually, or use tools that let your AI assistant see the backoffice directly:

* **Playwright:** Write E2E tests that interact with the backoffice. See [Testing Skills](testing-skills.md) for the full testing pyramid.
* **Browser automation:** Tools like Claude for Chrome let the AI see and interact with your running backoffice, catching visual issues that a build step cannot.

A passing build does not mean the extension works. Visual verification catches layout issues, missing UI elements, and interaction bugs.

## Automate the Full Process

To have the entire setup, build, and validation process guided for you, use the `umbraco-quickstart` skill. It handles project creation, extension setup, and walks you through the **Plan**, **Build**, **Validate** workflow. See the [Quickstart](quickstart.md) for details.

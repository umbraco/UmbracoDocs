---
description: >-
  Get from zero to a working Umbraco backoffice extension using the quickstart skill
  and the PLAN, BUILD, VALIDATE workflow.
---

# Quickstart

Get from zero to a working Umbraco backoffice extension.

## Setup

The `umbraco-quickstart` skill creates an Umbraco instance, creates an extension project, registers the extension, and guides you through the development workflow:

```bash
# Full setup with custom credentials
/umbraco-quickstart MyUmbracoSite MyExtension --email a@a.co.uk --password Admin123456

# With default credentials (admin@test.com / SecurePass1234)
/umbraco-quickstart MyUmbracoSite MyExtension

# No arguments — detects existing or prompts for names
/umbraco-quickstart
```

{% hint style="info" %}
The `/` syntax is for Claude Code. In other editors, describe the task in natural language and the agent loads the skill automatically.
{% endhint %}

## The PLAN, BUILD, VALIDATE Workflow

All extension development follows this workflow.

### PLAN

Before writing any code:

1. **Describe what you want to build** — "A dashboard that shows recent content changes", "A tree in Settings for managing custom data"
2. **Draw a wireframe** — The AI creates ASCII wireframes showing where UI elements appear in the backoffice
3. **Identify extension types** — Label each part of the wireframe: section, dashboard, workspace, tree
4. **Identify UUI components** — Map out which `uui-*` components you need (buttons, inputs, boxes, tables)
5. **Map data flow** — How does data move? Which contexts, repositories, and APIs are involved?

```
┌─────────────────────────────────────────────────────┐
│ [Header]                          [headerApp]       │
├──────────┬──────────────────────────────────────────┤
│ [Section]│ [Dashboard/Workspace]                    │
│  │       │  ┌────────────────────────────────────┐  │
│  ├─[Menu]│  │   Your content area                │  │
│  │  │    │  │   [uui-button] [uui-input]         │  │
│  │  └─[X]│  │   [uui-box]                        │  │
│  └─[Tree]│  └────────────────────────────────────┘  │
└──────────┴──────────────────────────────────────────┘
```

Planning prevents building the wrong extension type. You approve the plan before any code is written.

### BUILD

With the plan approved:

1. **Load the `umbraco-backoffice` skill** for best practices and example blueprints
2. **Invoke the identified sub-skills** — each extension type has its own skill with correct patterns
3. **Follow the examples** — Copy from the closest blueprint and adapt

### VALIDATE

After building, validation is mandatory:

1. **Build** — Run `npm run build` in the extension directory. Must compile without errors.
2. **Code review** — The `umbraco-extension-reviewer` agent checks for correct extension type usage, proper imports, context patterns, and manifest registration.
3. **Fix issues** — High and medium severity issues are auto-fixed.
4. **Rebuild** if fixes were made.
5. **Restart Umbraco** — Stop and restart `dotnet run`.
6. **Browser test** — Navigate to your extension in the backoffice. Verify: no console errors, UI renders correctly, interactions work.

## Optional: Add Source Code References

For better code generation, give the AI access to the Umbraco source:

```bash
git clone https://github.com/umbraco/Umbraco-CMS.git
git clone https://github.com/umbraco/Umbraco.UI.git

/add-dir /path/to/Umbraco-CMS/src/Umbraco.Web.UI.Client
/add-dir /path/to/Umbraco.UI/packages/uui
```

See [Tips for Best Results](tips.md) for more on this.

## Next Steps

- **[Backoffice Skills](backoffice-skills.md)** — Explore the 65 extension skills
- **[Testing Skills](testing-skills.md)** — Add tests to your extension
- **[Tips for Best Results](tips.md)** — Get better results from your AI assistant

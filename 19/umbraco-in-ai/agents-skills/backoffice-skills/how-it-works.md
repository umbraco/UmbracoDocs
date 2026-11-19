---
description: >-
  How backoffice skills route agents to best practices, documentation, and
  working examples through progressive discovery.
---

# How It Works

For a general introduction to agent skills and the `SKILL.md` format, see [What Are Skills?](../../concepts/agent-skills.md) article.

This page explains how the Umbraco backoffice skills use that format to guide AI agents through extension development. 

## Progressive Discovery

Each skill acts as a routing layer between the agent and three sources of knowledge:

* **Best practices:**  Validated code patterns for each extension type.
* **Live documentation:** Current pages from the Umbraco documentation, fetched at runtime.
* **Working examples:** Complete, buildable extensions that demonstrate real combinations.

When you describe a task, the agent loads only the relevant skill. The skill guides the agent through a workflow, pointing it to the right documentation and patterns. The agent decides how much context it needs based on task complexity.

The `umbraco-backoffice` skill acts as the top-level router. It contains an extension map showing where all extension types appear in the backoffice UI. It directs the agent to the specific skill for each extension type. For multi-extension tasks, it provides blueprints showing how skills combine.

This means the agent does not need the entire Umbraco backoffice documentation upfront. It discovers what it needs as it works.

## How Skills Are Selected

The agent matches your task description against skill descriptions. The `description` field in each skill's frontmatter is the primary signal.

For example, asking "I need a custom dashboard" matches against `"Implement dashboards in Umbraco backoffice using official docs"` and loads the `umbraco-dashboard` skill.

Router skills like `umbraco-backoffice` and `umbraco-testing` act as dispatchers. They help when a task does not map to a single skill, or when the agent needs to understand how extension types combine.

## Runtime Flow

```
User describes task
       |
AI matches skill by description
       |
SKILL.md loaded into context
       |
AI follows workflow steps
       |
WebFetch pulls current documentation
       |
AI generates code using skill patterns + fetched docs
       |
Post-build validation (build, review, test)
```

Skills combine **static patterns** (validated code in the `SKILL.md`) with **dynamic content** (documentation fetched at runtime). This means skills stay accurate even as Umbraco documentation evolves.

## Skill Composition

Skills reference each other through their content. A skill might say "use the `umbraco-context-api` skill for data sharing" or "invoke `umbraco-openapi-client` for API calls." The agent follows these references to load additional skills as needed.

The `umbraco-backoffice` backbone skill provides a central index with an extension map, blueprints, and a sub-skills reference organized by category. Each skill stays focused on one extension type, while the backbone skill shows how they fit together.

## Plugin Packaging

Skills are packaged as plugins with a marketplace manifest for discovery:

```
plugins/
├── umbraco-backoffice-skills/
│   ├── .claude-plugin/plugin.json
│   └── skills/
│       ├── umbraco-dashboard/SKILL.md
│       ├── umbraco-tree/SKILL.md
│       └── ...
└── umbraco-testing-skills/
    ├── .claude-plugin/plugin.json
    └── skills/
        ├── umbraco-testing/SKILL.md
        └── ...
```

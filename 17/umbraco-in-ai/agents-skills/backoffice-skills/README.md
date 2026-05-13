---
description: >-
  AI skills for building Umbraco backoffice extensions. Available for Claude
  Code, Cursor, GitHub Copilot, Windsurf, and other editors that support the
  `SKILL.md` format.
---

# Backoffice Skills

Backoffice skills give your AI coding assistant deep knowledge of Umbraco's extension points. Each skill covers one extension type, such as dashboards, trees, property editors, modals, and more, with patterns, code examples, and references to the latest documentation.

Skills use the open [`SKILL.md`](https://agentskills.io/home) format. They load on demand: only the skill relevant to your current task is pulled into context. Installing all skills does not affect performance. For a general introduction to agent skills and how they work, see [Agent Skills](../../concepts/agent-skills.md).

## Installation

### Claude Code

Add the marketplace and install the plugins:

```bash
# Add the marketplace
/plugin marketplace add umbraco/Umbraco-CMS-Backoffice-Skills

# Install backoffice extension skills (58 skills)
/plugin install umbraco-cms-backoffice-skills@umbraco-backoffice-marketplace

# Install testing skills (8 skills) — optional but recommended
/plugin install umbraco-cms-backoffice-testing-skills@umbraco-backoffice-marketplace
```

### Cursor, GitHub Copilot, Windsurf, and Others

Use the [Vercel Skills CLI](https://github.com/vercel-labs/skills) with the `-a` flag to target your editor:

```bash
# For Cursor
npx skills add umbraco/Umbraco-CMS-Backoffice-Skills --skill '*' -a cursor

# For GitHub Copilot
npx skills add umbraco/Umbraco-CMS-Backoffice-Skills --skill '*' -a github-copilot

# For Windsurf
npx skills add umbraco/Umbraco-CMS-Backoffice-Skills --skill '*' -a windsurf
```

You can also install specific skills instead of all of them:

```bash
npx skills add umbraco/Umbraco-CMS-Backoffice-Skills --skill umbraco-dashboard --skill umbraco-tree -a cursor
```

{% hint style="warning" %}
Always use the `-a` flag to target your editor. Without it, skills are symlinked into every supported agent directory.
{% endhint %}

## Documentation

| Guide                                              | Description                                                                                   |
| -------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| [Quickstart](quickstart.md)                        | Set up Umbraco and an extension project, learn the **Plan**, **Build**, **Validate** workflow |
| [Backoffice Skills Overview](backoffice-skills.md) | All 65 extension skills, the extension map, and working examples                              |
| [Testing Skills](testing-skills.md)                | The 4-level testing pyramid and 8 testing skills                                              |
| [Tips for Best Results](tips.md)                   | Source code references, prompting advice, and editor requirements                             |
| [How It Works](how-it-works.md)                    | How skills route agents to best practices through progressive discovery                       |

# What Are Skills?

Agent Skills are modular instruction sets that guide AI coding agents toward the right information at the right time. They automate [context engineering](context-enginerring.md) through active context management. Skills are not activated unless the task requires them. They use progressive discovery so the agent starts with a summary and pulls in deeper detail only when needed.

For Umbraco, skills allow us to:

- **Guide agents to the right information** — pointing them to current APIs and platform-specific patterns rather than letting them guess
- **Show best practice** — providing validated code examples and workflow guidance for each extension type
- **Deliver the right Umbraco information at the right time** — the agent only receives context relevant to the current task

## What's Inside a Skill?

Each skill is a directory containing a `SKILL.md` file along with supporting reference files and scripts:

- **`SKILL.md`** — the main instruction file with workflow guidance and code patterns
- **Reference files** — detailed documentation, style guides, or API references that the skill loads on demand
- **Scripts** — helper scripts the AI can run to validate work or automate checks

When you ask your AI assistant to "create a dashboard", it loads the `umbraco-dashboard` skill and gets precise, current instructions instead of guessing.

## What Skills Are Not

- **Not a replacement for documentation.** Skills point to the documentation and teach the AI how to apply it. You should still read the [Umbraco documentation](https://docs.umbraco.com/) yourself.
- **Not scaffolding tools.** They don't generate boilerplate from templates. They teach the AI to write code that fits your specific requirements.
- **Not perfect.** Skills improve results but cannot guarantee correctness. Always review generated code.

## How Skills Differ Across Editors

Skills use the open [`SKILL.md` format](https://agentskills.io/home), which is supported by multiple AI coding tools. The experience varies slightly:

| Editor | How Skills Load | Installation |
|--------|----------------|--------------|
| **Claude Code** | Native plugin system, on-demand | `/plugin install` from marketplace |
| **Cursor** | `.cursor/skills/` directory, on-demand | `npx skills add` via Skills CLI |
| **GitHub Copilot** | `.github/skills/` directory, on-demand | `npx skills add` via Skills CLI |
| **Windsurf** | `.windsurf/skills/` directory, on-demand | `npx skills add` via Skills CLI |

The skill content is identical across editors. What differs is how each editor discovers and loads the skill files. Claude Code uses a plugin/marketplace system; other editors use the [Vercel Skills CLI](https://github.com/vercel-labs/skills) to install skills into editor-specific directories.

Some advanced features (like spawning reviewer agents or entering plan mode) work best in Claude Code. The core value — correct code patterns from current documentation — works everywhere.

## Skills and MCP

Skills and the [Model Context Protocol (MCP)](../base-mcp/README.md) are complementary. Skills provide **knowledge** — they teach the agent how to write correct code. MCP provides **capability** — it gives the agent tools to interact with a running Umbraco instance. An agent might use a skill to learn how to build a dashboard, and use MCP tools to create the content types it needs.

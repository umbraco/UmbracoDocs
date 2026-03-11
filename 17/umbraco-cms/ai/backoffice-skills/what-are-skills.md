# What Are Skills?

## The Problem

AI coding assistants are powerful, but they hallucinate APIs. Ask one to build an Umbraco backoffice extension and you'll get plausible-looking code that imports modules that don't exist, uses patterns from older versions, and follows conventions that were never real. The code compiles in the AI's imagination but not in your project.

This happens because the AI's training data is a snapshot. It learned Umbraco patterns from blog posts, documentation, and code samples that existed before its knowledge cutoff - some current, some outdated, some wrong. It has no way to know which is which.

## What Skills Do

Skills are curated AI knowledge files that bridge the gap between documentation and coding assistants. Each skill is a `SKILL.md` file containing:

- **Correct, validated code patterns** for a specific Umbraco concept
- **Links to official documentation** that the AI fetches at runtime
- **Working examples** tested against real Umbraco instances
- **Workflow guidance** (what to do first, what to check after)

When you ask your AI assistant to "create a dashboard", it loads the `umbraco-dashboard` skill and gets precise, current instructions instead of guessing.

## What Skills Are Not

- **Not a replacement for documentation.** Skills point to docs and teach the AI how to apply them. You should still read the [Umbraco documentation](https://docs.umbraco.com/) yourself.
- **Not scaffolding tools.** They don't generate boilerplate from templates. They teach the AI to write code that fits your specific requirements.
- **Not perfect.** Skills dramatically reduce hallucination but can't eliminate it entirely. Always review generated code.

## On-Demand Loading

You don't need to worry about 66 skills bloating your AI's context window. Skills load **on demand** - only the skill relevant to your current task is loaded. If you ask about dashboards, only the dashboard skill loads. If you ask about testing, only the testing skills load.

This is true across all supported editors.

## How Skills Differ Across Editors

Skills use the open [SKILL.md format](https://agentskills.io/home), which is supported by multiple AI coding tools. The experience varies slightly:

| Editor | How Skills Load | Installation |
|--------|----------------|--------------|
| **Claude Code** | Native plugin system, on-demand | `/plugin install` from marketplace |
| **Cursor** | `.cursor/skills/` directory, on-demand | `npx skills add` via Skills CLI |
| **GitHub Copilot** | `.github/skills/` directory, on-demand | `npx skills add` via Skills CLI |
| **Windsurf** | `.windsurf/skills/` directory, on-demand | `npx skills add` via Skills CLI |

The skill content is identical across editors. What differs is how each editor discovers and loads the skill files. Claude Code uses a plugin/marketplace system; other editors use the [Vercel Skills CLI](https://github.com/vercel-labs/skills) to install skills into editor-specific directories.

Some advanced features (like spawning reviewer agents or entering plan mode) work best in Claude Code but the core value - correct code patterns from current documentation - works everywhere.

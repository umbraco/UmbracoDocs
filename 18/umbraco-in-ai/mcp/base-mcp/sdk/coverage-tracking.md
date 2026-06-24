---
description: >-
  Track which API operations are covered by tools and catalog endpoints that
  are deliberately excluded.
---

# Coverage Tracking

As your MCP server grows, you need to know which API operations have tools and which are deliberately excluded. The Claude Code plugin provides two skills for this.

## Counting Tools

The `/count-mcp-tools` skill counts tools per collection and displays a summary. Use it to track implementation progress and identify collections with too many or too few tools.

```
/count-mcp-tools
```

## Cataloging Ignored Endpoints

The `/update-ignored-endpoints` skill analyzes your generated API clients and compares them against implemented tools. Endpoints that are not implemented are cataloged in `docs/analysis/IGNORED_ENDPOINTS.md` with coverage statistics and categorization.

```
/update-ignored-endpoints
```

This produces:

* Total endpoint count and coverage percentage
* Categorized list of ignored endpoints grouped by collection
* Reasons for exclusion (security, deprecation, unsuitable for MCP)

Maintaining this file gives you a clear record of which API endpoints are deliberately excluded and why. The `/discuss-mcp` skill respects this file and will not suggest building tools for ignored endpoints.

## When to Run

Run these skills whenever you add or remove tools, or after running `/build-tools` to generate new collections. Keeping coverage data up to date helps you make informed decisions about what to implement next.

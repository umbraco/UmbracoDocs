---
description: Get the most out of the Umbraco CMS Editor MCP server
---

# Example Instructions File

Custom instructions help guide your AI assistant to follow your specific content editing practices and conventions. By creating an instructions file, you can ensure consistent behaviour across all interactions with the Editor MCP Server.

The example below demonstrates a comprehensive instruction file for an editorial team working with the Editor MCP.

## Example Instruction File

```markdown
# Umbraco Content Editing Guidelines

## General Rules

- Always search for existing content before creating new pages to avoid duplicates
- Never publish directly — always save as draft first and confirm with the team
- Use the site tree to understand where new content should be placed before creating it

## Content Structure

- Blog posts go under /blog and use the "Blog Post" document type
- Product pages go under /products and use the "Product Page" document type
- Landing pages go under their campaign folder (e.g. /campaigns/summer-2025)

## Content Standards

- All pages must have a meta description filled in
- Page titles should be under 60 characters
- Hero images should use the "Hero Banner" block type in the main content area
- All images must have alt text for accessibility

## Translation Workflow

- English (en-US) is the primary language
- Danish (da-DK) variants should be created for all published pages
- Use copy-variant to seed Danish translations from English content
- Dictionary items use dot-notation keys (e.g. Navigation.Home, Buttons.Submit)

## Media Organisation

- Product images go in the Media/Products folder
- Team photos go in the Media/Team folder
- Campaign assets go in Media/Campaigns/{campaign-name}
- Delete unused media quarterly to keep the library tidy

## Publishing Process

1. Create or edit the page as a draft
2. Run an SEO audit using audit-page-seo
3. Check content quality using audit-page-content
4. Get approval from the content lead
5. Publish the page

## Bulk Operations

- Never bulk-publish more than 5 pages at a time without checking each one
- Always review the confirmation list before approving bulk operations
- Use bulk-schedule-publish for coordinated campaign launches
```

This example demonstrates how to create project-specific guidelines that your AI assistant can consistently follow throughout your editorial workflow.

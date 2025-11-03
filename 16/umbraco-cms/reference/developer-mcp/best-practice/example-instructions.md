---
description: Get the most out of the Umbraco CMS developer MCP server
---

# Example instructions file

Custom instructions help guide your AI assistant to follow your specific Umbraco development practices and conventions. By creating a `.claude/instructions.md` file in your project, you can ensure consistent behavior across all interactions with the MCP server.

The example below demonstrates a comprehensive instruction file that covers tool usage, content structure, templates, and other best practices. The version of Umbraco (v16.2.0) is explicitly specified in the title. This helps AI assistants use version-specific documentation sources like Context7 to provide accurate guidance for your Umbraco installation.

Created by [Tom Madden](https://github.com/TwoMoreThings)

## Example `.claude/instructions.md`

```markdown
# Umbraco Development Guidelines (v16.2.0)

## Tool Usage

- Use Context7 to retrieve Umbraco v16.2.0 documentation
- Use the Umbraco MCP tool for ALL Umbraco interactions - make multiple calls as needed, never try to optimize with bulk operations
- Use create-media MCP tool for media items, referencing files in wwwroot/media/my-folder

## Content Structure

- Always use Block List over Block Grid for composable pages
- All navigable content pages must be nested under the Home page
- All Content Type properties must belong to either a tab or a group

## Block List Configuration

- Items require a contentKey in UUID/GUID format
    - Define labels using the Umbraco Flavored Markdown format, e.g. {umbValue: propertyAlias} (NOT {{$propertyAlias}})

## Templates & Content Types

- For web page content types (non-element types):
    - Create corresponding template via Management API first
    - Assign template to content type
    - Set as default template

## Data Types

- Save new Data Types in 'Custom Data Types' folder
- Use 'Rich Text Editor [Tiptap]' for formatted text content
- Use Link Picker instead of multiple TextString properties for links

## File Handling

- Never modify file metadata/dates (preserves Git change tracking)
- Add static assets to wwwroot subdirectories
- When downloading images, exclude favicon.png and apple-icon.png
- Look for CSS/inline style images, not just src attributes

## Models & Publishing

- STOP and prompt user to generate models and restart site (never generate manually)
- Verify the node Layout is set correctly when saving/publishing pages
```

This example demonstrates how you can create project-specific guidelines that your AI assistant will follow consistently throughout your development workflow.
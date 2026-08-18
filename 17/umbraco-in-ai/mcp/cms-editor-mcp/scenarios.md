---
description: Common use cases for the Editor MCP
---

# Use Cases

This document provides practical examples of how to use the Editor MCP for common Umbraco editorial tasks. Each scenario includes example prompts that demonstrate how to accomplish real-world operations using the available MCP tools.

## Table of Contents

- [Content Management](#content-management)
- [Publishing Workflows](#publishing-workflows)
- [Media Management](#media-management)
- [Translation and Localization](#translation-and-localization)
- [Content Health and SEO](#content-health-and-seo)
- [Content Reporting](#content-reporting)
- [Site Structure Analysis](#site-structure-analysis)
- [Content Relationships](#content-relationships)
- [Bulk Operations](#bulk-operations)
- [Member Management](#member-management)
- [Scheduling](#scheduling)
- [Redirects](#redirects)
- [Blueprints and Templates](#blueprints-and-templates)

## Content Management

1. **Creating and Editing Content**
   - Create new pages from conversational descriptions

     **Example Prompt:** "Create a new Blog Post page called 'Summer Product Launch' under the News section"

     **Required Tool Collections:** `content`

   - Edit existing page content by describing the changes

     **Example Prompt:** "Update the About Us page intro text to mention our new office in Copenhagen"

     **Required Tool Collections:** `content`

   - Work with block-based content editors

     **Example Prompt:** "Show me the blocks on the Homepage and update the hero banner heading to 'Welcome to Our New Site'"

     **Required Tool Collections:** `content`

   - Navigate and explore the site tree

     **Example Prompt:** "Show me all pages under the Products section"

     **Required Tool Collections:** `content`

2. **Content Review and Cleanup**
   - Find draft pages that may have been forgotten

     **Example Prompt:** "Find all unpublished pages under the Blog section"

     **Required Tool Collections:** `content-reporting`

   - Review recent editorial activity

     **Example Prompt:** "Show me all pages changed in the last 3 days"

     **Required Tool Collections:** `content-reporting`

   - Find pages with missing or empty fields

     **Example Prompt:** "Check all pages under Products for empty fields"

     **Required Tool Collections:** `content-health`

## Publishing Workflows

3. **Single and Multi-page Publishing**
   - Publish a page and all its children

     **Example Prompt:** "Publish the Summer Campaign page and all its child pages"

     **Required Tool Collections:** `content`, `publishing`

   - Unpublish outdated content

     **Example Prompt:** "Unpublish the Winter Sale landing page"

     **Required Tool Collections:** `content`, `publishing`

4. **Version Management**
   - Review version history before publishing

     **Example Prompt:** "Show me the version history of the Pricing page"

     **Required Tool Collections:** `content`, `versioning`

   - Rollback to a previous version

     **Example Prompt:** "Roll back the Homepage to the version from last Friday"

     **Required Tool Collections:** `content`, `versioning`

## Media Management

5. **Browsing and Organizing Media**
   - Search for specific media items

     **Example Prompt:** "Find the team photo uploaded last month"

     **Required Tool Collections:** `media`

   - Create folder structures to organize media

     **Example Prompt:** "Create a new folder called '2025 Campaign Assets' in the Marketing folder"

     **Required Tool Collections:** `media`, `media-management`

   - Move media items between folders

     **Example Prompt:** "Move all the product images from the Temp folder to the Product Photos folder"

     **Required Tool Collections:** `media`, `media-management`

6. **Media Uploads**
   - Upload files to the media library

     **Example Prompt:** "Upload the new company logo from my downloads folder to the Logos media folder"

     **Required Tool Collections:** `media`, `media-management`

   - Restore accidentally deleted media

     **Example Prompt:** "Restore the banner image I deleted yesterday"

     **Required Tool Collections:** `media-management`

## Translation and Localization

7. **Managing Language Variants**
   - Create a new language variant for a page

     **Example Prompt:** "Create a Danish variant of the About Us page"

     **Required Tool Collections:** `content`, `translation`, `language`

   - Copy content from one language to another as a translation starting point

     **Example Prompt:** "Copy the English content of the Homepage to the German variant so I can translate it"

     **Required Tool Collections:** `content`, `translation`

   - Find pages missing translations

     **Example Prompt:** "Which pages under Products don't have a French variant yet?"

     **Required Tool Collections:** `translation`, `language`

8. **Dictionary Management**
   - Manage UI labels and static text translations

     **Example Prompt:** "Add a dictionary item `Buttons.ReadMore` with English 'Read More' and Danish 'Læs Mere'"

     **Required Tool Collections:** `dictionary`, `language`

   - Search for existing dictionary entries

     **Example Prompt:** "Find all dictionary items with 'Button' in the key name"

     **Required Tool Collections:** `dictionary`

9. **Translation Coverage Reporting**
   - Get a translation coverage overview

     **Example Prompt:** "Show me the translation coverage matrix for all pages under the Products section"

     **Required Tool Collections:** `content-reporting`

## Content Health and SEO

10. **SEO Auditing**
    - Audit a page's SEO health

      **Example Prompt:** "Run an SEO audit on the Homepage"

      **Required Tool Collections:** `content-health`

    - Check meta descriptions against actual content

      **Example Prompt:** "Check if the About Us page meta description matches the page content"

      **Required Tool Collections:** `content-health`

    - Find images missing alt text

      **Example Prompt:** "Find all images in the media library that are missing alt text"

      **Required Tool Collections:** `content-health`

11. **Content Quality**
    - Find thin content pages

      **Example Prompt:** "Find all pages with fewer than 50 words of content"

      **Required Tool Collections:** `content-health`

    - Identify stale content

      **Example Prompt:** "Show me all pages that haven't been updated in over a year"

      **Required Tool Collections:** `content-reporting`

## Content Reporting

12. **Content Analytics**
    - See a breakdown of content by Document Type

      **Example Prompt:** "How many pages do we have of each Document Type?"

      **Required Tool Collections:** `content-reporting`

    - Review recently changed content

      **Example Prompt:** "What pages were changed this week?"

     **Required Tool Collections:** `content-reporting`

## Site Structure Analysis

13. **Site Architecture**
    - Get a site tree overview

      **Example Prompt:** "Show me the site tree structure with page counts per level"

      **Required Tool Collections:** `site-structure`

    - Find deeply nested pages

      **Example Prompt:** "Find pages that are more than 4 levels deep in the site tree"

      **Required Tool Collections:** `site-structure`

## Content Relationships

14. **Understanding Content Dependencies**
    - Find orphan pages with no inbound references

      **Example Prompt:** "Find pages that aren't referenced by any other page"

      **Required Tool Collections:** `relationships`

    - Check what references a page before deleting it

      **Example Prompt:** "Show me which pages reference the Legacy Products page"

      **Required Tool Collections:** `relationships`

    - See everything a page links to

      **Example Prompt:** "Show me all the internal pages, media items, and external URLs that the Homepage links to"

      **Required Tool Collections:** `relationships`

    - Audit outbound links before restructuring

      **Example Prompt:** "Before I move the Services section, show me what the Services landing page links to"

      **Required Tool Collections:** `relationships`

## Bulk Operations

14. **Batch Publishing**
    - Publish multiple pages at once

      **Example Prompt:** "Publish these 5 blog posts that are ready to go live"

      **Required Tool Collections:** `content`, `bulk-operations`

    - Schedule a batch of pages for future publishing

      **Example Prompt:** "Schedule all the Christmas campaign pages to publish on December 1st at 9am"

      **Required Tool Collections:** `bulk-operations`

15. **Batch Content Updates**
    - Update a property on multiple pages

      **Example Prompt:** "Set the `showBanner` property to false on all Event pages"

      **Required Tool Collections:** `content`, `bulk-operations`

    - Move multiple pages to a new location

      **Example Prompt:** "Move all the 2024 news articles into an Archive/2024 folder"

      **Required Tool Collections:** `content`, `bulk-operations`

    - Update block content across multiple pages

      **Example Prompt:** "Update the Call To Action block's button text to 'Get Started' on all Product pages"

      **Required Tool Collections:** `content`, `bulk-operations`

## Member Management

16. **Managing Members**
    - Search for and review member profiles

      **Example Prompt:** "Find the member with email john@example.com and show me their full profile"

      **Required Tool Collections:** `member`

    - Create new member accounts

      **Example Prompt:** "Create a new member account for Jane Smith with email jane@example.com in the Premium Members group"

      **Required Tool Collections:** `member`, `member-group`

    - Review member activity

      **Example Prompt:** "Show me members who haven't logged in for over 6 months"

      **Required Tool Collections:** `member-reporting`

17. **Member Reporting**
    - Get member count breakdowns

      **Example Prompt:** "How many members do we have in each member group?"

      **Required Tool Collections:** `member-reporting`

## Scheduling

18. **Content Scheduling**
    - Schedule a page for future publishing

      **Example Prompt:** "Schedule the New Year Sale page to publish on January 1st at midnight"

      **Required Tool Collections:** `content`, `scheduling`

    - Review scheduled content

      **Example Prompt:** "What pages are currently scheduled to be published?"

      **Required Tool Collections:** `scheduling`

    - Cancel a scheduled publish

      **Example Prompt:** "Cancel the scheduled publish for the Spring Campaign page"

      **Required Tool Collections:** `scheduling`

## Redirects

19. **URL Redirect Management**
    - Review existing redirects

      **Example Prompt:** "List all URL redirects on the site"

      **Required Tool Collections:** `redirect`

    - Check redirect tracking status

      **Example Prompt:** "Is automatic URL redirect tracking enabled?"

      **Required Tool Collections:** `redirect`

    - Clean up old redirects

      **Example Prompt:** "Delete the redirect for /old-about-us"

      **Required Tool Collections:** `redirect`

## Blueprints and Templates

20. **Working with Blueprints**
    - List available page blueprints

      **Example Prompt:** "What page blueprints are available?"

      **Required Tool Collections:** `blueprint`

    - Save a page as a blueprint for reuse

      **Example Prompt:** "Save the Product Landing Page as a blueprint called 'Standard Product Page'"

      **Required Tool Collections:** `content`, `blueprint`

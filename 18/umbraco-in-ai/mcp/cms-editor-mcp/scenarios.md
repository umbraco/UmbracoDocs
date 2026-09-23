---
description: Common use cases for the Editor MCP
---

# Use Cases

This document provides practical examples of how to use the Editor MCP for common Umbraco editorial tasks. Each scenario includes an example prompt that demonstrates how to accomplish a real-world operation through conversation.

Your AI assistant is often connected to more than the Editor MCP, or connector, in the same conversation. It might also have access to Google Drive, Slack, or a shared folder, for example.

Combining these lets you turn a meeting transcript into a draft blog post. It also lets you pull photos from a shared folder into the media library. Or turn a spreadsheet of page names into a bulk update, without leaving the chat.

Some of the prompts below show this pattern. It works with whichever other tools your AI host is connected to, whether they run as a hosted service or locally on your machine. Google Drive is one example.

## Table of Contents

- [Content Management](#content-management)
- [Publishing Workflows](#publishing-workflows)
- [Media Management](#media-management)
- [Library Elements](#library-elements)
- [Translation and Localization](#translation-and-localization)
- [Content Health and SEO](#content-health-and-seo)
- [Site Structure Analysis](#site-structure-analysis)
- [Content Relationships](#content-relationships)
- [Bulk Operations](#bulk-operations)
- [Member Management](#member-management)
- [Scheduling](#scheduling)
- [Redirects](#redirects)
- [Blueprints and Templates](#blueprints-and-templates)

## Content Management

1. **Creating and Editing Content**
   - Turn source material into a new page

     **Example Prompt:** "Turn yesterday's meeting transcript from Google Drive into a Blog Post page called 'Summer Product Launch' under News."

   - Edit existing page content by describing the changes

     **Example Prompt:** "Update the About Us page intro text to mention our new office in Copenhagen."

   - Work with block-based content editors

     **Example Prompt:** "Show me the blocks on the Homepage and update the hero banner heading to 'Welcome to Our New Site'."

   - Navigate and explore the site tree

     **Example Prompt:** "Show me all pages under the Products section."

## Publishing Workflows

2. **Single and Multi-page Publishing**
   - Publish a page and all its children

     **Example Prompt:** "Publish the Summer Campaign page and all its child pages."

   - Unpublish outdated content

     **Example Prompt:** "The Winter Sale ended yesterday — unpublish the landing page."

3. **Version Management**
   - Review version history before publishing

     **Example Prompt:** "Show me the version history of the Pricing page."

   - Rollback to a previous version

     **Example Prompt:** "The Homepage looks wrong after last night's edit — roll it back to the version from last Friday."

## Media Management

4. **Browsing and Organizing Media**
   - Search for specific media items

     **Example Prompt:** "Find the team photo uploaded last month."

   - Create folder structures to organize media

     **Example Prompt:** "Create a new folder called '2025 Campaign Assets' in the Marketing folder."

   - Move media items between folders

     **Example Prompt:** "Move all the product images from the Temp folder to the Product Photos folder."

5. **Media Uploads**
   - Upload files from a shared source

     **Example Prompt:** "The photographer shared this week's product shots in our Google Drive folder — upload them to the Logos media folder with sensible names."

   - Restore accidentally deleted media

     **Example Prompt:** "I deleted the banner image by mistake yesterday — can you restore it?"

## Library Elements

6. **Working with Reusable Elements**
   - Create a new Library element

     **Example Prompt:** "Create a new Testimonial element called 'Customer Story - Acme Corp' in the Library and publish it."

   - Reuse an element's blocks across pages

     **Example Prompt:** "Show me the blocks inside the 'Pricing Table' element and update the middle tier's price to 499 kr."

   - Organize the Library

     **Example Prompt:** "Create a folder called 'Testimonials' in the Library and move the customer story elements into it."

## Translation and Localization

7. **Managing Language Variants**
   - Create a new language variant for a page

     **Example Prompt:** "Create a Danish variant of the About Us page."

   - Copy content from one language to another as a translation starting point

     **Example Prompt:** "Copy the English content of the Homepage to the German variant so our translator has something to start from."

   - Find pages missing translations

     **Example Prompt:** "Which pages under Products don't have a French variant yet?"

8. **Dictionary Management**
   - Manage UI labels and static text translations

     **Example Prompt:** "Add a dictionary item `Buttons.ReadMore` with English 'Read More' and Danish 'Læs Mere'."

   - Search for existing dictionary entries

     **Example Prompt:** "Find all dictionary items with 'Button' in the key name."

## Content Health and SEO

9. **SEO Auditing**
   - Audit a page's SEO health

     **Example Prompt:** "Run an SEO audit on the Homepage."

   - Check meta descriptions against actual content

     **Example Prompt:** "Does the About Us page meta description still match what's on the page?"

## Site Structure Analysis

10. **Site Architecture**
    - Get a site tree overview

      **Example Prompt:** "Show me the site tree structure with page counts per level."

    - Find deeply nested pages

      **Example Prompt:** "Visitors say they can't find some pages — find anything more than 4 levels deep in the site tree."

## Content Relationships

11. **Understanding Content Dependencies**
    - Check what references a page before deleting it

      **Example Prompt:** "I want to delete the Legacy Products page — show me what still links to it first."

    - See everything a page links to

      **Example Prompt:** "Show me all the internal pages, media items, and external URLs that the Homepage links to."

    - Audit outbound links before restructuring

      **Example Prompt:** "Before I move the Services section, show me what the Services landing page links to."

## Bulk Operations

12. **Batch Publishing**
    - Publish multiple pages at once

      **Example Prompt:** "Publish these 5 blog posts that are ready to go live."

    - Schedule a batch of pages for future publishing

      **Example Prompt:** "Schedule all the Christmas campaign pages to publish on December 1st at 9am."

13. **Batch Content Updates**
    - Update a property on multiple pages from a list

      **Example Prompt:** "Marketing sent this spreadsheet of Event pages — turn off `showBanner` for every page on the list."

    - Move multiple pages to a new location

      **Example Prompt:** "Move all the 2024 news articles into an Archive/2024 folder."

    - Update block content across multiple pages

      **Example Prompt:** "Update the Call To Action block's button text to 'Get Started' on all Product pages."

## Member Management

14. **Managing Members**
    - Search for and review member profiles

      **Example Prompt:** "Find the member with email john@example.com and show me their full profile."

    - Create new member accounts

      **Example Prompt:** "Create a new member account for Jane Smith with email jane@example.com in the Premium Members group."

    - Review member activity

      **Example Prompt:** "Show me members who haven't logged in for over 6 months."

15. **Member Reporting**
    - Get member count breakdowns

      **Example Prompt:** "How many members do we have in each member group?"

## Scheduling

16. **Content Scheduling**
    - Schedule a page for future publishing

      **Example Prompt:** "Schedule the New Year Sale page to publish on January 1st at midnight."

    - Cancel a scheduled publish

      **Example Prompt:** "The Spring Campaign launch got pushed back — cancel its scheduled publish."

## Redirects

17. **URL Redirect Management**
    - Review existing redirects

      **Example Prompt:** "List all URL redirects on the site."

    - Check redirect tracking status

      **Example Prompt:** "Is automatic URL redirect tracking enabled?"

    - Clean up old redirects

      **Example Prompt:** "Delete the redirect for /old-about-us — it's not needed anymore."

## Blueprints and Templates

18. **Working with Blueprints**
    - List available page blueprints

      **Example Prompt:** "What page blueprints are available?"

    - Save a page as a blueprint for reuse

      **Example Prompt:** "Save the Product Landing Page as a blueprint called 'Standard Product Page'."

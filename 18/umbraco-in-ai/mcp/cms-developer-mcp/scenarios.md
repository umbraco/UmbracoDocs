---
description: Common useful scenarios for the developer MCP
---

# Use Cases

This document provides practical examples of how to use the Developer MCP for common Umbraco tasks.
Each scenario includes example prompts that demonstrate how to accomplish real-world operations using the available MCP tools.

## Table of Contents

- [Content Management Automation](#content-management-automation)
- [Media Management](#media-management)
- [Site Structure & Configuration](#site-structure-and-configuration)
- [Development & DevOps](#development-and-devops)
- [Monitoring & Maintenance](#monitoring-and-maintenance)
- [User & Permissions Management](#user-and-permissions-management)
- [Content Analysis & Reporting](#content-analysis-and-reporting)
- [Multi-language & Localization](#multi-language-and-localization)
- [Advanced Workflows](#advanced-workflows)
- [API & Integration Use Cases](#api-and-integration-use-cases)

## Content Management Automation

1. **Bulk Content Creation**
   - Automatically create multiple documents from CSV/JSON/MD data together with the Filesystem MCP

     **Example Prompt:** "Read blog-posts.csv and create a Blog Post document for each row under /blog"

     **Required Tool Collections:** `document`, `document-type`  

   - Generate landing pages from templates with dynamic content

     **Example Prompt:** "Read cities.csv and create city landing pages using the City Landing Page Document Type for each UK city"

     **Required Tool Collections:** `document`, `document-type`

   - Import product catalogs into Umbraco document structure

     **Example Prompt:** "Import the product catalog from catalog.json and create the appropriate document hierarchy"

     **Required Tool Collections:** `document`, `document-type`

   - Create multi-language content variants programmatically

     **Example Prompt:** "For all documents under /news, create German and French language variants with placeholder content"

     **Required Tool Collections:** `document`, `language`

2. **Content Migration & Synchronization**
   - Migrate content from external CMS to Umbraco

     **Example Prompt:** "Import all blog posts from the WordPress export file and create them as Blog Post documents"

     **Required Tool Collections:** `document`, `document-type`

   - Sync content between staging and production environments

     **Example Prompt:** "Compare the /products section between staging and production and show me what's different"

     **Required Tool Collections:** `document`

   - Create document blueprints from existing successful pages

     **Example Prompt:** "Analyze the top 10 performing blog posts and create blueprints based on their structure and content patterns"

     **Required Tool Collections:** `document`, `document-blueprint`

   - Copy and adapt content structures across sites

     **Example Prompt:** "Copy the entire /services structure to /solutions, but update all 'service' terminology to 'solution', fix internal links, and update the navigation metadata"

     **Required Tool Collections:** `document`

3. **Publishing Workflows**
   - Schedule bulk publishing of seasonal content

     **Example Prompt:** "Find all documents tagged 'Christmas Campaign' and publish them all at once"

     **Required Tool Collections:** `document`, `tag`

   - Publish document hierarchies with descendants

     **Example Prompt:** "Publish all pages under /summer-2025 that have a publishDate in the past and are still in draft, including all their child pages"

     **Required Tool Collections:** `document`

   - Auto-publish time-sensitive content (events, promotions)

     **Example Prompt:** "Find all Event documents where eventDate is in the next 48 hours and publish them if they're in draft"

     **Required Tool Collections:** `document`

   - Content Review Reminders: Identify stale content needing updates

     **Example Prompt:** "List all published documents that haven't been updated in over 12 months"

     **Required Tool Collections:** `document`

4. **Content Quality Validation Pipeline**
   - Run automated content checks (spell check, SEO validation, broken links)

     **Example Prompt:** "Check all Blog Post documents and report any with titles over 60 characters or missing meta descriptions"

     **Required Tool Collections:** `document`, `document-type`

   - Validate required fields and metadata completeness

     **Example Prompt:** "Audit all Product documents and show me which ones are missing required fields like price or category"

     **Required Tool Collections:** `document`, `document-type`

   - Check content against brand guidelines and style rules

     **Example Prompt:** "Find all pages where the main heading doesn't follow our title case convention"

     **Required Tool Collections:** `document`

   - Ensure all media references are valid and optimized

     **Example Prompt:** "Check all documents for broken media references and list any images over 2MB"

     **Required Tool Collections:** `document`, `media`

## Media Management

5. **Asset Management**
   - Batch upload media files from local directories

     **Example Prompt:** "Upload all images from the /downloads/product-photos folder to the Product Images media folder"

     **Required Tool Collections:** `media`, `temporary-file`

   - Organize media into folder structures programmatically

     **Example Prompt:** "Move all media items tagged 'press-kit-2024' into a new folder called Press/2024"

     **Required Tool Collections:** `media`

   - Audit and optimize media file sizes

     **Example Prompt:** "Find all images in the Team Photos folder and create a report showing their dimensions, file sizes, and which pages use them"

     **Required Tool Collections:** `media`

   - Track and audit media usage across content

     **Example Prompt:** "Show me which documents are using the hero-banner.jpg image"

     **Required Tool Collections:** `media`

   - Identify and clean up unused media assets

     **Example Prompt:** "Find all media items that aren't referenced by any published content"

     **Required Tool Collections:** `media`

6. **Media Integration**
   - Upload media from web URLs

     **Example Prompt:** "Download all the product images from these URLs and upload them to the Products media folder with appropriate naming"

     **Required Tool Collections:** `media`, `temporary-file`

   - Process and upload user-generated content

     **Example Prompt:** "Upload the submitted testimonial photos and link them to the corresponding Testimonial documents"

     **Required Tool Collections:** `media`, `temporary-file`

   - Create media with proper metadata and tags

     **Example Prompt:** "Upload these images and automatically tag them based on their filenames"

     **Required Tool Collections:** `media`

   - Manage media references and dependencies

     **Example Prompt:** "Update all references to old-logo.png to use new-logo.png instead"

     **Required Tool Collections:** `media`

## Site Structure & Configuration

7. **Document Type Management**
   - Create Document Types from JSON schemas

     **Example Prompt:** "Create a new FAQ Page Document Type with a title, rich text intro, and repeatable FAQ items block list"

     **Required Tool Collections:** `document-type`

   - Update property configurations across multiple types

     **Example Prompt:** "Add a 'Last Reviewed Date' property to all Document Types that have the SEO composition"

     **Required Tool Collections:** `document-type`

   - Manage compositions and inheritance structures

     **Example Prompt:** "Create a Social Media composition with Open Graph properties and apply it to all page types"

     **Required Tool Collections:** `document-type`

   - Generate element types for Block List/Grid configurations

     **Example Prompt:** "Create element types for Call To Action, Image Gallery, and Video blocks"

     **Required Tool Collections:** `document-type`

8. **Data Type Administration**
   - Create custom Data Types with specific property editors

     **Example Prompt:** "Create a color picker Data Type limited to our brand colors: #FF0000, #00FF00, #0000FF"

     **Required Tool Collections:** `data-type`

   - Update Data Type configurations globally

     **Example Prompt:** "Update the Rich Text Editor Data Type to enable the source code button"

     **Required Tool Collections:** `data-type`

   - Find and manage Data Type references

     **Example Prompt:** "Show me all Document Types using the 'Legacy Rich Text' Data Type"

     **Required Tool Collections:** `data-type`, `document-type`

   - Migrate between different property editor configurations

     **Example Prompt:** "Update all properties using the old Media Picker to use the new Media Picker 3"

     **Required Tool Collections:** `data-type`

   - Standardize property appearance settings

     **Example Prompt:** "Update all Rich Text Editor properties across all Document Types to use 'Label above' appearance"

     **Required Tool Collections:** `document-type`

9. **Template Management**
   - Execute template queries to test content rendering

     **Example Prompt:** "Test render the /products/widget-pro page using the Product Detail template"

     **Required Tool Collections:** `template`, `document`

   - Search and update template code

     **Example Prompt:** "Find all templates that reference the old ViewHelper and update them to use the new one"

     **Required Tool Collections:** `template`

## Development & DevOps

10. **CI/CD Integration**
    - Export/import Document Type definitions for version control

      **Example Prompt:** "Export all Document Type definitions to JSON files for commit to our repo"

      **Required Tool Collections:** `document-type`

    - Automate environment setup and configuration

      **Example Prompt:** "Set up the Document Type structure from our schema files in this fresh Umbraco instance"

      **Required Tool Collections:** `document-type`

    - Deploy content structure changes across environments

      **Example Prompt:** "Compare Document Types between dev and staging and generate a migration plan"

      **Required Tool Collections:** `document-type`

    - Validate content before deployment

      **Example Prompt:** "Check that all required Document Types exist before deploying content"

      **Required Tool Collections:** `document-type`

11. **Code Generation**
    - Trigger Models Builder to generate strongly-typed models

      **Example Prompt:** "Regenerate all ModelsBuilder models after the Document Type changes"

      **Required Tool Collections:** `models-builder`

    - Create scripts and stylesheets programmatically

      **Example Prompt:** "Create a new stylesheet called `landing-page.css` with our standard structure"

      **Required Tool Collections:** `stylesheet`, `script`

    - Generate partial views from templates

      **Example Prompt:** "Create partial views for each of our navigation components"

      **Required Tool Collections:** `partial-view`

    - Automate boilerplate code creation

      **Example Prompt:** "Generate a surface controller template for handling form submissions"

      **Required Tool Collections:** `template`

## Monitoring & Maintenance

12. **Health Monitoring**
    - Run system health checks programmatically

      **Example Prompt:** "Run all health checks and report any that are in warning or error state"

      **Required Tool Collections:** `health`

    - Monitor server status and performance

      **Example Prompt:** "Check the server status and tell me if there are any performance issues"

      **Required Tool Collections:** `server`

    - Execute remedial actions for issues

      **Example Prompt:** "If the HTTPS check fails, show me the current configuration and suggest fixes"

      **Required Tool Collections:** `health`

    - Track system diagnostics and troubleshooting data

      **Example Prompt:** "Generate a diagnostic report for our support ticket including all health check results"

      **Required Tool Collections:** `health`, `server`

13. **Log Analysis**
    - Search and filter log entries

      **Example Prompt:** "Show me all error log entries from the last 24 hours"

      **Required Tool Collections:** `log-viewer`

    - Create saved searches for common issues

      **Example Prompt:** "Create a saved search for all SQL timeout errors"

      **Required Tool Collections:** `log-viewer`

    - Monitor error patterns and trends

      **Example Prompt:** "Find the most common error messages in the past week"

      **Required Tool Collections:** `log-viewer`

    - Generate reports from log data

      **Example Prompt:** "Create a summary report of all errors grouped by message type"

      **Required Tool Collections:** `log-viewer`

14. **Search & Indexing**
    - Rebuild search indexes automatically

      **Example Prompt:** "Rebuild the external search index"

      **Required Tool Collections:** `indexer`

    - Query content using custom searchers

      **Example Prompt:** "Search for all documents containing 'sustainability' using the external index"

      **Required Tool Collections:** `searcher`

    - Monitor index status and health

      **Example Prompt:** "Check if all Examine indexes are healthy and report any issues"

      **Required Tool Collections:** `indexer`

    - Optimize search performance

      **Example Prompt:** "Show me which indexes are largest and might need optimization"

      **Required Tool Collections:** `indexer`

## User & Permissions Management

15. **User Group Administration**
    - Create and configure user groups

      **Example Prompt:** "Create a 'Content Reviewer' user group with read access to all content but no publish rights"

      **Required Tool Collections:** `user-group`

    - Audit user group configurations

      **Example Prompt:** "Show me all user groups and their permission levels"

      **Required Tool Collections:** `user-group`

    - Update user group settings

      **Example Prompt:** "Update the Marketing user group to allow access to the Media section"

      **Required Tool Collections:** `user-group`

    - Clean up unused user groups

      **Example Prompt:** "Find and delete any user groups that have no users assigned to them"

      **Required Tool Collections:** `user-group`, `user`

16. **Member Management**
    - Create member accounts programmatically

      **Example Prompt:** "Create member accounts for all email addresses in the subscribers.csv file"

      **Required Tool Collections:** `member`, `member-type`

    - Manage member groups and properties

      **Example Prompt:** "Add all members with 'premium' status to the Premium Members group"

      **Required Tool Collections:** `member`, `member-group`

    - Update member type configurations

      **Example Prompt:** "Add a 'Subscription Expiry Date' property to the Member type"

      **Required Tool Collections:** `member-type`

    - Track member engagement and access

      **Example Prompt:** "Find all members who haven't logged in for 6 months"

      **Required Tool Collections:** `member`

## Content Analysis & Reporting

17. **Content Auditing**
    - Audit content relationships and dependencies

      **Example Prompt:** "Show me all relations of type 'Related Links' for documents under /products"

      **Required Tool Collections:** `relation`, `relation-type`, `document`

    - Analyze content tree structure for impact

      **Example Prompt:** "List all descendant pages under /products/legacy so I can understand the impact of deletion"

      **Required Tool Collections:** `document`

    - Identify content without required metadata

      **Example Prompt:** "Find all published pages that are missing SEO metadata like meta descriptions or Open Graph tags"

      **Required Tool Collections:** `document`

    - Generate content dependency reports

      **Example Prompt:** "Create a report showing the content hierarchy and dependencies for the /services section"

      **Required Tool Collections:** `document`

18. **Version Control**
    - Manage document versions programmatically

      **Example Prompt:** "Show me all versions of the homepage from the last 30 days"

      **Required Tool Collections:** `document-version`

    - Rollback to previous versions

      **Example Prompt:** "Rollback the /pricing page to the version from last Friday"

      **Required Tool Collections:** `document-version`

    - Prevent cleanup of important versions

      **Example Prompt:** "Mark the current version of all legal pages as 'keep forever'"

      **Required Tool Collections:** `document-version`

    - Audit content changes over time

      **Example Prompt:** "Show me who made changes to documents under /products in the last week"

      **Required Tool Collections:** `document-version`

## Multi-language & Localization

19. **Language Management**
    - Configure languages and fallback chains

      **Example Prompt:** "Add Spanish as a new language with English as the fallback"

      **Required Tool Collections:** `language`

    - Create multi-language content variants

      **Example Prompt:** "Create French variants for all pages under /products that don't have them yet"

      **Required Tool Collections:** `document`, `language`

    - Manage dictionary items for translations

      **Example Prompt:** "Add dictionary items for all our standard UI labels with English and German translations"

      **Required Tool Collections:** `dictionary`, `language`

    - Bulk update culture-specific content

      **Example Prompt:** "Update all German content to use the formal 'Sie' instead of informal 'du'"

      **Required Tool Collections:** `document`, `language`

## Advanced Workflows

20. **Custom Webhooks**
    - Set up webhooks for content events

      **Example Prompt:** "Find the publish event, then create a webhook that posts to our Slack webhook URL whenever a page is published"

      **Required Tool Collections:** `webhook`

    - Monitor webhook execution logs

      **Example Prompt:** "Use get-all-webhook-logs to show me the last 50 webhook events and any that failed"

      **Required Tool Collections:** `webhook`

    - Integrate with external systems on content changes

      **Example Prompt:** "Use create-webhook to set up a webhook that calls https://api.example.com/sync when Product documents are published, triggering on the Content.Published event"

      **Required Tool Collections:** `webhook`

    - Automate notifications and integrations

      **Example Prompt:** "Create webhooks to notify our CDN purge endpoint at `https://cloudflare/` whenever content in `/news` is published"

      **Required Tool Collections:** `webhook`

21. **Redirect Management**
    - Create and manage URL redirects

      **Example Prompt:** "Create a 301 redirect from /old-services to /services"

      **Required Tool Collections:** `redirect`

    - Import bulk redirect rules

      **Example Prompt:** "Import all the redirects from redirects.csv"

      **Required Tool Collections:** `redirect`

    - Monitor redirect usage

      **Example Prompt:** "Show me which redirects have been hit in the last 30 days"

      **Required Tool Collections:** `redirect`

    - Maintain SEO during content restructuring

      **Example Prompt:** "When I move /products/widget to /solutions/widget, create the appropriate redirects"

      **Required Tool Collections:** `redirect`

## API & Integration Use Cases

22. **AI-Powered Content Management**
    - Generate content using AI and publish to Umbraco

      **Example Prompt:** "Generate product descriptions for all products missing them and save as drafts for review"

      **Required Tool Collections:** `document`

    - Automatically tag and categorize content

      **Example Prompt:** "Analyze all blog posts and suggest appropriate category tags based on content"

      **Required Tool Collections:** `document`, `tag`

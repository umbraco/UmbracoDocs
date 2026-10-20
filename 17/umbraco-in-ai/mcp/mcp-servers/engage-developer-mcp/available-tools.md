---
description: List of tools that are enabled in the Engage Developer MCP
---

# Available Tools

This document lists all available tools grouped according to the categories defined in the **Umbraco Engage Management API**.
Each section represents a functional area of the API, following the grouping and naming conventions used in Umbraco Engage's backend services.

The names shown in parentheses, for example, `(ab-test)` or `(segments)` refer to the **Tool Collection names**, which are used for configuration via environment variables: `UMBRACO_INCLUDE_TOOL_COLLECTIONS` or `UMBRACO_EXCLUDE_TOOL_COLLECTIONS`.

This server also chains to the [Umbraco CMS Developer MCP](../cms-developer-mcp/README.md), whose tools are proxied with a `cms:` prefix (for example, `cms:get-document`). See [Configuration Options](configuration.md#cms-mcp-server-chaining) for details. Those chained tools are documented on the [CMS Available Tools](../cms-developer-mcp/available-tools.md) page and are not repeated here.

## Table of Contents

- [A/B Test (`ab-test`)](#ab-test-ab-test)
- [A/B Test Project (`ab-test-project`)](#ab-test-project-ab-test-project)
- [A/B Test Variant (`ab-test-variant`)](#ab-test-variant-ab-test-variant)
- [Add-ons (`add-ons`)](#add-ons-add-ons)
- [Analytics (`analytics`)](#analytics-analytics)
- [Annotations (`annotations`)](#annotations-annotations)
- [Applied Personalization (`applied-personalization`)](#applied-personalization-applied-personalization)
- [Campaign Group (`campaign-group`)](#campaign-group-campaign-group)
- [Campaigns (`campaigns`)](#campaigns-campaigns)
- [Configuration (`configuration`)](#configuration-configuration)
- [Content Scoring (`content-scoring`)](#content-scoring-content-scoring)
- [Content Types (`content-types`)](#content-types-content-types)
- [Cultures (`cultures`)](#cultures-cultures)
- [Customer Journey (`customer-journey`)](#customer-journey-customer-journey)
- [Data Cleanup (`data-cleanup`)](#data-cleanup-data-cleanup)
- [Document Type Permissions (`document-type-permissions`)](#document-type-permissions-document-type-permissions)
- [Goal (`goal`)](#goal-goal)
- [Goals (`goals`)](#goals-goals)
- [Heatmaps (`heatmaps`)](#heatmaps-heatmaps)
- [Main Switch (`main-switch`)](#main-switch-main-switch)
- [Package (`package`)](#package-package)
- [Persona (`persona`)](#persona-persona)
- [Profile (`profile`)](#profile-profile)
- [Referral Group (`referral-group`)](#referral-group-referral-group)
- [Referral Scoring (`referral-scoring`)](#referral-scoring-referral-scoring)
- [Reporting (`reporting`)](#reporting-reporting)
- [Search Terms (`search-terms`)](#search-terms-search-terms)
- [Segments (`segments`)](#segments-segments)
- [Statistics (`statistics`)](#statistics-statistics)
- [Suspicious Activity (`suspicious-activity`)](#suspicious-activity-suspicious-activity)
- [Traffic Filter (`traffic-filter`)](#traffic-filter-traffic-filter)
- [User Group Permissions (`user-group-permissions`)](#user-group-permissions-user-group-permissions)

## A/B Test (`ab-test`)

- `delete-ab-test` — Delete an A/B test
- `get-ab-test` — Get a single A/B test
- `get-ab-test-all` — List every A/B test in the site
- `get-ab-test-empty` — Get a blank draft A/B test template for the given test type
- `get-ab-test-page` — List all A/B tests that target a given Umbraco content page
- `get-ab-test-preview-url` — Get a preview URL for a specific A/B test variant
- `get-ab-test-view-model` — Get a single A/B test
- `post-ab-test` — Create a new A/B test in Draft status against a real content page, comparing an implicit Original benchmark variant to one named second variant
- `post-ab-test-runtime-indication` — Estimate how long an A/B test would need to run to reach statistical significance, given participation rate, minimum detectable effect, expected daily visitors, baseline conversion rate, and variant count
- `post-ab-test-segment` — Record which A/B test variant segment a visitor falls into, by writing an empty segment-varying property value onto the target content page
- `post-ab-test-start` — Start, schedule, or reschedule a not-yet-stopped A/B test by setting its start time
- `post-ab-test-stop` — Stop or mark complete an existing, already-started A/B test
- `post-ab-test-variant-details` — Compute per-variant conversion statistics for a set of named A/B test variants

## A/B Test Project (`ab-test-project`)

- `delete-ab-test-project` — Delete an A/B test project
- `get-ab-test-project` — Get a single A/B test project
- `get-ab-test-project-all` — List every A/B test project
- `get-ab-test-project-details` — Get a summarized overview of an A/B test project
- `post-ab-test-project` — Create a new, empty A/B test project
- `put-ab-test-project` — Update an existing A/B test project's fields

## A/B Test Variant (`ab-test-variant`)

- `delete-ab-test-variant` — Delete an A/B test variant
- `get-ab-test-variant` — Get a single A/B test variant
- `get-ab-test-variant-all` — List A/B test variants
- `get-ab-test-variant-segment` — Get the A/B test variant currently assigned to a given visitor segment
- `post-ab-test-variant` — Update an existing A/B test variant's fields
- `post-ab-test-variant-create` — Add a new, blank variant to an existing A/B test
- `post-ab-test-variant-disable` — Disable an existing A/B test variant

## Add-ons (`add-ons`)

- `get-add-ons` — Report whether the Umbraco Forms and Umbraco Commerce add-on integrations are currently enabled for this Engage installation

## Analytics (`analytics`)

- `get-analytics-distinct` — List the distinct values recorded for a given analytics dimension
- `post-analytics-query` — Run a read-only aggregated analytics report over a date range, grouped by dimensions and measured by metrics

## Annotations (`annotations`)

- `delete-annotations` — Delete an annotation
- `get-annotations-all` — List analytics annotations
- `get-annotations-empty` — Get a blank annotation template with default field values
- `get-annotations-global` — List global analytics annotations
- `get-annotations-page` — List analytics annotations
- `post-annotations` — Create a new analytics annotation

## Applied Personalization (`applied-personalization`)

- `delete-applied-personalization` — Delete an applied personalization
- `get-applied-personalization-all` — List every applied personalization
- `get-applied-personalization-id` — Get a single applied personalization
- `get-applied-personalization-segment` — Get the applied personalization currently associated with a segment
- `post-applied-personalization` — Create a new applied personalization
- `post-applied-personalization-segment` — Associate an existing applied personalization

## Campaign Group (`campaign-group`)

- `delete-campaign-group` — Delete a campaign group
- `get-campaign-group` — Get a single campaign group
- `get-campaign-group-all` — List every campaign group
- `get-campaign-group-unscored` — List distinct UTM tag combinations
- `get-campaign-group-visitors` — Get visitor counts per campaign group
- `post-campaign-group` — Create a new campaign group, or update an existing one

## Campaigns (`campaigns`)

- `get-campaigns` — List UTM campaign-attribution events recorded for visitors

## Configuration (`configuration`)

- `get-configuration` — Get Umbraco Engage's installation-wide configuration

## Content Scoring (`content-scoring`)

- `delete-content-scoring-journey` — Delete a Journey-type content-scoring row
- `delete-content-scoring-persona` — Delete a Persona-type content-scoring row
- `get-content-scoring-all` — List content-scoring rows
- `get-content-scoring-export-customer-journey` — Export all customer-journey content-scoring data as CSV text
- `get-content-scoring-export-persona` — Export all persona content-scoring data as CSV text
- `post-content-scoring-save` — Save one or more content-scoring rows

## Content Types (`content-types`)

- `get-content-types-all` — List the Umbraco Document Types tracked by Engage
- `get-content-types-segmented-property` — Check whether a Document Type has a property configured for content segmentation

## Cultures (`cultures`)

- `get-cultures` — List the visitor cultures/locales tracked by Umbraco Engage analytics

## Customer Journey (`customer-journey`)

- `delete-customer-journey` — Delete a customer journey
- `get-customer-journey-all` — List all configured customer journeys
- `get-customer-journey-details` — Get a single customer journey and its full steps array
- `get-customer-journey-empty` — Get a blank customer journey template with default field values
- `post-customer-journey` — Create a new customer journey
- `post-customer-journey-lock` — Lock a visitor's customer-journey-step score assignment
- `post-customer-journey-unlock` — Unlock a visitor's customer-journey-step score assignment previously locked

## Data Cleanup (`data-cleanup`)

- `get-data-cleanup-last-run` — Get the status of the most recently completed Engage data-cleanup job
- `get-data-cleanup-logs` — List flat, per-table Engage data-cleanup log entries
- `get-data-cleanup-runs` — List historical Engage data-cleanup runs, most recent first

## Document Type Permissions (`document-type-permissions`)

- `get-permissions-document-type` — Get the Engage access-permissions entry for a Document Type
- `get-permissions-document-type-all` — List Engage access permissions
- `post-permissions-document-type` — Create Engage permissions entries for one or more Document Types

## Goal (`goal`)

- `get-goal-all-types` — List the catalogue of valid goal types
- `get-goal-details` — Get a single goal's full details
- `post-goal` — Create a new goal
- `post-goal-all` — Search goals with pagination, optional name filtering

## Goals (`goals`)

- `get-goals-all` — List every goal, unpaginated
- `get-goals-main` — List goals from the main goals endpoint

## Heatmaps (`heatmaps`)

- `get-heatmaps-variants` — List the distinct URL-variant combinations
- `post-heatmaps-generate-scroll-heatmap` — Generate a scroll-depth heatmap for a page

## Main Switch (`main-switch`)

- `get-main-switch` — Get whether Umbraco Engage tracking is currently enabled site-wide
- `post-main-switch-turn-off` — Turn off Umbraco Engage tracking site-wide
- `post-main-switch-turn-on` — Turn on Umbraco Engage tracking site-wide

## Package (`package`)

- `get-package` — Get the installed Umbraco Engage license and package information

## Persona (`persona`)

- `delete-persona` — Delete a persona group
- `get-persona-all` — List all persona groups
- `get-persona-details` — Get a single persona group's full details
- `get-persona-empty` — Get a blank persona group template with default field values
- `post-persona` — Create a new persona group
- `post-persona-lock` — Lock a visitor's persona score assignment
- `post-persona-unlock` — Unlock a visitor's persona score assignment previously locked

## Profile (`profile`)

- `get-profile-bot-visitors` — List visitors detected as bots, site-wide
- `get-profile-customer-journey-step-scores` — List a visitor's customer-journey-step scores
- `get-profile-details` — Get a visitor's profile summary, including activity and personalization status
- `get-profile-export` — Search visitor profiles with the same filters as post-profile-overview
- `get-profile-goal-completions` — List a visitor's goal completions
- `get-profile-last-active-segment` — List the segment unique GUID(s) most recently active for a visitor
- `get-profile-page-events` — List events recorded within a single pageview
- `get-profile-pageviews` — List the pageviews within a single browsing session
- `get-profile-persona-scores` — List a visitor's persona scores
- `get-profile-potential` — Get a visitor's active and engaged potential scores
- `get-profile-related` — List numeric visitor IDs related to the given member
- `get-profile-sessions` — List a visitor's browsing sessions
- `get-profile-statistics-growth` — Get monthly visitor-growth counts
- `get-profile-statistics-identification` — Get visitor identification counts
- `get-profile-statistics-total` — Get the total count of identified versus unknown visitor profiles, site-wide
- `post-profile-export-csv` — Export visitor profiles matching the same filters as post-profile-overview
- `post-profile-overview` — Search visitor profiles with filters

## Referral Group (`referral-group`)

- `delete-referral-group` — Delete a referral group
- `get-referral-group` — Get a single referral group
- `get-referral-group-all` — List every referral group
- `get-referral-group-visitors` — Get visitor counts per referral group
- `post-referral-group` — Create a new referral group, or update an existing one

## Referral Scoring (`referral-scoring`)

- `post-referral-scoring-scored` — List referral URLs that have been assigned a referral score
- `post-referral-scoring-unscored` — List referral URLs seen in traffic that have not yet been assigned a referral score

## Reporting (`reporting`)

- `get-reporting` — List goal-personalization performance rows
- `get-reporting-generation-status` — Check the status of Engage's reporting-table generation job
- `get-reporting-goal-personalization-performance-by-segment-id` — List goal-personalization performance rows
- `get-reporting-segment-sessions-personalization-by-segment-id` — Get session-count buckets for a segment's personalization view
- `get-reporting-segment-sessions-potential-by-segment-id` — Get session-count buckets for a segment's potential view
- `post-reporting-generation-start` — Start an asynchronous reporting-table generation job

## Search Terms (`search-terms`)

- `get-search-terms` — List on-site search queries recorded by Umbraco Engage

## Segments (`segments`)

- `delete-segments` — Delete a segment
- `delete-segments-delete-segment-content` — Remove tracked content association for an internal A/B testing or personalization segment identifier
- `get-segments` — Get a single segment
- `get-segments-all` — List all visitor segments
- `get-segments-locations-data` — List all countries, provinces, cities, and counties seen across visitor traffic
- `post-segments` — Create a new visitor segment, or update an existing one
- `post-segments-update-priority` — Reorder segments by updating their sort order values

## Statistics (`statistics`)

- `get-statistics` — Get site-wide Umbraco Engage totals for pageviews, visitors, and events

## Suspicious Activity (`suspicious-activity`)

- `get-suspicious-activity-overview` — List visitors flagged with unusually high pageview counts

## Traffic Filter (`traffic-filter`)

- `delete-traffic-filter` — Delete a traffic filter rule
- `get-traffic-filter` — Get a single traffic filter rule
- `get-traffic-filter-all` — List every traffic filter rule
- `get-traffic-filter-empty` — Get a blank traffic filter template with default field values
- `post-traffic-filter` — Create a new traffic filter rule

## User Group Permissions (`user-group-permissions`)

- `get-permissions-user-group` — Get the Engage access-permissions entry for a specific Umbraco user group
- `get-permissions-user-group-all` — List Engage access permissions
- `post-permissions-user-group` — Create an Engage permissions entry for an Umbraco user group

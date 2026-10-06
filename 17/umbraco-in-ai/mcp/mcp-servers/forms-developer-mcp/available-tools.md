---
description: List of tools that are enabled in the Forms Developer MCP
---

# Available Tools

This document lists all available tools, grouped by tool collection. Most collections follow the grouping of the **Umbraco Forms Management API**. The `form-submission` collection uses the Forms Delivery API instead.

The names shown in parentheses, for example, `(form)` or `(record)` refer to the **Tool Collection names**, which are used for configuration via environment variables: `UMBRACO_INCLUDE_TOOL_COLLECTIONS` or `UMBRACO_EXCLUDE_TOOL_COLLECTIONS`.

This server also chains to the [Umbraco CMS Developer MCP](../cms-developer-mcp/README.md), whose tools are proxied with a `cms--` prefix (for example, `cms--get-document-by-id`). See [Configuration Options](configuration.md#cms-mcp-server-chaining) for details. Those chained tools are documented on the [CMS Available Tools](../cms-developer-mcp/available-tools.md) page and are not repeated here.

{% hint style="info" %}
Some tools need a later Umbraco Forms 17.x release. See [Umbraco Forms Version Support](README.md#umbraco-forms-version-support) for the minimum version of each.
{% endhint %}

## Table of Contents

- [Acceptance Tests (`acceptance-tests`)](#acceptance-tests-acceptance-tests)
- [Analytics (`analytics`)](#analytics-analytics)
- [Config (`config`)](#config-config)
- [Data Source (`data-source`)](#data-source-data-source)
- [Data Source Type (`data-source-type`)](#data-source-type-data-source-type)
- [Email Template (`email-template`)](#email-template-email-template)
- [Export (`export`)](#export-export)
- [Field Type (`field-type`)](#field-type-field-type)
- [Folder (`folder`)](#folder-folder)
- [Form (`form`)](#form-form)
- [Form Submission (`form-submission`)](#form-submission-form-submission)
- [Form Template (`form-template`)](#form-template-form-template)
- [Licensing (`licensing`)](#licensing-licensing)
- [Media (`media`)](#media-media)
- [Member (`member`)](#member-member)
- [Picker (`picker`)](#picker-picker)
- [Prevalue Source (`prevalue-source`)](#prevalue-source-prevalue-source)
- [Prevalue Source Type (`prevalue-source-type`)](#prevalue-source-type-prevalue-source-type)
- [Record (`record`)](#record-record)
- [Theme (`theme`)](#theme-theme)
- [Umbraco Server (`umbraco-server`)](#umbraco-server-umbraco-server)
- [Updates (`updates`)](#updates-updates)
- [Workflow Type (`workflow-type`)](#workflow-type-workflow-type)

## Acceptance Tests (`acceptance-tests`)

- `get-acceptance-tests-system-info` — Get the operating system and database engine of the Umbraco Forms instance

## Analytics (`analytics`)

- `query-analytics-origins` — Get a per-page breakdown of where form submissions came from
- `query-analytics-origins-overview` — Get a per-form summary of the pages that submissions came from
- `query-analytics-overview` — Get the Forms dashboard summary for each form, such as entry counts and workflow errors
- `query-analytics-submissions` — Get a time series of form submissions over a date range
- `query-analytics-submissions-hourly` — Get submission volume by hour of day over a date range
- `query-analytics-workflows` — Get the number of workflow runs, successes, and failures for each workflow

## Config (`config`)

- `get-forms-config` — Get the Umbraco Forms backoffice configuration, such as the security mode and allowed file upload types

## Data Source (`data-source`)

- `create-data-source` — Create a data source from a data source type and its settings
- `create-form-from-data-source` — Create a form with fields generated from an existing data source
- `delete-data-source` — Delete a data source
- `get-data-source` — Get a single data source
- `get-data-source-ancestors` — Get the ancestor folders of a data source or folder in the data source tree
- `get-data-source-scaffold` — Get a blank data source with default values
- `get-data-source-tree-root` — List the root-level folders and data sources in the data source tree
- `get-data-source-wizard-scaffold` — Get the default field mappings for generating a form from a data source
- `list-data-sources` — List data sources, with paging
- `update-data-source` — Update the name, type, or settings of a data source

## Data Source Type (`data-source-type`)

- `get-data-source-type-by-id` — Get a single data source type and its settings
- `list-data-source-types` — List all data source types, including types added by packages

## Email Template (`email-template`)

- `get-email-template-tree-children` — List the folders and email templates under a folder in the email template tree
- `get-email-template-tree-root` — List the root-level folders and email templates in the email template tree

## Export (`export`)

- `download-export-file` — Check that a generated record export file is ready, and get its content type and size
- `generate-form-export` — Generate an export file of a form's records, filtered by date range, state, member, or search text
- `list-export-types` — List the available record export formats, such as Excel or CSV

## Field Type (`field-type`)

- `get-field-type-by-id` — Get a single field type and its settings
- `get-field-type-richtext-datatype` — Get the Umbraco Data Type behind the Rich Text field type
- `list-field-type-validation-patterns` — List the predefined validation patterns, such as patterns for email addresses or numbers
- `list-field-types` — List all field types and their settings

## Folder (`folder`)

- `create-folder` — Create a folder, optionally inside another folder
- `delete-folder` — Delete a folder
- `get-folder-by-id` — Get a single folder
- `get-item-folder` — Get the name and ID of one or more folders
- `is-folder-empty` — Check whether a folder is empty before deleting it
- `move-folder` — Move a folder to another parent folder or to the root
- `update-folder` — Rename a folder

## Form (`form`)

- `add-form-fields` — Add fields to an existing form without sending the full form design
- `copy-form` — Copy a form to a new form, optionally with a new name or folder
- `copy-form-workflows` — Copy selected workflows from one form to another existing form
- `create-form` — Create a form from a full form design, including conditions, workflows, and multiple pages
- `create-simple-form` — Create a single-page form from a name and a list of fields
- `delete-form` — Delete a form
- `delete-form-field` — Remove a single field from a form without sending the full form design
- `export-form` — Download a prepared form export by its export ID
- `get-form-by-id` — Get the full design of a single form
- `get-form-has-relations` — Check whether a form is related to other Umbraco content
- `get-form-items-by-ids` — Get the name and ID of one or more forms
- `get-form-referenced-by` — List the items that reference a form
- `get-form-referenced-descendants` — List the items referenced by the descendants of a form
- `get-form-relations` — List the Umbraco relations of a form
- `get-form-scaffold` — Get a blank form design with default settings
- `get-form-scaffold-by-template` — Get a form design pre-filled from a form template
- `get-form-tree-ancestors` — Get the ancestor folders of a form or folder in the Forms tree
- `get-form-tree-children` — List the folders and forms under a folder in the Forms tree
- `get-form-tree-root` — List the root-level folders and forms in the Forms tree
- `get-forms-are-referenced` — Check which forms in a list are referenced elsewhere in Umbraco
- `import-form` — Create a form from an uploaded form export file
- `list-all-forms` — List all forms without paging
- `list-forms` — List forms, with paging
- `move-form` — Move a form to another folder or to the root
- `search-forms` — Search forms by name, with paging
- `update-form` — Replace the full design of an existing form
- `validate-form-field-settings` — Validate the settings of a field against its field type without saving
- `validate-form-workflow-settings` — Validate the settings of a workflow against its workflow type without saving

## Form Submission (`form-submission`)

- `get-form-definition` — Get a form as the Delivery API returns it to front-end consumers, including field aliases
- `submit-form-entry` — Submit an entry to a form through the Delivery API

{% hint style="info" %}
The `form-submission` tools need the Forms Delivery API to be enabled and an API key to be configured. The collection is also not part of any mode.

See [Forms Delivery API](configuration.md#forms-delivery-api) for the setup.
{% endhint %}

## Form Template (`form-template`)

- `list-form-templates` — List the form templates used as starting points for new forms

## Licensing (`licensing`)

- `get-licensing-status` — Get the Umbraco Forms license status, its limitations, and the licensed domains

## Media (`media`)

- `get-media-by-path` — Get a media item by its path, such as a media reference stored in a form setting

## Member (`member`)

- `get-member-form-summaries` — List the forms a member has submitted entries to, with the number of entries for each
- `get-member-linkable-properties` — List the member properties that a form field can be linked to

## Picker (`picker`)

- `get-picker-document-type-properties` — List the properties of a Document Type that form fields can be mapped to
- `list-picker-data-types` — List the Data Types available as the source for a field's picker
- `list-picker-document-types` — List the Document Types available for mapping form fields
- `refresh-picker-document-type-mappings` — Recalculate the property mappings of a field against a Document Type

## Prevalue Source (`prevalue-source`)

- `create-prevalue-source` — Create a prevalue source from a prevalue source type and its settings
- `delete-prevalue-source` — Delete a prevalue source
- `get-prevalue-source` — Get a single prevalue source
- `get-prevalue-source-ancestors` — Get the ancestor folders of a prevalue source or folder in the prevalue source tree
- `get-prevalue-source-scaffold` — Get a blank prevalue source with default values
- `get-prevalue-source-text-file` — Get the raw text content of the file behind a file-based prevalue source
- `get-prevalue-source-tree-root` — List the root-level folders and prevalue sources in the prevalue source tree
- `get-prevalue-source-values` — Get the options that a prevalue source currently returns
- `list-prevalue-sources` — List prevalue sources
- `update-prevalue-source` — Update the name, type, settings, or cache duration of a prevalue source

## Prevalue Source Type (`prevalue-source-type`)

- `get-prevalue-source-type-by-id` — Get a single prevalue source type and its settings
- `list-prevalue-source-types` — List all prevalue source types

## Record (`record`)

- `execute-record-action` — Run a record action, such as approve or delete, on one or more records
- `get-record-audit-trail` — Get the update history of a record
- `get-record-metadata` — Get the number of matching records and the date of the latest submission
- `get-record-page-number` — Find which page of search results a record is on
- `get-record-set-actions` — List the actions that can be run on a set of records
- `get-record-workflow-audit-trail` — Get the workflow execution history of a record
- `retry-record-workflow` — Retry a workflow that already ran on a record
- `search-records` — Search the records of a form, with filters, sorting, and paging
- `update-record` — Update field values on an existing record

## Theme (`theme`)

- `list-themes` — List the available Umbraco Forms themes

## Umbraco Server (`umbraco-server`)

- `get-server-info` — Get Umbraco server information, including the version

## Updates (`updates`)

- `get-updates-version` — Check for the latest available Umbraco Forms version

## Workflow Type (`workflow-type`)

- `get-workflow-type-by-id` — Get a single workflow type and its settings
- `list-workflow-types` — List all workflow types, including types added by packages

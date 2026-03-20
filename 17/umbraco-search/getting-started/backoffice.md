---
description: >-
  A guide for interacting with Umbraco Search in the Umbraco backoffice
---

# The backoffice 

Umbraco Search adds a Search section to the Umbraco backoffice, providing tools for inspecting and managing search indexes.

## Accessing the Search section

The Search section is available to users with access to the Settings section in the Umbraco backoffice. You'll find the it under **Settings > Search**. 

## Index overview

The root view displays a table of all registered search indexes. Each row shows:

| Column | Description                                                                                      |
|--------|--------------------------------------------------------------------------------------------------|
| **Alias** | The index alias (for example `Umb_PublishedContent`, `Umb_Content`, `Umb_Media`, `Umb_Members`) |
| **Health** | The current health status of the index                                                           |
| **Documents** | The number of documents currently in the index                                                   |

Each row also has an entity action dropdown for per-index operations like rebuilding.

## Index detail view

Click an index row to open its detail view. The detail view uses a two-column layout with extensible boxes:

- **Left column**: The search box for testing queries against the index.
- **Right column**: The stats box showing the index alias, document count, and health status.

Search providers can add additional boxes to either column. See [Extending the search backoffice](../extending/backoffice-extensions.md) for more information.

## Searching documents

The search box allows you to test queries directly against an index:

1. Enter a full-text search query in the input field.
2. Results appear in a table showing document ID, name, object type, and relevance score.
3. Use pagination controls at the bottom to navigate through results.

### Culture selection

For multilingual sites, a set of culture tabs appears above the search box. Selecting a culture filters the search to include documents in that culture (invariant content is always included). The selected culture is reflected in the URL for bookmarking.

### Search results table

Each result row displays:

| Column | Description |
|--------|-------------|
| **Document ID** | The content key (clickable link to open the content item) |
| **Name** | The document name |
| **Object type** | The content type (for example "Document", "Media") |
| **Score** | The relevance score for the search query |

An entity action dropdown on each row provides per-document actions. The available actions depend on which search providers are installed. For example, the Examine provider adds a "Show Fields" action.

## Index health status

Each index reports a health status:

| Status | Meaning |
|--------|---------|
| **Healthy** | The index is operational and up to date |
| **Rebuilding** | The index is currently being rebuilt |
| **Empty** | The index contains no documents |
| **Corrupted** | The index is in a bad state and needs rebuilding |

## Rebuilding an index

To rebuild an index:

1. **From the collection view**: Click the entity action dropdown on the index row and select "Rebuild Index".
2. **From the detail view**: Click the entity action dropdown in the workspace header and select "Rebuild Index".

During a rebuild:
- The detail view shows a loading indicator.
- The collection view shows a "Rebuilding" health status for the index.
- When the rebuild completes, the server sends a notification via SignalR and the UI updates automatically.

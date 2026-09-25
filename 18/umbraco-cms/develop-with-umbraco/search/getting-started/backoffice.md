---
description: A guide for interacting with the search functionality in the Umbraco backoffice
---

# The Backoffice

The Search section in the Umbraco backoffice provides tools for inspecting and managing search indexes.

## Accessing the Search section

The Search section is available to users with access to the Settings section. Go to **Settings** and select **Search** under **Advanced** in the sidebar.

## Index overview

The overview lists all registered search indexes in a table:

| Column             | Description                                                                                                  |
| ------------------ | ------------------------------------------------------------------------------------------------------------ |
| **Alias**          | The index alias, for example `Umb_PublishedContent`, `Umb_Content`, `Umb_Media`, or `Umb_Members`.           |
| **Health status**  | The current health status of the index.                                                                      |
| **Document count** | The number of documents in the index. An index without documents shows **Empty**.                            |

Select an alias to open the detail view of the index. Each row also holds the actions for that index, such as **Rebuild**. Use **Refresh** above the table to reload the list of indexes.

## Index detail view

The detail view uses a two-column layout with extensible boxes:

* **Left column**: The **Search** box, for testing queries against the index.
* **Right column**: The **Index information** box, showing the alias, provider, document count, and health status of the index.

Search providers can add boxes to either column. For more information, see the [Search Backoffice](../extending-search/backoffice-extensions.md) article.

## Searching documents

The Search box lets you test queries directly against an index:

1. Enter a full-text search query in the input field. Results update as you type.
2. Press **Enter** or select **Search** to run the search straight away.
3. Use the pagination controls below the results to move between pages.

{% hint style="info" %}
Search is only available when the health status of the index is **Healthy**. For any other status, the Search box shows **Search unavailable** together with the current status.
{% endhint %}

The query, the current page, and the selected culture are all reflected in the URL. You can bookmark or share a search to return to the same results.

### Culture selection

On a site with more than one language, a **Culture** dropdown appears next to the search input. Selecting a culture filters the search to include documents in that culture. Invariant content is always included.

### Search results table

Each result row displays:

| Column   | Description                                                                                             |
| -------- | ------------------------------------------------------------------------------------------------------- |
| **Name** | The name of the item, with its key underneath. Select the name to open the item in a modal.             |
| **Type** | The entity type of the item, for example `document`, `media`, or `member`.                              |

Each row also holds the actions available for the document. The available actions depend on the search providers that the site uses. For example, the Examine provider adds a **Show Fields** action.

## Index health status

Each index reports a health status:

| Status         | Meaning                                          |
| -------------- | ------------------------------------------------ |
| **Healthy**    | The index is operational and up to date          |
| **Rebuilding** | A rebuild of the index is in progress            |
| **Empty**      | The index contains no documents                  |
| **Corrupted**  | The index is in a bad state and needs rebuilding |
| **Unknown**    | No health status is available for the index      |

## Rebuilding an index

To rebuild an index:

1. Select **Rebuild** on the row of the index in the overview, or in the actions menu of the detail view.
2. Confirm the rebuild in the **Rebuild index** dialog.

{% hint style="warning" %}
A rebuild recreates the index from scratch. Searching the index may return incomplete results until the rebuild finishes.
{% endhint %}

During a rebuild:

* A notification confirms that the index is rebuilding in the background.
* The overview shows a progress bar in place of the health status of the index.
* The **Index information** box shows **Rebuilding**, together with a loading indicator.

When the rebuild completes, the server notifies the backoffice. The UI updates automatically, and a **Rebuild completed** notification appears.

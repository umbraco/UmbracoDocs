# Advanced Search dashboard

Advanced Search further expands Workflow's functionality outside its original content-approval focus, adding a new dashboard for performing deep searches of your website content.

The Advanced Search dashboard is added in the content section for all users.

![Workflow Advanced Search Dashboard in the Content Section](../.gitbook/assets/workflow-advanced-search-v14.png)

Advanced Search allows searching any number of content types, optionally filtered to a subset of variants. The search can be performed across all indexed fields, a subset of fields, or all fields using a particular Data Type or Property Editor.

You can do an approximate Search using Lucene's default similarity measurement algorithm.

![Workflow Advanced Search with selected content types](../.gitbook/assets/approximate-search.png)

## Search Types

The search types are described below:

* **All properties**: Searches for a single value across all indexed fields for the selected content types.
* **Some properties**: Searches the selected properties. A different search term can be provided for each selected property.
* **Single property**: Searches for a single value in the selected property.
* **Data Type**: Searches for a single value in all fields where the indexed property uses the selected Data Type (for example, all Textstring type).
* **Property Editor**: Searches for a single value in all fields where the indexed property uses the selected Property Editor (for example, all types using the Umbraco.TextBox editor).

![Workflow Advanced Search with selected search type](../.gitbook/assets/single-property-search-type.png)

## Optional Fields

Searches can be further refined by restricting results to particular editors, created, or updated date ranges.

The additional fields are all optional.

![Workflow Advanced Search optional fields](../.gitbook/assets/additonal-optional-fields.png)

## Search results

Results are displayed in a familiar format, linking to nodes in an infinite editors, which allows users to retain their search results.

Search results include published, unpublished and trashed content, and are filtered according to the current user's content start node(s).

![Workflow Advanced Search search results](../.gitbook/assets/search-type.png)

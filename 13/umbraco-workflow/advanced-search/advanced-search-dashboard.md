# Advanced Search dashboard

Advanced Search further expands Workflow's functionality outside its original content-approval focus, adding a new dashboard for performing deep searches of your website content.

The Advanced Search dashboard is added in the content section for all users.

![Workflow Advanced Search Dashboard in the Content Section](<../.gitbook/assets/workflow-advanced-search (1).png>)

Advanced Search allows searching any number of content types, optionally filtered to a subset of variants. The search can be performed across all indexed fields, a subset of fields, or all fields using a particular Data Type or Property Editor.

Searches can optionally be made fuzzy, using Lucene's default similarity measurement algorithm.

![Workflow Advanced Search with selected content types](<../.gitbook/assets/workflow-advanced-search (2).png>)

## Search types

The search types are described below.

* **All properties**: search for a single value across all indexed fields for the selected content types.
* **Some properties**: search the selected properties. A different search term can be provided for each selected property.
* **Single property**: search for a single value in the selected property.
* **Data Type**: search for a single value in all fields where the indexed property uses the selected Data Type (for example, all Textstring type).
* **Property Editor**: search for a single value in all fields where the indexed property uses the selected Property Editor (for example, all types using the Umbraco.TextBox editor).

![Workflow Advanced Search with selected search type](<../.gitbook/assets/workflow-advanced-search (3).png>)

## Optional fields

Searches can be further refined by restricting results to particular editors, or created and updated date ranges.

The additional fields are all optional.

![Workflow Advanced Search optional fields](<../.gitbook/assets/workflow-advanced-search (4).png>)

## Search results

Results are displayed in a familiar format, linking to nodes in an infinite editors, which allows users to retain their search results.

Search results include published, unpublished and trashed content, and are filtered according to the current user's content start node(s).

![Workflow Advanced Search search results](<../.gitbook/assets/workflow-advanced-search (5).png>)

# Viewing And Exporting Entries

To view the Entries for each Form, go to the Form and click on the **Entries** tab.

![Tree](../.gitbook/assets/tree-v14.png)

## Video overview

{% embed url="https://youtu.be/vUQpX3wqDrs" %}
Watch this video to learn how to manage entries submitted via Umbraco Forms.
{% endembed %}

## Entries Overview

When accessing the Entries viewer, you will be able to see all the entries submitted via the Form.

![Entries viewer](../.gitbook/assets/tree-v14.png)

### Viewing the Entries

By default, the list is filtered to show entries only from the past month. If you want to change the date range, pick the appropriate time period from the date picker. You can also filter the entries by specific words using the Search field on the left.

Click **Entry details** on each record in the list to open the full set of information recorded for the form entry. Clicking on the entry record displays the **Clear** and **Delete** buttons.

![Filter](../.gitbook/assets/entry-details-v14.png)

### Editing the Entries

If configured via the permissions model and supported by the version of Umbraco Forms you are running, entries may be editable via the backoffice. If available, click the _Edit_ button to switch the read-only view of an entry to an editable one and _Save_ to record the changes. An audit trail will show who and when updates on the entry were made.

Validation will operate as is configured for the form in terms of mandatory fields and those that must match a particular pattern. Conditional display of fields is not supported.

## Exporting Entries

To export all the entries from your Form:

1. Go to the **Forms** section.
2. Navigate to the Form **Entries** you wish to export.
3.  Click **Export**.

    ![Export Entries](../.gitbook/assets/Export-v14.png)
4.  The Export dialog opens. Choose a format such as **Excel File** to export the Form records to.

    ![Export dialog](../.gitbook/assets/ExportAllDialog-v14.png)
5. Click **Export**.
6. Click **Save**.

If you have fields that allow the user to upload files within your form, you will also have the option to download a zip file containing these files. You can either download the files in the structure that they are stored on the web server's disk. Or you can download them organised by entry, so it's easier to match up the entry listed in the spreadsheet download with the uploaded file(s).

## Record Actions

When selecting entries, it is possible to execute different actions. To select an entry, click anywhere on the entry.

![Record bulk actions](../.gitbook/assets/entry-details-v14.png)

Select at least 1 record to see the available actions. By default, there are 2 possible actions:

* Clear
* Delete

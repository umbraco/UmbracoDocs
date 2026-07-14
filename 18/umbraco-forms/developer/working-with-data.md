---
description: "Developer documentation on working with Forms record data."
---

# Working With Record Data

Umbraco Forms includes some helper methods that return records of a given Form, which can be used to output records in your templates using razor.

## Available Methods

The methods can be found by injecting the `Umbraco.Forms.Core.Services.IRecordReaderService` interface. These methods are paged, but each one returns the records for an entire Form or Umbraco page. To filter records on the server, use the `IFormRecordSearcher` interface instead. It is described in the [Querying records with a filter](#querying-records-with-a-filter) section below, and supports options such as a submission date range.

### GetApprovedRecordsFromPage

```csharp
PagedModel<Record> GetApprovedRecordsFromPage(int pageId, int pageNumber, int pageSize)
```

Returns all records with the state set to approved from all Forms on the Umbraco page with the id = `pageId` .

### GetApprovedRecordsFromFormOnPage

```csharp
PagedModel<Record> GetApprovedRecordsFromFormOnPage(int pageId, Guid formId, int pageNumber, int pageSize)
```

Returns all records with the state set to approved from the Form with the id = `formId` on the Umbraco page with the id = `pageId` as a `PagedModel<Record>`.

### GetApprovedRecordsFromForm

```csharp
PagedModel<Record> GetApprovedRecordsFromForm(Guid formId, int pageNumber, int pageSize)
```

Returns all records with the state set to approved from the Form with the ID = `formId` as a `PagedModel<Record>`.

### GetRecordsFromPage

```csharp
PagedModel<Record> GetRecordsFromPage(int pageId, int pageNumber, int pageSize)
```

Returns all records from all Forms on the Umbraco page with the id = `pageId` as a `PagedModel<Record>`.

### GetRecordsFromFormOnPage

```csharp
PagedModel<Record> GetRecordsFromFormOnPage(int pageId, Guid formId, int pageNumber, int pageSize)
```

Returns all records from the Form with the id = `formId` on the Umbraco page with the id = `pageId` as a `PagedModel<Record>`.

### GetRecordsFromForm

```csharp
PagedModel<Record> GetRecordsFromForm(Guid formId, int pageNumber, int pageSize)
```

Returns all records from the Form with the ID = formId as a `PagedModel<Record>`.

## The returned objects

All of these methods will return an object of type `PagedModel<Record>` so you can iterate through the `Record` objects.

The properties available on a `Record` are:

```csharp
int Id
FormState State
DateTime Created
DateTime Updated
Guid Form
string IP
int UmbracoPageId
Guid? UmbracoPageKey
string MemberKey
Guid UniqueId
Dictionary<Guid, RecordField> RecordFields
```

`UmbracoPageKey` is the GUID identifier of the page a form was submitted from. It is the preferred reference over the integer `UmbracoPageId`.

In order to access custom Form fields, these are available in the `RecordFields` property. Furthermore there exists an extension method named `ValueAsString` on `Record` in `Umbraco.Forms.Core.Extensions`, such that you can get the value as string given the alias of the field.

This extension method handle multi value fields by comma separating the values. E.g. "A, B, C"

## Sample razor script

Sample script that is outputting comments using a Form created with the default comment Form template.

```csharp
@using Umbraco.Forms.Core.Extensions;
@using Umbraco.Forms.Core.Services;
@inject IRecordReaderService _recordReaderService;

<ul id="comments">
    @foreach (var record in _recordReaderService.GetApprovedRecordsFromPage(Model.Id, 1, 10).Items)
    {
    <li>
        @record.Created.ToString("dd MMMM yyy")
        @if(string.IsNullOrEmpty(record.ValueAsString("email"))){
            <strong>@record.ValueAsString("name")</strong>
        }
        else{
            <strong>
                <a href="mailto:@record.ValueAsString("email")" target="_blank">@record.ValueAsString("name")</a>
            </strong>
        }
        <span>said</span>
        <p>@record.ValueAsString("comment")</p>
    </li>
    }
</ul>
```

## Querying records with a filter

The `IRecordReaderService` methods above return all records for a Form or Umbraco page. When you need to query records with server-side filtering, for example, retrieving only the submissions created within a date range, inject the `Umbraco.Forms.Core.Searchers.IFormRecordSearcher` interface instead.

This is the same database-level query used by the entries view in the backoffice. The filtering and paging are applied in the query sent to the database, so it does not load every record for the Form into memory.

Describe the query by passing a `RecordFilter`. Its main properties are:

```csharp
int Skip                // Start index (defaults to 0).
int Take                // Number of records to return (defaults to 20).
string? MemberKey       // Only records submitted by this member.
string SortBy           // Column to sort by: "created", "updated" or "state".
RecordSorting SortOrder // Sort direction.
DateTime StartDate      // Only records created on or after this date (UTC).
DateTime EndDate        // Only records created on or before this date (UTC).
string? Filter          // Free-text search across the record values.
List<FormState> States  // Only records in these states. Leave empty to return all states.
List<Guid> RecordIds    // Only records with these specific unique Ids.
```

`StartDate` and `EndDate` filter on the record's created date and are matched in UTC, so provide UTC values. Both dates are optional. If you leave `StartDate` unset, it defaults to a date far in the past. If you leave `EndDate` unset, it defaults to the current time. As a result, you can filter by only a start date or only an end date.

The following example retrieves the records for a Form created in the last 24 hours:

```csharp
@using System.Linq
@using Umbraco.Forms.Core.Models
@using Umbraco.Forms.Core.Searchers
@inject IFormRecordSearcher _formRecordSearcher

@{
    var formId = new Guid("a34e0692-6a46-45f2-8b70-4ee0a72e4b0d");

    var filter = new RecordFilter
    {
        StartDate = DateTime.UtcNow.AddDays(-1),
        Take = 100,
    };

    EntrySearchResultCollection results = _formRecordSearcher.QueryDataBase(formId, filter);
}

<p>@results.TotalNumberOfResults record(s) submitted in the last 24 hours.</p>

<ul>
    @foreach (EntrySearchResult entry in results.Results)
    {
        <li>@entry.Created.ToString("g") - @entry.State</li>
    }
</ul>
```

Each `EntrySearchResult` exposes the record metadata (`Id`, `UniqueId`, `State`, `Created`, `Updated`, and so on) together with a `Fields` collection. To read the value of a specific field, match the field's `Alias` in the returned `Schema` to its `Id`, then find the matching entry in `Fields`:

```csharp
string GetFieldValue(EntrySearchResultCollection results, EntrySearchResult entry, string alias)
{
    string? fieldId = results.Schema.FirstOrDefault(s => s.Alias == alias)?.Id;
    return entry.Fields.FirstOrDefault(f => f.FieldId == fieldId)?.Value?.ToString() ?? string.Empty;
}
```

## Loading a Record From a Submitted Form
When a form is submitted, the submitted form ID and the saved record ID are stored in the `TempData` so they can be referenced.

You can use the FormService and the RecordStorage to get the `Form` and `Record` objects.

Here is a sample code for retrieving a record in a view.

```
@using Umbraco.Forms.Core.Models
@using Umbraco.Forms.Core.Persistence.Dtos
@using Umbraco.Forms.Core.Data.Storage
@using Umbraco.Forms.Core.Services
@inject IFormService _formService
@inject IRecordStorage _recordStorage
@inherits UmbracoViewPage
@{
	Guid formId;
	Form? form;
	Guid recordId;
	Record? record;
    string submittedEmail;

	if (Guid.TryParse(TempData["UmbracoFormSubmitted"]?.ToString(), out formId) &&
	    Guid.TryParse(TempData["Forms_Current_Record_id"]?.ToString(), out recordId))
	{

		form = _formService.Get(formId);

		if (form != null && TempData["Forms_Current_Record_id"] != null)
		{
			Guid.TryParse(TempData["Forms_Current_Record_id"]?.ToString(), out recordId);

			record = _recordStorage.GetRecordByUniqueId(recordId, form);

            submittedEmail = record.GetRecordFieldByAlias("email")?.ValuesAsString();
		}
	}
}
```

---
versionFrom: 8.0.0
meta.Title: "Working with Umbraco Forms data"
meta.Description: "Developer documentation on working with Forms record data."
---

# Working with Record data

Umbraco Forms includes some helper methods that return records of a given form, which can be used to output records in your templates using Razor.

## Working with records in bulk

The methods can be found by injecting the `Umbraco.Forms.Core.Services.IRecordReaderService` interface.

For performance reasons, all these methods are paged and retrieve their values from an underlying Examine search index.

### GetApprovedRecordsFromPage

```csharp
PagedResult<IRecord> GetApprovedRecordsFromPage(int pageId, int pageNumber, int pageSize)
```

Returns all records with the state set to approved from all forms on the Umbraco page with the id = `pageId` .

### GetApprovedRecordsFromFormOnPage

```csharp
PagedResult<IRecord> GetApprovedRecordsFromFormOnPage(int pageId, Guid formId, int pageNumber, int pageSize)
```

Returns all records with the state set to approved from the form with the id = `formId` on the Umbraco page with the id = `pageId` as a PagedResult<IRecord>.

### GetApprovedRecordsFromForm

```csharp
PagedResult<IRecord> GetApprovedRecordsFromForm(Guid formId, int pageNumber, int pageSize)
```

Returns all records with the state set to approved from the form with the ID = `formId` as a PagedResult<IRecord>.

### GetRecordsFromPage

```csharp
PagedResult<IRecord> GetRecordsFromPage(int pageId, int pageNumber, int pageSize)
```

Returns all records from all forms on the Umbraco page with the id = `pageId` as a PagedResult<IRecord>.

### GetRecordsFromFormOnPage

```csharp
PagedResult<IRecord> GetRecordsFromFormOnPage(int pageId, Guid formId, int pageNumber, int pageSize)
```

Returns all records from the form with the id = `formId` on the Umbraco page with the id = `pageId` as a PagedResult<IRecord>.

### GetRecordsFromForm

```csharp
PagedResult<IRecord> GetRecordsFromForm(Guid formId, int pageNumber, int pageSize)
```

Returns all records from the form with the ID = formId as a PagedResult<IRecord>

### The returned object

All of these methods will return an object of type `PagedResult<IRecord>` so you can iterate through the `IRecord` objects.

The properties available on a `IRecord` are:

```csharp
int Id
FormState State
DateTime Created
DateTime Updated
Guid Form
string IP
int UmbracoPageId
string MemberKey
Guid UniqueId
Dictionary<Guid, RecordField> RecordFields
```

In order to access custom form fields, these are available in the `RecordFields` property.

Furthermore, there exists an extension method named `ValueAsString` on `IRecord` in `Umbraco.Forms.Core.Services`, such that you can get the value as a string given the alias of the field.

This extension method will handle multi-value fields by comma separating the values. E.g. "A, B, C"

### Sample Razor script

Sample script that is outputting comments using a form created with the default comment form template.

```csharp
@using Umbraco.Core;
@using Umbraco.Core.Composing
@using Umbraco.Forms.Core.Services
@{
    var recordReaderService = Current.Factory.GetInstance<IRecordReaderService>();
}
<ul id="comments">
    @foreach (var record in recordReaderService.GetApprovedRecordsFromPage(Model.Id, 1, 10).Items)
    {
        <li>
            @record.Created.ToString("dd MMMM yyy")

            @if(string.IsNullOrEmpty(record.ValueAsString("email"))
            {
                <strong>@record.ValueAsString("name")</strong>
            }
            else
            {
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

## Working with single records

If you have a use case where you want to be able to retrieve the single record created from a form submission by a user, then a different interface, that provides access via database requests, should be used.  The interface is `IRecordStorage`, found in the `Umbraco.Forms.Core.Data.Storage` namespace.

By using this interface you avoid any timing issues caused by the Examine indexes used in the previous examples not yet being populated.

### GetRecordByUniqueId

```csharp
Record GetRecordByUniqueId(Guid uniqueId, Form form);
```

Returns a single record based on its unique Id and form.

[This blog post](https://www.andybutland.dev/2022/04/getting-submitted-form-data-in-umbraco.html) shows an example where `TempData` values are used to retrieve the identifiers of the submitted form and created record. With those identifiers, the full details of the form and record can be retrieved and displayed on the page.



---
description: "Developer documentation on working with Forms record data."
---

# Working With Record Data

Umbraco Forms includes some helper methods that return records of a given Form, which can be used to output records in your templates using razor.

## Available Methods

The methods can be found by injecting the `Umbraco.Forms.Core.Services.IRecordReaderService` interface. For performance reasons, all these methods are paged.

### GetApprovedRecordsFromPage

```csharp
PagedResult<Record> GetApprovedRecordsFromPage(int pageId, int pageNumber, int pageSize)
```

Returns all records with the state set to approved from all Forms on the Umbraco page with the id = `pageId` .

### GetApprovedRecordsFromFormOnPage

```csharp
PagedResult<Record> GetApprovedRecordsFromFormOnPage(int pageId, Guid formId, int pageNumber, int pageSize)
```

Returns all records with the state set to approved from the Form with the id = `formId` on the Umbraco page with the id = `pageId` as a `PagedResult<Record>`.

### GetApprovedRecordsFromForm

```csharp
PagedResult<Record> GetApprovedRecordsFromForm(Guid formId, int pageNumber, int pageSize)
```

Returns all records with the state set to approved from the Form with the ID = `formId` as a `PagedResult<Record>`.

### GetRecordsFromPage

```csharp
PagedResult<Record> GetRecordsFromPage(int pageId, int pageNumber, int pageSize)
```

Returns all records from all Forms on the Umbraco page with the id = `pageId` as a `PagedResult<Record>`.

### GetRecordsFromFormOnPage

```csharp
PagedResult<Record> GetRecordsFromFormOnPage(int pageId, Guid formId, int pageNumber, int pageSize)
```

Returns all records from the Form with the id = `formId` on the Umbraco page with the id = `pageId` as a `PagedResult<Record>`.

### GetRecordsFromForm

```csharp
PagedResult<Record> GetRecordsFromForm(Guid formId, int pageNumber, int pageSize)
```

Returns all records from the Form with the ID = formId as a `PagedResult<Record>`.

## The returned objects

All of these methods will return an object of type `PagedResult<Record>` so you can iterate through the `Record` objects.

The properties available on a `Record` are:

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

In order to access custom Form fields, these are available in the `RecordFields` property. Furthermore there exists an extension method named `ValueAsString` on `Record` in `Umbraco.Forms.Core.Extensions`, such that you can get the value as string given the alias of the field.

This extension method handle multi value fields by comma separating the values. E.g. "A, B, C"

## Sample razor script

Sample script that is outputting comments using a Form created with the default comment Form template.

```csharp
@using Umbraco.Core;
@using Umbraco.Cms.Core.Composing;
@using Umbraco.Forms.Core.Extensions;
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

## Loading a Record From a Submitted Form
When a form is submitted, the submitted form id and the saved record id is stored in the TempData so it can be referenced.

You can use the FormService and the RecordStorage to get the ```Form``` and ```Record``` objects.   

Here is sample code for how to get the record in a view.

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

	if (TempData["UmbracoFormSubmitted"] != null)
	{
		Guid.TryParse(TempData["UmbracoFormSubmitted"]?.ToString(), out formId);

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

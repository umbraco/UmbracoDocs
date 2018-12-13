# Working with Record data

Umbraco Forms includes some helper methods that return dynamic objects, which makes it easy to output records in your templates using razor.

## Available methods
The static methods can be found in Umbraco.Forms.Mvc.DynamicObjects.Library

### GetApprovedRecordsFromPage

```csharp
DynamicRecordList GetApprovedRecordsFromPage(int pageId)
```

Returns all records with the state set to approved from all forms on the Umbraco page with the id = `pageId` as a DynamicRecordList. 

### GetApprovedRecordsFromFormOnPage

```csharp
DynamicRecordList GetApprovedRecordsFromFormOnPage(int pageId, string formId)
```

Returns all records with the state set to approved from the form with the id = `formId` on the Umbraco page with the id = `pageId` as a DynamicRecordList.

### GetApprovedRecordsFromForm

```csharp
DynamicRecordList GetApprovedRecordsFromForm(string formId)
```

Returns all records with the state set to approved from the form with the ID = `formId` as a DynamicRecordList.

### GetRecordsFromPage

```csharp
DynamicRecordList GetRecordsFromPage(int pageId)
```

Returns all records from all forms on the Umbraco page with the id = `pageId` as a DynamicRecordList.

### GetRecordsFromFormOnPage

```csharp
DynamicRecordList GetRecordsFromFormOnPage(int pageId, string formId)
```

Returns all records from the form with the id = `formId` on the Umbraco page with the id = `pageId` as a DynamicRecordList.

### GetRecordsFromForm

```csharp
DynamicRecordList GetRecordsFromForm(string formId)
```

Returns all records from the form with the ID = formId as a DynamicRecordList

## DynamicRecordsList and DynamicRecord

All of these methods will return an object of type `DynamicRecordList` so you can easily iterate through the DynamicRecord objects.

The properties available on a DynamicRecord are:

```csharp
DateTime Created
string Form
string Id
string IP
object MemberKey
Dictionary<Guid, RecordField> RecordFields
FormState? State
int UmbracoPageId
DateTime Updated
```

In order to access custom form fields you can simply use the dot notation, using the field caption but removing all spaces and non alphanumeric characters.

## Sample razor script 

Sample script that is outputting comments using a form created with the default comment form template.

```csharp
@using Umbraco.Forms.Mvc.DynamicObjects

<ul id="comments">
	@foreach (dynamic record in Library
			.GetApprovedRecordsFromPage(@CurrentPage.Id))
	{
		<li>
			@record.Created.ToString("dd MMMM yyy")
			@if(string.IsNullOrEmpty(record.Website)){
				<strong>@record.Name</strong>
			}
			else{
				<strong>
				<a href="@record.Website" target="_blank">@record.Name</a>
				</strong>
			}
			<span>said</span>
			<p>@record.Comment</p>
		</li>
	}
</ul>
```
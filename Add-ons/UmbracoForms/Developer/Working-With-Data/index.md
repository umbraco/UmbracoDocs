---
versionFrom: 8.0.0
---

# Working with Record data

From Umbraco Forms `v8.2` includes some helper methods that return records of a given form, which makes it easy to output records in your templates using razor.

## Available methods
The methods can be found by injecting the `Umbraco.Forms.Core.Services.IRecordReaderService` interface.

```csharp
IReadOnlyList<IRecord> GetApprovedRecordsFromPage(int pageId)
```

### GetApprovedRecordsFromPage

```csharp
IReadOnlyList<IRecord> GetApprovedRecordsFromPage(int pageId)
```

Returns all records with the state set to approved from all forms on the Umbraco page with the id = `pageId` as a DynamicRecordList. 

### GetApprovedRecordsFromFormOnPage

```csharp
IReadOnlyList<IRecord> GetApprovedRecordsFromFormOnPage(int pageId, string formId)
```

Returns all records with the state set to approved from the form with the id = `formId` on the Umbraco page with the id = `pageId` as a DynamicRecordList.

### GetApprovedRecordsFromForm

```csharp
IReadOnlyList<IRecord> GetApprovedRecordsFromForm(string formId)
```

Returns all records with the state set to approved from the form with the ID = `formId` as a DynamicRecordList.

### GetRecordsFromPage

```csharp
IReadOnlyList<IRecord> GetRecordsFromPage(int pageId)
```

Returns all records from all forms on the Umbraco page with the id = `pageId` as a DynamicRecordList.

### GetRecordsFromFormOnPage

```csharp
IReadOnlyList<IRecord> GetRecordsFromFormOnPage(int pageId, string formId)
```

Returns all records from the form with the id = `formId` on the Umbraco page with the id = `pageId` as a DynamicRecordList.

### GetRecordsFromForm

```csharp
IReadOnlyList<IRecord> GetRecordsFromForm(string formId)
```

Returns all records from the form with the ID = formId as a DynamicRecordList

## DynamicRecordsList and DynamicRecord

All of these methods will return an object of type `IReadOnlyList<IRecord>` so you can iterate through the `IRecord` objects.

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

In order to access custom form fields, there exists an extension method named `ValueAsString` on  `IRecord` in `Umbraco.Forms.Core.Services`, such that you can get the value as string given the alias of the field.

This extension method handle multi value fields by comma separating the values. E.g. "A, B, C"

## Sample razor script 

Sample script that is outputting comments using a form created with the default comment form template.

```csharp
@using Umbraco.Core;
@using Umbraco.Core.Composing
@using Umbraco.Forms.Core.Services
@{
   var recordReaderService = Current.Factory.GetInstance<IRecordReaderService>();
}
<ul id="comments">
   @foreach (dynamic record in recordReaderService.GetApprovedRecordsFromPage(Model.Id))
   {
      <li>
         @record.Created.ToString("dd MMMM yyy")
         @if(string.IsNullOrEmpty(record.ValueAsString("email")){
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

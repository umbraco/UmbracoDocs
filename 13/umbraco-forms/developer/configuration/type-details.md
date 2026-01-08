---
description: "Provides details of the built-in provider types available with Umbraco Forms"
---

# Forms Provider Type Details

This page provides some details of the provider types available in Umbraco Forms.

The intention is to be able to make available details such as IDs, aliases and property names, that may be necessary when configuring the product.

## Field Types

<details>

<summary>Checkbox</summary>

**ID:** `D5C0C390-AE9A-11DE-A69E-666455D89593`

**Alias:** `checkbox`

**Settings:**

* `Caption`
* `DefaultValue`
* `ShowLabel`

</details>

<details>

<summary>Data Consent</summary>

**ID:** `A72C9DF9-3847-47CF-AFB8-B86773FD12CD`

**Alias:** `dataConsent`

**Settings:**

* `AcceptCopy`
* `ShowLabel`

</details>

<details>

<summary>Date</summary>

**ID:** `F8B4C3B8-AF28-11DE-9DD8-EF5956D89593`

**Alias:** `date`

**Settings:**

* `Placeholder`
* `ShowLabel`
* `AriaLabel`

</details>

<details>

<summary>Dropdown List</summary>

**ID:** `0DD29D42-A6A5-11DE-A2F2-222256D89593`

**Alias:** `dropdown`

**Settings:**

* `DefaultValue`
* `AllowMultipleSelections`
* `ShowLabel`
* `AutocompleteAttribute`
* `SelectPrompt`

</details>

<details>

<summary>File Upload</summary>

**ID:** `84A17CF8-B711-46a6-9840-0E4A072AD000`

**Alias:** `fileUpload`

**Settings:**

* `SelectedFilesListHeading`

</details>

<details>

<summary>Long Answer</summary>

**ID:** `023F09AC-1445-4bcb-B8FA-AB49F33BD046`

**Alias:** `longAnswer`

**Settings:**

* `DefaultValue`
* `Placeholder`
* `ShowLabel`
* `AutocompleteAttribute`
* `NumberOfRows`
* `MaximumLength`

</details>

<details>

<summary>Hidden Field</summary>

**ID:** `DA206CAE-1C52-434E-B21A-4A7C198AF877`

**Alias:** `hidden`

**Settings:**

* `DefaultValue`

</details>

<details>

<summary>Multiple Choice</summary>

**ID:** `FAB43F20-A6BF-11DE-A28F-9B5755D89593`

**Alias:** `multipleChoice`

**Settings:**

* `DisplayLayout`
* `DefaultValue`
* `ShowLabel`

</details>

<details>

<summary>Password</summary>

**ID:** `FB37BC60-D41E-11DE-AEAE-37C155D89593`

**Alias:** `password`

**Settings:**

* `Placeholder`

</details>

<details>

<summary>reCAPTCHA 2</summary>

**ID:** `B69DEAEB-ED75-4DC9-BFB8-D036BF9D3730`

**Alias:** `recaptcha2`

**Settings:**

* `Theme`
* `Size`
* `ErrorMessage`

</details>

<details>

<summary>reCAPTCHA 3</summary>

**ID:** `663AA19B-423D-4F38-A1D6-C840C926EF86`

**Alias:** `recaptcha3`

**Settings:**

* `ScoreThreshold`
* `ErrorMessage`
* `SaveScore`

</details>

<details>

<summary>reCAPTCHA Enterprise</summary>

**ID:** `1BAB78CB-52B1-495C-BBC2-A46540642828`

**Alias:** `recaptchaEnterprise`

**Settings:**

* `ScoreThreshold`
* `ErrorMessage`
* `SaveScore`

</details>

<details>

<summary>Rich Text</summary>

**ID:** `1F8D45F8-76E6-4550-A0F5-9637B8454619`

**Alias:** `richText`

**Settings:**

* `Html`
* `ShowLabel`

</details>

<details>

<summary>Single Choice</summary>

**ID:** `903DF9B0-A78C-11DE-9FC1-DB7A56D89593`

**Alias:** `singleChoice`

**Settings:**

* `DisplayLayout`
* `DefaultValue`
* `ShowLabel`

</details>

<details>

<summary>Short Answer</summary>

**ID:** `3F92E01B-29E2-4a30-BF33-9DF5580ED52C`

**Alias:** `shortAnswer`

**Settings:**

* `DefaultValue`
* `Placeholder`
* `ShowLabel`
* `MaximumLength`
* `FieldType`
* `AutocompleteAttribute`

</details>

<details>

<summary>Title and Description</summary>

**ID:** `e3fbf6c4-f46c-495e-aff8-4b3c227b4a98`

**Alias:** `titleAndDescription`

**Settings:**

* `CaptionTag`
* `Caption`
* `BodyText`
* `ShowLabel`

</details>

## Workflow Types

<details>

<summary>Change Record State</summary>

**ID:** `4C40A092-0CB5-481d-96A7-A02D8E7CDB2F`

**Alias:** `changeRecordState`

**Settings:**

* `Words`
* `Action`

</details>

<details>

<summary>Post as XML</summary>

**ID:** `470EEB3A-CB15-4b08-9FC0-A2F091583332`

**Alias:** `postAsXml`

**Settings:**

* `Url`
* `Method`
* `XsltFile`
* `Fields`
* `Username`
* `Password`

</details>

<details>

<summary>Save As Umbraco Content Node</summary>

**ID:** `89FB1E31-9F36-4e08-9D1B-AF1180D340DB`

**Alias:** `saveAsUmbracoContentNode`

**Settings:**

* `Fields`
* `Publish`
* `RootNode`

</details>

<details>

<summary>Save As XML File</summary>

**ID:** `9CC5854D-61A2-48f6-9F4A-8F3BDFAFB521`

**Alias:** `saveAsAnXmlFile`

**Settings:**

* `Path`
* `Extension`
* `XsltFile`

</details>

<details>

<summary>Send Email</summary>

**ID:** `E96BADD7-05BE-4978-B8D9-B3D733DE70A5`

**Alias:** `sendEmail`

**Settings:**

* `Email`
* `CcEmail`
* `BccEmail`
* `SenderEmail`
* `ReplyToEmail`
* `Subject`
* `Message`
* `Attachment`

</details>

<details>

<summary>Send Email With Razor Template</summary>

**ID:** `17c61629-d984-4e86-b43b-a8407b3efea9`

**Alias:** `sendEmailWithRazorTemplate`

**Settings:**

* `Email`
* `CcEmail`
* `BccEmail`
* `SenderEmail`
* `ReplyToEmail`
* `Subject`
* `RazorViewFilePath`
* `Attachment`

</details>

<details>

<summary>Send Email With Extensible Stylesheet Language Transformations (XSLT) Template</summary>

**ID:** `616edfeb-badf-414b-89dc-d8655eb85998`

**Alias:** `sendEmailWithXsltTemplate`

**Settings:**

* `Email`
* `CcEmail`
* `BccEmail`
* `SenderEmail`
* `ReplyToEmail`
* `Subject`
* `XsltFile`

</details>

<details>

<summary>Send Form To URL</summary>

**ID:** `FD02C929-4E7D-4f90-B9FA-13D074A76688`

**Alias:** `sendFormToUrl`

**Settings:**

* `Url`
* `Method`
* `StandardFields`
* `Fields`
* `Username`
* `Password`

</details>

<details>

<summary>Slack</summary>

**ID:** `bc52ab28-d3ff-42ee-af75-a5d49be83040`

**Alias:** `slack`

**Settings:**

* `WebhookUrl`

</details>

<details>

<summary>Slack (Legacy)</summary>

**ID:** `ccbfb0d5-adaa-4729-8b4c-4bb439dc0202`

**Alias:** `slackLegacy`

**Settings:**

* `Token`
* `Channel`
* `Username`
* `AvatarUrl`

</details>

## Prevalue Source Types

<details>

<summary>Datasource</summary>

**ID:** `cc9f9b2a-a746-11de-9e17-681b56d89593`

**Alias:** `dataSource`

</details>

<details>

<summary>Get Values From Text File</summary>

**ID:** `35C2053E-CBF7-4793-B27C-6E97B7671A2D`

**Alias:** `getValuesFromTextFile`

**Settings:**

* `TextFile`

</details>

<details>

<summary>SQL Database</summary>

**ID:** `F1F5BD4D-E6AE-44ed-86CB-97661E4660B2`

**Alias:** `sqlDatabase`

**Settings:**

* `Connection`
* `ConnectionString`
* `Table`
* `KeyColumn`
* `ValueColumn`
* `CaptionColumn`

</details>

<details>

<summary>Umbraco Datatype Prevalues</summary>

**ID:** `EA773CAF-FEF2-491B-B5B7-6A3552B1A0E2`

**Alias:** `umbracoDataTypePreValues`

**Settings:**

* `DataTypeId`

</details>

<details>

<summary>Umbraco Documents</summary>

**ID:** `de996870-c45a-11de-8a39-0800200c9a66`

**Alias:** `umbracoDocuments`

**Settings:**

* `RootNode`
* `UseCurrentPage`
* `DocType`
* `ValueField`
* `CaptionField`
* `ListGrandChildren`
* `OrderBy`

</details>

## Data Source Types

<details>

<summary>SQL Database</summary>

**ID:** `F19506F3-EFEA-4b13-A308-89348F69DF91`

**Alias:** `sqlDatabase`

**Settings:**

* `Connection`
* `Table`

</details>

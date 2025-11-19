---
description: >-
  Information on configuration allowing for the modification of default data
  installed in new projects
---

# Install Default Data Settings

When Umbraco is installed for the first time, it creates a set of default data. These include a language, some Data Types, and some Media and Member Types.

In certain setups, you may want to take control over what is installed and opt-out of the creation of certain items.

When working in a team and using Umbraco Deploy for schema updates, consider your colleague's local project setup. The default installed data may not always be useful.

For example, if different languages are set up in Umbraco, it's better not to recreate them from the default language (en-US). In other situations, certain Umbraco default Data, Member and Media Types may not be required.

The following example configuration shows how this default data installation can be customized:

```json
"Umbraco": {
  "CMS": {
  "InstallDefaultData": {
      "Languages": {
        "InstallData": "Values",
        "Values": [
          "en-US"
        ]
      },
      "DataTypes": {
        "InstallData": "ExceptValues",
        "Values": [
          "0225af17-b302-49cb-9176-b9f35cab9c17"
        ]
      },
      "MediaTypes": {
        "InstallData": "All",
      },
      "MemberTypes": {
        "InstallData": "None"
      }
    }
  }
}
```

Each `InstallData` setting can be one of the following values:

* `All` - all default data for the type will be installed (this is the default behavior if the configuration is omitted).
* `Values` - only the default data specified will be installed. For languages, the values are the ISO codes for the language. For all other types, the Guid for the type should be listed.
* `ExceptValues` - all default data except those specified will be installed.
* `None` - no default data of the type will be installed.

{% hint style="warning" %}
Be cautious when changing a Data Type configuration, as there are some dependencies between the different types. Make sure to check the reference information in the `info` tab to ensure they are not referenced somewhere else.
{% endhint %}

For example, if you check the info tab of the `Label (bigint)` Data Type, you can see that it is referenced by the `Media Types`:

<figure><img src="../../../../15/umbraco-cms/.gitbook/assets/ReferencedDataTypes (1).PNG" alt=""><figcaption><p>Data Type referenced by Media Type</p></figcaption></figure>

## Data Identifiers

For `DataTypes`, `MediaTypes` and `MemberTypes` the Guid identifiers for the default data items need to be provided in the `Values` collection.

For `Languages`, the `Values` collection expects the standard language ISO codes to be provided. Given this code is enough to fully specify a language, it's possible to use this collection to install additional default data.

As an example, the following configuration would omit the default "English (United States)" language and instead install the "English (United Kingdom)" and "Italian" languages. As "English (United Kingdom)" is provided first, it would be created as Umbraco's default language for content creation.

```json
"Umbraco": {
  "CMS": {
    "InstallDefaultData": {
      "Languages": {
        "InstallData": "Values",
        "Values": [
          "en-GB",
          "it"
        ]
      }
    }
  }
}
```

## Reference

The Guid values representing the default Data, Media, and Member Types installed are as follows.

Data types:

```
ApprovedColor = 0225af17-b302-49cb-9176-b9f35cab9c17
Checkbox = 92897bc6-a5f3-4ffe-ae27-f2e7e33dda49
CheckboxList = fbaf13a8-4036-41f2-93a3-974f678c312a
ContentPicker = FD1E0DA5-5606-4862-B679-5D0CF3A52A59
DatePicker = 5046194e-4237-453c-a547-15db3a07c4e1
DatePickerWithTime = e4d66c0f-b935-4200-81f0-025f7256b89a
Dropdown = 0b6a45e7-44ba-430d-9da5-4e46060b9e03
DropdownMultiple = f38f0ac7-1d27-439c-9f3f-089cd8825a53
ImageCropper = 1df9f033-e6d4-451f-b8d2-e0cbc50a836f
LabelBigInt = 930861bf-e262-4ead-a704-f99453565708
LabelDateTime = 0e9794eb-f9b5-4f20-a788-93acd233a7e4
LabelDecimal = 8f1ef1e1-9de4-40d3-a072-6673f631ca64
LabelInt = 8e7f995c-bd81-4627-9932-c40e568ec788
LabelString = f0bc4bfb-b499-40d6-ba86-058885a5178c
LabelTime = a97cec69-9b71-4c30-8b12-ec398860d7e8
ListViewContent = C0808DD3-8133-4E4B-8CE8-E2BEA84A96A4
ListViewMedia = 3A0156C4-3B8C-4803-BDC1-6871FAA83FFF
ListViewMembers = AA2C52A0-CE87-4E65-A47C-7DF09358585D
MediaPicker = 135D60E0-64D9-49ED-AB08-893C9BA44AE5
MediaPicker3 = 4309A3EA-0D78-4329-A06C-C80B036AF19A
MediaPicker3Multiple = 1B661F40-2242-4B44-B9CB-3990EE2B13C0
MediaPicker3MultipleImages = 0E63D883-B62B-4799-88C3-157F82E83ECC
MediaPicker3SingleImage = AD9F0CF2-BDA2-45D5-9EA1-A63CFC873FD3
Member = d59be02f-1df9-4228-aa1e-01917d806cda
MemberPicker = 1EA2E01F-EBD8-4CE1-8D71-6B1149E63548
MultipleMediaPicker = 9DBBCBBB-2327-434A-B355-AF1B84E5010A
Numeric = 2e6d3631-066e-44b8-aec4-96f09099b2b5
Radiobox = bb5f57c9-ce2b-4bb9-b697-4caca783a805
RelatedLinks = B4E3535A-1753-47E2-8568-602CF8CFEE6F
RichtextEditor = ca90c950-0aff-4e72-b976-a30b1ac57dad
Tags = b6b73142-b9c1-4bf8-a16d-e1c23320b549
Textarea = c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3
Textstring = 0cc0eba1-9960-42c9-bf9b-60e150b429ae
Upload = 84c6b441-31df-4ffe-b67e-67d5bc3ae65a
UploadArticle = bc1e266c-dac4-4164-bf08-8a1ec6a7143d
UploadAudio = 8f430dd6-4e96-447e-9dc0-cb552c8cd1f3
UploadVectorGraphics = 215cb418-2153-4429-9aef-8c0f0041191b
UploadVideo = 70575fe7-9812-4396-bbe1-c81a76db71b5
```

Media types:

```
MediaTypes.Article - a43e3414-9599-4230-a7d3-943a21b20122
MediaTypes.Audio - a5ddeee0-8fd8-4cee-a658-6f1fcdb00de3
MediaTypes.File - 4c52d8ab-54e6-40cd-999c-7a5f24903e4d
MediaTypes.Folder - f38bd2d7-65d0-48e6-95dc-87ce06ec2d3d
MediaTypes.Image - cc07b313-0843-4aa8-bbda-871c8da728c8
MediaTypes.Video - f6c515bb-653c-4bdc-821c-987729ebe327
"Vector Graphics (SVG)" - c4b1efcf-a9d5-41c4-9621-e9d273b52a9c
```

Member types:

```
MemberTypes.DefaultAlias - d59be02f-1df9-4228-aa1e-01917d806cda
```

---
meta.Title: "Creating Dictionary Items in Umbraco"
meta.Description: "Creating Dictionary Items in Umbraco"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Dictionary Items

Depending on how your site is set up, not all content is edited through the **Content** section. There might be some text in your templates or macros that needs translation. Using Dictionary Items, you can store a value for each language. Dictionary Items have a unique key which is used to fetch the value of the Dictionary Item.

Dictionary Items can be managed from the **Translation** section. Let's take a look at an example. In this example, we will translate "Welcome to Umbraco" from within the template and add it to the dictionary:
![Dictionary Item](images/dictionary-item.png)

## Adding a Dictionary Item

To add a Dictionary Item:

1. Go to the **Translation** section.
2. Click on **Dictionary** in the **Translation** tree and select **Create**.
3. Enter the **Name** for the dictionary item. Let's say *Welcome*.
    ![Create dictionary item](images/Create-dictionary-item.png)
4. Click **Create**.
5. Enter the values for the different language versions.
    ![Create dictionary item](images/dictionary-item-values.png)
6. Click **Save**.

### Grouping Dictionary Items

To group dictionary items:

1. Go to the **Translation** section.
2. Click on **Dictionary** in the **Translation** tree and select **Create**.
3. Enter the **Name** for the dictionary item. Let's say *Contact*.
4. Click **Create**.
5. Click on **Contact** and select **Create**.
6. Enter the **Name** of the item to be created under the **Contact** group.
7. Click **Create**.
8. Enter the values for the different language versions.
    ![Display dictionary item](images/display-dictionary-item.png)
9. Click **Save**.

## Fetching Dictionary Values

To fetch dictionary values in the template, replace the text with the following snippet:

```csharp
@Umbraco.GetDictionaryValue("Welcome")
```

![Rendering dictionary item](images/rendering-dictionary-item.png)

Alternatively, you can specify an `altText` which will be returned if the dictionary value is empty.

```csharp
@Umbraco.GetDictionaryValue("Welcome", "Another amazing day in Umbraco")
```

![Rendering dictionary item](images/rendering-altvalue-dictionary-item.png)

## Using Dictionary Item in a Multilingual website

To use Dictionary Items in a multilingual website, see the [Creating a Multilingual Site](../../../Tutorials/Multilanguage-Setup/index.md) article.

## Related Links

- [API reference for the DictionaryItem](../../../Reference/Management/Models/DictionaryItem.md)
- [Localization Service](../../../Reference/Management/Services/LocalizationService/index.md)
- [Creating a Multilingual Site](../../../Tutorials/Multilanguage-Setup/index.md)
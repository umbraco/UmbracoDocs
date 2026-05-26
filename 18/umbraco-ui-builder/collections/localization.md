---
description: >-
  Using the available context to handle localization for an UI Builder
  collection
---

# Localization

The localization context enables developers to use multilingual collection names and descriptions in fluent configurations. It also supports translations for actions, context apps, dashboards, sections, and trees.

To enable localization, prefix the input string with the `#` character.

Upon character identification in the fluent configuration, the localization context will attempt to lookup a matching localized string using two services available. If no matching record is found, it will default to the provided string value.

Supported areas:

* Collections - `Name` and `Description` properties.
* Data Views - only if the key is in a localization resource, not in the translation dictionary (e.g. [additional localization](#localizing-an-additional-area)).
* Collection filters - `Label` and `Description` properties.
* Cards
* Editor fields - `Label` and `Description` field properties.
* Fieldsets names
* Actions names
* Context Apps names
* Dashboards names
* Sections names

## Localization Services

The localization context uses two abstractions to provide localization options.

The first uses the Umbraco translations dictionary to retrieve a value based on a provided key.

The second uses the CMS `ILocalizedTextService` to retrieve a value based on area and alias. These values are supplied in the collection's fluent configuration, separated by an underscore `_` from the localization resources.

## Example

### Localizing a Collection

For a `Students` collection, use the following fluent configuration:

```csharp
treeConfig.AddCollection<Student>(x => x.Id, "#CollectionStudents", "#CollectionStudents", "A list of students", "icon-umb-members", "icon-umb-members", collectionConfig =>
{
    ...
});
```

![collection\_translation](../.gitbook/assets/collection_translation.png)

Alternatively, you can use the lowercase version:

```csharp
treeConfig.AddCollection<Student>(x => x.Id, "#collection_students", "#collection_students", "A list of students", "icon-umb-members", "icon-umb-members", collectionConfig =>
{
    ...
});
```

Define the translation in your localization dictionary file:

```
import type { UmbLocalizationDictionary } from "@umbraco-cms/backoffice/localization-api";

export default {
    collection: {
        students: "Studerende"
    }
    ...
}
```

![collection\_name](../.gitbook/assets/collection_name.png)

### Localizing a Section

For a custom section, use the following configuration:

```csharp
.AddSection("#UmbracoTraining", sectionConfig =>
{
    ...
}
```

![section_name](../images/section_name.png)

### Localizing an additional area

When the implemented localization does not cover a specific area, you can update it directly in the fluent configuration by using the `LocalizationContext`.

For example, this custom data view:

```csharp
public class CommentStatusDataViewsBuilder : DataViewsBuilder<Comment>
{
    private readonly LocalizationContext _localizationContext;
    public CommentStatusDataViewsBuilder(LocalizationContext localizationContext)
    {
        _localizationContext = localizationContext;
    }

    public override IEnumerable<DataViewSummary> GetDataViews()
    {
        yield return new DataViewSummary
        {
            Name = _localizationContext.TryLocalize("#dataView_All", out string localizedText) ? localizedText : string.Empty,
            Alias = "all",
            Group = "Status"
        };
        
        foreach (var val in Enum.GetValues<CommentStatus>())
        {
            yield return new DataViewSummary
            {
                Name = val.ToString(),
                Alias = val.ToString().ToLower(),
                Group = "Status"
            };
        }
    }
}
```

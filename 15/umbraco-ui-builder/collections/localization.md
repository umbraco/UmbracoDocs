---
description: Using the available context to handle localization for an UI Builder collection
---

# Localization

The localization context enables developers to use multilingual collection names and descriptions in fluent configurations. It also supports translations for actions, context apps, dashboards, sections, and trees. 

To enable localization the input string must be prefixed by the `#` character.

Upon character identification in the fluent configuration, the localization context will attempt to lookup a matching localized string using two services available. If no matching record is found, it will default to the provided string value.

## Localization Services

To provide localization options, the context is using two abstractions.

One is using the Umbraco translations dictionary to retrieve a value based on a provided key.

The other uses the CMS `ILocalizedTextService` to retrieve a value based on area and alias (these will be supplied in the collection's fluent configuration separated by `_`) from the localization resources.

## Example

For a `Students` collection we would use the following fluent configuration:

```csharp
treeConfig.AddCollection<Student>(x => x.Id, "#CollectionStudents", "#CollectionStudents", "A list of students", "icon-umb-members", "icon-umb-members", collectionConfig =>
{
    ...
});
```

![collection_translation](../images/collection_translation.png)

Or

```csharp
treeConfig.AddCollection<Student>(x => x.Id, "#collection_students", "#collection_students", "A list of students", "icon-umb-members", "icon-umb-members", collectionConfig =>
{
    ...
});
```

```
import type { UmbLocalizationDictionary } from "@umbraco-cms/backoffice/localization-api";

export default {
    collection: {
        students: "Studerende"
    }
    ...
}
```

![collection_name](../images/collection_name.png)

For a custom section we can use the following configuration:

```csharp
.AddSection("#UmbracoTraining", sectionConfig =>
{
    ...
}
```

![section_name](../images/section_name.png)



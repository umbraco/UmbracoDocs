---
description: An explanation on sections and trees in Umbraco
---

# Sections

The Umbraco backoffice consists of Sections, also referred to as Applications, which contain Trees.

Each section is shown in the top navigation ribbon of the Umbraco Backoffice.

## Create a Custom Section

To create a new custom section in your Umbraco backoffice, the first thing you have to do is create a new folder inside `/App_Plugins`. We will call it `MyFavouriteThings`.

Next we need to create a manifest where we'll include some basic configuration for our new section.

## Registering a Custom Section

There are two approaches to registering a custom section to appear in the Umbraco Backoffice:

### Registering with package.manifest

Create a new file in the `/App_Plugins/MyFavouriteThings/` folder and name it `package.manifest`. In this new file, copy the code snippet below and save it.

```json
{
    "sections": [
        {
            "alias": "myFavouriteThings",
            "name": "My Favourite Things"
        }
    ]
}
```

This would create a new section in your Umbraco backoffice called 'My Favourite Things'.

When registering your section this way, it is added to the end of the collection of sections. But as more `package.manifest` files may do the same, the order of the additional sections depends on the order of which the `package.manifest` files are loaded. Registering your section this way doesn't allow further control of its order.

### Registering with C# Type

By creating a C# class that implements `ISection` from `Umbraco.Cms.Core.Sections`:

```csharp
using Umbraco.Cms.Core.Sections;

namespace My.Website.Sections;

public class MyFavouriteThingsSection : ISection
{
    public string Alias => "myFavouriteThings";

    public string Name => "My Favourite Things";
}
```

For your C# type to be discovered by Umbraco at application start up, it needs to be appended to the `SectionCollectionBuilder`.

You can achieve this by creating a `Composer` and call the `Append` method:

```csharp
using Umbraco.Cms.Core.Composing;

namespace My.Website.Sections;

public class SectionComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Sections().Append<MyFavouriteThingsSection>();
    }
}
```

This would also create a new section called 'My Favourite Things' in your Umbraco Backoffice.

Similar to registering the section via a `package.manifest` file, the `Append<>` method will add the section to the end of the list of sections.

If you wish to control the order of your section a bit more, you can use some of the other methods on `SectionsCollectionBuilder`. For instance, you can add your section at a specific index:

```csharp
builder.Sections().Insert<MyFavouriteThingsSection>(2);
```

Or before or after an existing section:

```csharp
builder.Sections().InsertBefore<SettingsSection, MyFavouriteThingsSection>();
```

```csharp
builder.Sections().InsertAfter<SettingsSection, MyFavouriteThingsSection>();
```

The final order of the sections is down to the order of which the composers are executed. For instance, two composers may add a new section before `SettingsSection`, in which case the latter will add its section between the section of the first composer and `SettingsSection`.

### Why can't I see my new Custom Section?

You will also need to allow your current Umbraco User group access to this new Custom Section via the backoffice! (you will need to logout and back in again to see the change)

![Add Section for User](<../../../../13/umbraco-cms/extending/section-trees/images/add-custom-section-v8 (1).png>)

### Adding a Language Translation (get rid of the square brackets)

![Custom Section appears displaying Alias](<../../../../13/umbraco-cms/extending/section-trees/images/custom-section-alias-v8 (1).png>)

When your new custom section appears, you'll notice only the section 'Alias' is displayed inside square brackets. This is because Umbraco caters for Multiple Languages in the backoffice, and is looking for a translation file for the current backoffice culture, containing a translation key for your custom section alias.

Create a /lang folder in the folder where you are creating the implementation for your custom section. If you do not have one already, create a `/lang` folder within the folder where you are creating the implementation for your custom section, eg. `/App_Plugins/MyFavouriteThings/lang/`.

It is worth knowing that the `/lang` folder does not have to be directly in the MyFavouriteThings folder, it can be nested deeper if you need it to be. The only requirement is that the folder is called lang. E.g. _\~/App\_Plugins/MyFavouriteThings/Some/Another/Lang/_.

Inside this folder create a file called **en-us.xml**. This is the 'default' fallback language translation file. Add the following definition:

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language alias="en" intName="English (US)" localName="English (US)" lcid="" culture="en-US">
  <area alias="sections">
    <key alias="myFavouriteThings">My Favourite Things</key>
  </area>
</language>
```

Recycle the application pool, and the square brackets will be gone, and your section will have the title 'My Favourite Things'.

You can add custom language translation keys in this file for providing translated versions of text used throughout your custom section/tree implementation.

To provide translations in other languages, duplicate the en-us.xml file in the /lang folder and rename it to match the lang/culture combination of your newly supported language. Update the contents of the language element attributes, and provide a translation for each 'language translation key'.

You will need to recycle the application pool, to see changes to the language translation files reflected in the backoffice.

[Now create a custom tree to load in your custom section!](trees/)

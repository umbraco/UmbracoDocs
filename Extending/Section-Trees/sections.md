# Sections

The Umbraco backoffice consists of Sections, also referred to as Applications, which contain Trees. 

Each section is identified by an icon in the left-hand side navigation ribbon of the Umbraco Backoffice.

[Configuration for sections is defined in the `~/Config/applications.config` file.](../../Reference/Config/applications/index.md) 

## Create a Custom Section

To create a new custom section in your Umbraco backoffice, add an entry in the `~/Config/applications.config` file.

eg, adding the following...

```xml
<add alias="favStuff" name="My Favourite Things" icon="icon-hearts" sortOrder="7" />
```

... would create a new Section in your Umbraco backoffice called 'My Favourite Things' and be represented by a heart in the section navigation.

### Why can't I see my new Custom Section?

You will also need to allow your current Umbraco User access to this new Custom Section via the backoffice! (you will need to logout and back in again to see the change)

![Add Section for User](images/add-custom-section.png)

### Adding a Language Translation (get rid of the square brackets)

![Custom Section appears displaying Alias](images/custom-section-alias.png)

When your new custom section appears, you'll notice only the section 'Alias' is displayed inside square brackets. This is because Umbraco caters for Multiple Languages in the backoffice, and is looking for a translation file for the current backoffice culture, containing a translation key for your custom section alias.

Create a /lang folder in the folder where you are creating the implementation for your custom section(if not create one in the app_plugins folder eg */app_plugins/favouritethings/lang*)

inside this folder create a file called **en-us.xml** this is the 'default' fallback language translation file, and add the following definition:

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language alias="en" intName="English (US)" localName="English (US)" lcid="" culture="en-US">
  <area alias="sections">
    <key alias="favStuff">My Favourite Things</key>
  </area>
</language>
```

Recycle the application pool, and the square brackets will be gone, and your section will have the title 'My Favourite Things'

You can add custom language translation keys in this file for providing translated versions of text used throughout your custom section/tree implementation.

To provide translations in other languages, duplicate the en-us.xml file in the /lang folder and rename to match the lang/culture combination of your newly supported language, update the contents of the language element attributes, and provide a translation for each 'language translation key'

You will need to recycle the application pool, to see changes to the language translation files reflected in the backoffice.

[Now create a custom tree to load in your custom section!](../../Extending/Section-Trees/trees-v7.md) 

## Section Service API v7

The section API in v7+ is found in the interface `Umbraco.Core.Services.ISectionService` which is exposed on the ApplicationContext singleton. This API is used to control/query the storage for tree registrations in the ~/Config/applications.config file.

[See the section service API reference here](../../Reference/Management/Services/SectionService.md) 

## Section (Application) API v6

The section API in v6/v4 is found in the class `umbraco.BusinessLogic.Application`. This API is used to control/query the storage for section registrations in the ~/Config/applications.config file.

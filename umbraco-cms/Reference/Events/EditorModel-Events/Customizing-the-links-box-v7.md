---
versionFrom: 7.0.0
---

# Customizing the "Links" box

For a content item, Umbraco will show a **Links** box under the **Info** tab. By default, this box will show one or more links to content item.

![image](Images/properties-info-tab.png)

With the `SendingContentModel` event, we can manipulate the links in the `Urls` property - eg. replace it with some custom links (although a URL provider may be more suitable):

```C#
EditorModelEventManager.SendingContentModel += (sender, e) => {

    // Replace the links with our custom array
    e.Model.Urls = new []
    {
        "/products/?id=" + e.Model.Id
    };

};
```

or remove the box entirely by providing an empty list of links:

:::warning
Versions prior to Umbraco 7.13 don't support hiding the **Links** box, and as a result, the example below will lead to an empty box.
:::

```C#
EditorModelEventManager.SendingContentModel += (sender, e) => {

    // Setting "Urls" to either null or an empty array will remove the box from the UI
    e.Model.Urls = null;

};
```

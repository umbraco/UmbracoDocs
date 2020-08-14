---
versionFrom: 8.0.0
---

# Customizing the "Links" box

For a content item, Umbraco will show a **Links** box within the **Info** content app. By default, this box will show one or more links to content item.

![image](Images/properties-info-app.png)

With the `SendingContentModel` event, we can manipulate the links in the `Urls` property - eg. replace it with some custom links (although a URL provider may be more suitable):

```C#
EditorModelEventManager.SendingContentModel += (sender, e) => {

    // Replace the links with our custom array
    e.Model.Urls = new[]
	{
		new UrlInfo("/products/?id=" + e.Model.Id, true, CultureInfo.CurrentCulture.Name)
		
	};

};
```

or remove the box entirely by providing an empty list of links:

```C#
EditorModelEventManager.SendingContentModel += (sender, e) => {

    // Setting "Urls" to either null or an empty array will remove the box from the UI
    e.Model.Urls = null;

};
```

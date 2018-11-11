# Customizing tabs

All of the current four events allow you to customize the tabs. This could be as simple as changing the label (text) of the tab - here for content:

```C#
EditorModelEventManager.SendingContentModel += (sender, e) => {

    // Iterate through the tabs
    foreach (var tab in e.Model.Tabs)
    {

        // Change the label of the "Content" tab to "Hello World"
        if (tab.Label == "Content")
        {
            tab.Label = "Hello World";
        }

    }

};
```

In this example, we iterate over the tabs provided in the model, and change the label of the **Content** tab to **Hello World**.

For another scenario, we could have an **Advanced** tab we only wish to show to for certain users:

```C#
EditorModelEventManager.SendingContentModel += (sender, e) => {

    if (UmbracoContext.Current == null) return;

    // Is the current user an administrator?
    if (UmbracoContext.Current.Security.CurrentUser.IsAdmin() == false)
    {
        e.Model.Tabs = e.Model.Tabs.Where(x => x.Label != "Advanced");
    }

};
```

Notice that the example doesn't check the content type, so will apply for all **Advanced** tabs across all content items where a tab with this name is present.

:::tip
The `CssClass` property as shown in the example below is available from Umbraco 7.13.
:::

It's also possible to to change the look of a tab. This could be by making the label bold, or appending an icon to the tab - both accomplished by specifying one or more CSS class names for the `CssClass` property:

```C#
EditorModelEventManager.SendingContentModel += (sender, e) => {

    // Iterate through the tabs
    foreach (var tab in e.Model.Tabs)
    {

        // Add a "h5yr" class to the "Umbraco" tab
        if (tab.Label == "Umbraco")
        {
            tab.CssClass = "h5yr";
        }

        // Add a "design" class to the "Design" tab
        if (tab.Label == "Design")
        {
            tab.CssClass = "design";
        }

    }

};
```

With the correct CSS, the two tabs could then look like:

![image](https://user-images.githubusercontent.com/3634580/47519269-7f263980-d88d-11e8-8abd-9b976cdb9239.png)

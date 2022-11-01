---
versionTo: 6.2.1
---

# Create a dashboard using Usercontrols (v6)

## Create one or more UserControls

The Dashboard loads one or more UserControls and displays them on a series of tabs. So in order to customize the control, one needs to first create the UserControls that are to be displayed on the page. If these are for your own personal use you can place the UserControls in a location on your site that can be accessed by Umbraco. It is recommended that you place them in the /usercontrol directory, preferably in your own subfolder. If you are creating a package for others to use, you should include the usercontrols in the package for install with the rest of the package contents.

## Update the Dashboard.config

Once you have created the UserControls that you want to have loaded when a section loads, you must then update the Dashboard.config to tell Umbraco to load your UserControls when a user enters a new section. Again, if you are doing this for yourself all you need to do is edit the Dashboard.config on your site to add the controls. However, if you are adding a section to go with a package, you will want to include a Package Action to update the Dashboard.config during install.

See [Package Actions.](../../../Extending/Packages/package-actions.md) for more information.

## Sample

Below is an example of a valid Dashboard.config:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<dashBoard>
    <section>
        <areas>
            <area>content</area>
        </areas>
        <tab caption="Last Edits">
            <access>
                <deny>editor</deny>
            </access>
            <control>/usercontrols/dashboard/latestEdits.ascx</control>
        </tab>
        <tab caption="Latest Items">
            <control>/usercontrols/dashboard/newestItems.ascx</control>
        </tab>
        <tab caption="Create blog post">
            <control>/usercontrols/umbracoBlog/dashboardBlogPostCreate.ascx</control>
        </tab>
        <tab caption="Show This Only Once">
            <control showOnce="true">/usercontrols/ConfigureAPlugin.ascx</control>
        </tab>
    </section>
</dashBoard>
```

What this does is every time a user clicks on the Content section of the Umbraco UI, it loads a page with three tabs called "Last Edits", "Latest Items" and "Create blog post". For each tab a UserControl is loaded to provide the functionality that the developer created for those tabs. The UI finds the UserControls via the paths provided.

The `showOnce` attribute made it possible to only show a particular user control once.

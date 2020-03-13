---
keywords: nonodes
versionFrom: 9.0.0
meta.Title: "No Published Content Page"
meta.Description: "Details the standard page served by Umbraco when no published content is available."
---
# No Published Content Page

When Umbraco is first installed, if no starter kit is chosen, there will be no content created in the backoffice, and no published content to display.

Content can also be created, but be unpublished.

If browsing the front-end of the website, when this situation of no published content is found, a custom page is displayed.

This page is served from `/config/splashes/NoNodes.cshtml`.

## Customising The Page

Whilst the contents of this page can be edited directly, this isn't recommended, as care would need to be taken to avoid the changes getting overwritten in upgrades.

Instead there are two options.

To return the contents of a different Razor file, create this file at your chosen location and configure it's use within the `<appSettings>` section of `web.config` using the following details:

```
<add key="Umbraco.Core.NoNodesViewPath" value="~/path/to/CustomNoNodes.cshtml" />
```

*Note: this key/value will likely move to another location once .Net Core configuration is implemented.*

For finer control, you write code to handle the route directly, allowing the implementation of a custom controller, view model and view:

```
    public class CustomNoNodesComposer: ComponentComposer<CustomNoNodesComponent>, IUserComposer
    {
    }

    public class CustomNoNodesComponent : IComponent
    {
        public void Initialize()
        {
            if (RouteTable.Routes[Constants.Web.NoContentRouteName] is Route route)
            {
                route.Defaults = new RouteValueDictionary()
                {
                    ["controller"] = "CustomNoNodes",
                    ["action"] = "Index"
                };
            }
        }

        public void Terminate() { }
    }
```



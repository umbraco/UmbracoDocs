---
keywords: dashboards dashboard extending v8 version8
versionFrom: 8.0.0
meta.Title: "Umbraco Custom Dashboards"
meta.Description: "A guide to creating custom dashboards in Umbraco"
---

# Dashboards
Each section of the Umbraco backoffice has its own set of default dashboards.

The dashboard area of Umbraco is used to display an 'editor' for the selected item in the tree. If no item is selected, for example when the section 'first loads', then the default set of section dashboards are displayed in the dashboard area, arranged over multiple tabs.

## Registering your own Dashboard
There are two approaches to registering a custom dashboard to appear in the Umbraco Backoffice:

### Registering with package.manifest
Add a file named 'package.manifest' to the 'App_Plugins' folder, containing the following json configuration pointing to your dashboard view:

```json
{
    "dashboards":  [
        {
            "alias": "myCustomDashboard",
            "view":  "/App_Plugins/myCustom/dashboard.html",
            "sections":  [ "content", "member", "settings" ],
            "weight": -10
        }
    ]
}
```

The section aliases can be found in the C# developer reference for [Umbraco.Core.Constants.Applications](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Constants.Applications.html).

### Registering with C# Type
By creating a C# class that implements `IDashboard` from `Umbraco.Core.Dashboards` then this will automatically be discovered by Umbraco at application startup time.

```csharp
using System;
using Umbraco.Core.Composing;
using Umbraco.Core.Dashboards;

namespace My.Website
{
    [Weight(-10)]
    public class MyDashboard : IDashboard
    {
        public string Alias => "myCustomDashboard";

        public string[] Sections => new[]
        {
            Umbraco.Core.Constants.Applications.Content,
            Umbraco.Core.Constants.Applications.Members,
            Umbraco.Core.Constants.Applications.Settings
        };

        public string View => "/App_Plugins/myCustom/dashboard.html";

        public IAccessRule[] AccessRules => Array.Empty<IAccessRule>();
    }
}
```

### Re-ordering / weighting
Each dashboard, regardless of how it is registered (package.manifest or C# or default core dashboard) uses a *weight* property to assign the order that the dashboard should be displayed. The dashboard with the lowest weighting number will be displayed first in a collection where one or more dashboards are visible for a section/application.

For reference, here is a list of the weighting values for the default Umbraco dashboards, so you can assign a weighting to your own custom dashboard with a higher or lower value to suit your custom ordering needs.

**Content**
<table class="table">
  <thead>
    <tr>
    <th>Name</th>
    <th>Weight</th>
    <th>Language Key</th>
    <th>C# Type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
    <td>Getting Started</td>
    <td>10</td>
    <td>dashboardTabs/contentIntro</td>
    <td>Umbraco.Web.Dashboards.ContentDashboard</td>
    </tr>
    <tr>
    <td>Redirect URL Management</td>
    <td>20</td>
    <td>dashboardTabs/contentRedirectManager</td>
    <td>Umbraco.Web.Dashboards.RedirectUrlDashboard</td>
    </tr>
  </tbody>
</table>

**Media**
<table class="table">
  <thead>
    <tr>
    <th>Name</th>
    <th>Weight</th>
    <th>Language Key</th>
    <th>C# Type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
    <td>Content</td>
    <td>10</td>
    <td>dashboardTabs/mediaFolderBrowser</td>
    <td>Umbraco.Web.Dashboards.MediaDashboard</td>
    </tr>
  </tbody>
</table>

**Settings**
<table class="table">
  <thead>
    <tr>
    <th>Name</th>
    <th>Weight</th>
    <th>Language Key</th>
    <th>C# Type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
    <td>Welcome</td>
    <td>10</td>
    <td>dashboardTabs/settingsWelcome</td>
    <td>Umbraco.Web.Dashboards.SettingsDashboard</td>
    </tr>
    <tr>
    <td>Examine Management</td>
    <td>20</td>
    <td>dashboardTabs/settingsExamine</td>
    <td>Umbraco.Web.Dashboards.ExamineDashboard</td>
    </tr>
    <tr>
    <td>Published Status</td>
    <td>30</td>
    <td>dashboardTabs/settingsPublishedStatus</td>
    <td>Umbraco.Web.Dashboards.PublishedStatusDashboard</td>
    </tr>
    <tr>
    <td>Models Builder</td>
    <td>40</td>
    <td>dashboardTabs/settingsModelsBuilder</td>
    <td>Registered in ModelsBuilder package.manifest</td>
    </tr>
    <tr>
    <td>Health Check</td>
    <td>50</td>
    <td>dashboardTabs/settingsHealthCheck</td>
    <td>Umbraco.Web.Dashboards.HealthCheckDashboard</td>
    </tr>
  </tbody>
</table>

**Members**
<table class="table">
  <thead>
    <tr>
    <th>Name</th>
    <th>Weight</th>
    <th>Language Key</th>
    <th>C# Type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
    <td>Getting Started</td>
    <td>10</td>
    <td>dashboardTabs/memberIntro</td>
    <td>Umbraco.Web.Dashboards.MembersDashboard</td>
    </tr>
  </tbody>
</table>

**Forms**
<table class="table">
  <thead>
    <tr>
    <th>Name</th>
    <th>Weight</th>
    <th>Language Key</th>
    <th>C# Type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
    <td>Install Umbraco Forms</td>
    <td>10</td>
    <td>dashboardTabs/formsInstall</td>
    <td>Umbraco.Web.Dashboards.FormsDashboard</td>
    </tr>
  </tbody>
</table>

### Add Language Keys
After registering your dashboard, it will appear in the backoffice - however it will have its dashboard alias [mycustomdashboard] wrapped in square brackets. This is because it is missing a language key. The language key allows people to provide a translation of the dashboard name in multilingual environments. To remove the square brackets - add a language key:

If your dashboard is unique to your Umbraco installation then you can modify the following application language file: `config/lang/en-US.user.xml`. If the dashboard is to be released as an Umbraco package and shared with others to use in their own Umbraco installation, you will need to create a *lang* folder in your custom dashboard folder. You also need to create a package specific language file:  `App_Plugins/Mycustomdashboard/lang/en-US.xml`.

[Read more about language files](../Language-Files/index.md)

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language>
    <area alias="dashboardTabs">
        <key alias="myCustomDashboard">My Dashboard</key>
    </area>
</language>
```

### Specifying permissions
You can configure which applications/sections a dashboard will appear in, in the above examples (package.manifest or c#), you can see the alias of the section is used to control where the dashboard is allowed to appear.

Further to this, within this section, you can control which Users can see a particular dashboard based upon the *User Groups* they belong to. This is done by setting the 'access' permissions based on the *User Group* alias, you choose to deny or grant a particular User Group's access to the dashboard.

```json
{
    "dashboards":  [
        {
            "alias": "myCustomDashboard2",
            "view":  "/App_Plugins/myCustom/dashboard.html",
            "sections": [ "content", "settings" ],
            "weight": -10,
            "access": [
                { "deny": "translator" },
                { "grant": "admin" }
            ]
        }
    ]
}
```

```csharp
using Umbraco.Core.Composing;
using Umbraco.Core.Dashboards;

namespace My.Website
{
    [Weight(-10)]
    public class MyDashboard : IDashboard
    {
        public string Alias => "myCustomDashboard";
		
        public string[] Sections => new[]
        {
            Umbraco.Core.Constants.Applications.Content,
            Umbraco.Core.Constants.Applications.Settings
        };
				
        public string View => "/App_Plugins/myCustom/dashboard.html";

        public IAccessRule[] AccessRules
        {
            get
            {
                var rules = new IAccessRule[]
                {
                    new AccessRule {Type = AccessRuleType.Deny, Value = Umbraco.Core.Constants.Security.TranslatorGroupAlias},
                    new AccessRule {Type = AccessRuleType.Grant, Value = Umbraco.Core.Constants.Security.AdminGroupAlias}
                };
                return rules;
            }
        }
    }
}
```

## Remove an Umbraco dashboard
In previous versions of Umbraco if you wanted to remove or modify the order of a default dashboards you would amend the `config/dashboards.config` file on disk.

In Umbraco 8+ the configuration file approach has been removed and you need to use code to create your own *composer* to remove a dashboard. It could be a c# class that can be used to organise and customise your Umbraco application to your own needs. For example - if you wanted to remove the 'Content Dashboard' you would create a RemoveDashboard composer like this:

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Web;
using Umbraco.Web.Dashboards;

namespace My.Website
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class RemoveDashboard : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.Dashboards().Remove<ContentDashboard>();
        }
    }
}
```

## Override an Umbraco Dashboard
In Umbraco 8+, to modify the order of a default dashboard or change its permissions, you must first remove the default dashboard (see above), then add an overridden instance of the default dashboard.  The overridden dashboard can then include your modifications.  For example, if you wanted to deny the Writers group access to the default Redirect URL Management dashboard, you would create an override of RedirectUrlDashboard to add after removing the default dashboard.

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Dashboards;
using Umbraco.Web;
using Umbraco.Web.Dashboards;

namespace MyDashboardCustomization
    {
    public class MyComposer : IComposer
    {
        public void Compose(Composition composition)
        {
            composition.Dashboards()
                // Remove the default
                .Remove<RedirectUrlDashboard>()
                // Add the overridden one
                .Add<MyRedirectUrlDashboard>();
        }
    }

    // overridden redirect dashboard with custom rules
    public class MyRedirectUrlDashboard : RedirectUrlDashboard, IDashboard
    {
        // override explicit implementation
        IAccessRule[] IDashboard.AccessRules { get; } = new IAccessRule[]
        {
            new AccessRule {Type = AccessRuleType.Deny, Value = "writer"},
            new AccessRule {Type = AccessRuleType.Grant, Value = Umbraco.Core.Constants.Security.AdminGroupAlias}
        };
    }
}
```

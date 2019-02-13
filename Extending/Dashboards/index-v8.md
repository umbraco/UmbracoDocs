---
keywords: dashboards dashboard extending v8 version8
versionFrom: 8.0.0
---

# Dashboards
Each section of the Umbraco backoffice has its own set of default dashboards.

The dashboard area of Umbraco is used to display an 'editor' for the selected item in the tree. If no item is selected, for example when the section 'first loads', then the default set of section dashboards are displayed in the dashboard area, arranged over multiple tabs.

## Creating your own Dashboard
There are two approaches on registering a dashboard in Umbraco which are explained in detail below.

### Registering with package.manifest
```json
{
    "dashboards":  [
        {
            "alias": "myCustomDashboard",
            "view":  "/App_Plugins/myCustom/dashboard.html",
            "sections":  [ "content", "settings" ],
            "weight": -10
        }
    ]
}
```

### Registering with C# Type
By creating a C# class that implements `IDashboard` from `Umbraco.Core.Dashboards` then this will automatically get picked up by Umbraco when it boots up.

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

        public string[] Sections => new[] { "content", "settings" };

        public string View => "/App_Plugins/myCustom/dashboard.html";

        public IAccessRule[] AccessRules => Array.Empty<IAccessRule>();
    }
}
```

### Re-ordering
Each dashboard be it registered with package.manifest or C# uses a weight property to assign the order that the dashboard should be displayed. With the lowest number being displayed first in a collection where one or more dashboards are visible in a section/application.

For reference here is the values of the default Umbraco dashboards, so you are then able to assign your own custom dashboard with a higher or lower value to suit your own ordering needs.

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
      <td>Examine Management</td>
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
After creating your dashboard, you will see in the backoffice it will have it's dahsboard alias wrapped in square brackets. This is because it is missing a language key.
You will need to add a language key like shown below.

If your dashboard is unique to your Umbraco installation then you can modify the following: `config/lang/en-US.user.xml` or if it is intended to be used in an Umbraco pakcage and share with others to use in their own Umbraco installation then you will need to modify/add `App_Plugins/MyPackage/lang/en-US.xml`

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
See the updated examples now includes access properties that specify what user groups aliases are granted or denied permission to see the dashboard.

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

        public string[] Sections => new[] { "content", "settings" };

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
In previous versions of Umbraco if you wanted to modify the order of the default dashboards you would ammend the `config/dashboards.config` file on disk. With V8+ you need to create your own composer that is used to organise and customise your Umbraco application to your own needs. If you want for example to remove the Content Dashboard you would do this:

```csharp
using Umbraco.Core;
using Umbraco.Core.Components;
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

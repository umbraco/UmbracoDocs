---
description: A guide to creating custom dashboards in Umbraco
---

# Dashboards

{% hint style="warning" %}
This page is a work in progress. It has been migrated but the content is waiting to be updated for the new Backoffice.
{% endhint %}

You can try and [create a custom dashboard](broken-reference) when you have read this article.

Each section of the Umbraco backoffice has its own set of default dashboards.

The dashboard area of Umbraco is used to display an 'editor' for the selected item in the tree. If no item is selected, for example when the section is first loaded in the browser, then the default set of section dashboards are displayed in the dashboard area, arranged over multiple tabs.

## Registering your Dashboard

There are two approaches to registering a custom dashboard to appear in the Umbraco Backoffice:

### Registering with the package.manifest file

Add a file named 'package.manifest' to the 'App\_Plugins' folder, containing the following JSON configuration pointing to your dashboard view:

```jsx
{
    "dashboards":  [
        {
             "alias": "myCustomDashboard",
             "view": "/App_Plugins/MyCustomDashboard/dashboard.html",
             "sections": [ "content", "member", "settings" ],
             "weight": -10
        }
    ]
}
```

The section aliases can be found in the C# developer reference for [Umbraco.Cms.Core.Constants.Applications](https://apidocs.umbraco.com/v9/csharp/api/Umbraco.Cms.Core.Constants.Applications.html).

### Registering with C# Type

By creating a C# class that implements `IDashboard` from `Umbraco.Cms.Core.Dashboards` then this will automatically be discovered by Umbraco at application startup time.

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Dashboards;
using Umbraco.Cms.Core;

namespace Umbraco.Docs.Samples.Web.Dashboards
{
    [Weight(-10)]
    public class MyCustomDashboard : IDashboard
    {
        public string Alias => "myCustomDashboard";

        public string[] Sections => new[]
        {
            Constants.Applications.Content,
            Constants.Applications.Members,
            Constants.Applications.Settings
        };

        public string View => "/App_Plugins/MyCustomDashboard/dashboard.html";

        public IAccessRule[] AccessRules => Array.Empty<IAccessRule>();
       
    }
}
```

### Re-ordering / weighting

Each dashboard regardless of how it is registered (package.manifest or C# or default core dashboard) uses a _weight_ property to assign the order that the dashboard should be displayed. The dashboard with the lowest weighting number will be displayed first in a collection where one or more dashboards are visible for a section/application.

For reference, here is a list of the weighting values for the default Umbraco dashboards, so you can assign a weighting to your custom dashboard with a higher or lower value to suit your custom ordering needs.

**Content**

| Name                    | Weight | Language Key                         | C# Type                                          |
| ----------------------- | ------ | ------------------------------------ | ------------------------------------------------ |
| Getting Started         | 10     | dashboardTabs/contentIntro           | Umbraco.Cms.Core.Dashboards.ContentDashboard     |
| Redirect URL Management | 20     | dashboardTabs/contentRedirectManager | Umbraco.Cms.Core.Dashboards.RedirectUrlDashboard |

**Media**

| Name    | Weight | Language Key                     | C# Type                                    |
| ------- | ------ | -------------------------------- | ------------------------------------------ |
| Content | 10     | dashboardTabs/mediaFolderBrowser | Umbraco.Cms.Core.Dashboards.MediaDashboard |

**Settings**

| Name               | Weight | Language Key                          | C# Type                                              |
| ------------------ | ------ | ------------------------------------- | ---------------------------------------------------- |
| Welcome            | 10     | dashboardTabs/settingsWelcome         | Umbraco.Cms.Core.Dashboards.SettingsDashboard        |
| Examine Management | 20     | dashboardTabs/settingsExamine         | Umbraco.Cms.Core.Dashboards.ExamineDashboard         |
| Published Status   | 30     | dashboardTabs/settingsPublishedStatus | Umbraco.Cms.Core.Dashboards.PublishedStatusDashboard |
| Models Builder     | 40     | dashboardTabs/settingsModelsBuilder   | Umbraco.Cms.Core.Dashboards.ModelsBuilderDashboard   |
| Health Check       | 50     | dashboardTabs/settingsHealthCheck     | Umbraco.Cms.Core.Dashboards.HealthCheckDashboard     |

**Members**

| Name            | Weight | Language Key              | C# Type                                      |
| --------------- | ------ | ------------------------- | -------------------------------------------- |
| Getting Started | 10     | dashboardTabs/memberIntro | Umbraco.Cms.Core.Dashboards.MembersDashboard |

**Forms**

| Name                  | Weight | Language Key               | C# Type                                    |
| --------------------- | ------ | -------------------------- | ------------------------------------------ |
| Install Umbraco Forms | 10     | dashboardTabs/formsInstall | Umbraco.Cms.Core.Dashboards.FormsDashboard |

### Add Language Keys

After registering your dashboard, it will appear in the backoffice - however, it will have its dashboard alias \[mycustomdashboard] wrapped in square brackets. This is because it is missing a language key. The language key allows people to provide a translation of the dashboard name in multilingual environments. To remove the square brackets - add a language key:

If your dashboard is unique to your installation, you can add or modify the relevant language files: `config/lang/{language}.user.xml` (e.g. `config/lang/en-US.user.xml`). If the dashboard is to be released as an Umbraco package, you will need to create a _lang_ folder in your custom dashboard folder. You also need to create a package-specific language file: `App_Plugins/Mycustomdashboard/lang/en-US.xml`.

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language>
    <area alias="dashboardTabs">
        <key alias="myCustomDashboard">My Dashboard</key>
    </area>
</language>
```

### Specifying permissions

You can configure which applications/sections a dashboard will appear in, in the above examples (package.manifest or C#), you can see the alias of the section is used to control where the dashboard is allowed to appear.

Further to this, within this section, you can control which users can see a particular dashboard based on the _User Groups_ they belong to. This is done by setting the 'access' permissions based on the _User Group_ alias, you choose to deny or grant a particular User Group's access to the dashboard.

```csharp
{
  "dashboards": [
    {
      "alias": "myCustomDashboard",
      "view": "/App_Plugins/MyCustomDashboard/dashboard.html",
      "sections": [ "content", "member", "settings" ],
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
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Dashboards;
using Umbraco.Cms.Core;

namespace Umbraco.Docs.Samples.Web.Dashboards
{
    [Weight(-10)]
    public class MyCustomDashboard : IDashboard
    {
        public string Alias => "myCustomDashboard";

        public string[] Sections => new[]
        {
            Constants.Applications.Content,
            Constants.Applications.Members,
            Constants.Applications.Settings
        };

        public string View => "/App_Plugins/MyCustomDashboard/dashboard.html";

        public IAccessRule[] AccessRules
        {
            get
            {
                var rules = new IAccessRule[]
                {
                    new AccessRule {Type = AccessRuleType.Deny, Value = Constants.Security.TranslatorGroupAlias},
                    new AccessRule {Type = AccessRuleType.Grant, Value = Constants.Security.AdminGroupAlias}
                };
                return rules;
            }
        }
    }
}
```

## Remove an Umbraco dashboard

In previous versions of Umbraco if you wanted to remove or modify the order of a default dashboard you would amend the `config/dashboards.config` file on disk.

You need to use code to create your own _composer_ to remove a dashboard. It could be a c# class that can be used to organize and customize your Umbraco application to your own needs. For example - if you wanted to remove the 'Content Dashboard' you would create a RemoveDashboard composer like this:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Dashboards;
using Umbraco.Cms.Core.DependencyInjection;

namespace Umbraco.Docs.Samples.Web.Dashboards
{
    public class RemoveDashboard : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.Dashboards().Remove<ContentDashboard>();
        }
    }
}
```

## Override an Umbraco Dashboard

To modify the order of a default dashboard or change its permissions, you must first remove the default dashboard (see above), then add an overridden instance of the default dashboard. The overridden dashboard can then include your modifications. For example, if you wanted to deny the Writers group access to the default Redirect URL Management dashboard, you would create an override of RedirectUrlDashboard to add after removing the default dashboard.

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Dashboards;
using Umbraco.Cms.Core.DependencyInjection;

namespace Umbraco.Docs.Samples.Web.Dashboards
{
    public class MyDashboardComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.Dashboards()
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
            new AccessRule {Type = AccessRuleType.Deny, Value = Constants.Security.WriterGroupAlias},            
            new AccessRule {Type = AccessRuleType.Grant, Value = Constants.Security.AdminGroupAlias},
            new AccessRule {Type = AccessRuleType.Grant, Value = "marketing"}
        };
    }
}
```

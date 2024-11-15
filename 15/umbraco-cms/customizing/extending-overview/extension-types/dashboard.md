---
description: A guide to creating custom dashboards in Umbraco
---

# Dashboards

Each section of the Umbraco backoffice has its own set of default dashboards. Your own custom sections can show dashboards, and you can create your own custom dashboards for existing sections.

<figure><img src="../../../extending/images/getting-started-dashboard.jpg" alt="The Getting Started dashboard in Umbraco"><figcaption><p>The Getting Started dashboard in Umbraco</p></figcaption></figure>

The dashboard area of Umbraco is used to display an "editor" for the selected item in the tree. If no item is selected, then the default set of section dashboards is shown in the dashboard area.

Notice that [Section Views](section-view.md) is another similar approach to append information to the root of a Section. Section views are thought mainly to be used as Secondary pages. These two approaches should ideally not be combined.

## Default Dashboards in Umbraco

The default dashboards in Umbraco are the ones that are displayed when you first enter a section in the backoffice. These dashboards are used to display information and functionality that is relevant to the section you are in.

The default sections in Umbraco are:

| Alias                   | Name       |
| ----------------------- | ---------- |
| Umb.Section.Content     | Content    |
| Umb.Section.Media       | Media      |
| Umb.Section.Settings    | Settings   |
| Umb.Section.Members     | Members    |
| Umb.Section.Users       | Users      |
| Umb.Section.Translation | Dictionary |

Here is a table of the default dashboards in Umbraco and the sections they are used including their aliases:

| Alias                            | Section              | Weight | Description                                                                                                                                      |
| -------------------------------- | -------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| Umb.Dashboard.UmbracoNews        | Umb.Section.Content  | 20     | The Getting Started dashboard users see when they first enter Umbraco. Contains the latest news of Umbraco including outbound links to resources |
| Umb.Dashboard.RedirectManagement | Umb.Section.Content  | 10     | Contains a list of active URL redirects                                                                                                          |
| Umb.Dashboard.SettingsWelcome    | Umb.Section.Settings | 500    | Contains a set of boxes with links to appropriate resources                                                                                      |

Even though these dashboards are useful, you might want to create your own custom dashboard to display specific information or functionality.

You can try and [create a custom dashboard](../../../../tutorials/creating-a-custom-dashboard/) as a way on getting started on this topic.

## Registering your Dashboard

This section dives into the Dashboard Extension Manifest, shows how to register one, and append additional details.

### Example Extension Manifest

{% hint style="info" %}
You can read more about manifests in the tutorial [Creating Your First Extension](../../../tutorials/creating-your-first-extension.md).
{% endhint %}

Insert this as an entry in the `extensions` list in a `umbraco-package.json` file.

{% code title="~/App_Plugins/WelcomeDashboard/umbraco-package.json" lineNumbers="true" %}
```json
{
  "type": "dashboard",
  "alias": "my.welcome.dashboard",
  "name": "My Welcome Dashboard",
  "element": "/App_Plugins/WelcomeDashboard/dashboard.js",
  "weight": -1,
  "meta": {
    "label": "Welcome Dashboard",
    "pathname": "welcome-dashboard"
  }
}
```
{% endcode %}

This will register a dashboard with the alias `my.welcome.dashboard` and the name `My Welcome Dashboard`. The dashboard will be loaded from the file `/App_Plugins/WelcomeDashboard/dashboard.js`. The dashboard will be displayed with the label `Welcome Dashboard` and the URL `/welcome-dashboard` on _all sections_, e.g. `/section/content/dashboard/welcome-dashboard`.

### Conditions

You can specify conditions for when the dashboard should be displayed. This is done by adding a `conditions` property to the manifest. Ideally, we would like the dashboard to be shown only in a specific section. This can be done by specifying the condition called `Umb.Condition.SectionAlias` and providing the [alias of the section](dashboard.md#default-dashboards-in-umbraco) you want the dashboard to be displayed on:

```json
"conditions": [
  {
    "alias": "Umb.Condition.SectionAlias",
    "match": "Umb.Section.Content"
  }
]
```

This will make the dashboard only be displayed on the Content section.

{% hint style="info" %}
You can read more about [Extension Conditions](condition.md) in the documentation.
{% endhint %}

### Properties

The dashboard manifest can contain the following properties:

| Property    | Type   | Description                                                                                                                                                                                                                                                                                               |
| ----------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| type        | string | The type of extension, should be `dashboard`                                                                                                                                                                                                                                                              |
| alias       | string | A unique alias for the dashboard extension                                                                                                                                                                                                                                                                |
| name        | string | The name of the dashboard extension                                                                                                                                                                                                                                                                       |
| element     | string | The path to the JavaScript file that exports the dashboard                                                                                                                                                                                                                                                |
| elementName | string | (Optional) The name of the Web Component that contains the dashboard (only if not a default export)                                                                                                                                                                                                       |
| weight      | number | (Optional) The weight of the dashboard, higher numbers are displayed first                                                                                                                                                                                                                                |
| meta        | object | <p>Additional metadata for the dashboard</p><table><thead><tr><th>Property</th><th>Type</th><th>Description</th></tr></thead><tbody><tr><td>Label</td><td>string</td><td>The label shown to the user</td></tr><tr><td>pathname</td><td>string</td><td>The routable URL pathname</td></tr></tbody></table> |
| Property    | Type   | Description                                                                                                                                                                                                                                                                                               |
| Label       | string | The label shown to the user                                                                                                                                                                                                                                                                               |
| pathname    | string | The routable URL pathname                                                                                                                                                                                                                                                                                 |
| Property    | Type   | Description                                                                                                                                                                                                                                                                                               |
| Label       | string | The label shown to the user                                                                                                                                                                                                                                                                               |
| pathname    | string | The routable URL pathname                                                                                                                                                                                                                                                                                 |
| Property    | Type   | Description                                                                                                                                                                                                                                                                                               |
| Label       | string | The label shown to the user                                                                                                                                                                                                                                                                               |
| pathname    | string | The routable URL pathname                                                                                                                                                                                                                                                                                 |
| conditions  | array  | (Optional) [Conditions](condition.md) for when the dashboard should be displayed                                                                                                                                                                                                                          |

### Full Example

{% code title="~/App_Plugins/WelcomeDashboard/umbraco-package.json" lineNumbers="true" %}
```json
{
  "type": "dashboard",
  "alias": "my.welcome.dashboard",
  "name": "My Welcome Dashboard",
  "element": "/App_Plugins/WelcomeDashboard/dashboard.js",
  "weight": -1,
  "meta": {
    "label": "Welcome Dashboard",
    "pathname": "welcome-dashboard"
  },
  "conditions": [
    {
      "alias": "Umb.Condition.SectionAlias",
      "match": "Umb.Section.Content"
    }
  ]
}
```
{% endcode %}

<figure><img src="../../../extending/images/welcome-dashboard.jpg" alt="The Welcome Dashboard shown in the Content section"><figcaption><p>The Welcome Dashboard appears in the Content section</p></figcaption></figure>

You can learn about [creating a custom dashboard](../../../tutorials/creating-a-custom-dashboard/) in the tutorials section. Here you will learn how to build the dashboard itself as a Web Component.

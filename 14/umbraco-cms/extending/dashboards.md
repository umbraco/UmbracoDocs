---
description: >-
  A guide to creating custom dashboards in Umbraco
---

# Dashboard

{% hint style="warning" %}
This page is a work in progress. It has been migrated but the content is waiting to be updated for the new Backoffice.
{% endhint %}

Each section of the Umbraco backoffice has its own set of default dashboards.

The dashboard area of Umbraco is used to display an 'editor' for the selected item in the tree. If no item is selected, for example when the section is first loaded in the browser, then the default set of section dashboards are displayed in the dashboard area, arranged over multiple tabs.

The dashboard area of Umbraco is used to display information for a Section. Notice that Section Views is another similar approach to append information to the root of a Section. Section views are thought mainly used as Secondary pages. These two approaches should ideally not be combined.

You can try and [create a custom dashboard](../../tutorials/creating-a-custom-dashboard/) as a way on getting started on this topic.

## Registering your Dashboard

This section dives into the Dashboard Extension Manifest, shows how to register one, and append additional details.

### Example Extension Manifest

Insert this as an entry of extensions in your `Umbraco-package.json` or register it via JavaScript.

```jsx

{
 "type": "dashboard",
 "alias": "my.welcome.dashboard",
 "name": "My Welcome Dashboard",
 "element": "/App_Plugins/WelcomeDashboard/dashboard.js",
 "elementName": "my-welcome-dashboard",
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

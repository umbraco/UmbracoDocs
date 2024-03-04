---
description: >-
  Dashboards provides a space for information, placed at the entrance of a
  Section
---

# Dashboard

{% hint style="warning" %}
This page is a work in progress. It has been migrated but the content is waiting to be updated for the new Backoffice.
{% endhint %}

The dashboard area of Umbraco is used to display information for a Section. Notice that Section Views is another similar approach to append information to the root of a Section. Section views are thought mainly used as Secondary pages. These two approaches should ideally not be combined.

You can try and [create a custom dashboard](../../tutorials/creating-a-custom-dashboard.md) as a way on getting started on this topic.

## Dashboard registration

This section dives into the Dashboard Extension Manifest, shows how to register one, and append additional details.

### Example Extension Manifest

Insert this as an entry of extensions in your `Umbraco-package.json` or register it via JavaScript.

```jsx

{
	"type": "dashboard",
	"alias": "my.welcome.dashboard",
	"name": "My Welcome Dashboard",
	"js": "/App_Plugins/WelcomeDashboard/dashboard.js",
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

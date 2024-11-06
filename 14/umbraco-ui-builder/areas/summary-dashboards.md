---
description: Configuring a summary dashboard in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Summary Dashboards

A summary dashboard is automatically displayed at the root of a defined Umbraco UI Builder section. It displays summaries of collections found within it that are told to display on the dashboard. It also provides quick links to jump to that collections list view. It can also add quickly a new entry to that collection (if the collection isn't read-only).

![Summary Dashboard](../images/dashboard.png)

## Showing a collection on a summary dashboard

Showing a collection in the summary dashboard is controlled via the collection configuration.

### **ShowOnSummaryDashboard() : CollectionConfigBuilder&lt;TEntityType&gt;**

Sets the collection to display on the summary dashboard.

````csharp
// Example
collectionConfig.ShowOnSummaryDashboard();
````

{% hint style="warning" %}
Only section root level collections can be shown on the summary dashboard.
{% endhint %}

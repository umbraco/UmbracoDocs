---
description: >-
  Configuring a summary dashboard to provide an overview of collections within a
  section.
---

# Summary Dashboards

A summary dashboard appears automatically at the root of an Umbraco UI Builder section. It provides an overview of key collections within that section, enabling quick access to list views. Additionally, it allows for adding new entries to the collection, provided the collection is not set to read-only.

By summarizing important data and simplifying navigation, the summary dashboard improves content management efficiency.

![Summary Dashboard](<../.gitbook/assets/dashboard (1).png>)

## Displaying a Collection on the Summary Dashboard

To display a collection on the summary dashboard, use the `ShowOnSummaryDashboard()` method in the collection configuration.

### Configuration Example

```csharp
collectionConfig.ShowOnSummaryDashboard();
```

**Code Reference:** `ShowOnSummaryDashboard() : CollectionConfigBuilder<TEntityType>`

{% hint style="warning" %}
Only root-level collections within a section can be displayed on the summary dashboard.
{% endhint %}

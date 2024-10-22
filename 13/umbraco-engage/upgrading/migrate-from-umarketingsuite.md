---
description: >-
  Below you will find the general steps to perform during the upgrade. You can
  also jump directly to the detailed steps and instructions here <link to guide
  of Corné below>
---

# Migrate from uMarketingSuite

{% hint style="info" %}
This document is a work in progress.

The final version will be available with the release of Umbraco Engage.
{% endhint %}

### **General upgrade steps from uMarketingSuite to Umbraco Engage**

* Backup database from production environment and restore locally
* Apply the databases changes as outlined below
  * The database changes should be executed in < 10 sec. because we are using [sp\_rename](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-rename-transact-sql)
* Apply the code changes as outlined below in the detailed steps
* Test locally&#x20;
* Apply the database changes and the new code to each environment (make sure to create backups of code and database!)

### **Default scripts**

Make sure to change the reference to the client side analytics scripts to:

```
<script src="~/Assets/Umbraco.Engage/Scripts/umbracoEngage.analytics.js"></script>
<script src="~/Assets/Umbraco.Engage/Scripts/umbracoEngage.analytics.ga-bridge.js"></script>
<script src="~/Assets/Umbraco.Engage/Scripts/umbracoEngage.analytics.blockerdetection.js"></script>
```

See the detailed steps and instructions here \<link to guide of Corné below>

### **Implemented custom javascript events?**&#x20;

Make sure to change all custom events from **ums** to **umbEngage**

`ums("send", "event", "<Category name>", "<Action>", "<Label>")`&#x20;

is now:

`umbEngage("send", "event", "<Category name>", "<Action>", "<Label>")`

### **Any custom code?**

Did you build your own segments, added custom goal triggering etc. then have a close look at which namespaces and classes have been changed here \<link to the C# Class changes section>.



### **Any custom firewall changes?**

If the /umbraco/umarketingsuite/ path was previously allowed, this needs to change to /umbraco/engage/

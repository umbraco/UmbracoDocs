---
description: >-
  Learn how to manage Proactive Auto-Heal on Umbraco Cloud, including
  how to disable it for projects on a Dedicated plan.
---

# Proactive Auto-Heal

Proactive Auto-Heal is an Azure App Service feature that automatically monitors the health of your Umbraco Cloud environments. When the platform detects that an environment is in an unhealthy state. The health of your environment is based on memory consumption or slow request processing. In such cases, it performs an overlapping restart to recover the environment. This means a new instance is started before the old one is stopped, minimizing downtime.

Proactive Auto-Heal is **enabled by default** on all Umbraco Cloud projects and helps ensure your site remains available without manual intervention.

For more technical details on how Proactive Auto-Heal works, see the Azure blog post [Introducing Proactive Auto-Heal](https://azure.github.io/AppService/2017/08/17/Introducing-Proactive-Auto-Heal.html) and the [Azure App Service environment variables reference](https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings#app-environment).

## When to Disable Proactive Auto-Heal

In most cases, Proactive Auto-Heal should remain enabled. However, there are scenarios where legitimate high-resource workloads may trigger unnecessary restarts. Consider disabling Proactive Auto-Heal when your project performs:

* **Large content imports** — Bulk importing content can temporarily increase memory usage and request processing times.
* **Examine index rebuilds** — Rebuilding search indexes is resource-intensive and can trigger the monitoring thresholds.
* **Schema migrations** — Running database schema migrations may cause slow request processing during the migration.
* **Large content caches** — Projects with large content caches may consistently use higher memory, which could be misidentified as an unhealthy state.

{% hint style="warning" %}
Disabling Proactive Auto-Heal means your environment will no longer be automatically restarted when it enters an unhealthy state. If your site experiences genuine resource exhaustion, you will need to manually restart the environment or wait for the issue to resolve itself. Only disable this feature if you understand the trade-offs.
{% endhint %}

## Requirements

{% hint style="info" %}
The option to disable Proactive Auto-Heal is only available for projects on a **Dedicated** plan. Projects on Shared plans always have Proactive Auto-Heal enabled.
{% endhint %}

## How to Enable or Disable Proactive Auto-Heal

To manage the Proactive Auto-Heal setting for your project:

1. Go to your project in the [Umbraco Cloud Portal](https://www.s1.umbraco.io).
2. Navigate to **Configuration** > **Advanced** in the left-side menu.
3. Locate the **Proactive Auto-Heal** toggle.
4. Toggle the setting to **enable** or **disable** Proactive Auto-Heal.

The change triggers a restart.

## Automatic Re-enablement on Plan Downgrade

If you downgrade your project from a **Dedicated** plan to a **Shared** plan, Proactive Auto-Heal is automatically re-enabled. This ensures that projects on shared infrastructure benefit from the automatic recovery behavior.

You do not need to take any action, the setting is applied automatically as part of the downgrade process.

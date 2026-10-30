---
description: >-
  Learn how to manage Platform Configuration on Umbraco Cloud, including
  Proactive Auto-Heal, Always On, Sticky Sessions, and File System Certificate.
tags:
  - ai-generated
---

# Platform Configuration

The Platform Configuration section in the Umbraco Cloud Portal lets you manage environment-level settings that affect how your application runs on Azure App Service. You can control the following settings:

* **Proactive Auto-Heal**: Automatically restart an environment when the platform detects unhealthy resource usage.
* **Always On**: Keep your application loaded at all times so it does not unload after 20 minutes without any incoming requests.
* **Sticky Sessions**: Keep each visitor on the same instance for the duration of their session.
* **File System Certificate**: Load client certificates from the file system of the environment.

The settings are available on the following plans:

| Setting                 | Shared plans | Dedicated plans |
| ----------------------- | ------------ | --------------- |
| Proactive Auto-Heal     | ❌            | ✅               |
| Always On               | ❌            | ✅               |
| Sticky Sessions         | ✅            | ✅               |
| File System Certificate | ✅            | ✅               |

Changes to any setting cause the environment to restart and take effect only after you confirm them.

## Proactive Auto-Heal

Proactive Auto-Heal is an Azure App Service feature that automatically monitors the health of your Umbraco Cloud environments. When the platform detects an unhealthy environment due to memory usage or slow requests, it performs an overlapping restart to recover it. This means a new instance is started before the old one is stopped, minimizing downtime.

Proactive Auto-Heal is **enabled by default** on all Umbraco Cloud projects and helps ensure your site remains available without manual intervention.

### When Proactive Auto-Heal is triggered

Proactive Auto-Heal monitors your environment and triggers a restart depending on the following factors:

* **Memory usage**: If the environment's memory consumption exceeds 90% of the available limit for more than 30 seconds, an overlapping restart is triggered. The exact memory limit depends on the worker size and process architecture.
* **Slow requests**: If 80% or more of all requests take longer than 200 seconds within a 2-minute rolling window, a restart is triggered. This rule requires a minimum of 5 requests in the window before it activates. The rule is not applied during the initial warm-up period after a process start.

### When to Disable Proactive Auto-Heal

In most cases, Proactive Auto-Heal should remain enabled. However, there are scenarios where legitimate high-resource workloads may trigger unnecessary restarts. Consider disabling Proactive Auto-Heal when your project performs:

* **Large content imports**: Bulk importing content can temporarily increase memory usage and request processing times.
* **Examine index rebuilds**: Rebuilding search indexes is resource-intensive and can trigger the monitoring thresholds.
* **Schema migrations**: Running database schema migrations may cause slow request processing during the migration.
* **Large content caches**: Projects with large content caches may consistently use higher memory, which could be misidentified as an unhealthy state.

{% hint style="warning" %}
Disabling Proactive Auto-Heal means your environment will no longer be automatically restarted when it enters an unhealthy state. If your site experiences genuine resource exhaustion, you need to manually restart the environment or wait for the issue to resolve itself. Only disable this feature if you understand the trade-offs.
{% endhint %}

{% hint style="info" %}
The option to disable Proactive Auto-Heal is only available for projects on a **Dedicated** plan. Projects on Shared plans always have Proactive Auto-Heal enabled.
{% endhint %}

### Automatic Re-enablement on Plan Downgrade

If you downgrade your project from a **Dedicated** plan to a **Shared** plan, Proactive Auto-Heal is automatically re-enabled. This ensures that projects on shared infrastructure benefit from the automatic recovery behavior.

You do not need to take any action. The setting is applied automatically during the downgrade process.

## Always On

Always On keeps your application loaded, so it does not unload after 20 minutes without any incoming requests. Without Always On, an idle application is unloaded to free resources. The next incoming request then has to wait for the application to start again.

Keeping the application loaded removes this warm-up delay and helps ensure consistent response times.

{% hint style="warning" %}
Changing the Always On toggle is only available for environments on a **Dedicated** plan. Environments on Shared plans use the default value for Always On. This restriction exists for sustainability reasons. Keeping idle applications loaded consumes resources that could otherwise be released on shared infrastructure.
{% endhint %}

### Default Value on Plan Downgrade

If you downgrade an environment from a **Dedicated** plan to a **Shared** plan, the Always On setting reverts to its default value:

* **Production environments**: Always On is enabled (`true`) by default.
* **Development/Pre-Production environments**: Always On is disabled (`false`) by default.

You do not need to take any action. The default is applied automatically as part of the downgrade process.

## Sticky Sessions

Sticky Sessions route each visitor to the same instance for the duration of their session. Use Sticky Sessions when your application keeps session state in the memory of a single instance.

Sticky Sessions are available on all plans.

### Sticky Sessions and Load Balancing

[Load Balancing](../../../optimize-and-maintain-your-site/optimize-performance/load-balancing.md) requires Sticky Sessions. While Load Balancing is enabled on an environment, Sticky Sessions are enabled and the toggle cannot be changed.

To disable Sticky Sessions, disable Load Balancing on the environment first.

## File System Certificate

File System Certificate lets your application load client certificates, such as X.509 certificates, as files at runtime. Enable File System Certificate when your project loads a certificate file to authenticate with an external service. Examples include payment providers, identity providers, and partner APIs.

File System Certificate is available on all plans. The setting is kept when the platform rebuilds the configuration of the environment, for example during a plan change.

For more information on loading a certificate from a file, see the [Load certificate from file](https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-certificate-in-code#load-certificate-from-file) article in the Microsoft documentation.

{% hint style="warning" %}
Only enable File System Certificate on environments that need it. Store certificate passwords using [Secrets Management](../../../begin-your-cloud-journey/project-features/secrets-management.md) instead of in your source code.
{% endhint %}

## How to Update Platform Configuration

To update the Platform Configuration for your project:

1. Go to your project in the [Umbraco Cloud Portal](https://www.s1.umbraco.io).
2. Navigate to **Configuration** > **Advanced** in the left-side menu.
3. Locate the **Platform Configuration** section.
4. Select the environment you want to update.

<figure><img src="../../../.gitbook/assets/platform-configuration-toggles.png" alt="Platform Configuration toggles in Advanced Configuration"><figcaption><p>Platform Configuration toggles</p></figcaption></figure>

5. Toggle the settings to the desired state.
6. Select **Save** to apply the changes.
   * Select **Cancel** to discard the changes.
7. On the confirmation dialog, review the new values and select **Save** to confirm. The environment restarts to apply the new settings.
   * Select **Cancel** to keep the environment running and discard the pending changes.

<figure><img src="../../../.gitbook/assets/platform-configuration-dialog.png" alt="Platform Configuration confirmation dialog"><figcaption><p>Platform Configuration confirmation dialog</p></figcaption></figure>

{% hint style="warning" %}
Saving changes to Platform Configuration restarts the environment. Selecting **Cancel** on the dialog or the **Cancel** button below the toggles reverts any pending changes.
{% endhint %}

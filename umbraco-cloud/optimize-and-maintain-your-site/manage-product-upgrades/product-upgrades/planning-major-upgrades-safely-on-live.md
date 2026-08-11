---
description: >-
  Choose the right upgrade path and resource strategy to safely manage database migrations and prevent downtime on your production environment.
---

# Planning Major Upgrades Safely for Live Environments

Major upgrades differ from normal deployments. The first startup on the new version must often run database migrations, update content, rebuild caches, and refresh indexes.

While many projects upgrade successfully on existing plans, larger or business-critical Live environments face risks. The migration process will compete with live traffic and editor activity for server resources.

To avoid surprises, it is recommended to plan the upgrade window carefully. Choose the upgrade path that matches the size and importance of the project.

{% hint style="warning" %}
This guide focuses on running the upgrade safely on the Live environment. It does not replace the standard upgrade steps. 

You should review this guide **after** you have already followed the standard [Major Upgrades](major-upgrades.md) guide.

Once your upgraded codebase is tested and ready on your machine, use this article to plan your production deployment strategy.
{% endhint %}

## Why Live Behaves Differently from Staging

A major upgrade can be resource-intensive. When the upgraded code first boots, it runs database migrations and rebuilds caches and indexes. That work happens on top of whatever the site is already doing.

- **Development/Staging Environments:** There is typically little or no public traffic, meaning almost all of the server's capacity is dedicated to the upgrade. For most standard projects, the migration completes comfortably. However, because Staging environments often run on lower plan tiers with fewer dedicated resources, a large database or complex migration can still overload a Staging environment and cause it to fail, even without public traffic.
- **Live Environments:** Real visitors are using the site when the upgrade starts. The environment is already handling normal production traffic, and the upgrade workload is added on top of that.

For many projects, this can still be completed successfully. But on larger, busier, or resource-constrained sites, the combined workload can push the environment beyond what it can comfortably process during the upgrade. Requests may start to queue, the migration may not complete cleanly, and the site can become unavailable.

This is why an upgrade can pass on Staging and still behave differently on Live, even with identical content. The production conditions and the underlying resource capacities are not.

![Server capacity on Staging versus Live during an upgrade](../../../.gitbook/assets/2-why-live-fails.png)

## Build a Staging Safety Net First

Before upgrading Live, create an exact, already-upgraded copy on Staging. Ensure this copy includes both the database and your Azure Blob Storage media. This gives you a working reference environment on the new version before you touch Live.

For many projects, Staging is mainly a validation and recovery safety net. This lets you confirm the upgraded site runs safely with Live content. It also gives you a known-good reference point if the Live upgrade encounters delays.

Follow the instructions in the [Building the Copy](#building-the-copy) section below.

![Visitor traffic routing to Live during the upgrade, with Staging as a fallback if downtime exceeds plan.](../../../.gitbook/assets/4-safety-net-during-upgrade.png)

### Critical Considerations for Staging Fallbacks

Do not assume that Staging can automatically replace Live during the upgrade window. Many sites depend on processes that may write to the database or behave differently outside of Live. Review your environment for:

- External services and integrations.
- Scheduled jobs, forms, and member activity.
- Ecommerce flows and search services.

If you want to use Staging as a temporary visitor-facing fallback, review the full production behaviour first. Make sure you understand:

- Which integrations are active.
- Which data may be written during the fallback period.
- Whether any of that data could be lost when traffic moves back to Live.

{% hint style="info" %}
For business-critical sites, the safer approach is often a planned maintenance window. During this window, you take Live offline and display a maintenance page to visitors. You can then safely complete and verify the major upgrade.
{% endhint %}

### Building the Copy

1. Create a fresh Staging environment on your project. See [Manage Environments](../../../build-and-customize-your-solution/handle-deployments-and-environments/manage-environments.md).
2. Restore the Live database and media into it so it matches Live exactly. Each environment has its own SQL database and its own Blob Storage container, so you need both. See [Restoring Content](../../../build-and-customize-your-solution/handle-deployments-and-environments/deployment/restoring-content.md) and [Media on Cloud](../../../build-and-customize-your-solution/handle-deployments-and-environments/media/README.md).
3. Push the upgraded code to Staging and let the upgrade run there. If the migration does not complete, finish it from your local machine using the [Local Upgrade Option](#approach-2-run-a-controlled-local-migration-local-upgrade-option) below.
4. If Staging was used as a temporary fallback, move traffic back once Live is healthy on the new version. Staging can then return to its normal role.

## Completing the Migration: Choosing Your Path

With your safety net in place, determine whether the Live upgrade can run on your existing Cloud plan, or if the migration needs extra control. To avoid surprises, plan your upgrade window carefully and choose the path that matches the size and business importance of your project. Review these three supported approaches to decide which path to take before proceeding to the deployment steps:

![Comparing the Local Upgrade Option and Cloud Dedicated Upgrade Option for completing a migration.](../../../.gitbook/assets/3-two-ways-to-complete-migration.png)

- [Approach 1: Run the upgrade on the existing Cloud plan](#approach-1-run-the-upgrade-on-the-existing-cloud-plan)
  - Best for: Projects where the upgrade has been thoroughly tested, the migration dataset is expected to be manageable, and a standard planned upgrade window is acceptable.

- [Approach 2: Run a controlled local migration (Local Upgrade Option)](#approach-2-run-a-controlled-local-migration-local-upgrade-option)
  - Best for: Large databases or scenarios where you want to execute the database migration entirely separate from the Live application startup, or when a Cloud-side migration does not complete as expected. It isolates the compute load to your local machine.

- [Approach 3: Use dedicated resources for the upgrade window (Cloud Upgrade Option)](#approach-3-use-dedicated-resources-for-the-upgrade-window-cloud-upgrade-option)
  - Best for: Highly business-critical or high-traffic projects with extensive content datasets where scaling up to temporary dedicated upgrade capacity ensures the migration completes quickly and safely within the Cloud region.

### Approach 1: Run the upgrade on the existing Cloud plan

Many projects can complete the major upgrade successfully on their existing plan. Proceed with the standard approach outlined in the [Execution Summary](#execution-summary-from-pre-upgrade-to-go-live) at the end of this guide.

### Approach 2: Run a controlled local migration (Local Upgrade Option)

This path grants direct control over the database migration. Your upgraded local project runs on your own machine while connected directly to the Live database.

![Finishing the migration from your local machine.](../../../.gitbook/assets/1-finishing-migration-from-local-machine.png)

**Emergency Recovery:** If a Live upgrade has already failed and the site goes down, this is also your recovery path. Follow the execution steps below, ensuring you take the environment offline and restore from your clean backup before starting the local migration.

#### Step-by-Step Local Upgrade Execution

1. **Take the Live environment offline:** This prevents outside processes from writing to the database or booting mid-migration. For more information, see the [Start and stop environments](../../../release-notes/overview-2026/2026-03-releasenotes.md#start-and-stop-environments) section. It is important to start it again once you are ready to push code to the Live environment, else the git remote will be offline.
2. **Back up and verify the Live database:** If Cloud's migration attempt failed partway, restore from a clean backup first to ensure a known-good starting state. For more information, see the [Restore Database](../../../build-and-customize-your-solution/set-up-your-project/databases/backups.md#restore-database) article.
3. **Allowlist your IP address:** Open the **SQL connection details** for the **Live** environment in the Cloud Portal and **allowlist your IP address**. For more information, see the [Project Settings](../../../build-and-customize-your-solution/set-up-your-project/project-settings/README.md) and [Working with a Cloud database locally](../../../build-and-customize-your-solution/set-up-your-project/databases/cloud-database/local-database.md) articles.
4. **Configure your connection string:** Check on your machine the exact codebase and version that is currently deployed to Live, and point its connection string at the Live database. Ensure you set an appropriate [`Connection Timeout`](https://learn.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlconnection.connectiontimeout?) value in the [`ConnectionString`](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnection.connectionstring?) inside your `appsettings.json` file.
5. **Run the migration:** Start your local project. The core upgrade installer will boot and run all schema migrations directly against the Live database until complete.
6. **Bring Live back online:** Restart your Live environment. It will boot up cleanly on the new version, automatically rebuild its local indexes and caches, and verify overall site health.

{% hint style="info" %}
Examine indexes and the local content cache are not stored in the database. The Cloud server will rebuild them automatically when it restarts, regardless of where the database migration was run.
{% endhint %}

{% hint style="warning" %}
**Critical Migration Rules:**

- **Run one process at a time:** Keep Live offline while you work. Ensure Cloud is not mid-upgrade.
- **Match your codebase:** Always use the exact codebase version deployed to Live. Never point an older or different codebase at the database.
- **Guard against connection drops:** Large migrations over the internet can take a long time. A dropped connection can leave the database half-migrated.
- **Hold your backup:** Keep your database backup until Live is confirmed healthy on the new version.
{% endhint %}

### Approach 3: Use dedicated resources for the upgrade window (Cloud Upgrade Option)

If a local upgrade is too slow due to extensive content, let Cloud handle the migration by temporarily upgrading your hosting capacity.

#### Execution Steps

1. **Scale Up Capacity:** Before pushing the upgrade, navigate to the **Management** menu in the Cloud Portal and move your project onto dedicated resources. Note: Moving to dedicated resources changes your plan and billing, so review pricing before switching. For more information, see the [Project Settings](../../../build-and-customize-your-solution/set-up-your-project/project-settings/README.md) article.
2. **Deploy the Code:** Push the major upgrade to Live. The migration will run natively inside the Cloud region infrastructure, eliminating internet round-trip latency. (If anything fails to complete, the [Local Upgrade Option](#approach-2-run-a-controlled-local-migration-local-upgrade-option) remains available as an immediate fallback).
3. **Scale Down Capacity:** Once Live is fully verified on the new major version, navigate back to the **Management** menu and scale the plan back down to its original tier to resume normal billing.

## Execution Summary: From Pre-Upgrade to Go-Live

Ensure you have followed these phases to execute your deployment cleanly:

### Phase 1: Pre-Upgrade Optimization (Before Code Push)

Before pushing any upgrade code to Live, optimize your database to reduce migration work and ensure the upgrade completes faster:

- Delete old content versions.
- Clear recycle bins.
- Remove unused media.
- Check for and remove other unnecessary project-specific data.

Reducing the volume of data helps the upgrade complete faster and more predictably. Only remove data that you are sure is no longer needed, and make sure you have a backup before doing any cleanup.

### Phase 2: Deployment & Verification (During the Window)

With your optimal migration path chosen and your Staging safety net ready, execute the deployment:

1. Push the major upgrade to Live following the [Major Upgrades](major-upgrades.md) guide.
2. **If it completes successfully:** Verify the site on the new major version to finish the upgrade.
3. **If it stalls or fails:** Immediately transition to the [Local Upgrade Option](#approach-2-run-a-controlled-local-migration-local-upgrade-option) to complete the schema migration from your machine.
4. **If downtime exceeds limits:** Route traffic to your prepared fallback option (a maintenance page or your pre-upgraded Staging copy).

{% hint style="info" %}
Plan a content freeze during the migration window so editor changes are not lost while the upgrade runs. If you used dedicated resources, review the project’s ongoing resource needs once Live is verified; if the additional capacity was only needed for the upgrade, scale the project back to its previous plan.
{% endhint %}

### Phase 3: Post-Upgrade Wrap-Up (After Go-Live)

Once Live is verified as healthy on the new version:

1. **Scale Down Resources:** If you temporarily moved to dedicated resources for the upgrade window, scale the project back to its previous plan to manage ongoing billing.
2. **Lift the Freeze:** Safely open the environment back up to your content editors.

## Self-Service Checklist

Run through this quick check to ensure everything is in place before you upgrade Live:

| What to have ready | Why it matters |
| :--- | :--- |
| **Data Cleanup:** Unneeded content versions, recycle bin items, and unused project data removed. | Helps reduce migration time and makes the major upgrade more predictable. |
| **Local Testing:** Project upgraded and tested locally with a copy of the live database on the new major version. | Confirms the upgrade itself is sound before you touch Live. |
| **Package Compatibility:** Packages and custom code confirmed compatible with the new version. | Incompatibilities are the other common cause of failed upgrades. |
| **Backups:** A database backup for every environment you will touch. | Lets you roll back cleanly if a migration goes wrong. |
| **Staging Safety Net:** An upgraded Staging copy of Live (both database and media). | Provides a validation and recovery reference before changing Live. |
| **Migration Path Chosen:** Existing Cloud plan, controlled local migration, or dedicated resources. | Decides how the migration gets enough capacity to finish. |
| **SQL Access:** SQL connection details noted and your IP allowlisted. | Needed to complete the migration from your machine (Local Upgrade Option). |
| **Content Freeze:** A content freeze planned for large sites. | Prevents editor changes being lost during a long migration. |

## Reference Documentation

- [Major Upgrades](major-upgrades.md)
- [Manage Environments](../../../build-and-customize-your-solution/handle-deployments-and-environments/manage-environments.md)
- [Restoring Content](../../../build-and-customize-your-solution/handle-deployments-and-environments/deployment/restoring-content.md)
- [Media on Cloud](../../../build-and-customize-your-solution/handle-deployments-and-environments/media/README.md)
- [Working with a Cloud database locally](../../../build-and-customize-your-solution/set-up-your-project/databases/cloud-database/local-database.md)
- [Project Settings](../../../build-and-customize-your-solution/set-up-your-project/project-settings/README.md)

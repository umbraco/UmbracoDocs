# October 2026

## Key Takeaways

* **Upgrade windows for automatic upgrades** - Choose the 4-hour upgrade windows in which automatic minor and patch upgrades can start. The default schedule is Tuesday from 08:00 to 20:00 UTC.
* **Automatic NuGet cache cleanup** - Superseded NuGet packages are removed from your environments after each deployment, so long-lived projects no longer fill their disk with old package versions.
* **Leftover `global.json` no longer breaks deployments** - The temporary `global.json` file written during a Git deployment is now removed when a build fails or the deployment is interrupted.

## Upgrade windows for automatic upgrades

Automatic minor and patch upgrades now follow a weekly schedule of upgrade windows. An upgrade window is a 4-hour period in which an automatic upgrade can start. You select the windows that suit your project under **Configuration** -> **Automatic Upgrades** in the Cloud Portal.

<figure><img src="../../.gitbook/assets/automatic-upgrade-windows.png" alt="Picker for upgrade windows showing a weekly grid of 4-hour windows in local time, with selected windows checked and windows shaded from quiet to very busy"><figcaption><p>Selecting upgrade windows for automatic upgrades</p></figcaption></figure>

* **Six windows a day.** Windows start at 00:00, 04:00, 08:00, 12:00, 16:00, and 20:00 UTC. You can select as many windows as you need.
* **Tuesday by default.** The default schedule is Tuesday from 08:00 to 20:00 UTC. If no windows are selected, automatic upgrades do not run for the project.
* **Defined in UTC.** Windows do not move with daylight saving time. The picker can also show the windows in your local time.
* **The window limits when an upgrade starts.** Environments are upgraded one at a time. An upgrade that starts late in a window can upgrade Staging and Live after the window has closed.
* **Postponed upgrades are retried.** If the platform is at capacity, the upgrade is shown as **Cancelled** on the Project History page. It is attempted again in your next window within 7 days of the release.

Selecting several windows does not lead to several upgrades. Each release is applied once, and extra windows give the upgrade more opportunities to start.

The **Upgrade available** banner is not affected by upgrade windows. Umbraco Cloud can still roll out critical security fixes outside of your upgrade windows.

See the [Upgrade Windows](../../optimize-and-maintain-your-site/manage-product-upgrades/product-upgrades/minor-upgrades.md#upgrade-windows) section for details.

## Automatic NuGet cache cleanup

Every deployment and upgrade restores NuGet packages into the NuGet cache on your environment. Older package versions were never removed from the cache. On long-lived projects, the cache could grow to several gigabytes and use up the disk space of the environment.

Umbraco Cloud now cleans up the NuGet cache 15 minutes after each completed deployment. The cleanup works as follows:

* **Package versions your site uses are kept.** These are read from the `*.deps.json` files of the deployed site.
* **The newest version of build-only packages is kept.** These are packages used during the build, such as analyzers and SDK packs.
* **All other versions are removed.**

## Leftover `global.json` no longer breaks deployments

During a Git deployment, Umbraco Cloud writes a temporary `global.json` file to the repository in the environment. The file selects a .NET SDK that can build your project and is removed again after a successful build.

When a build failed, or the deployment was interrupted, the file was left behind. The leftover `global.json` could then cause the next deployment to fail.

The temporary `global.json` file is now removed in both cases:

* **Failed builds** - The repository on the environment is cleaned up when the build fails, the same way as after a successful build.
* **Interrupted deployments** - Umbraco Cloud checks the repository once the deployment has finished and removes a leftover `global.json` file.

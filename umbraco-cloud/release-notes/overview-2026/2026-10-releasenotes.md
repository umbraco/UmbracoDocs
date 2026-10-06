# October 2026

## Key Takeaways

* **Upgrade windows for automatic upgrades** - Choose the 4-hour upgrade windows in which automatic minor and patch upgrades can start. The default schedule is Tuesday from 08:00 to 20:00 UTC.

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

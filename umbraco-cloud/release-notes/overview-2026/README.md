---
description: Get an overview of the release notes for each month in 2026.
---

# Overview 2026

## [April 2026](2026-04-releasenotes.md)

* **Always On toggle for Dedicated plans** - A new Always On toggle is available in the Platform Configuration section. It keeps your application loaded at all times so it does not unload after periods of inactivity.
* **Platform Configuration section renamed** - The Auto-Heal Settings section in the Advanced Configuration has been renamed to Platform Configuration and now groups the Proactive Auto-Heal and Always On toggles.
* **Release Umbraco.Cloud.Identity v13.2.7 and Umbraco.Cloud.Cms v13.0.2, v16.0.4, v17.1.1, v17.1.2** - Two bug fixes: B2C backoffice actions no longer throw MsalUiRequiredException, and TrackBootStateNotificationHandler now properly awaits its async HTTP call.

## [March 2026](2026-03-releasenotes.md)

* **Show Windows event logs on the log page** - On the environments log page we already showed the Umbraco logs, Deployment logs, Site extension logs and IIS logs. Now this page has been expanded with a new log type - Event logs.
* **Umbraco Cloud branded error pages for platform errors** - After deploying or restarting environments, the default IIS 503 message is no longer served. Instead, you'll see an error page that automatically refreshes once the site is back up.
* **CI/CD Deploy to any target** - Enables CI/CD Flow deployments to all environments in your project, giving you full control over which environment receives each deployment.
* **Release Umbraco.Cloud.Identity.Cms 13.2.6, Umbraco.Cloud.Cms 16.0.3 & 17.0.3** - Retains current user group if user already exists, and allows for mapping a single role to multiple Umbraco user groups.
* **Start and stop environments** - You can now start and stop your Cloud environments directly from the project overview, giving you more control over your hosting resources.
* **Release Umbraco.Cloud.Cms 17.1.0** - Preparation for the upcoming Load Balancing feature.
* **Proactive Auto-Heal toggle for Dedicated plans** - Projects on a Dedicated plan can now disable Proactive Auto-Heal. This prevents automatic restarts during high-resource workloads such as content imports, index rebuilds, and schema migrations.
* **Downgrade plan Support** - The "Change plan" feature now supports both upgrades and downgrades for all admin users with self-service plan changes, including environment limit validation and downgrade warnings.

## [February 2026](2026-02-releasenotes.md)

* **Release Umbraco.Cloud.Cms 13.0.1, 16.0.2 & 17.0.2** - Adds middleware that ensures the internal Azure URL remains hidden on initial requests.
* **Opt out of automatic patch upgrades** - Allows project admins to opt out of automatic patch upgrades so you can now fully control when your project upgrades.
* **Disable parallel builds** - Disable parallel builds for Umbraco 9+ sites to prevent resource contention.
* **Project invite notifications** - Adds UI notifications when receiving project invitations, improving visibility and making it easier to respond directly from the Portal.

## [January 2026](2026-01-releasenotes.md)

* **CI/CD Flow page** - CI/CD Flow has been moved from the `Configuration -> Advanced` page to a standalone page `Configuration -> CI/CD Flow`.
* **Enhanced debug information for CI/CD deployments** - Added a new "See More" link on the `Insights -> Project History` page for CI/CD Flow deployment events. That leads to a new page with information such as logs and artifact info about the deployment.
* **List of deployment artifacts** - Added a list of deployment artifacts on the `Configuration -> CI/CD Flow` page with a download link to help with debugging.

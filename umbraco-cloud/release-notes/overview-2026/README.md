---
description: Get an overview of the release notes for each month in 2026.
---

# Overview 2026

## [June 2026](2026-06-releasenotes.md)

* **Baseline enhancements** - The **Manage child projects** page loads faster. More data is shown on child, and list has more filtering options.
* **Release Umbraco.Cloud.Cms v17.2.0** - Enhancements for Load Balancing. Adds Danish localization for the Umbraco ID backoffice UI. Fix for a timing issue related to Umbraco ID sign-in screen.

## [May 2026](2026-05-releasenotes.md)

* **Error pages** - Upload your own HTML error pages and assign them per hostname, so visitors see your own page instead of the default Umbraco Cloud error page when your site is temporarily unavailable.
* **Baseline enhancements** - An activity starts when the baseline pushes updates to child projects.
* **Baseline enhancements** - Baseline update UI state is restored when an update is running.
* **Baseline enhancements** - An activity starts on the baseline project during the creation of a child project.
* **Basic Authentication for all plans** - Basic Authentication is now available on all Umbraco Cloud plans.
* **Anonymized backoffice users on team removal** - Removing a team member from a project now anonymizes their backoffice user across every environment. Audit history is preserved while personal data is cleared.
* **Edge traffic analytics on Traffic & Performance** - The Traffic & Performance page now combines Azure application metrics with Cloudflare edge analytics. New edge metric tiles, chart series, and breakdown tables let you analyze HTTP traffic by status code, cache status, geography, devices, and more.
* **Release Umbraco.Cloud.Cms v17.1.3** - Adds support for the new Basic Authentication login form introduced in Umbraco 17.4.0.

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

# November 2026

## Key Takeaways

* **Recommendations** - See how each project and environment measures up against Umbraco Cloud best practices, and what to address it.
* **Alerting and Notifications** - Set up alert rules that send an email or webhook notification about DDoS attacks, automatic restarts, deployments, and upgrades.
* **More details in the organization Projects list** - See the hosting type, the live Umbraco version, and the ownership of each project in your organization.
* **Reroll the Deploy API key** - Generate a new Deploy API key for a project from the Cloud Portal if the key has been shared or leaked.
* **Release Umbraco.Cloud.Cms 17.2.4 & 18.0.4** - Updates dependencies.

## Recommendations

Recommendations are automated checks of your project setup against Umbraco Cloud best practices. They work like Umbraco CMS Health Checks, applied to your hosting setup. Each check shows what to change and how, so you can close gaps in security, performance, and operations before they cause problems. Find the page under **Insights** -> **Recommendations** on your project in the Cloud Portal.

The checks are grouped into four categories:

* **Security** - For example, WAF rules, legacy TLS cipher suites, Production runtime mode, and SQL firewall rules.
* **Performance** - CDN caching and cache TTL on custom hostnames.
* **Best practices** - The `Umbraco.Cloud.Cms` package and Models Builder mode on the live environment.
* **Operations** - Uptime monitoring and alert rules for the project.

Each result is marked **Critical**, **To fix**, **To review**, or **Passing**. The rating depends on the environment and its setup, so the same check can be rated differently across environments.

<figure><img src="../../.gitbook/assets/cloud-recommendations-project.png" alt=""><figcaption><p></p></figcaption></figure>

The recommendation score counts the checks that pass. The project page shows the results for each environment and how the score develops over time. Organization admins can see the results for all projects under **Overview** -> **Recommendations** on the organization.

<figure><img src="../../.gitbook/assets/cloud-recommendations-organization.png" alt=""><figcaption><p></p></figcaption></figure>

If a check does not apply to your project, you can disable it for the project or for the whole organization. After a change that affects a check, such as a deployment or a configuration change, the results update within about 15 minutes.

For now, access to Recommendations is limited to project admins and organization admins. For more details, see the [Recommendations](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/recommendations.md) documentation.


## Alerting and Notifications

Alerting and Notifications lets you choose which events on your Umbraco Cloud projects you want to hear about. You set up alert rules that send a notification by email or to a webhook when an event happens. Find the page under **Insights** -> **Alerting & Notifications** on your project or organization in the Cloud Portal.

The following alerts are available:

* **DDoS** - A DDoS attack against one of your hostnames is detected and mitigated.
* **Autoheal** - Umbraco Cloud restarts an environment automatically to recover it.
* **Deployment** - A deployment starts, completes, or fails.
* **Autoupgrade** - An upgrade starts, completes, fails, or times out.

You can create a rule for a single project or for your whole organization. Organization rules can cover every project, including projects you create later. A cooldown on each rule keeps you from being flooded during an ongoing incident. The alert history shows every alert and whether each destination received the notification.

For more details, see the [Alerting and Notifications](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/alerting-and-notifications/README.md) documentation.

## More details in the organization Projects list

The **Projects** section of your organization in the Cloud Portal now shows more information about each project. You can compare your projects without opening each one.

<figure><img src="../../.gitbook/assets/organization-projects-list.png" alt="The organization Projects list with the Umbraco, Hosting, and Ownership columns shown for each project"><figcaption><p>The organization Projects list with the new Umbraco, Hosting, and Ownership columns.</p></figcaption></figure>

The list has three new columns:

* **Umbraco** - The Umbraco version running on the live environment. Umbraco Heartcore projects show a dash, and **Unknown** is shown when the version cannot be read.
* **Hosting** - **Shared**, or **Dedicated** followed by the size of the dedicated option, for example **Dedicated · Small**.
* **Ownership** - The `PAY` and `TECH` labels show whether your organization is the payment owner and the technical owner. A crossed-out label means another organization holds the role.

You can sort the list by each of the new columns.

The project name now links to the project page for the projects where you are a team member.

For more details, see the [Organizations](../../begin-your-cloud-journey/the-cloud-portal/organizations/README.md#projects) documentation.

## Reroll the Deploy API key

You can now reroll the Deploy API key of a project from the Cloud Portal. Umbraco Deploy uses the key when content and schema are transferred between environments. Reroll the key if you suspect the key has been shared or leaked. Find the page under **Security** -> **Deploy** on your project in the Cloud Portal.

A reroll generates one new key and applies the new key to every environment in the project:

* **All environments are restarted.** Each website is unavailable for a short while during the restart.
* **The repository is updated.** The key in the `umbraco-cloud.json` file is updated in the repository of every environment. Pull the latest changes into any local clone before the next transfer.
* **The old key stops working.** Transfers and deployments that use the old key are rejected.
* **Baseline projects share one key.** Rerolling the key on a baseline project also applies the new key to every child project. The key cannot be rerolled from a child project.

Only project admins can reroll the key. The page shows the status of each environment while the reroll runs.

## Release Umbraco.Cloud.Cms 17.2.4 & 18.0.4

These releases update the `Microsoft.AspNetCore.SignalR.StackExchangeRedis` dependency to version 10.0.15. The new version fixes a high-severity denial-of-service vulnerability in the ASP.NET Core SignalR Redis backplane. For details, see [CVE-2026-114147](https://github.com/advisories/GHSA-wr8v-9x5q-ggcm).

`Umbraco.Cloud.Cms` only uses the SignalR Redis backplane on projects with Load Balancing enabled. Projects without Load Balancing do not run the affected code.

The releases also raise the minimum version of the related `Microsoft.Extensions` packages to 10.0.15. Existing projects receive the new versions through automatic upgrades.

# November 2026

## Key Takeaways

* **Alerting and Notifications** - Set up alert rules that send an email or webhook notification about DDoS attacks, automatic restarts, deployments, and upgrades.
* **More details in the organization Projects list** - See the hosting type, the live Umbraco version, and the ownership of each project in your organization.
* **Reroll the Deploy API key** - Generate a new Deploy API key for a project from the Cloud Portal if the key has been shared or leaked.

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

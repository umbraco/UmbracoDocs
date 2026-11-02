# November 2026

## Key Takeaways

* **Alerting and Notifications** - Set up alert rules that send an email or webhook notification about DDoS attacks, automatic restarts, deployments, and upgrades.

## Alerting and Notifications

Alerting and Notifications lets you choose which events on your Umbraco Cloud projects you want to hear about. You set up alert rules that send a notification by email or to a webhook when an event happens. Find the page under **Insights** -> **Alerting & Notifications** on your project or organization in the Cloud Portal.

The following alerts are available:

* **DDoS** - A DDoS attack against one of your hostnames is detected and mitigated.
* **Autoheal** - Umbraco Cloud restarts an environment automatically to recover it.
* **Deployment** - A deployment starts, completes, or fails.
* **Autoupgrade** - An upgrade starts, completes, fails, or times out.

You can create a rule for a single project or for your whole organization. Organization rules can cover every project, including projects you create later. A cooldown on each rule keeps you from being flooded during an ongoing incident. The alert history shows every alert and whether each destination received the notification.

For more details, see the [Alerting and Notifications](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/alerting-and-notifications/README.md) documentation.

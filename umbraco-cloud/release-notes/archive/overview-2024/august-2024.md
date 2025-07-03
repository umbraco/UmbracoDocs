# August 2024

## [Import Database](../../../build-and-customize-your-solution/ready-to-set-up-your-project/databases/backups.md#upload-database)

A new level of flexibility has arrived in Umbraco Cloud—Database Import. You can now easily import your database into any environment within your project, whether from an existing site or a local development setup.

<figure><img src="../../../.gitbook/assets/image (88).png" alt="Upload database to Umbraco Cloud."><figcaption><p>Upload database to Umbraco Cloud.</p></figcaption></figure>

With this feature, migrating your project’s data has never been easier. Instead of relying on complex and time-consuming methods to move databases between systems, you can upload your database directly to your Umbraco Cloud environment. This streamlines the process, helping you avoid the manual steps that can slow down migrations.

The Database Import feature also gives you a more tailored setup for your project. Whether you are working with a specific database configuration or migrating to an existing site, you can bring in the exact database you need. This control allows you to maintain consistency across environments and ensures that your data is perfectly aligned with your project’s unique requirements.

## [Restore a database to an environment](../../../build-and-customize-your-solution/ready-to-set-up-your-project/databases/backups.md#restore-database)

Umbraco Cloud has made managing your project’s data even easier with the new Database Restore feature. Now, you can restore a database backup directly to any environment in your project, giving you greater flexibility and control over your data.

Whether you need to roll back to a previous version or recover from an issue, restoring your database is now a seamless process. This eliminates the need for complicated recovery steps and gives you peace of mind, knowing you can quickly revert to a stable state when necessary.

<figure><img src="../../../.gitbook/assets/image (89).png" alt="Restore Backup to environment."><figcaption><p>Restore Backup to environment.</p></figcaption></figure>

The Database Restore feature also allows you to tailor each environment with the exact data you need. Whether you are prepping for a staging deployment or testing in a development environment, you can restore the relevant database to match the specific requirements. This ensures that your team is always working with the right data at the right time.

## [Update to availability & Performance](../../../monitor-and-troubleshoot/availability-performance.md#platform-and-cms-events)

The Performance and Availability page in Umbraco Cloud now provides even more transparency with the addition of Boot Status insights. You can now easily see whether an environment experienced a **hot** or **cold** boot, giving you a clearer picture of your site’s performance.

<figure><img src="../../../.gitbook/assets/image (90).png" alt="Hot and cold boot."><figcaption><p>Hot and cold boot.</p></figcaption></figure>

A **cold** **boot** occurs when the application is starting from scratch, which generally takes a bit longer as all dependencies need to be reloaded. On the other hand, a **hot** **boot** happens when the application is restarted but retains cached data, making the process significantly faster.

This new insight helps you better understand what might be impacting your site's startup times and gives you the ability to optimize accordingly. Whether troubleshooting or wanting to monitor your site's performance more closely, knowing the difference between **hot** and **cold** boots is key to keeping everything running smoothly.

\

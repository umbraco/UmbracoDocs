# The Umbraco Backoffice

An error in the Backoffice often looks like this:

<figure><img src="../troubleshooting/images/backoffice-error.png" alt=""><figcaption></figcaption></figure>

Errors in the backoffice can be presented in many different ways, the most common ones are

* Errors when doing a content transfer / restore
* A blank page when visiting the backoffice
* Missing sections / trees

## If the error is during a content transfer / restore

Start by clicking "View more details", often it will give you a link to a specific article with a guide on how to fix it. We have some guides on how to fix the most common errors below:

* [Schema mismatch](deployments/schema-mismatches.md)
* [Dependency Exception](deployments/dependency-exceptions.md)
* [SQL Timeouts](https://docs.umbraco.com/umbraco-deploy/deploy-settings#timeout-settings)
* [Media path too long](deployments/path-too-long-exception.md)

If your issue is not covered above, here are some general guidelines on what you should do when you have content transfer / restore errors:

The first thing to ensure is that any schema changes have been pushed through Git or deployed between environments so the environments are in sync.

Another thing to check would be the log files, relevant information can often be found in the [umbracoTraceLogs](log-files.md#umbraco-logs) for both the source and target environments, so make sure to check both.

If you have issues with new user emails / Umbraco Forms emails not being sent it is likely because your SMTP settings are not being set or configured correctly. Make sure to read the [SMTP Documentation ](../project-settings/smtp-settings.md)for Umbraco Cloud.

## If the error is something not loading in the backoffice

This can have many different causes, and as such we don't have specific guides on this, but to narrow it down there are some things you should check:

* Do you have any rewrite rules? Often rewrite rules that are not set up correctly will cause issues with the backoffice, make sure that the following are negated:
  * ^/umbraco
  * ^/DependencyHandler.axd
  * ^/App\_Plugins
  * You can see examples of how to set up rewrites correctly in the [Rewrites on Cloud](../going-live/manage-hostnames/rewrites-on-cloud.md) article.
* Do you get any errors in your browser console that may help you figure it out?
* Do you get any errors in your umbracoTraceLog?
* If something isn't loading after a package was installed it could be because the package overwrites something like the dashboard.config file - try to turn the package off and see if that helps.

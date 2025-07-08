# Log files

You can access the different types of log files on Umbraco Cloud or through [Kudu](../power-tools/). You have access to different types of logs:

* Umbraco logs
* Deploy logs
* Environment logs
* Site Extension logs
* IIS logs

{% hint style="info" %}
Remember that the timestamps in all logs are in UTC so they might be a few or many hours off from the time your actual problem occurred.
{% endhint %}

## Video

{% embed url="https://www.youtube.com/embed/xM5QbF751SI" %}
Video example.
{% endembed %}

## Accessing the logs

### On Umbraco Cloud Portal

1.  Go to your project and click on the arrow next to the environment name.

    <figure><img src="../../../.gitbook/assets/image (49).png" alt=""><figcaption></figcaption></figure>
2. Click **Logs** to view the log details.

<figure><img src="../../../troubleshooting/images/logs-table.png" alt=""><figcaption></figcaption></figure>

### On Kudu

To access logs through Kudu, see [Power tools (Kudu)](../power-tools/) article.

## Umbraco logs

Umbraco logs on Cloud work almost the same as on a [normal installation](https://docs.umbraco.com/umbraco-cms/fundamentals/code/debugging/logging), they are still found in the `~/site/wwwroot/umbraco/Logs/` folder. Umbraco Deploy also writes to the standard log files with events and errors. If there is an extraction error and you can't find any issues in your Umbraco log, try the Deploy log listed below.

## Deploy logs

It is possible that a deployment failed so it is not the active deployment at the moment, there could be valuable information in the logs of this deployment. You can find out what the last attempted deploy was by going to your Kudu URL and adding `/api/deployments` to the URL (so for example `https://stage-mysite.scm.s1.umbraco.io/api/deployments`. This will give you some JSON data and the first entry here is the newest attempted deployment. You can also find some information in `~/site/wwwroot/umbraco/Deploy` if there are for example extraction errors.

## Environment logs

Whenever you push between environments or when you deploy using the Umbraco Cloud portal, you're deploying your site using Git. This works as follows: you commit changes to Git and push them to development, these changes is then stored in the `site > repository` folder. Then the state of the newest commit gets copied into the `wwwroot` folder, which is where your website lives.

When you're in Kudu, you can go up to the `site` folder and then the `deployments` folder. The `active` file has the identifier of the currently active deployment in it. If you go into the folder that has the same name as that identifier you can see a few files: `log.log`, `manifest` and `status.xml`.

* `status.xml` shows you detailed information of which commit was deployed to the `wwwroot` folder
* `manifest` is used to track which files are in the currently active deployment so that additions, renames and deletions, can be detected for the next deploy (this is an internal file which you should not touch)
* `log.log` shows you the same output you will have seen when pushing your changes using Git, it will show you what happened during the push and if any errors occurred. This file is especially useful when trying to find errors for deploys using the portal (for example, from dev > live or from dev > staging > live). Even though the last line may end with "Deployment successful" it is possible that there were errors or suspicious messages before that so make sure to give them a read.

## Cleaning up the environment logs viewer

On Cloud environments, all errors are logged to a database table in the portal under each environment. If you leave too many unread log messages it can cause timeouts when you go to see your errors.

Since the errors are stored in your database, it is possible to clean them up. To do this, start by [accessing the database](../../../build-and-customize-your-solution/set-up-your-project/databases/cloud-database/) for the environment where you want to run the cleanup.

If you want to delete logs from one of your environments' log viewers then you will have to connect to the environment DB and run the following query:

```sql
DELETE TOP(90) PERCENT
  FROM [dbo].[UCErrorLog]
  WHERE [Read] = 0
```

This will delete 90% of the oldest logs that are unread and leave you with 10% of the newest ones. It is up to you to decide how many % of logs you want to delete.

## IIS Logging

It is possible to enable IIS Logging on each of your Umbraco Cloud environments. There is a rolling size limit on the log files of 100 MB. This means that once the limit is reached, the oldest log files will be overwritten by new ones.

{% hint style="info" %}
Do note that the IIS logging will be automatically turned off after 12 hours. It's not possible to have them enabled for longer at once due to possible performance degradation while the logging is enabled.
{% endhint %}

You can enable the logging from the **Advanced** menu found under _Settings_ in the project overview for the project. The logs will be accessible from KUDU in `C:\home\LogFiles\http`.

After enabling IIS logging for the environment, the site will have to restart.

Find more information about IIS Logging on [the Official Microsoft Documentation](https://docs.microsoft.com/en-us/iis/configuration/system.webserver/httplogging).

{% hint style="info" %}
IIS Logging is only available if your project is on a Professional plan.

See our [Cloud Pricing plans](https://umbraco.com/umbraco-cloud-pricing/) for more details on various tiers.
{% endhint %}

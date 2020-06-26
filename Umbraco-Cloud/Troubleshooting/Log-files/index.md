---
versionFrom: 7.0.0
---

# Log files on Umbraco Cloud

:::note
If your project is using Umbraco Courier, please refer to this article as well: [Courier in debug mode](../../../Add-ons/UmbracoCourier/Architecture/Configuration#debugmode)
:::

To get access to the different types of log files on Umbraco Cloud it is necessary to use [Kudu](../../Set-Up/Power-Tools). Once you access the server files through Kudu there are several different types of logs you will have access to:

* Umbraco logs
* Deploy logs
* Environment logs

__NOTE:__ Remember that the timestamps in all logs are in UTC so they might be a few or many hours off from the time your actual problem occurred.


## Umbraco logs
Umbraco logs on Cloud works almost the same as on a [normal installation](../../../Getting-Started/Code/Debugging/#logging), they are still found in the __~/site/wwwroot/App_Data/Logs/__ folder. One important note for Cloud though is that Umbraco Deploy also writes to the standard log file, with events and errors. If there is an extraction error and you can't find any issues in your Umbraco log, try the Deploy log listed below.

## Deploy logs

It is possible that a deployment failed so that it is not the active deployment at the moment, there could be valuable information in the logs of this deployment. You can find out what the last attempted deploy was by going to your Kudu URL and adding `/api/deployments` to the URL (so for example: `https://stage-mysite.scm.s1.umbraco.io/api/deployments`. This will give you some JSON data and the first entry in here is the newest attempted deploy.
You can also find some information in __~/site/wwwroot/data/deploy.log__ if there are for example extraction errors.

## Environment logs
Whenever you push from local to staging or when you deploy using the Umbraco Cloud portal, you're deploying your site using Git. This works as follows: you commit changes to Git and push them to development, these changes are then stored in the site > repository folder. Then the state of the newest commit gets copied into the wwwroot folder, which is where your website lives.

When you're in Kudu, you can go up to your `site` folder as described in the 5 steps above and then jump into the deployments folder. The `active` file has the identifier of the currently active deployment in it. If you go into the folder that has the same name as that identifier you can see a few files: `log.log`, `manifest` and `status.xml`.

- `status.xml` shows you detailed information of which commit was deployed to the `wwwroot` folder

- `manifest` is used to track which files are in the currently active deploy so that additions, renames and deletions can be detected for the next deploy (this is an internal file which you should not touch)

- `log.log` shows you the same output you will have seen when pushing your changes using Git, it will show you what happened during the push and if any errors occurred. This file is especially useful when trying to find errors for deploys using the portal (so from dev > live or from dev > staging > live). Even though the last line may end with "Deployment successful" it is possible that there were errors or suspicious messages before that so make sure to give them a read.

## IIS Logging

It is possible to enable IIS Logging on each of your Umbraco Cloud environments. There is a rolling size limit on the log files of 100 MB. This means that once the limit is reached, the oldest log files will be overwritten by new ones.

You can enable the logging from the **Advanced** menu found under *Settings* in the project overview for the project. The logs will be accessible from KUDU in `C:\home\LogFiles\http`.

Please be aware when you are enabling IIS logging for the environment the site will have to restart.

Find more information about IIS Logging on [the Official Microsoft Documentation](https://docs.microsoft.com/en-us/iis/configuration/system.webserver/httplogging).

:::note
IIS Logging is only available if your project is on a Professional plan.

See our [Cloud Pricing plans](https://umbraco.com/umbraco-cloud-pricing/) for more details on various tiers.
:::

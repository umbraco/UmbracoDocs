# Manually run Extractions on your Cloud Environments

{% hint style="info" %}
If you are running Deploy 4+, we recommend you run extractions from the Deploy Dashboard instead of KUDU. For more information, see the [Deploy Dashboard](../../build-and-customize-your-solution/handle-deployments-and-environments/deployment/deploy-dashboard.md) article.
{% endhint %}

When you deploy from one environment to another on your Umbraco Cloud project, the files from the Git repository are merged into the files used on the site. The Deploy engine then runs an extraction. This means that the files on the disk will be deserialized into the database in the Cloud environment.

Run an extraction following these steps:

1. Access Kudu.
2. Navigate to **CMD** under the **Debug console** menu.
3. In the file structure, navigate to `site/wwwroot/umbraco/Deploy`.

{% hint style="info" %}
When using Umbraco 7 or 8, you need to navigate to `site/wwwroot/data` folder.
{% endhint %}

4. The `/Deploy` folder contains:
   * `Revision` folder containing all your project's UDA files.
   * `deploy-marker` indicating the state of the latest extraction (`deploy-complete` or `deploy-failed`).
   * `deploy.log` containing logs from the latest extraction.
5. While in this folder, type the following command in the CMD console: `echo > deploy`. This will initiate extraction of the environment.
6. While the extraction is running, the _deploy-marker_ will change its name to `deploy-progress`.
7. The extraction will end in one of two possible outcomes:
   1. `deploy-complete`: The extraction succeeded and your environment is in good shape.
   2. `deploy-failed`: The extraction failed - open the file, to see the error message. The same error message will be shown on your environment in the Umbraco Cloud Portal.

![Run manual extraction](../../set-up/power-tools/images/manual-extraction-v9.gif)

{% hint style="info" %}
Sometimes, you might encounter a deploy-marker called `deploy`. This usually means that extraction cannot run and you need to restart your environment for the extraction to run.
{% endhint %}

Sometimes, you might also need to run this extraction locally. This can be done by following the above steps using Command Prompt (CMD) on your local machine and navigating to the `/umbraco/data` folder in your local project folder.

Find general information about Kudu and how to access the tool in the [Power tools](./) article.

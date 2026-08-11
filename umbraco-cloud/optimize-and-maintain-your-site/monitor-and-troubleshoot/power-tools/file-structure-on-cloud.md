# View the Files on your Cloud Environments

When you clone your Umbraco Cloud project to your local machine, all project files are in the specified folder. There may be times when you want to check the files in your Umbraco Cloud environments. This could be to ensure everything is synchronized or if you suspect that a deployment or extraction hasn't proceeded as expected.

In Kudu, you can view your project files, if you navigate to **CMD** under the **Debug console** menu. Here you'll find a file structure. All your project files are under the `/site` folder.

![File structure](../../../.gitbook/assets/CMD-file-structure-v9.png)

The three highlighted folders are used the most when visiting Kudu:

* The **deployments** folder: This folder contains log files for the deployments and extractions that have been run on the environment.
* The **repository** folder: This is your Git repository. You'll find a clone of your site's structure files in the`/wwwroot` folder. Changes are pushed to and pulled from the `/repository/` folder when working locally.
* The **wwwroot** folder: This folder contains your site's structure files. These are the files used to run the site in the environment.

{% hint style="info" %}
`/wwwroot/` contains the files used to show your website to the world. When you push changes from your local machine, they are pushed to the Git repository (`/repository/`). Once this process completes successfully, the changes are then copied to the live site.
{% endhint %}

Find general information about Kudu and how to access the tool in the [Power tools](./) article.

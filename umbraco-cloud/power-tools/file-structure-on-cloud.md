# View the Files on your Cloud Environments

When you clone down your Umbraco Cloud project to your local machine, you can see all the project files in the folder you specify when cloning down the project. Sometimes, you might also want to view the files you have on your Umbraco Cloud environments - perhaps to make sure that everything is in sync or if you suspect that a deployment or extraction hasn't gone as planned.

In Kudu, you can view your project files, if you navigate to **CMD** under the **Debug console** menu. Here you'll find a file structure. All your project files are under the `/site` folder.

![File structure](../set-up/power-tools/images/CMD-file-structure-v9.png)

The three highlighted folders are used the most when visiting Kudu:

* The **deployments** folder: This folder contains log files for the deployments and extractions that have been run on the environment.
* The **repository** folder: This is your Git repository. You'll find a clone of your site's structure files in the`/wwwroot` folder. Changes are pushed to and pulled from the `/repository/` folder when working locally.
* The **wwwroot** folder: This folder contains your site's structure files. These are the files used to run the site in the environment.

{% hint style="info" %}
`/wwwroot/` contains the files used to show your website to the world. When you push changes from your local machine, they are pushed to the Git repository (`/repository/`), and when this finishes successfully the changes are copied into the live site.
{% endhint %}

Find general information about Kudu and how to access the tool in the [Power tools](./) article.

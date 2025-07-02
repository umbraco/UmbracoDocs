# Baseline Merge Conflicts

Here we outline how to manually resolve a merge conflict after having updated the children for a Baseline project.

On a Baseline project you can click to _“Manage updates here”_, which enables you to push updates to your child projects from the Live environment of the Baseline project.

![Upgrades Baseline children](../getting-started/baselines/images/manage-baseline-children.gif)

Select the child projects you want to upgrade, and click **Update selected children**. The overview will then change to show the progress and status for updating the various child projects.

The outcome of the update will result in one of three statuses:

* Updated has completed
* Error while updating from upstream
* Encountered a merge conflict so abandoning update

A merge conflict is something you currently need to handle manually in order to push future updates to the child project, which encountered a merge conflict upon updating.

![environment](../getting-started/baselines/images/mergeconflict.jpg)

<details>

<summary>Resolving merge conflicts</summary>

{% hint style="info" %}
Since the following documentation was outlined we've made quite a few improvements to the Baseline workflow. For the most part this documentation is still relevant and we are working on getting them updated with the latest details.
{% endhint %}

To resolve the conflict, you need to go to the **child site** open up the SCM / Kudu site for the development environment. Click the “\[link]” (see screenshot above) for the project (see screenshot above) and find clone url for the development site, which is similar to this: `https://dev-my-website-alias.scm.umbraco.io/c565ead8-7a27-4696-9ab4-dad7eba2cd2c.git` and remove everything after the last slash, so you have a url that looks like this: `https://dev-my-website-alias.scm.umbraco.io`

![environment](../getting-started/baselines/images/getcloneurl.jpg)

You will be prompted to login to the SCM / Kudu site - use the credentials you normally use to login to the Umbraco Cloud portal. Now click “Debug console” from the top menu and select “CMD”. This will take you to a command line interface from where you need to navigate to the repository folder: site / repository

![environment](../getting-started/baselines/images/image03.png)

From here you need to merge the branch (upstream/master), which contains the updates which were fetched from the Baseline project. In the console enter: `git merge upstream/master`

This will result in an output showing the files, which contains conflicts that you need to resolve in order to fully merge the two branches:

```
Auto-merging data/Revision/properties/77279e39-ed1f-428a-ad7e-258db5f9e6ee.courier
CONFLICT (content): Merge conflict in data/Revision/properties/77279e39-ed1f-428a-ad7e-258db5f9e6ee.courier
Auto-merging data/Revision/documents/77279e39-ed1f-428a-ad7e-258db5f9e6ee.courier
CONFLICT (content): Merge conflict in data/Revision/documents/77279e39-ed1f-428a-ad7e-258db5f9e6ee.courier
Automatic merge failed; fix conflicts and then commit the result.
```

In the above output two files are listed and we want to pick the ones that comes from the current project (the child) - in other words we want to keep our files, as these are content changes. We use the following commands to achieve that:

```
git checkout --ours data/Revision/properties/77279e39-ed1f-428a-ad7e-258db5f9e6ee.courier

git checkout --ours data/Revision/documents/77279e39-ed1f-428a-ad7e-258db5f9e6ee.courier
```

_Note_: If you wanted to select the files from the Baseline project instead of the ones from the current project, you should write “--theirs” instead of “--ours” in the command from above. “Ours” corresponds to the current project (the development site) and “Theirs” corresponds to the Baseline project.

Now you need to add the (modified) files to Git and finally commit the changes using the following commands:

```
git add .
git commit -m “Resolving merge conflicts”
```

The merge conflict has now been resolved, and you can update your local repository with the latest changes by pulling from the development site. Please note that the changes from the commit haven’t been deployed to the website yet, as we have only applied the changes to the Git repository. In order to deploy the recent changes to the website you can push your local changes to the development site or you can use the Kudu api to trigger a deployment. You can use the following command from the Kudu Debug Console to deploy the latest changes:

```
curl https://dev-my-website-alias.scm.s1.umbraco.io/api/deployments -X PUT -H "Content-Type: Application/json" --data "{ }" --user yourusername:password
```

If you prefer to use the Kudu REST API for triggering a deployment, you can find the details here: [https://github.com/projectkudu/kudu/wiki/REST-API#deployment](https://github.com/projectkudu/kudu/wiki/REST-API#deployment)

</details>

<details>

<summary>Break Reference between Baseline and Child Project</summary>

Umbraco Cloud Portal offers a powerful baseline-child relationship between projects. A Baseline Child project is similar to a Fork (forked repository) on GitHub. We create a clone of an existing project while maintaining a connection between the two projects.

If, at some point, you wish to sever the connection between the baseline and one of its child projects, you can do so. This action is possible with admin privileges.

{% hint style="warning" %}
Kindly be aware that this action cannot be undone.
{% endhint %}

![Baseline child project](../getting-started/baselines/images/Baseline-child-project.png)

From this page, you can break the connection of all the Child Projects this Baseline project has.

To break reference between a baseline and child project:

1. Go to the Baseline project on the Cloud portal.
2. Click on Manage updates **here**.
3. Click on the ![Disconnect](../getting-started/baselines/images/disconnect-icon.png) icon in the **Manage child projects** page.
4. A window with the consequences of the action is displayed.
5. Check all the boxes after reading and understanding the consequences mentioned.
6.  Click **Disconnect**.

    ![Break Baseline and child project](../getting-started/baselines/images/Break-baseline.gif)

</details>

<details>

<summary>Handling configuration files</summary>

{% hint style="warning" %}
This is currently not possible on projects that run Umbraco 9 and above.

We are working on making it available for Umbraco Cloud projects using version 9 and above.
{% endhint %}

When you are doing your normal development process, you'd be updating the configuration files in your solution as usual. When you are working with a Baseline setup there are a few things to keep in mind.

When you are deploying updates from the Baseline project to the Child projects, all solvable merge conflicts on configuration files will be solved by using the setting on the Child project.

That also means that if a file has been changed in both the Baseline and in the Child project, the change from the Baseline won’t be applied to the Child. To have custom settings on the Child project, you should take advantage of the vendor-specific transform files.

On Umbraco Cloud, it is possible to create transform files that will be applied to certain environments by naming them like `web.live.xdt.config` (see [Config-Transforms](../project-settings/config-transforms.md)). This should be used when a Child project needs different settings than the Baseline project.

It can be achieved by using a configuration file that is specific to the Child Project, naming it like `child.web.live.xdt.config`. This file should only be in the Child projects repository, which can be achieved by creating the file locally and pushing it directly to the Child project. Read the [Working locally](../build-and-customize-your-solution/working-with-deployments/working-locally.md) article to learn more about how this is done.

Following this workflow will ensure that when the Child is updated from the Baseline, the settings won’t be overwritten.

This practice is especially important when the Baseline project gets major new functionality, like new code that is dependent on the configuration files or when upgrades are applied.

{% hint style="warning" %}
When you need a specific configuration on Child projects, you should always use config transforms. Making changes directly to the default config files on the Child project might prevent you from being able to push changes from your Baseline project in the future.
{% endhint %}

## Examples

Here is a few examples of what could be transformed in the child sites.

## Adding or updating appsettings

{% code title="child-appsettings.web.live.xdt.config" %}
```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
    <appSettings xdt:Transform="InsertIfMissing">
        <!-- Updates the value of the appSetting called owin:appStartup -->
        <add key="owin:appStartup" value="MyCustomOwinStartup" xdt:Locator="Match(key)" xdt:Transform="SetAttributes(value)" />
        <!-- Adds the appsetting MyOwnAppSetting, if it isn't already there -->
        <add key="MyOwnAppSetting" value="AmazingValue" xdt:Locator="Match(key)" xdt:Transform="InsertIfMissing" />
        <!-- Ensures a custom value is there and set to a certain value (remove and add) -->
        <add key="MyOwnAppSetting2" xdt:Locator="Match(key)" xdt:Transform="RemoveAll" />
        <add key="MyOwnAppSetting2" value="AmazingValue2" xdt:Locator="Match(key)" xdt:Transform="InsertIfMissing" />
    </appSettings>
</configuration>
```
{% endcode %}

## Setting the Simple Mail Transfer Protocol (SMTP) settings for the child project

{% code title="child-smtpsettings.web.live.xdt.config" %}
```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
    <system.net xdt:Transform="InsertIfMissing">
        <mailSettings xdt:Transform="InsertIfMissing">
            <smtp xdt:Transform="RemoveAll" />
            <smtp from="abc@def.com" xdt:Transform="InsertIfMissing">
                <network host="smtp.sendgrid.com" userName="abc" password="def" />
            </smtp>
        </mailSettings>
    </system.net>
</configuration>
```
{% endcode %}

## Setting custom rewrite rules for the child project

{% code title="child-iisrewrite.web.live.xdt.config" %}
```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
    <system.webServer>
        <rewrite xdt:Transform="InsertIfMissing">
            <rules xdt:Transform="InsertIfMissing">
                <rule xdt:Locator="Match(name)" xdt:Transform="InsertIfMissing" name="Redirects umbraco.io to actual domain" stopProcessing="true">
                    <match url=".*" />
                    <conditions>
			<add input="{HTTP_HOST}" pattern="^(.*)?.euwest01.umbraco.io$" />
                        <add input="{REQUEST_URI}" negate="true" pattern="^/umbraco" />
                        <add input="{REQUEST_URI}" negate="true" pattern="^/DependencyHandler.axd" />
                        <add input="{REQUEST_URI}" negate="true" pattern="^/App_Plugins" />
                        <add input="{REQUEST_URI}" negate="true" pattern="localhost" />
                    </conditions>
                    <action type="Redirect" url="http://childdomain.dk/{R:0}" appendQueryString="true" redirectType="Permanent" />
                </rule>
            </rules>
        </rewrite>
    </system.webServer>
</configuration>
```
{% endcode %}

The above could either be added to its config files or be split up into one config file per setting. Umbraco Cloud will run through all the config files for the project.

* `child.web.live.xdt.config`

or having multiple files

* `child-appsettings.web.live.xdt.config`
* `child-iisrewrite.web.live.xdt.config`
* `child-smtpsettings.web.live.xdt.config`

</details>

<details>

<summary>Pushing Upgrades to a Child Project</summary>

When a project has one or more Child Projects it will appear on the Project page and the user can click to get an overview of all the Child Projects based on the current project.

![Manage Baseline Children](../getting-started/baselines/images/mange-updates-here_v10.png)

From this page, you will have an overview of all the Child Projects this Baseline project has. This is also where you go when you want to push upgrades from your Baseline Project to the Child Projects.

To do a minor or major upgrade of a Baseline project and its Child projects, the first task is to run the upgrade on the Baseline project itself.

Follow the upgrade guides for [Minor](../product-upgrades/minor-upgrades.md) and/or [Major](../product-upgrades/major-upgrades.md) upgrade notes to upgrade your Baseline project.

Once the upgrade has been verified on the Baseline project, follow the guides outlined here to push the upgrade to the child projects.

{% hint style="info" %}
We recommend setting up a Development environment on your Child projects before deploying the updates/upgrades.

That way you'll have an environment to test on and verify that everything has been deployed correctly.

Once you are happy with the Development environment, you can go ahead and deploy it to the Live environment as well.
{% endhint %}

## Upgrading Child Projects to a New Major Version

{% hint style="info" %}
If you've done any version-specific steps, when upgrading the baseline project, these also need to be done on the child projects before pushing the upgrade.
{% endhint %}

1. Go to the child projects you are upgrading.
2. Go to the Advanced Setting tab.
3. Update the .NET version to the corresponding one for the major version upgrading to.
4. Go to the Baseline Project.
5. Click on "Manage updates here".
6. Select the Child Projects you want to push your upgrades to - you can select as many or as few as you like.
7. Click **Update all child projects** or **Update selected**.
8. Click **Confirm** once the selection looks correct.

If the upgrade has been completed successfully, the Child Projects will be displayed under the **Successful Updates/upgrades** section.

![Upgrade Child Projects](../getting-started/baselines/images/manage-baseline-children_v10.gif)

## Deploying Minor upgrades to Child projects

1. Go to the **Manage child projects** page on the Baseline.

On this page, the Child projects will have an available upgrade.

2. Select the projects you want to upgrade.
3. Click the "Upgrade selected children" button.

First, any pending changes made on the Baseline will be deployed to the child site.

Once the changes have been deployed, the child site will be upgraded to the same version as the Baseline site.

{% hint style="info" %}
All products (CMS, Deploy, and Forms) will be upgraded.
{% endhint %}

![Minor upgrade labels](../getting-started/baselines/images/minor-upgrades.png)

The upgrade itself will happen once you click the upgrade button. This will start by triggering the update, where all the files are updated on the children from the baseline.

Once the files are in place, we also run the upgrade process, making sure that the children are fully upgraded.

When using the feature, the Baseline Child projects must be set up following our [best practices for handling config files](broken-reference). This means that any changes to the Child project should be applied via a config transform file.

The reason for this is that the Child Projects config files will be merged by choosing the parent's config files first. That is to ensure that changes to config files, that have been made in the minor upgrade, will also be applied to the child projects.

## Errors while upgrading children from baseline

If the upgrade of a Child project fails, or the Child project is left in a bad state, it is most likely because the Child project was unable to be merged properly.

When updating Child projects from a Baseline project, a configuration from the Child project will take precedence over the Baseline project configuration. This means that when the update from the baseline to the child runs, the configuration file sometimes won’t be changed.

To fix this, it is important to follow the flow shown in [Handling configuration files](broken-reference). It prevents the child will update configuration files and will ensure the best flow between the baseline and the child.

If the flow isn't used, then the repository will be in a state where the code has been updated, but the configuration files haven’t been updated. The solution is to manually fix the configuration files on the child project. Do a comparison of the configuration files on the baseline and the child, and make sure that all changes have been added to the child’s configuration files.

</details>

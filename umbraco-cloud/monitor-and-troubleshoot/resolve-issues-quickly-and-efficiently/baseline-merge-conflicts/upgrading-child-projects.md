# Pushing Upgrades to a Child Project

When a project has one or more Child Projects it will appear on the Project page and the user can click to get an overview of all the Child Projects based on the current project.

![Manage Baseline Children](../../../getting-started/baselines/images/mange-updates-here_v10.png)

From this page, you will have an overview of all the Child Projects this Baseline project has. This is also where you go when you want to push upgrades from your Baseline Project to the Child Projects.

To do a minor or major upgrade of a Baseline project and its Child projects, the first task is to run the upgrade on the Baseline project itself.

Follow the upgrade guides for [Minor](../../../optimize-and-maintain-your-site/manage-product-upgrades/product-upgrades/minor-upgrades.md) and/or [Major](../../../optimize-and-maintain-your-site/manage-product-upgrades/product-upgrades/major-upgrades.md) upgrade notes to upgrade your Baseline project.

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

![Upgrade Child Projects](../../../getting-started/baselines/images/manage-baseline-children_v10.gif)

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

![Minor upgrade labels](../../../getting-started/baselines/images/minor-upgrades.png)

The upgrade itself will happen once you click the upgrade button. This will start by triggering the update, where all the files are updated on the children from the baseline.

Once the files are in place, we also run the upgrade process, making sure that the children are fully upgraded.

When using the feature, the Baseline Child projects must be set up following our [best practices for handling config files](configuration-files.md). This means that any changes to the Child project should be applied via a config transform file.

The reason for this is that the Child Projects config files will be merged by choosing the parent's config files first. That is to ensure that changes to config files, that have been made in the minor upgrade, will also be applied to the child projects.

## Errors while upgrading children from baseline

If the upgrade of a Child project fails, or the Child project is left in a bad state, it is most likely because the Child project was unable to be merged properly.

When updating Child projects from a Baseline project, a configuration from the Child project will take precedence over the Baseline project configuration. This means that when the update from the baseline to the child runs, the configuration file sometimes won’t be changed.

To fix this, it is important to follow the flow shown in [Handling configuration files](configuration-files.md). It prevents the child will update configuration files and will ensure the best flow between the baseline and the child.

If the flow isn't used, then the repository will be in a state where the code has been updated, but the configuration files haven’t been updated. The solution is to manually fix the configuration files on the child project. Do a comparison of the configuration files on the baseline and the child, and make sure that all changes have been added to the child’s configuration files.

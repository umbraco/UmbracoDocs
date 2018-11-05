# Pushing upgrades to a Child Project
When a project has one or more Child Projects it will appear on the Project page, and the user can click to get an overview of all the Child Projects based on the current project.

![Manage Baseline Children](images/mange-updates-here.png)

From this page you will have an overview af all the Child Projects this Baseline project has. This is also where you go, when you want to push upgrades from your Baseline Project to the Child Projects.

## Upgrading Child Projects

1. Select the Child Projects you want to push your upgrades to - you can select as many or as few as you like!
2. Click **Update selected children**
3. Make sure the selection looks correct then click **Confirm**
4. Follow the process as the upgrades are pushed to the child projects one by one
5. When the Child Projects *turn green* the upgrade was a success

![Upgrade Child Projects](images/manage-baseline-children.gif)

## Deploying Minor upgrades to Child projects

To do a minor upgrade of a Baseline project and its Child projects, the initial task is to run the minor upgrade on the baseline it self. This is done as you'd expect in the Umbraco Cloud portal by clicking the "Upgrade available!" button on the Development environment. 

Following [Minor upgrades](../../Upgrades/#minor-version-upgrades) guide and process will leave the Baseline project upgraded to the latest version, while all the children are untouched for now.

Once the upgrade has been verified on the Baseline project, and you've made sure everything works as expected, you should go to the **Manage Child Projects** page on the Baseline. 

On this page you'll notice that all the children will be marked as if they have a pending upgrade. At this point you are able to select one or more projects to upgrade. 

![Minor upgrade labels](images/minor-upgrades.png)

The upgrade itself will happen, once you click the upgrade button. This will start by triggering the update, where all the files are updated on the children from the baseline. Once the files are in place we also run the upgrade process, making sure that the children are fully upgraded, once done. 

When using the feature, it is important that the Baseline Child projects have been setup following our [best practices for handling config files](../Configuration-files). This means that any changes to the Child project, shoud be applied via a config transform file. The reason is that the Child projects config files will be merged by choosing the parents config files first, to ensure that changes to config files, that has been made in the minor upgrade, will also be applied to the childsites.

### Errors while upgrading children from baseline
If for some reason the update of a child fail, or the child is left in a weird state, where it has some wrong configuration files, it is most likely because the child was unable to be merged properly. When updating Child projects from a Baseline project, a configuration file will be preferred from the child over the one from the baseline. This means that when the update from the baseline to the child runs, the configuration file sometimes won’t be changed. 

To fix this, it is important to follow the flow shown in [Handling configuration files](../Configuration-files/). It prevents that the child will update configuration files, and will ensure the best flow between the baseline and the child.

If the flow isn't used, then the repository will be in a state where the code has been updated, but the configuration files hasn’t been updated. The solution is to manually fix the configuration files on the child project. Do a compare of the configuration files on the baseline and the child, and make sure that all changes has been added to the child’s configuration files.
# The Umbraco Heartcore Portal

In this article you will learn more about the Umbraco Heartcore Portal and what options that are available to you.

After you have logged into the [Heartcore Portal](https://www.umbraco.io) you are presented with the project overview.

![Portal Project Overview](images/portalOverview.png)

From here you can see a list of all your projects. If you have many projects, you are able to search for specific projects from the search bar in the top right corner.

Clicking on a project will take you to the project where you will get an overview of your environment(s).

![Portal Project Overview](images/projectOverview.png)

## Manage Environments

From here you are able to create multiple environments so you might have a Development environment as well. Depending on what plan you have chosen, you will have acces to one or more environment on your project.

![Manage the environments](images/manageEnvironments.png)

If you want to add an environment all you have to do is click the big green button. Umbraco will create the environment for you.

When you are done you can go ahead and click on 'Done, take me back' in the top-right corner to get back to the project overview.

## Invite member

In the top-right corner you will find the **invite member** option. This will allow you to quickly invite new team members to your project from a modal that pops up. This makes it very fast and easy to invite new team members. Depending on your chosen plan, you might be charged an extra €5 euros per added team member.

![Invite Team Member Modal](images/inviteModal.png)

## Settings

Right next to the invite member option. you will find the **Settings** dropdown menu. Here you will find various links to more management and configuration options.

### Edit Team

As with the **invite member** option you are able to add new team members to your project. It is also possible to change the role for the team member here. You will also be able to remove team members from this page as well as see any pending invitations you might have sent.

It is also here you are able to add or edit the Technical Contact information such as Name, Email and a telephone number.

![Edit Team Members page](images/editTeam.png)

### Webhooks

Here you are able to set up a webhook that will gather all the information related to deployments. This information is very useful if you har set up something like Slack integration so every time a deployment has been made a message will be posted.

:::note
The webhooks that can be added here is **not the same** as the webhooks that can be created from the Backoffice.
:::

### Upgrade plan

Here you will be able to upgrade your trial to a plan that fits your needs.

### Rename project

Here you are able to rename your project. All default umbraco.io hostnames will be updated to match the new name. When renaming a project you will also need to update the `Umb-Project-Alias` header when you are sending requests to the API, as changing the name of the project will also change the project alias.

![Rename Project Page](images/renameProject.png)

### Delete project

From this page you can delete your project. When deleting the project your subscription will automatically be cancelled as well. Deleting the project is a **permanent action**.

![Delete project](images/deleteProject.png)

## Go to backoffice

Clicking on the 'Go to backoffice' link will open up a new tab with the login screen for the Backoffice. If you would like to learn more, you can read our documentation for the [Heartcore Backoffice](../The-Headless-Portal).

## Environment history

Here you will be able to see a timeline of your projects environment where you will get a detailed description of what changes that has been made.

![Delete project](images/environmentHistory.png)

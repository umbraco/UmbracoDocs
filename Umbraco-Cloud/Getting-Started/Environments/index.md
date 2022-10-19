---
versionFrom: 7.0.0
---

# Environments

When you have multiple environments in your Umbraco Cloud project:

- The *Development* environment is the first environment in the workflow.

    This is the environment you are going to work with when building the structure of your website. This is also the environment you clone down when you want to work with your project locally.

    The Development environment is included in the Standard and Professional plans on Umbraco Cloud. In the Starter plan, you have the option to add the Development environment.

- The environment next in line in the workflow is the *Staging* environment.

    Having this environment enables you to give your team members different workspaces - the developers can work with code in the Development environment while the content editors can work with content in the Staging environment. All of this without affecting the actual public site.

    The Staging environment is included in the Professional plan. In the Standard plan, you have the option to add the Staging environment.

Both the Development and the Staging environments are protected with **basic authentication**. This means that you must log in to see the frontend of these environments.

- The final environment is the *Live* environment.

    This is your live site - the site that's visible to the public. When you are in trial mode the Live environment will be protected by basic authentication - this will be removed as soon as you set up a subscription for the project.

    The Live environment is included in the Standard and Professional plans on Umbraco Cloud.

For more information about the workflow on Umbraco Cloud, see the [Deployments](../../Deployment) article. Below you will find a technical overview of the different parts that make up an environment on your Umbraco Cloud project:

![Umbraco Cloud Environment Technical Overview](images/environment-tech-overview.png)

## Site and Git Repository

Each environment on Umbraco Cloud has both a Git repository and a folder with your actual live site. The Git repository is what you clone down when you work with the project locally, and it's where your changes are pushed to.

The live site (`/site/wwwroot/`) contains the files used to show your website to the world. When you push changes from your local machine, they are pushed to the Git repository (`/site/repository/`), and when this finishes successfully the changes are copied into the live site.

## Team Members/Invite Users

All the team members you add through the Umbraco Cloud Portal will be added as backoffice users in your environments as well. As with any other Umbraco CMS installation, you can also add users directly in the backoffice of your Umbraco Cloud environments. If you do this, the user will not have the option to deploy changes between the environments.

Read more about this and team member roles in the [Team Members](../../Set-Up/Team-Members) article.

## SQL Database

Each of your Umbraco Cloud environments has its own SQL Azure database. You have full access to the databases, and you can create custom tables as you'd expect from any other hosting provider.

Learn more about how to connect to your Umbraco Cloud databases in the [Database](../../Databases) article.

## Power Tools (Kudu)

Aside from viewing the files on your Umbraco Cloud environments when cloning down the project to your local machine, you also have access to what we call **Power Tools** - Kudu.

This is a dashboard that allows you to browse, view, and edit all the files in your Umbraco Cloud environment. We recommend using the tool *only* when you are following one of our guides in the Troubleshooting section.

In the [Power Tools](../../Set-Up/Power-Tools) article, you can read more about how to access the dashboard, and how we recommend using it.

## Environment History

Each of your Umbraco Cloud environments has a Git repository and therefore also a Git history. We've made a simplified view of this Git history in the Umbraco Cloud Portal - the **Environment History**.

In this view, you'll be able to see what file changes have been made in each environment.

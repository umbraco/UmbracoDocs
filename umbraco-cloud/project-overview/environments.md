---
description: >-
  Environments are a core part of your Umbraco Cloud project. This is where you
  develop, write, build, and eventually publish your website.
---

# Environments

An Umbraco Cloud environment is defined as a _workspace_ and is also a Git repository. When you have more than one environments on your project, these environments act as branches of the main repository.

Umbraco Cloud uses a deployment model that relies on Git and other core technology. This gives you the option to move both content and structure files from one environment to another. Learn more in the [Deployment section](../build-and-customize-your-solution/handle-deployments-and-environments/deployment/).

You can have multiple environments in your Umbraco Cloud project, with two types available: **Mainline Environments** and **Flexible Environments**.

The image below shows a Cloud setup including two mainline environments and one flexible environment connected to the left-most mainline environment.

![A Cloud setup including 2 mainline environments and 1 flexible environment connected to the left-most mainline environment](../getting-started/images/cloud-environments.png)

## Mainline Environments

A mainline environment serves as the root deployment pipeline, responsible for managing code and content flow. Each mainline environment is a part of the [left-to-right deployment workflow](../build-and-customize-your-solution/handle-deployments-and-environments/deployment/).

The **left-most mainline environment** is where you can connect to your local machine using Git. This environment is often called the Development environment.

The **right-most mainline environment** is your live website, often called the Live or Production environment.

Each mainline environment can have one or more flexible environments branching off from it.

## Flexible Environments

A flexible environment is an environment that branches off a mainline environment. It is positioned vertically from the mainline deployment flow.

Changes made on a flexible environment can only be pushed to the next designated Mainline Environment in the pipeline.

Technically, the flexible environment is connected only to its mainline environment using a Git remote. This ensures that changes follow a structured path while allowing flexibility in development workflows.

Learn more about how this works in the [Flexible Environments](flexible-environments.md) article.

## Plans and availability

<table><thead><tr><th width="117">Plan</th><th width="116" data-type="number">Mainline Environments</th><th width="167" data-type="checkbox">Flexible Environments</th></tr></thead><tbody><tr><td>Starter</td><td>2</td><td>false</td></tr><tr><td>Standard</td><td>3</td><td>true</td></tr><tr><td>Professional</td><td>4</td><td>true</td></tr></tbody></table>

## Environment Components

### Site and Git Repository

Each environment on Umbraco Cloud has both a Git repository and a folder with your actual live site. The Git repository is what you clone down when you work with the project locally, and it's where your changes are pushed to.

The live site (`/site/wwwroot/`) contains the files used to show your website to the world. When pushing changes from your local machine, they are pushed to the Git repository (`/site/repository/`). When this finishes successfully, the changes are copied into the live site.

### Configuration files

An `appSettings.json` file holds all configurations for the Umbraco CMS project within the Cloud project. This file follows ASP.NET standards as they are tied to the Umbraco CMS installation.

It is possible to set up specific configurations for each environment:

1. Clone the `appSettings.json` file.
2. Rename it by adding the environment name: `appSettings.{EnvironmentAlias}.json`.

The `EnvironmentAlias` is fetched from the Environment variable named `DOTNET_ENVIRONMENT`. This variable can be found in the Environment Variables section of Kudu on the environment. You can read more about ASP.NET Configuration in the official [Microsoft documentation](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-9.0).

The value of the `DOTNET_ENVIRONMENT` environment variable can be managed through the **Advanced** settings in the **Configuration** section of the Cloud Portal.

{% hint style="info" %}
Make sure that when you start up the Umbraco Application, you load the correct JSON file as per the ASP.NET Configuration in the official [Microsoft documentation](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-9.0).
{% endhint %}

### Team Members

All the team members you add through the Umbraco Cloud Portal will also be added as backoffice users in your environments. You can also add users directly in the backoffice of your Umbraco Cloud environments. If you do this, the user will not have the option to deploy changes between the environments.

Read more about this and team member roles in the [Team Members](team-members/) article.

### SQL Database

Each of your Umbraco Cloud environments has its own SQL Azure database. You have full access to the databases, and you can create custom tables as you'd expect from any other hosting provider.

Learn more about how to connect to your Umbraco Cloud databases in the [Database](../build-and-customize-your-solution/ready-to-set-up-your-project/databases/) article.

### Power Tools (Kudu)

Aside from viewing the files when cloning down the project to your local machine, you also have access to Kudu (Power Tools).

Kudu is a dashboard that allows you to browse, view, and edit all the files in your environments. We recommend using the tool _only_ when you are following one of our guides.

In the [Power Tools](../monitor-and-troubleshoot/power-tools/) article, you can read more about how to access the dashboard, and how we recommend using it.

### Environment History

Each of your Umbraco Cloud environments has a Git repository and therefore also a Git history. We've made a simplified view of this Git history in the Cloud Portal. The **History** is found via the action menu available on each environment in the environments overview on your project.

In the History view, you'll be able to see what file changes have been made in the environment.

![Umbraco Cloud Environment Technical Overview](../getting-started/images/environment-tech-overview.png)

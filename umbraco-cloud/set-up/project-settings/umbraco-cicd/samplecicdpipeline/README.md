# Configuring a CI/CD pipeline

Getting started with configuring a CI/CD pipeline

{% hint style="warning" %}
This documentation is currently a work in progress.
{% endhint %}

Learn how to configure a CI/CD pipeline in **Azure DevOps** and **GitHub Actions** Workflows using the sample scripts provided.

You'll find example shell scripts and pipeline configurations in the **Sample scripts** section, covering both Azure DevOps and GitHub Actions Workflows.

## Why should one configure a sample CI/CD pipeline?

Umbraco Cloud repositories are not meant to be used as source code repositories. More details on our official documentation.

Once you commit your code to Cloud the build pipeline converts your C# code to DLLs and deploys it on the respective environment.

{% hint style="info" %}
Only C# code is built, and all frontend artifacts need to be built and committed to the repository.
{% endhint %}

You can use AzureDevops as an external repository and with the pipelines, it will automatically keep your Azure Devops source code repository in sync. The sync is done with the git repository of Umbraco Cloud of the development environment.

![UmbracoCloud CI/CD sample pipeline](../../../images/UmbracoCloudCicdSample.png)

## Prerequisites: Setting Up an Umbraco Cloud Project

Before proceeding, you'll need an Umbraco Cloud project and a CI/CD pipeline. You will also need the required files to add to your pipeline for successful interaction with the Umbraco Cloud API.

1. Create an Umbraco Cloud Project: Preferably with a development environment. You can either create a trial, create a new project, or use an existing one.
2. Create a new or use an existing CI/CD pipeline in [Azure DevOps](https://learn.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops\&tabs=browser).
3. Get your set of supporting files: Download sample files as a [zip-file](https://drive.google.com/file/d/1Wpxib2F5-eIyVsSdm3EBvA54eOrgiwLi/view?usp=drive\_link).

{% hint style="info" %}
The only file you need to make changes to is the `.yaml file`.
{% endhint %}

{% hint style="info" %}
On the page "What is Umbraco CI/CD Flow", deployments are targeted at the leftmost environment in your Umbraco Cloud setup. This means if you have a Development environment, it will be automatically selected for deployment. If no Development environment exists, the Live environment will be used.
{% endhint %}

### Obtaining the Project ID and API Key

To get started with API interactions, you'll need to obtain your Project ID and API key. If you haven't already enabled the CI/CD feature, follow these steps:

1. Navigate to the [Umbraco Cloud Portal](https://www.s1.umbraco.io/projects) and select your project.
2. Go to `Settings` -> `Advanced`. This is where you can generate an API key and find your Project ID.

{% hint style="info" %}
The API key is tied to the specific project for which it is generated. Make sure to keep it secure, as it will be used for all subsequent API interactions related to that project.
{% endhint %}

### Cloning the Umbraco Cloud Repository

To get started with your local development, you'll need to clone the repository of the environment you intend to work with. Once cloned, make a copy of it in a new folder. In this example, we'll create a new folder named `local-cicd-demo-site` for the local repository.

```sh
# Clone the development environment repository
git clone https://scm.umbraco.io/euwest01/dev-cicd-demo-site.git

# Copy the repository to a new local folder
cp -r dev-cicd-demo-site local-cicd-demo-site
```

This will set up your local workspace, allowing you to work on the project before pushing changes back to the Umbraco Cloud repository.

### Reconfiguring Git Remotes

After cloning the Umbraco Cloud repository, it's essential to remove its remote settings so that you can link it to your own company's repository. In this example, we'll be using an Azure DevOps-hosted repository as the new origin.&#x20;

Follow the steps below to reset the Git remote from the root folder of `local-cicd-demo-site`:

```sh
# Reset the Git remote to point to the new Azure DevOps repository
git remote set-url origin git@ssh.dev.azure.com:v3/umbraco/Cloud%20Team/local-cicd-demo-site
```

By executing this command, you'll disconnect the local repository from the Umbraco Cloud repository and connect it to your company's Azure DevOps repository. This allows you to manage your project within your own version control system.

### Optional: Renaming the Master Branch to Main

If you prefer to use the term "main" instead of "master" for your primary branch, you can rename it with the following commands:

```sh
# Rename the 'master' branch to 'main'
git branch -m master main

# Push the newly renamed 'main' branch to the remote repository
git push -u origin main
```

By executing these commands, you'll rename the local 'master' branch to 'main' and update the remote repository to reflect this change. This is an optional step but aligns with the industry trend towards more inclusive language.

Once the Umbraco Cloud project has been set up, it is time to set up a CI/CD pipeline.&#x20;

Below we have two examples of how to set up a CI/CD Pipeline using either Azure DevOps or GitHub Actions.

### [Azure DevOps](azure-devops.md)

Details the setup of a CI/CD pipeline using Azure DevOps.

### [GitHub Actions](github-actions.md)

Details the setup of a CI/CD pipeline using GitHub Actions.

###



The deployment artifact consists of source files to maintain consistency with Umbraco Cloud's existing Git-based deployment flow. Only zip-archived files are currently supported, and the folder structure must align with a standard Umbraco Cloud project.

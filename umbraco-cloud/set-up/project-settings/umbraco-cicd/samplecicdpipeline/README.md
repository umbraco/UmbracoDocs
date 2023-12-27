# Configuring a CI/CD pipeline

Learn how to configure a CI/CD pipeline in **Azure DevOps** and **GitHub Actions** Workflows using the sample scripts provided.

You'll find example shell scripts and pipeline configurations in the **Sample scripts** section, covering both Azure DevOps and GitHub Actions Workflows.

{% hint style="info" %}
Samples are provided "AS IS" to get you started. Please familiarize yourself with them, and feel free to change them to fit your needs.
{% endhint %}

## Why should one configure a sample CI/CD pipeline?

Umbraco Cloud repositories are not meant to be used as source code repositories. More details on our official documentation.

Once you commit your code to Cloud the build pipeline converts your C# code to DLLs and deploys it on the respective environment.

{% hint style="info" %}
Only C# code is built, and all frontend artifacts need to be built and committed to the repository.
{% endhint %}

You can use AzureDevops as an external repository and with the pipelines, it will automatically keep your Azure Devops source code repository in sync. The sync is done with the git repository of Umbraco Cloud of the development environment.

![UmbracoCloud CI/CD sample pipeline](../../../images/UmbracoCloudCicdSample.png)

## Setting Up an Umbraco Cloud Project

Before proceeding, you'll need an Umbraco Cloud project and a CI/CD pipeline. You will also need the required files to add to your pipeline for successful interaction with the Umbraco Cloud API.

1. Create An Umbraco Cloud Project: Preferably with a development environment. You can either create a [trial](https://try.umbraco.com/cloud?utm\_source=github.com\&utm\_medium=referral\&utm\_campaign=), [create a new project](https://docs.umbraco.com/umbraco-cloud/#umbraco-cloud-portal-project), or use an existing one.
2. Create a new or an existing CI/CD pipeline in [Azure DevOps](https://learn.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops\&tabs=browser) or [GitHub Actions](https://github.com/features/actions).

{% hint style="info" %}
In this guide, deployments are targeted at the leftmost environment in your Umbraco Cloud setup. This means if you have a Development environment, it will be automatically selected for deployment. If no Development environment exists, the Live environment will be used.
{% endhint %}

### Obtaining the Project ID and API Key

To get started with API interactions, you'll need to obtain your Project ID and API key. If you haven't already enabled the CI/CD feature, follow these steps:

1. Navigate to the [Umbraco Cloud Portal](https://www.s1.umbraco.io/projects) and select your project.
2. Go to `Settings` -> `Advanced`. This is where you can generate an API key and find your Project ID.

<figure><img src="../../../../.gitbook/assets/image (8).png" alt=""><figcaption><p>Advanced tab on Cloud.</p></figcaption></figure>

{% hint style="warning" %}
The API key is tied to the specific project for which it is generated. Make sure to keep it secure in Azure or GitHub, as it will be used for all subsequent API interactions related to that project.
{% endhint %}

### Cloning the Umbraco Cloud Repository

To get started with your local development, you'll need to [clone the repository](https://docs.umbraco.com/umbraco-cloud/set-up/working-locally) of the environment you intend to work with. Once cloned, make a copy of it in a new folder. In this example, we'll create a new folder named `local-cicd-demo-site` for the local repository by using Gitbash. The copy will be used in either Azure DevOps or GitHub actions repository.

```sh
# Clone the development environment repository
git clone https://scm.umbraco.io/euwest01/your-cloud-project-alias.git

# Copy the repository to a new local folder
cp -r your-cloud-project-alias local-cicd-demo-site
```

{% hint style="info" %}
If you use the command line (cmd) to clone the project then you can use `copy -r` instead of `cp -r` to make a copy of the folder.
{% endhint %}

This will set up your local workspace, allowing you to work on the project before pushing changes back to the Umbraco Cloud repository.&#x20;

### Reconfiguring Git Remotes

After cloning the Umbraco Cloud repository, it's essential to remove its remote settings so that you can link it to your own or your company's repository.&#x20;

In the below example, we'll be using an Azure DevOps-hosted repository as the new origin.&#x20;

Follow the steps below to reset the Git remote from the root folder of `local-cicd-demo-site`:

```sh
# Reset the Git remote to point to the new Azure DevOps repository
git remote set-url origin https://company-repository-name@dev.azure.com/company-repository-name/azuredevops-project-name/_git/azuredevops-project-name
```

{% hint style="info" %}
You can get the origin link from your [Azure DevOps project repository](https://learn.microsoft.com/en-us/azure/devops/repos/git/clone?view=azure-devops\&tabs=visual-studio-2022): Repos -> under “Clone to your computer” choose “HTTPS” and then copy the link. `SSH` can also be used if preferred.
{% endhint %}

By executing this command, you'll disconnect the local repository from the Umbraco Cloud repository and connect it to your own or your company's Azure DevOps repository or GitHub Actions. This allows you to manage your project within your own version control system.

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

### Azure DevOps

Details the setup of a CI/CD pipeline using Azure DevOps.

- [Example using Powershell scripts](azure-devops-pwsh.md)
- [Example using Bash scripts](azure-devops.md)

### GitHub Actions

Details the setup of a CI/CD pipeline using GitHub Actions.

- [Example using Powershell scripts](github-actions-pwsh.md)
- [Example using Bash scripts](github-actions.md)
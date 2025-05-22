# Configuring a CI/CD pipeline

Learn how to configure a CI/CD pipeline in **Azure DevOps** and **GitHub Actions** Workflows using the sample scripts provided.

You'll find example shell scripts and pipeline configurations in the **Sample scripts** section, covering both Azure DevOps and GitHub Actions Workflows.

{% hint style="info" %}
Samples are provided "AS IS" to get you started. Please familiarize yourself with them, and feel free to change them to fit your needs.
{% endhint %}

## Why should one configure a sample CI/CD pipeline?

Umbraco Cloud repositories are not meant to be used as source code repositories. [More details here](../../../../getting-started/git-repository-in-a-cloud-project.md).

Once you commit your code to Cloud the build pipeline converts your C# code to DLLs and deploys it on the respective environment.

{% hint style="info" %}
In Umbraco Cloud only C# code is built, and all frontend artifacts need to be built and committed to the repository.
{% endhint %}

You can use Azure DevOps as an external repository and with the pipelines, it will automatically keep your Azure DevOps source code repository in sync. The sync is done with the git repository of Umbraco Cloud of the development environment.

![UmbracoCloud CI/CD sample pipeline](../../../images/UmbracoCloudCicdSample.png)

## Setting Up an Umbraco Cloud Project

Before proceeding, you'll need an Umbraco Cloud project and a CI/CD pipeline. You will also need the required files to add to your pipeline for successful interaction with the Umbraco Cloud API.

1. Pick an Umbraco Cloud project, preferably with a development environment (but not a requirement)

* Create a new Umbraco Cloud Project.
  * You can take a [trial here](https://try.umbraco.com/cloud?utm\_source=github.com\&utm\_medium=referral\&utm\_campaign=)
  * [Create a new project](https://www.s1.umbraco.io/createproject) in the Umbraco Cloud Portal
* Use one of your [existing projects](https://www.s1.umbraco.io/projects).

2. Create a new or an existing CI/CD pipeline in [Azure DevOps](https://learn.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops\&tabs=browser) or [GitHub Actions](https://github.com/features/actions).

{% hint style="info" %}
In this guide, deployments are targeted at the leftmost environment in your Umbraco Cloud setup. This means if you have a Development environment, it will be automatically selected for deployment. If no Development environment exists, the Live environment will be used.
{% endhint %}

## Obtaining the Project ID and API Key

To get started with API interactions, you'll need to obtain your Project ID and API key. If you haven't already enabled the CI/CD feature, follow these steps:

1. Navigate to the [Umbraco Cloud Portal](https://www.s1.umbraco.io/projects) and select your project.
2. Go to `Settings` -> `Advanced`. This is where you can generate an API key and find your Project ID.

<figure><img src="../../../../.gitbook/assets/image (27).png" alt="Advanced tab on Cloud."><figcaption><p>Advanced tab on Cloud.</p></figcaption></figure>

3. Click on "Activate CI/CD Flow" toggle to enable the feature.

<figure><img src="../../../../.gitbook/assets/UC-advanced-CICD.png" alt=""><figcaption><p>"Umbraco CI/CD Flow" section on the Advanced page.</p></figcaption></figure>

{% hint style="warning" %}
The API key is tied to the specific project for which it is generated. Make sure to keep it secure in Azure or GitHub, as it will be used for all subsequent API interactions related to that project.
{% endhint %}

## Sample pipelines

Below we have a couple of examples of how to set up a CI/CD Pipeline using either Azure DevOps or GitHub Actions.

Each guide describes:

* How to set up a new repository in either GitHub or Azure DevOps
* Get a copy of your Umbraco Cloud project into that repository
* And finally how to configure a new pipeline using the provided samples

The sample pipelines are using either Bash-scripts or Powershell-scripts to facilitate communication with the Umbraco CI/CD API.

{% hint style="info" %}
During the guides, you will have the option to choose between Powershell or Bash scripts. We recommend that you choose the scripting technology you feel most comfortable with.
{% endhint %}

### Azure DevOps sample

Details the setup of a CI/CD pipeline using Azure DevOps with the v1 cloud api endpoints.

* [Azure DevOps Sample](v1-azure-devops.md)

### GitHub Actions sample

Details the setup of a CI/CD pipeline using GitHub Actions with the v1 cloud api endpoints.

* [GitHub Actions Sample](v1-github-actions.md)

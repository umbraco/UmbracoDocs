# Configuring a CI/CD pipeline

Learn how to configure a CI/CD pipeline in **Azure DevOps** and **GitHub Actions** Workflows using the sample scripts provided.

You'll find example shell scripts and pipeline configurations in the **Sample scripts** section, covering both Azure DevOps and GitHub Actions Workflows.

{% hint style="info" %}
Samples are provided "AS IS" to get you started. Please familiarize yourself with them, and feel free to change them to fit your needs.
{% endhint %}

## Why should one configure a sample CI/CD pipeline?

Umbraco Cloud repositories are not meant to be used as source code repositories. [More details here](../../../../explore-umbraco-cloud/technology-overview/repositories-in-a-cloud-project.md).

Once you commit your code to Cloud the build pipeline converts your C# code to DLLs and deploys it on the respective environment.

{% hint style="info" %}
In Umbraco Cloud only C# code is built, and all frontend artifacts need to be built and committed to the repository.
{% endhint %}

You can use Azure DevOps as an external repository and with the pipelines, it will automatically keep your Azure DevOps source code repository in sync. The sync is done with the git repository of Umbraco Cloud of the development environment.

![UmbracoCloud CI/CD sample pipeline](../../../../.gitbook/assets/UmbracoCloudCicdSample.png)

## Setting Up an Umbraco Cloud Project

Before proceeding, you'll need an Umbraco Cloud project and a CI/CD pipeline. You will also need the required files to add to your pipeline for successful interaction with the Umbraco Cloud API.

1. Pick an Umbraco Cloud project, preferably with a development environment (but not a requirement)

* Create a new Umbraco Cloud Project.
  * You can take a [trial here](https://try.umbraco.com/cloud?utm_source=github.com\&utm_medium=referral\&utm_campaign=)
  * [Create a new project](https://www.s1.umbraco.io/createproject) in the Umbraco Cloud Portal
* Use one of your [existing projects](https://www.s1.umbraco.io/projects).

2. Create a new or an existing CI/CD pipeline in [Azure DevOps](https://learn.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops\&tabs=browser) or [GitHub Actions](https://github.com/features/actions).

{% hint style="info" %}
In this guide, deployments are targeted at the leftmost environment in your Umbraco Cloud setup. This means if you have a Development environment, it will be automatically selected for deployment. If no Development environment exists, the Live environment will be used.
{% endhint %}

## Obtaining the Project ID and API Key

To get started with API interactions, you'll need to obtain your Project ID and API key. If you haven't already enabled the CI/CD feature, follow these steps:

1. Navigate to the [Umbraco Cloud Portal](https://www.s1.umbraco.io/projects) and select your project.
2. Go to `Configuration` -> `CI/CD Flow`. This is where you can generate an API key and find your Project ID.

![CI/CD Flow page](../../../../.gitbook/assets/cicd-flow-page.png)

3. Click on "Activate CI/CD Flow" toggle to enable the feature.

<figure><img src="../../../../.gitbook/assets/UC-advanced-CICD.png" alt=""><figcaption><p>"Umbraco CI/CD Flow" section on the Advanced page.</p></figcaption></figure>

{% hint style="warning" %}
The API key is tied to the specific project for which it is generated. Make sure to keep it secure in Azure or GitHub, as it will be used for all subsequent API interactions related to that project.
{% endhint %}

## Getting environment aliases to target

With the feature enabled a button called "CI/CD Environment Targets" becomes available. Clicking the button will show a modal with your environments and their aliases.\
Next to the environment alias is a button you can click to copy the alias.

<figure><img src="../../../../.gitbook/assets/cicd-target-environments.webp" alt=""><figcaption><p>"Umbraco CI/CD Flow" section on the Advanced page.</p></figcaption></figure>

{% hint style="info" %}
If the alias is greyed out it is currently not a valid target through the Umbraco CI/CD flow api.

Currently flexible environments and the left-most environment are considered valid targets.

We are investigating the potential impact to allow CI/CD deployments to all environments.
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

Details the setup of a CI/CD pipeline using Azure DevOps.

* [Azure DevOps Sample](azure-devops.md)

### GitHub Actions sample

Details the setup of a CI/CD pipeline using GitHub Actions.

* [GitHub Actions Sample](github-actions.md)

## Samples for version 1

These are the guides for the old samples, relevant if you are using version 1 endpoints.

* [Azure DevOps Sample](../../../../set-up/project-settings/umbraco-cicd/samplecicdpipeline/v1-azure-devops.md)
* [GitHub Actions Sample](../../../../set-up/project-settings/umbraco-cicd/samplecicdpipeline/v1-github-actions.md)

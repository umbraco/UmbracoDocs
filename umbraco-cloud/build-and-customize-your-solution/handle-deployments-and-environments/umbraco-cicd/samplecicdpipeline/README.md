---
description: Learn how to configure a CI/CD pipeline using the sample scripts provided.
---

# Configuring a CI/CD pipeline

In this section, you can learn how to configure a CI/CD pipeline using either **Azure DevOps** or **GitHub Actions Workflows**.

You'll find sample shell scripts and pipeline configurations in the **Sample scripts** section. These cover both Azure DevOps and GitHub Actions Workflows.

{% hint style="info" %}
Samples are provided "AS IS" to get you started. Please familiarize yourself with them and feel free to change them to fit your needs.
{% endhint %}

## Why configure a sample CI/CD pipeline?

Umbraco Cloud repositories are not meant as source code repositories. For more information on repositories, see the [Repositories in a Cloud Project](../../../../explore-umbraco-cloud/technology-overview/repositories-in-a-cloud-project.md) article.

Once you commit your code to the Cloud, the build pipeline converts your C# code into DLLs and deploys them to the respective environment.

{% hint style="info" %}
In Umbraco Cloud, only C# code is built. This means that all frontend artifacts need to be built before they are committed to the repository.
{% endhint %}

You can use Azure DevOps as an external repository, and with the pipelines, it will automatically keep your Azure DevOps source code repository in sync. The sync is done with the git repository of the left-most Umbraco Cloud environment.

![UmbracoCloud CI/CD sample pipeline](../../../../.gitbook/assets/UmbracoCloudCicdSample.png)

## Setting Up an Umbraco Cloud Project

Before proceeding, you'll need an Umbraco Cloud project and a CI/CD pipeline. You will also need the required files to add to your pipeline for successful interaction with the Umbraco Cloud API.

1. Pick an Umbraco Cloud project, preferably with more than one environment (but not a requirement).
  * Create a new Umbraco Cloud Project.
    * You can take a [trial here](https://try.umbraco.com/cloud?utm_source=github.com\&utm_medium=referral\&utm_campaign=).
    * [Create a new project](https://www.s1.umbraco.io/createproject) in the Umbraco Cloud Portal.
  * Use one of your [existing projects](https://www.s1.umbraco.io/projects).

2. Create a new or an existing CI/CD pipeline in [Azure DevOps](https://learn.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops\&tabs=browser) or [GitHub Actions](https://github.com/features/actions).

{% hint style="info" %}
In this guide, deployments target the left-most environment in your Umbraco Cloud setup. This means if you have more than one environment, the left-most environment will automatically be selected for deployment. If only a single environment exists, this environment will be used.
{% endhint %}

## Obtaining the Project ID and API Key

To get started with API interactions, you'll need to obtain your Project ID and API key. If you haven't already enabled the CI/CD feature, follow these steps:

1. Navigate to the [Umbraco Cloud Portal](https://www.s1.umbraco.io/projects) and select your project.
2. Go to `Configuration` -> `CI/CD Flow`. This is where you can generate an API key and find your Project ID.

![CI/CD Flow page](../../../../.gitbook/assets/cicd-flow-page.png)

3. Toggle "Activate CI/CD Flow" to enable the feature.

<figure><img src="../../../../.gitbook/assets/UC-advanced-CICD.png" alt=""><figcaption><p>"Umbraco CI/CD Flow" section on the Advanced page.</p></figcaption></figure>

{% hint style="warning" %}
The API key is tied to the specific project for which it is generated. Ensure to keep it secure in Azure or GitHub, as it will be used for all subsequent API interactions related to that project.
{% endhint %}

## Getting environment aliases to target

With the feature enabled, a button called "CI/CD Environment Targets" becomes available. Clicking the button opens a modal with your environments and their aliases.

Next to the environment alias is a button you can click to copy the alias.

<figure><img src="../../../../.gitbook/assets/cicd-target-environments.webp" alt=""><figcaption><p>"Umbraco CI/CD Flow" section on the Advanced page.</p></figcaption></figure>

{% hint style="info" %}
If the alias is greyed out, it is currently not a valid target through the Umbraco CI/CD flow API.

Currently, flexible environments and the left-most environment are considered valid targets.

The impact of allowing CI/CD deployments to all environments is being investigated.
{% endhint %}

## Sample pipelines

Below are a couple of examples on how to set up a CI/CD Pipeline using either Azure DevOps or GitHub Actions.

Each guide describes:

* How to set up a new repository in either GitHub or Azure DevOps.
* How to get a copy of your Umbraco Cloud project into that repository.
* How to configure a new pipeline using the provided samples.

The sample pipelines use either Bash or PowerShell scripts to facilitate communication with the Umbraco CI/CD API.

{% hint style="info" %}
During the guides, you will have the option to choose between PowerShell or Bash scripts. You can select the scripting technology you feel most comfortable with.
{% endhint %}

### Azure DevOps sample

Covers setting up a CI/CD pipeline using Azure DevOps.

* [Azure DevOps Sample](azure-devops.md)

### GitHub Actions sample

Covers setting up a CI/CD pipeline using GitHub Actions.

* [GitHub Actions Sample](github-actions.md)

## Samples for version 1

If you are using version 1 endpoints, use the guides referenced below:

* [Azure DevOps Sample](azure-devops-v1.md)
* [GitHub Actions Sample](github-actions-v1.md)

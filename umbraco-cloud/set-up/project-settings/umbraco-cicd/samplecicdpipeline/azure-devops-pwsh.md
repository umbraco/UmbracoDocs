---
description: >-
  This section provides a step-by-step guide to setting up a CI/CD pipeline in
  Azure DevOps using the provided sample Powershell scripts.
---

# Azure DevOps with Powershell scripts

Before setting up the pipeline in Azure DevOps, make sure that the steps in the [Configuring a CI/CD pipeline](./) are done.

You will need to define your pipeline in YAML, and find a way to interact with the Umbraco Cloud Api.


{% hint style="info" %}
We have created a sample pipeline for Azure DevOps.  It includes YAML-files and custom Powershell scripts to interact with the Umbraco Cloud API.

You can get the samples for Azure DevOps and GitHub from this [repository](https://github.com/umbraco/Umbraco.Cloud.CICDFlow.Samples).

For Azure DevOps you will need the following files:
- From the root folder
  - `cloud.zipignore`
- From `powershell` folder
  - `Get-LatestDeployment.ps1`
  - `Get-ChangesById.ps1`
  - `New-Deployment.ps1`
  - `Add-DeploymentPackage.ps1`
  - `Start-Deployment.ps1`
  - `Test-DeploymentStatus.ps1`
- From the `powershell/azuredevops` folder
  - `azure-release-pipeline.yml`
  - `cloud-sync.yml` 
  - `cloud-deployment.yml`

{% endhint %}

## Import Cloud project repository to Azure DevOps
Go to your repositories in Azure DevOps and click on "Create a repository".

- Create a new empty repository (don't add a README and don't add a .gitignore), and note down the clone URL.
- Go to the Umbraco Cloud Portal and clone your cloud project down locally. [This article](../../../working-locally.md#cloning-an-umbraco-cloud-project) describes how you can find the clone URL.
- Now working locally remove the Git Remote called `origin`, which currently points to Umbraco Cloud

 ```sh 
 git remote remove origin
 ```

- Optionally rename branch `master` to `main`

 ```sh 
 # optional step
 git branch -m  main
 git symbolic-ref HEAD refs/heads/main
 ```

- Add a new remote called origin and pointing to the Azure DevOps clone URL and push

 ```sh 
 git remote add origin https://{your-organization}@dev.azure.com/{your-organization}/{azure-project-scope}/_git/{your-repository}
 git push -u origin --all
 ```

Now we can move on to setting up a pipeline.

## Set up the Azure DevOps pipeline files

While working with the project on you local machine, do the following to prepare the pipeline.
- Copy the `cloud.zipignore` file to the root of your repository
- Make a copy of the `.gitignore` and call it `cloud.gitignore`
  - Both files should be in the root of your repository
- Also in the root, create a folder called `devops`
- Copy the 3 YAML files into the `devops` folder
- Inside `devops` create an additional folder called `powershell`
- Copy the Powershell scripts to the `powershell` folder
- Commit the all changes, and push to Azure DevOps

## Configure Azure DevOps

The pipeline needs to know which Umbraco Cloud project to deploy to. In order to do this you will need the `Project ID` and the `API Key`. [This article](README.md#obtaining-the-project-id-and-api-key) describes how to get those values.

- Now go to the repository in Azure and click on "Set up build".

<figure><img src="../../../../.gitbook/assets/azuresetupbuild.png" alt=""><figcaption><p>Azure DevOps Repository</p></figcaption></figure>

- On the next screen click on "Existing Azure Pipelines YAML file"

<figure><img src="../../../images/Pipeline3.png" alt=""><figcaption><p>Configure pipeline with existing YAML file</p></figcaption></figure>


- Select `main` (or `master` if you did not change the branch name) in Branch
- Select `/devops/azure-release-pipeline.yaml` in Path and continue

<figure><img src="../../../images/Pipeline4.png" alt=""><figcaption><p>Select Branch and Path</p></figcaption></figure>


- Now you are on the "Review your pipeline YAML" screen
  - Replace the `##Your project Id here##` with the Project Id you got from Umbraco Cloud Portal
  - Click on "Variables"
  - Add the variable `umbracoCloudApiKey` with the value of the API Key you got from Umbraco Cloud Portal




{% hint style="info" %}
If you want to use other names for the variable, you need to rename the affected variables in `azure-release-pipeline.yaml`.

{% endhint %}

When you click on "Run" your first deployment will be triggered. Which means that Azure DevOps is set up with all the needed information to be able to deploy your Cloud project back to Umbraco Cloud.

## High level overview of the pipeline components

The mentioned scripts are provided as a starting point. It is recommended that you familiarize yourself with the scripts and with documentation related to how to use Azure DevOps.

The scripts demonstrates the following:
 - How to sync your Azure DevOps repository with the left-most project environment in Umbraco Cloud
 - How to deploy changes to the left-most project environment in Umbraco Cloud 

### Main

The `azure-release-pipeline.yaml` is the main pipeline, and is the one that will be triggered on a push to `main` branch.
You can configure a different trigger behavior in this file.

You can add your Build and Test stage between the `cloudSyncStage` and `cloudDeploymentStage` stages. 
Keep in mind that you do not need to retain the dotnet build artifact for upload later. The `cloudDeploymentStage` job will take care of packaging all your source code and upload to Umbraco Cloud. 

### Cloud-sync

The `cloud-sync.yml` shows how you can sync your Azure DevOps repository with the left-most environment of your Cloud project.
In this sample, it accepts any change from the api and applies and commits it back to the branch which triggered the pipeline. However the commit does not trigger the pipeline again.

If you don't want the pipeline to commit back to the triggering branch, this is where you need to change the pipeline. 

### Cloud-deployment

The `cloud-deployment.yml` shows how you can deploy your repository to the left-most environment of your Cloud project.
The sample shows how to prepare for deployment, request the deployment and wait for cloud to finish.

There are a couple of things here to be aware of:
- We are overwriting the `.gitignore` with the `cloud.gitignore`.
  This is a way to accommodate your gitignore-needs when working locally. For instance you might want to ignore frontend builds, but you want them build and published to cloud.  
- We have a special `cloud.zipignore`.
  This is a convenient way to tell the pipeline which files **not** to include when creating the zip package to send to cloud.

If you have frontend assets that needs to be built (using tools like npm/yarn or others), you should add the needed steps before `Zip Source Code`. This is to ensure that the fresh frontend assets will be part of the package to be sent to Umbraco Cloud. 

## Further information
- [Azure Pipelines Documentation](https://learn.microsoft.com/en-us/azure/devops/pipelines/)
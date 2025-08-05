---
description: >-
  This section provides a step-by-step guide to setting up a CI/CD pipeline in
  GitHub Actions using the provided sample Bash or Powershell scripts.
---

# GitHub Actions

Before setting up the pipeline in GitHub, make sure that the following steps from the [Configuring a CI/CD pipeline](./) are done:

* Pick a Cloud project
* Activate CI/CD Flow

Next, you will need to define your pipeline in YAML and use it to interact with the Umbraco Cloud API.

{% hint style="info" %}
Are you using version 1? Follow the [guide for GitHub Actions version 1](github-actions-v1.md).
{% endhint %}

{% hint style="info" %}
The Umbraco CI/CD Team has created a sample pipeline for GitHub Actions.

The Scripts are provided as is. This means that the scripts will do the bare minimum for a pipeline that is utilizing the CI/CD flow.

You'll need to adapt and integrate the script into your own pipelines to gain the ability to do deployments to your Umbraco Cloud projects.

The sample includes YAML-files and custom Powershell and Bash scripts to interact with the Umbraco Cloud API.

You can get the samples for both `Azure DevOps` and `GitHub Actions` from the [GitHub repository](https://github.com/umbraco/Umbraco.Cloud.CICDFlow.Samples).

Samples that target the endpoints described here are located in the V2 folder.
{% endhint %}

{% hint style="warning" %}
Please be aware that since this involves using your custom pipeline, any issues that arise will need to be resolved by you.
{% endhint %}

## Import Cloud project repository to GitHub

Go to your repositories in GitHub and click on "New".

* Create a new empty repository, and note down the clone URL.
* Go to the Umbraco Cloud Portal and clone your cloud project down locally. [This article](../../working-locally/#cloning-an-umbraco-cloud-project) describes how you can find the clone URL.
* Now working locally remove the Git Remote called `origin`, which points to Umbraco Cloud

```sh
git remote remove origin
```

* Optionally rename branch `master` to `main`

```sh
# optional step
git branch -m  main
git symbolic-ref HEAD refs/heads/main
```

* Add a new remote called origin and pointing to the GitHub clone URL and push

```sh
git remote add origin https://github.com/{your-organization}/{your-repository}.git
git push -u origin --all
```

Now we can move on to setting up a pipeline.

## Set up GitHub repository variables

The pipeline needs to know which Umbraco Cloud project to deploy to. In order to do this you will need the `Project ID` and the `API Key`. [This article](./#obtaining-the-project-id-and-api-key) describes how to get those values.

You will also need the alias of the environment you want to target. [This article](./#getting-environment-aliases-to-target) described how you can see a list of environments you can target here. Note the environment alias you want to target.

* Now go to the repository in GitHub, and click on the Settings section.
* Expand secrets and variables in the left-hand menu titled `Security` and click on `Actions`.

<figure><img src="../../../../.gitbook/assets/image (6) (1) (1) (1).png" alt=""><figcaption><p>Security and Actions menu GitHub</p></figcaption></figure>

* Create a `repository secret` called `UMBRACO_CLOUD_API_KEY` with the `API Key` value from the Umbraco Portal.
* Create another `repository secret` with the name `PROJECT_ID` and the `Project ID` value from the Umbraco Portal.

Now go to the **Variables** tab

* Create a `repository variable` called `TARGET_ENVIRONMENT_ALIAS` and enter the environment alias you selected earlier.

{% hint style="info" %}
If you want to use other names for the secrets and variables, you need to rename the `secrets` and `with` variables in each of `main.yml`'s jobs.

```yaml
jobs:
  cloud-sync:
    uses: ./.github/workflows/cloud-sync.yml
    secrets:
      projectId: ${{ secrets.PROJECT_ID }} # change the part inside the curly braces
      umbracoCloudApiKey: ${{ secrets.UMBRACO_CLOUD_API_KEY }} # change the part inside the curly braces
    with:
      targetEnvironmentAlias: ${{ vars.TARGET_ENVIRONMENT_ALIAS }} # change the part inside the curly braces

  cloud-artifact:
    uses: ./.github/workflows/cloud-artifact.yml
    secrets:
      projectId: ${{ secrets.PROJECT_ID }} # change the part inside the curly braces
      umbracoCloudApiKey: ${{ secrets.UMBRACO_CLOUD_API_KEY }} # change the part inside the curly braces

  cloud-deployment:
    needs: cloud-sync
    uses: ./.github/workflows/cloud-deployment.yml
    secrets:
      projectId: ${{ secrets.PROJECT_ID }} # change the part inside the curly braces
      umbracoCloudApiKey: ${{ secrets.UMBRACO_CLOUD_API_KEY }} # change the part inside the curly braces
    with:
      targetEnvironmentAlias: ${{ vars.TARGET_ENVIRONMENT_ALIAS }} # change the part inside the curly braces
```
{% endhint %}

Now GitHub is set up with the needed information to be able to run a deployment back to Umbraco Cloud.

Next up it setting up the actual pipeline.

### Allow GitHub to commit to your repository

The sample pipelines have a job called `cloud-sync`. This job is responsible for checking for changes in your Umbraco Cloud project, fetching them, and applying them back to your repository. In order for this to work, you need to give the `GITHUB_TOKEN` write permissions to the repository during workflow runs.

This is how you can grant these permissions:

* Working in your repository on `GitHub`, click on `Settings` in the top right
* In the left sidebar, click on `Actions` and then on `General`
* Scroll down to the `Workflow permissions` sections
* Select the `Read and write permissions`
* Click save

<figure><img src="../../../../.gitbook/assets/github-workflow-permissions.png" alt=""><figcaption><p>GitHub Workflow permissions</p></figcaption></figure>

## Set up the GitHub Actions pipeline

While working with the project on your local machine, follow these steps to prepare the pipeline, using the [samples from the repository](https://github.com/umbraco/Umbraco.Cloud.CICDFlow.Samples).

{% hint style="info" %}
Download the provided sample scripts as ZIP from the [GitHub repository](https://github.com/umbraco/Umbraco.Cloud.CICDFlow.Samples/). Click on "Code" and then choose "Download ZIP". Then unzip it and use the appropriate files from the V2 folder for the next steps.
{% endhint %}

Select your preferred scripting language:

{% tabs %}
{% tab title="Powershell" %}
For a pipeline that uses Powershell scripts you will need the following files:

* From the root folder
  * `cloud.zipignore`
* From the `powershell` folder
  * `Get-LatestDeployment.ps1`
  * `Get-ChangesById.ps1`
  * `Apply-Patch.ps1`
  * `Add-DeploymentArtifact.ps1`
  * `Start-Deployment.ps1`
  * `Test-DeploymentStatus.ps1`
* From the `powershell/github` folder
  * `main.yml`
  * `cloud-sync.yml`
  * `cloud-artifact.yml`
  * `cloud-deployment.yml`

**Do the following to prepare the pipeline:**

* Copy the `cloud.zipignore` file to the root of your repository
* Make a copy of the `.gitignore` from your repository and call the copy `cloud.gitignore`
  * Both files should be in the root of your repository
  * In the bottom of the `.gitignore` file add the line `**/git-patch.diff`
* Also in the root, create a folder called `.github`
* Inside `.github` create two additional folders
  * `workflows`
  * `powershell`
* Copy the 4 YAML files from the `github` folder into the `workflows` folder
* Copy the Powershell scripts from the `powershell` folder to the `powershell` folder
* **Note**: If you have not changed the branch to `main`, then in the `main.yml` file change the branch from `main`to `master.`
* Commit the all changes, and push to GitHub
{% endtab %}

{% tab title="Bash" %}
For a pipeline that uses Bash scripts you will need the following files:

* From the root folder
  * `cloud.zipignore`
* From the `bash` folder
  * `get_latest_deployment.sh`
  * `get_changes_by_id.sh`
  * `apply-patch.sh`
  * `upload_artifact.sh`
  * `start_deployment.sh`
  * `get_deployment_status.sh`
* From the `bash/github` folder
  * `main.yml`
  * `cloud-sync.yml`
  * `cloud-artifact.yml`
  * `cloud-deployment.yml`

**Do the following to prepare the pipeline:**

* Copy the `cloud.zipignore` file to the root of your repository
* Make a copy of the `.gitignore` from your repository and call the copy `cloud.gitignore`
  * Both files should be in the root of your repository
  * In the bottom of the `.gitignore` file add the line `**/git-patch.diff`
* Also in the root, create a folder called `.github`
* Inside `.github` create two additional folders
  * `workflows`
  * `scripts`
* Copy the 4 YAML files from the `github` folder into the `workflows` folder
* Copy the Bash scripts from the `bash` folder to the `scripts` folder
* **Note**: If you have not changed the branch to `main`, then in the `main.yml` file change the branch from `main`to `master.`
* Commit the all changes, and push to GitHub
{% endtab %}
{% endtabs %}

The push will start a new pipeline run.

### Optional: Test the pipeline

With everything set up, you may want to confirm that Umbraco Cloud reflects the changes you are sending via your pipeline.

While working on your project locally, add a new Document type.

* Commit the change to `main` branch (or `master` if you did not change the branch name) and push to your repository.
* The pipeline starts to run
* Once the pipeline is done log into Backoffice on your left-most environment in Umbraco Cloud
* Go to the Settings section and see that your new Document type has been deployed

## High level overview of the pipeline components

The mentioned scripts are provided as a starting point.\
It is recommended that you familiarize yourself with the scripts and with documentation related to how to use GitHub Actions.

The scripts demonstrates the following:

* How to sync your GitHub repository with an environment in Umbraco Cloud via the environment alias
* How to prepare and upload an artifact that can be used for a deployment
* How to deploy changes to an environment in Umbraco Cloud, targeted via the environment alias

### Main

The `main.yml` is the main pipeline, and is the one that will be triggered on a push to `main` branch. You can configure a different trigger behavior in this file.

You can add your Build and Test jobs between the `cloud-sync` and `cloud-artifact` jobs. Keep in mind that you do not need to retain the dotnet build artifact for upload later. The `cloud-artifact` job will take care of packaging all your source code and upload to Umbraco Cloud.

Make sure that you checkout the potentially updated code if you add Build and Test steps.

### Cloud-sync

The `cloud-sync.yml` shows how you can sync your GitHub repository with the targeted environment of your Cloud project. In this sample, it accepts any change from the API and applies and commits it back to the branch which triggered the pipeline. However the commit does not trigger the pipeline again.

If you don't want the pipeline to commit back to the triggering branch, this is where you need to change the pipeline.

### Cloud-artifact

The `cloud-artifact.yml` shows how you can prepare and package an artifact and finally upload it to Umbraco Cloud.

There are a couple of things here to be aware of:

* The sample is overwriting the `.gitignore` file with `cloud.gitignore`. This is a way to accommodate your gitignore-needs when working locally. For instance you might want to ignore frontend builds, but you want them build and published to cloud.
* The sample contains a special `cloud.zipignore` file. This is a convenient way to tell the pipeline which files **not** to include when creating the zip package to send to cloud.

If you want to customize the artifact take a look at [Artifact Best Practice](../../../../set-up/project-settings/umbraco-cicd/artifact-best-practice.md).

### Cloud-deployment

The `cloud-deployment.yml` shows how you can deploy to a named environment of your Cloud project. The sample shows how to request the deployment and wait for cloud to finish the operation.

{% hint style="info" %}
If you have frontend assets that needs to be built (using tools like npm/yarn or others), you should add the needed steps before `cloud-artifact`. This is to ensure that the fresh frontend assets will be part of the package to be sent to Umbraco Cloud.
{% endhint %}

## Next step

Please follow the above guide first.

* [Deploy to multiple targets](advanced-multiple-targets.md)

## Further information

* [GitHub Actions Documentation](https://docs.github.com/en/actions)

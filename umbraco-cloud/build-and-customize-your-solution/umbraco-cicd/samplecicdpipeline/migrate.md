# Migrate from version 1 to version 2

The original flow has been improved based on the feedback received from users of the feature.

This article covers how to migrate from version 1 samples to version 2. 

{% hint style="info" %}
Be advised that both scripts and pipeline files have changes.

Familiarize yourself with the new samples.

If you customized the flow or the version 1 scripts, take extra care to incorporate your changes. 
{% endhint %}

You can keep using the old endpoints and samples, but you will miss out on the enhancements. There are currently no plans to deprecate the version 1 endpoints.

## What has changed?

The biggest enhancement is the ability to target different environments. You can now target the flexible and the leftmost mainline environment.

The new endpoints are created to accommodate this enhancement, meaning you will have to supply a target environment alias in some requests.

The initial flow has been slightly changed. The upload of a deployment package is no longer tied to a "deployment-meta", but is now a separate step. Every uploaded artifact can be queried by the API, similar to querying deployments via the API. 

When you request a deployment, you now also need to supply an `artifactId`. More options are available when deploying.

To showcase how to use the version 2 endpoints and flow, updated samples are provided.  

## Migrate Azure DevOps

Start by deleting the scripts and YAML files you initially got from the CI/CD samples:

- Delete the YAML:
  - `azure-release-pipeline.yaml`
  - `cloud-sync.yml`
  - `cloud-deployment.yml`

You probably only have either PowerShell or Bash.

- PowerShell files to delete:
  - `Add-DeploymentPackage.ps1`
  - `Apply-Patch.ps1`
  - `Get-ChangesById.ps1`
  - `Get-LatestDeployment.ps1`
  - `New-Deployment.ps1`
  - `Start-Deployment.ps1`
  - `Test-Deployment.ps1`
- Bash files to delete:
  - `apply_patch.sh`
  - `create_deployment.sh`
  - `get_changes_by_id.sh`
  - `get_deployment_status.sh`
  - `get_latest_deployment.sh`
  - `start_deployment.sh`
  - `upload_package.sh`

Copy the scripts from the sample repository's version 2 folder to the corresponding folder in your repo:

- If you prefer PowerShell:
  - All `.ps1` files in `V2/powershell` should be copied to `devops/powershell`
  - All `.yaml/.yml` files in `V2/powershell/azuredevops` should be copied to `devops` 
- If you prefer Bash:
  - All `.sh` files in `V2/bash` should be copied to `devops/scripts`
  - All `.yaml/.yml` files in `V2/bash/azuredevops` should be copied to `devops` 

Now you need some important values: Project ID and Target environment alias.

- [How to get the project id](./README.md#obtaining-the-project-id-and-api-key) 
- [How to get the environment alias](./README.md#getting-environment-aliases-to-target)

Open the `azure-release-pipeline.yaml` in your favorite editor. 

Replace `##Your project Id here##` with the project ID and the value `##Your target environment alias here#` with the environment alias. 

You can use any of the available aliases, but to get similar functionality as before, select the environment described as `Leftmost mainline`.

## Migrate GitHub

Start by deleting the scripts and YAML files you initially got from the CI/CD samples:

- Delete the YAML:
  - `main.yml`
  - `cloud-sync.yml`
  - `cloud-deployment.yml`

You probably only have either PowerShell or Bash.

- PowerShell files to delete:
  - `Add-DeploymentPackage.ps1`
  - `Apply-Patch.ps1`
  - `Get-ChangesById.ps1`
  - `Get-LatestDeployment.ps1`
  - `New-Deployment.ps1`
  - `Start-Deployment.ps1`
  - `Test-Deployment.ps1`
- Bash files to delete:
  - `apply_patch.sh`
  - `create_deployment.sh`
  - `get_changes_by_id.sh`
  - `get_deployment_status.sh`
  - `get_latest_deployment.sh`
  - `start_deployment.sh`
  - `upload_package.sh`

Now copy the scripts from the sample repository's V2 folder to the corresponding folder in you repo:

- If you prefer PowerShell:
  - All `.ps1` files in `V2/powershell` should be copied to `.github/powershell`
  - All `.yaml/.yml` files in `V2/powershell/github` should be copied to `.github/workflows` 
- If you prefer Bash:
  - All `.sh` files in `V2/bash` should be copied to `.github/scripts`
  - All `.yaml/.yml` files in `V2/bash/github` should be copied to `.github/workflows` 

Now we need one important value: Target environment alias.

- [This section](./README.md#getting-environment-aliases-to-target) explains how to get the environment alias.

Go to your GitHub repository and enter the `Settings` section.

- On the left side menu, find the `Security` section and click on `Actions`.
- Click on the tab `Variables`.
- Click on `New repository variable`.
  - Call the variable `TARGET_ENVIRONMENT_ALIAS`.
  - Use the environment alias as a value.
- Click on `Add variable`.

You can use any of the available aliases, but to get similar functionality as before, select the environment described as `Leftmost mainline`.

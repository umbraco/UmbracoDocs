---
description: Learn how to migrate your CI/CD setup from version 1 to version 2.
---

# Migrate from V1 to V2

{% hint style="info" %}
Scripts and pipeline files have changes.

Familiarize yourself with the new samples.

If you customized the flow or the version 1 scripts, take extra care to incorporate your changes.
{% endhint %}

## What has changed in version 2?

While you can continue to use the version 1 endpoints, the version 2 endpoints contain improvements that enhance the CI/CD feature. Follow the migration guide below to start reaping the full benefits of this workflow.

The biggest enhancement is the **ability to target different environments**. You can target both the flexible and the left-most mainline environment.

The new endpoints are created to accommodate this enhancement, meaning you will have to supply a target environment alias in some requests.

The initial flow has been slightly changed. Uploading a deployment package is no longer tied to "deployment-meta" and is now a separate step. Every uploaded artifact can be queried in the API. This works similarly to querying deployments via the API.

When you request a deployment, you now also need to supply an `artifactId`. Additionally, more options are available when deploying.

Updated samples are provided to showcase how to use the version 2 endpoints and flow.

## Migrate Azure DevOps

Follow the migration steps below if you are using Azure DevOps.

1. Delete the scripts and YAML files you initially got from the CI/CD samples:

| YAML files                    | PowerShell files            | Bash files                 |
| ----------------------------- | --------------------------- | -------------------------- |
| `azure-release-pipeline.yaml` | `Add-DeploymentPackage.ps1` | `apply_patch.sh`           |
| `cloud-sync.yml`              | `Apply-Patch.ps1`           | `create_deployment.sh`     |
| `cloud-deployment.yml`        | `Get-ChangesById.ps1`       | `get_changes_by_id.sh`     |
|                               | `Get-LatestDeployment.ps1`  | `get_deployment_status.sh` |
|                               | `New-Deployment.ps1`        | `get_latest_deployment.sh` |
|                               | `Start-Deployment.ps1`      | `start_deployment.sh`      |
|                               | `Test-Deployment.ps1`       | `upload_package.sh`        |

2. Copy the scripts from the sample repository's [V2 folder](https://github.com/umbraco/Umbraco.Cloud.CICDFlow.Samples/tree/main/V2) to the corresponding folder in your repository:

**PowerShell files**:

| File Type    | Sample location             | Move to                 |
| ------------ | --------------------------- | ----------------------- |
| `.ps1`       | `V2/powershell`             | **`devops/powershell`** |
| `.yaml/.yml` | `V2/powershell/azuredevops` | **`devops`**            |

**Bash files**:

| File Type    | Sample location       | Move to              |
| ------------ | --------------------- | -------------------- |
| `.sh`        | `V2/bash`             | **`devops/scripts`** |
| `.yaml/.yml` | `V2/bash/azuredevops` | **`devops`**         |

3. Fetch the following values from your Cloud project: Project ID and Target environment alias.
   1. [How to get the project id](./#obtaining-the-project-id-and-api-key)
   2. [How to get the environment alias](./#getting-environment-aliases-to-target)
4. Open `azure-release-pipeline.yaml` in your favorite editor.
5. Replace `##Your project Id here##` with the project ID.
6. Replace `##Your target environment alias here#` with the environment alias.

You can use any of the available aliases, but to get similar functionality as before, select the environment described as `Leftmost mainline`.

## Migrate GitHub

Follow the migration steps below if you are using GitHub.

1. Delete the scripts and YAML files you initially got from the CI/CD samples:

| YAML files             | PowerShell files            | Bash files                 |
| ---------------------- | --------------------------- | -------------------------- |
| `main.yml`             | `Add-DeploymentPackage.ps1` | `apply_patch.sh`           |
| `cloud-sync.yml`       | `Apply-Patch.ps1`           | `create_deployment.sh`     |
| `cloud-deployment.yml` | `Get-ChangesById.ps1`       | `get_changes_by_id.sh`     |
|                        | `Get-LatestDeployment.ps1`  | `get_deployment_status.sh` |
|                        | `New-Deployment.ps1`        | `get_latest_deployment.sh` |
|                        | `Start-Deployment.ps1`      | `start_deployment.sh`      |
|                        | `Test-Deployment.ps1`       | `upload_package.sh`        |

2. Copy the scripts from the sample repository's [V2 folder](https://github.com/umbraco/Umbraco.Cloud.CICDFlow.Samples/tree/main/V2) to the corresponding folder in your repository:

**PowerShell files**:

| File Type    | Sample location        | Move to                  |
| ------------ | ---------------------- | ------------------------ |
| `.ps1`       | `V2/powershell`        | **`.github/powershell`** |
| `.yaml/.yml` | `V2/powershell/github` | **`.github/workflows`**  |

**Bash files**:

| File Type    | Sample location  | Move to                 |
| ------------ | ---------------- | ----------------------- |
| `.sh`        | `V2/bash`        | **`.github/scripts`**   |
| `.yaml/.yml` | `V2/bash/github` | **`.github/workflows`** |

3. Fetch the Target environment alias from the Cloud project.
   1. The [Getting environment aliases to target](./#getting-environment-aliases-to-target) section explains how to get the environment alias.
4. Go to your GitHub repository and enter the `Settings` section.
5. Locate the `Security` section in the left-side menu and click on `Actions`.
6. Click on the tab `Variables`.
7. Click on `New repository variable`.
8. Call the variable `TARGET_ENVIRONMENT_ALIAS`.
9. Use the environment alias as a value.
10. Click on `Add variable`.

You can use any of the available aliases, but to get similar functionality as before, select the environment described as `Left-most mainline`.

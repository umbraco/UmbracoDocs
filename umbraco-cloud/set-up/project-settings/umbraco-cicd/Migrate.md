# Migrate from V1 to V2
We wanted to improve on the original flow based on all the feedback received from users of the feature.

Here we will go through how to migrate from V1 samples to V2 samples. 

{% hint style="info" %}
Be advised that both scripts and pipeline files have changes.

Familiarize you self with the new samples.

If you customized the flow or the V1 scripts please take extra care to incorporate your changes. 
{% endhint %}

You keep using the old endpoints and samples, but you will miss out on the enhancements.  We currently don't have any plans to deprecate the V1 endpoints.

## What has changed?
The biggest enhancement is the ability to target different environments. You are now able to target the flexible and the leftmost mainline environment. 
We have created new endpoints to accommodate this enhancement, meaning you will have to supply a target environment alias in some requests.

Also the initial flow has been slightly changed. The upload of a deployment package is no longer tied to a "deployment-meta", but rather is a completely separate step. Every uploaded artifact can be queried by the api, similar to querying deployments via the api. 

When you request a deployment you now also need to supply an artifactId. Also more options are available when deploying.

To showcase how to use the new V2 endpoints and flow, we have created some updated samples.  

# Migrate Azure DevOps
Start by deleting the scripts and yaml files you initially got from the CICD samples:
- Delete the Yaml/yml:
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

Now copy the scripts from the sample repositorys V2 folder to the corresponding folder in you repo:
- If you prefer PowerShell:
  - All .ps1 files in `V2/powershell` should be copied to `devops/powershell`
  - All .yaml/.yml in `V2/powershell/azuredevops` should be copied to `devops` 
- If you prefer Bash:
  - All .sh files in `V2/bash` should be copied to `devops/scripts`
  - All .yaml/.yml in `V2/bash/azuredevops` should be copied to `devops` 

Now we need some important values: Project id and Target environment alias.
- [This section](./samplecicdpipeline/README.md#obtaining-the-project-id-and-api-key) explains how to get the project id. 
- [This section](./samplecicdpipeline/README.md#getting-environment-aliases-to-target) explains how to get the environment alias.

Now open the `azure-release-pipeline.yaml` in your favorite editor. 
You need to replace `##Your project Id here##` with the project Id and the value `##Your target environment alias here#` with the environment alias. 

You can use any of the available aliases, but to get similar functionality as before you should select the environment described as `Leftmost mainline`.

# GitHub
---
description: Learn how to use the deployment options available with the version 2 endpoints for CI/CD.
---

# Advanced Setup: Deployment options

This provides control over the CI/CD deployment process within the isolated instance before your code is pushed to the Cloud environment.

## Skip preserve Umbraco-Cloud.json 
The umbraco-cloud.json file is controlled by the Umbraco Cloud platform. It hold a description of the environment relationships used for content deployments. The configuration needed to be able to log in to the backoffice locally with Umbraco ID is also part of this file. The CI/CD Flow deployment system makes sure that the current JSON file on the cloud environment is preserved.

In edge cases users could have the need to supply their own umbraco-cloud.json to the system and overwrite the one on cloud. 

Enabling the `skipPreserveUmbracoCloudJson` option will allow user to overwrite the umbraco-cloud.json through CI/CD Flow.

{% hint style="warning" %}
We recommend that you do not edit or add values to the umbraco-cloud.json file. You should use the appropriate appSettings.*.json file or add secrets through the Secrets Management page in the Cloud Portal.
The cloud platform uses umbraco-clous.json to update environment relationships when adding or removing environments.
{% endhint %}

## Skip version checks

During deployment, the system automatically checks for downgrades of Cloud dependencies. This prevents accidental downgrades of packages that may have been automatically upgraded on Umbraco Cloud.

Enabling the `skipVersionCheck` option will allow deployments that include downgraded packages. 

{% hint style="info" %}
This option increases risk and is not recommended for normal workflows. Do not skip the version checks unless you understand the package differences and accept the potential consequences.
{% endhint %}

## Skip build and restore steps

The Umbraco CI/CD flow runs the deployment in an isolated instance and performs `dotnet restore` and `dotnet build` to catch obvious build issues before deploying to the Cloud.

Enabling the `noBuildAndRestore` option skips the restore and build steps in that isolated instance, which can shorten deployment time by a few minutes.

Keep in mind that the final Kudu deployment on the Cloud environment will still run **restore**, **build**, and **publish**; those steps cannot be skipped.

## Disable schema extraction

When deploying schema changes to environments beyond "left-most", the CI/CD Flow deployment system will automatically run a schema extraction. 

Setting `runSchemaExtration` to false, will result in the system not automatically running the schema extraction on the environment. Schema extraction can still be triggered from the backoffice.

{% hint style="info" %}
This setting doesn't have any effect on the `left-most environment`. 
{% endhint %}

## How to enable the options

While pipeline scripts follow the same structure, there are a few small details to be aware of.

{% tabs %}
{% tab title="Azure DevOps Bash" %}
Locate the main entry pipeline file. It will usually be this one: `azure-release-pipeline.yaml`.

```yml
  # Deploy to Umbraco Cloud
  # ####
  # you can edit the variables noBuildAndRestore and skipVersionCheck    
  # use booleans but as strings
  - stage: CloudDeploymentStage
    displayName: Deploy To Cloud
    dependsOn: cloudPrepareArtifact
    condition: in(dependencies.cloudPrepareArtifact.result, 'Succeeded')
    variables:
      artifactId: $[ stageDependencies.cloudPrepareArtifact.PrepareAndUploadArtifact.outputs['uploadArtifact.artifactId'] ]
    jobs: 
      - template: cloud-deployment.yml
        parameters:
          artifactId: $(artifactId)
          skipPreserveUmbracoCloudJson: 'false'
          noBuildAndRestore: 'false'
          skipVersionCheck: 'false'
          runSchemaExtration: 'true'
```

The `noBuildAndRestore` and `skipVersionCheck` options can be enabled by changing the value to `true`. 

{% endtab %}
{% tab title="Azure DevOps PowerShell" %}
Locate the main entry pipeline file. It will usually be this one: `azure-release-pipeline.yaml`.

```yml
  # Deploy to Umbraco Cloud
  # ####
  # you can edit the variables noBuildAndRestore and skipVersionCheck    
  # use booleans
  - stage: CloudDeploymentStage
    displayName: Deploy To Cloud
    dependsOn: cloudPrepareArtifact
    condition: in(dependencies.cloudPrepareArtifact.result, 'Succeeded')
    variables:
      artifactId: $[ stageDependencies.cloudPrepareArtifact.PrepareAndUploadArtifact.outputs['uploadArtifact.artifactId'] ]
    jobs: 
      - template: cloud-deployment.yml
        parameters:
          artifactId: $(artifactId)
          skipPreserveUmbracoCloudJson: false
          noBuildAndRestore: false
          skipVersionCheck: false
          runSchemaExtration: true
```

The `noBuildAndRestore` and `skipVersionCheck` options can be enabled by changing the value to `true`. 


{% endtab %}
{% tab title="GitHub Actions Bash" %}
Locate the main entry pipeline file. It will usually be this one: `main.yml`.

```yml
  # Deploy to Umbraco Cloud
  # ####
  # you can edit the variables noBuildAndRestore and skipVersionCheck    
  # use booleans but as strings
  cloud-deployment:
    name: "Deploy to Cloud"
    needs: cloud-artifact
    uses: ./.github/workflows/cloud-deployment.yml
    with:
      artifactId: ${{ needs.cloud-artifact.outputs.artifactId }}
      targetEnvironmentAlias: ${{ vars.TARGET_ENVIRONMENT_ALIAS }}
      skipPreserveUmbracoCloudJson: "false"
      noBuildAndRestore: "false"
      skipVersionCheck: "false"
      runSchemaExtration: "true"
    secrets:
      projectId: ${{ secrets.PROJECT_ID }}
      umbracoCloudApiKey: ${{ secrets.UMBRACO_CLOUD_API_KEY }}
```

The `noBuildAndRestore` and `skipVersionCheck` options can be enabled by changing the value to `true`. 

{% endtab %}
{% tab title="GitHub Actions PowerShell" %}
Locate the main entry pipeline file. It will usually be this one: `main.yml`.

```yml
  # Deploy to Umbraco Cloud
  # ####
  # you can edit the variables noBuildAndRestore and skipVersionCheck    
  # use 0 for false and 1 for true
  cloud-deployment:
    name: "Deploy to Cloud"
    needs: cloud-artifact
    uses: ./.github/workflows/cloud-deployment.yml
    with:
      artifactId: ${{ needs.cloud-artifact.outputs.artifactId }}
      targetEnvironmentAlias: ${{ vars.TARGET_ENVIRONMENT_ALIAS }}
      skipPreserveUmbracoCloudJson: 0
      noBuildAndRestore: 0
      skipVersionCheck: 0
      runSchemaExtration: 1
    secrets:
      projectId: ${{ secrets.PROJECT_ID }}
      umbracoCloudApiKey: ${{ secrets.UMBRACO_CLOUD_API_KEY }}
```

The `noBuildAndRestore` and `skipVersionCheck` options can be enabled by changing the value to `1`. 

{% endtab %}
{% endtabs %}

## Use the latest scripts

The sample scripts are updated to include these extra options. If you need to update, you do not have to update everything; only the following scripts have been updated:

| PowerShell files | Bash files |
|---|---|
| `Start-Deployment.ps1` | `start_deployment.sh`|

The following pipeline files are also updated. Remember to get the right files from either `V2/bash` or `V2/powershell` depending on what you are currently using.

| GitHub | Azure DevOps |
|---|---|
|`cloud-deployment.yml`| `cloud-deployment.yml` |
|`main.yml`| `azure-release-pipeline.yaml` |
|`main-more-targets.yml`| `azure-release-pipeline-more-targets.yaml` |
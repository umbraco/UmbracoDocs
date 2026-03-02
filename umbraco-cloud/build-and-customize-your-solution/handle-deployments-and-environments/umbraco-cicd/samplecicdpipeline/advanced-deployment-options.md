---
description: Learn how to use the deployment options available with the version 2 endpoints for CI/CD.
---

# Advanced Setup: Deployment options

This provides control over the CI/CD deployment process within the isolated instance before your code is pushed to the Cloud environment.

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
          noBuildAndRestore: 'false'
          skipVersionCheck: 'false'
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
          noBuildAndRestore: false
          skipVersionCheck: false

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
      noBuildAndRestore: "false"
      skipVersionCheck: "false"
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
      noBuildAndRestore: 0
      skipVersionCheck: 0
    secrets:
      projectId: ${{ secrets.PROJECT_ID }}
      umbracoCloudApiKey: ${{ secrets.UMBRACO_CLOUD_API_KEY }}
```

The `noBuildAndRestore` and `skipVersionCheck` options can be enabled by changing the value to `1`. 

{% endtab %}
{% endtabs %}

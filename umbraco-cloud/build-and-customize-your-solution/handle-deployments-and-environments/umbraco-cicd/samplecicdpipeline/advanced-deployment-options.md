# Advanced Setup: Deployment options

Here you will learn how to use the deployment options available with the v2 endpoints for CI/CD.

This provides some control to the CI/CD deployment process within the isolated instance before your code hits the website.

## Option: skipVersionCheck

When deploying, we will do an automatic check for Cloud dependency downgrades. This is to prevent customers from downgrading the packages that may have been autoupgraded in Umbraco Cloud, by accident. 

Enabling this option will skip that check and let any deployments with downgraded packages through. 

**This is generally not recommended**

## Option: noBuildAndRestore

 The Umbraco CI/CD Flow runs the deployment in an isolated instance before doing the actual deployment to cloud. In the isolated instance we will try to do a `Dotnet restore` and `Dotnet build` of the incoming solution. This is a safeguard to prevent CI/CD isolated instance from sending broken code to the Umbraco Cloud environment. 
 
 Enabling this option will skip the `restore` and `build` process in the isolated instance. This can shorten the deployment process with a couple of minutes. 
 
 Keep in mind that the final KUDU deployment on the actual website still runs it's own **Restore**, **Build** and **Publish**, which cannot be skipped. 

## How to enable the options

All the pipeline script generally follow the same structure. But there are some small details to be aware of.

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

The fields: `noBuildAndRestore` and `skipVersionCheck` can be marked with a `'true'`. 


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

The fields: `noBuildAndRestore` and `skipVersionCheck` can be marked with a `true`. 


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

The fields: `noBuildAndRestore` and `skipVersionCheck` can be marked with a `"true"`. 

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

The fields: `noBuildAndRestore` and `skipVersionCheck` can be marked with a `1`. 

{% endtab %}
{% endtabs %}

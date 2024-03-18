---
description: "Steps and examples on how to setup a build and deployment pipeline for Umbraco Deploy using Azure DevOps."
---

# Azure DevOps

In this section, we provide a full example of how Umbraco Deploy running on Umbraco 9 and above can be utilized. This can be used as a part of a build and deployment pipeline using Azure DevOps. You can use this directly or adapt it for your needs.

## Discussion on the Provided Example

We have defined a single stage build and deployment pipeline, configured in YAML format. While not as visually intuitive as a drag-and-drop task list, it provides the advantage of source control management.

We then have a number of variables defined, that are used in the build configuration below. By using variables we have the ability to modify the script for use on other web applications. Some values are set in the script, and some via Azure DevOps variables or secrets.

Most tasks in the pipeline are standard steps that will be used in any .NET web application release, such as the first steps:

\#1 Install of the NuGet tooling,

\#2 Restore of NuGet dependencies,

\#3 And the project build.

Additional steps can be added as required, for example for running automated tests.

The Umbraco Deploy license file and the schema data files will automatically be included within the build output.

The deployment part of the pipeline stage consists of two steps.

Firstly a web deployment (#4), takes the packaged build artifact and deploys it, in this case, to an Azure Web App slot.

The final step (#5) is Umbraco Deploy specific - to call a function defined in the PowerShell script and trigger the extraction. Replace `ApiSecret` with `ApiKey` if you're using the deprecated API key setting instead.

{% hint style="info" %} 
The Microsoft docs contain useful information, if you are unsure of how to set secrets for your pipeline:
* [Set secret variables](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/set-secret-variables?view=azure-devops&tabs=yaml%2Cbash)

* [Protecting secrets in Azure Pipelines](https://learn.microsoft.com/en-us/azure/devops/pipelines/security/secrets?view=azure-devops)
{% endhint %}

## Full Example

```yaml
trigger:
- main

pool:
  vmImage: 'windows-latest'

variables:
  solution: '**/*.sln'
  buildPlatform: 'Any CPU'
  buildConfiguration: 'Release'

  vsSolutionName: DeployOnPremSite
  vsProjectName: DeployOnPremSite
  umbracoDeployTriggerDeploy: $(Build.SourcesDirectory)\$(vsSolutionName)\$(vsProjectName)\TriggerDeploy.ps1
  umbracoDeployReason: AzureDeployment

  deployApiSecret: <set in Azure Pipeline secret>
  azureSubscription: <set in Azure Pipeline variable>
  webAppName: <set in Azure Pipeline variable>
  resourceGroupName: <set in Azure Pipeline variable>
  deploySlotName: <set in Azure Pipeline variable>
  deployBaseUrl: <set in Azure Pipeline variable>

steps:
#1 NuGet Tool Install
- task: NuGetToolInstaller@1
  displayName: Install NuGet

#2 NuGet Restore
- task: NuGetCommand@2
  displayName: Restore NuGet packages
  inputs:
    restoreSolution: '$(solution)'

#3 Build the VS Solution and publish the output to a zip file
- task: VSBuild@1
  displayName: Build solution
  inputs:
    solution: '$(solution)'
    msbuildArgs: '/p:DeployOnBuild=true /p:WebPublishMethod=Package /p:PackageAsSingleFile=true /p:SkipInvalidConfigurations=true /p:DesktopBuildPackageLocation="$(build.artifactStagingDirectory)\WebApp.zip" /p:DeployIisAppPath="Default Web Site"'
    platform: '$(buildPlatform)'
    configuration: '$(buildConfiguration)'

#4 Deploy to an Azure web app slot
- task: AzureRmWebAppDeployment@4
  displayName: Deploy to web app
  inputs:
    ConnectionType: 'AzureRM'
    azureSubscription: '$(azureSubscription)'
    appType: 'webApp'
    WebAppName: '$(webAppName)'
    deployToSlotOrASE: true
    ResourceGroupName: '$(resourceGroupName)'
    SlotName: '$(deploySlotName)'
    packageForLinux: '$(build.artifactStagingDirectory)\WebApp.zip'

#5 Trigger the Umbraco Deploy extraction
- task: PowerShell@2
  displayName: Run PowerShell script
  inputs:
    filePath: '$(umbracoDeployTriggerDeploy)'
    arguments: '-InformationAction:Continue -Action TriggerWithStatus -ApiSecret $(deployApiSecret) -BaseUrl $(deployBaseUrl) -Reason $(umbracoDeployReason) -Verbose'
```

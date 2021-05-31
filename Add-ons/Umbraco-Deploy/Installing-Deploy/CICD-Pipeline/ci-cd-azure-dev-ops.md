---
versionFrom: 8.0.0
meta.Title: "Setting up a CI/CD Build and Deployment Pipeline Using Azure DevOps"
meta.Description: "Steps and examples on how to setup a build and deployment pipeline for Umbraco Deploy using Azure DevOps"
---

# Setting up CI/CD build server with Azure DevOps

In this section we provide a full example on how Umbraco Deploy can be utilized as part of a build and deployment pipeline using Azure DevOps, which you can use or adapt for your needs.

## Discussion on the Provided Example

We have defined a two stage build process, divided into a build and a deploy stage, configured in YAML format.  Although initially this isn’t as easy to read as the drag and drop list of tasks, it does have the benefit of being managed in source control.

We then have a number of variables defined, that are used in the build configuration below.  By using variables we have the ability to modify the script easily for use on other web applications.

### Build Stage

Each stage - the first of which being the build stage - consists of a number of tasks. The majority of these are standard things that will be used in any .NET web application release, such as the first steps:
#1 Install of the NuGet tooling, 
#2 Restore of NuGet dependencies,
#3 And the project build.

The build uses a publish profile named `ToFileSys.pubxml` in order to output the published web application to a temporary disk location, from where it can be packaged up for deployment.  This publish profile should be added to your web application project in the `\Properties\PublishProfiles\` folder.

Step #4 is the first Deploy specific step.  The Umbraco Deploy license file needs to live in the bin folder, which here we have checked into source control, but not defined as part of the `.csproj` file.  In this step, we copy it to the bin folder of the published web application using the values defined in the variables.

There is then a similar step for the schema data files (#5).  They are checked into source control and need to be part of the build output so they are deployed to the destination site.

The last steps in the build stage (#6, #7, #8) prepares the build artifacts, of which there are two.  One being the zipped-up, published website along with schema data and license files.  The other being the Powershell script, provided with Umbraco Deploy, that will be used to trigger the extraction of the schema files and update of the target environment in the deploy stage.

### Deploy Stage

The deploy stage consists of two steps.  Firstly a web deployment (#1), taking the packaged build artifact and deploying it, in this case, to an Azure web app.  

The second step (#2) is Umbraco Deploy specific - to call a function defined in the Powershell script and trigger the extraction.  We provide the API key to authenticate this operation, either from a variable, or in order to add a layer of security, from an Azure secret defined within Azure DevOps.


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

  # The Visual Studio .sln name
  vsSolutionName: DeployOnPremSite 

  # The Visual Studio .csproj Web App name
  vsProjectName: DeployOnPremSite

  # The umbraco deploy trigger reason
  umbracoDeployReason: AzureDeployment

  # The umbraco deploy data folder path
  umbracoDeployData: $(Build.SourcesDirectory)\$(vsSolutionName)\data

  # The umbraco deploy license folder path
  deployLicense: $(Build.SourcesDirectory)\$(vsSolutionName)\bin

  # The TriggerDeploy.ps1 file path
  umbracoDeployTriggerDeploy: $(Build.SourcesDirectory)\$(vsSolutionName)\TriggerDeploy.ps1

  # The file system folder to publish the web app build
  publishDir: '$(Build.ArtifactStagingDirectory)\_Publish'

  # The zip file location of the zipped build output
  zipDir: '$(Build.ArtifactStagingDirectory)\_Zip'

  # The name of the target Azure web application
  azureWebAppName: deploy-on-prem-live

  # The azure subscription to deploy to
  azureSubscription: 'Microsoft Azure Sponsorship(5ffea398-7922-451b-bd72-fbe725185cbf)'

  # The upstream environment URL
  deployBaseUrl: https://deploy-on-prem-live.azurewebsites.net/

# Stage 1: Build
stages:
- stage: Build
  variables:
    Release.EnvironmentName: '$(buildConfiguration)'
  jobs: 
  - job: RestoreBuildPublish
    steps:
    
    #1 NuGet Tool Install
    - task: NuGetToolInstaller@1
      displayName: Install NuGet

    #2 NuGet Restore
    - task: NuGetCommand@2
      displayName: Restore NuGet
      inputs:
        restoreSolution: '$(solution)'
        feedsToUse: 'config'
        nugetConfigPath: 'Nuget.config'
        
    #3 Build the VS Solution and publish the output to a directory
    - task: VSBuild@1
      displayName: Build
      inputs:
        solution: '$(solution)'
        msbuildArgs: /p:UseWPP_CopyWebApplication=True /p:PipelineDependsOnBuild=False /p:PublishProfile=ToFileSys.pubxml /p:DeployOnBuild=true /p:AutoParameterizationWebConfigConnectionStrings=False /p:PublishOutDir=$(publishDir) /p:MarkWebConfigAssistFilesAsExclude=false /p:TransformWebConfigEnabled=false
        platform: '$(buildPlatform)'
        configuration: '$(buildConfiguration)'
        clean: true

    #4 Copy the deploy .lic file as they are not part of the csproj/msbuild
    - task: CopyFiles@2
      displayName: Copy Deploy license
      enabled: true
      inputs:
        sourceFolder: $(deployLicense)
        targetFolder: '$(publishDir)\bin'
        Contents: '*.lic'
    
    #5 Copy the deploy (data) files since they are not part of the csproj/msbuild
    - task: CopyFiles@2
      displayName: Copy data files
      enabled: true
      inputs:
        sourceFolder: $(umbracoDeployData)
        targetFolder: '$(publishDir)'        

    #6 Zip the output    
    - task: ArchiveFiles@2
      displayName: Zip build output
      inputs:
        rootFolderOrFile: '$(publishDir)'
        includeRootFolder: false
        archiveType: 'zip'
        archiveFile: '$(zipDir)/$(Build.BuildId).zip'
        replaceExistingArchive: true
    
    #7 Publish the zipped website as a build artifact
    - task: PublishBuildArtifacts@1
      displayName: Publish website artifact
      inputs:
        PathtoPublish: '$(zipDir)'
        ArtifactName: 'zip'
        publishLocation: 'Container'
    
    #8 Publish the TriggerDeploy.ps1 file as a build artifact
    - task: PublishBuildArtifacts@1
      displayName: Publish deploy trigger script
      inputs:
        pathtoPublish: '$(umbracoDeployTriggerDeploy)' 
        artifactName: 'triggerDeploy' 
        publishLocation: 'Container'

# Stage 2: Deploy
- stage: Deploy
  variables:
    Release.EnvironmentName: '$(buildConfiguration)'
  condition: succeeded('Build')
  jobs:
  - deployment: DeployToAzureWebsites
    environment: $(azureWebAppName)-azurewebsites-net
    strategy:
      runOnce:
        deploy:
          steps:

          #1 Deploy web application
          - task: AzureRmWebAppDeployment@4
            displayName: Deploy web application
            inputs:
              ConnectionType: 'AzureRM'
              azureSubscription: 'Microsoft Azure Sponsorship'
              appType: 'webApp'
              WebAppName: '$(azureWebAppName)'
              packageForLinux: '$(Agent.BuildDirectory)\zip\*.zip'
              enableCustomDeployment: true
              DeploymentType: 'webDeploy'
              enableXmlTransform: true

          #2 Trigger schema update
          - powershell: $(Agent.BuildDirectory)\triggerDeploy\TriggerDeploy.ps1 -InformationAction:Continue -Action TriggerWithStatus -ApiKey $(deployApiKey) -BaseUrl $(deployBaseUrl) -Reason $(umbracoDeployReason) -Verbose
            displayName: Umbraco Deploy extraction
            failOnStderr: true
            enabled: true
    
```

## Publish Profile

```xml
<?xml version="1.0" encoding="utf-8" ?>
<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <DeleteExistingFiles>False</DeleteExistingFiles>
    <ExcludeApp_Data>True</ExcludeApp_Data>
    <PublishUrl>$(PublishOutDir)</PublishUrl>
    <WebPublishMethod>FileSystem</WebPublishMethod>
  </PropertyGroup>
</Project>
```



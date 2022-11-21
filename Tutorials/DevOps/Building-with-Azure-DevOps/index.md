#Building with Azure DevOps

Azure DevOps is an offering by Microsoft to assist in storing, building and deploying your codebase. As well as monitoring your releases to provide feedback for that next bug fix.

Building an Umbraco 10 site is very straightforward in Azure DevOps below is the YAML to build and create an artifact for your Umbraco Website. An artifact is simply the end result of your build, typically a zip file with your compiled website.

```
trigger:
- master
- fix/anotherbranch

pool:
  vmImage: 'windows-latest'

variables:
  solution: '**/*.sln'
  buildPlatform: 'Any CPU'
  buildConfiguration: 'Release'

steps:
- task: NuGetToolInstaller@1

- task: NuGetCommand@2
  inputs:
    restoreSolution: '$(solution)'

- task: VSBuild@1
  inputs:
    solution: '$(solution)'
    msbuildArgs: '/p:DeployOnBuild=true /p:WebPublishMethod=Package /p:PackageAsSingleFile=true /p:SkipInvalidConfigurations=true /p:PackageLocation="$(build.artifactStagingDirectory)"'
    platform: '$(buildPlatform)'
    configuration: '$(buildConfiguration)'

- task: PublishBuildArtifacts@1
  displayName: 'Publish Artifacts'
  inputs:
    PathtoPublish: '$(Build.ArtifactStagingDirectory)'
    ArtifactName: 'drop'
    publishLocation: 'Container'

```

##What does this do?

The first block determines how this pipeline will be triggered we have specified two branches for Azure DevOps to listen for commits.

Pool is stating what OS the build agent should run. `windows-latest` or `ubuntu-latest` should be fine for most use cases. You can find a list of supported images [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops&tabs=yaml#software).

Variables is a section to define any sort of object such as a string or boolean to be used in your YAML.

Steps is used define what tasks need to happen in sequence to complete our build

Since this is a basic example we are just using Steps. You can incorporate Stages with steps to have a more complex build process. You can read more about Stages [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/stages?view=azure-devops&tabs=yaml)

In our Steps we are telling Azure DevOps to restore our nuget packages, run VS Build and then package our compiled website into an artifact called drop.zip.

It does not matter if you use VS Build instead of Dot Net Core CLI when building Umbraco 9+ as they ultimately do the same thing. You will run into issues using the Dot Net Core CLI task for a .Net Framework project, Umbraco 8 and below.

The above VS Build example includes a list of MS Build parameters to build and publish our website into a zip file to be passed on to the artifacts task.
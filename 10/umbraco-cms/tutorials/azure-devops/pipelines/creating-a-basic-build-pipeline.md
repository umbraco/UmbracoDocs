# Creating a basic build pipeline

Building an Umbraco 10 site is very straightforward in Azure DevOps. Below is the YAML to build and create an artifact containing your compiled Umbraco Website. 

An artifact is simply the end result of your build, typically a zip file with your compiled website.

```
trigger:
- master
- fix/anotherbranch
- support/*

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

## What does this do?

### Branch Triggers

The first block determines how this pipeline will be triggered. We have specified two branches and any branches starting with support/, Azure DevOps will listen for commits on these branches. Understanding this block will offer you great control over the circumstances that trigger the build. More information [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/repos/azure-repos-git?view=azure-devops&tabs=yaml#ci-triggers)

### Agent Pool

Pool is stating what OS the build agent should run. `windows-latest` or `ubuntu-latest` should be fine for most use cases. You can find a list of supported images [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops&tabs=yaml#software).

### Variables

Variables is a section to define any sort of object such as a string or boolean to be used in your YAML.

### Steps

Steps is used define what tasks need to happen in sequence to complete our build

Since this is a basic example we are just using Steps. You can incorporate Stages with steps to build complex projects that may need different requirements to build. You can read more about Stages [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/stages?view=azure-devops&tabs=yaml)

In our Steps we are telling Azure DevOps to the following:

- Restore our nuget packages and run VS Build.
- Build our Solution and publish our application to the following directory on the agent: $(build.artifactStagingDirectory)
- Publish our application as a build artifact into a drop.zip file for consumption by other tasks/stages/releases. 

It does not matter if you use VS Build instead of Dot Net Core CLI when building Umbraco 9+ as they ultimately do the same thing. You will run into issues using the Dot Net Core CLI task for a .Net Framework project, such as Umbraco 8 and below.
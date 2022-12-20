#Building with Azure DevOps

Azure DevOps is an offering by Microsoft to assist in storing, building and deploying your codebase. It also monitors your releases to provide feedback for that next bug fix.

Building an Umbraco site is straightforward in Azure DevOps here is the YAML to build and create an artifact for your Umbraco Website. An artifact is the end result of your build, typically a zip file with your compiled website.

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

The first block determines how the pipeline is triggered. We have specified two branches `master` and `fix/anotherbranch` for Azure DevOps to listen for commits.

The pool states the OS the build agent should run. `windows-latest` or `ubuntu-latest` should be fine for most use cases. You can find a list of supported virtual machine images from the [Microsoft docs](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops&tabs=yaml#software).

Variables is a section to define any sort of object such as a string or boolean to be used in your YAML.

Steps is used to define what tasks need to happen in sequence to complete the build.

Since this is a basic example we are using Steps. You can incorporate Stages with steps to have a more complex build process. You can read more about Stages in the [Microsoft docs](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/stages?view=azure-devops&tabs=yaml)

In the Steps block, we are restoring the NuGet packages, running VS build, and then packaging the compiled website into an artifact called drop.zip.

It does not matter if you use VS Build instead of .Net Core CLI when building Umbraco 9+ as they do the same thing. You will run into issues using the .Net Core CLI task for a .Net Framework project for Umbraco 8 and below.

The VS Build example includes a list of MS Build parameters to build and publish the website into a zip file. This file is then passed on to the artifacts task.
# Troubleshooting

## Upload Errors

### Failed to read the request form. Multipart body length limit 134217728 exceeded

We currently have a size limit set to 134217728 bytes or about ~128 MB. 

Make sure that the package you are trying to upload does not contain anything unnessary.

Our samples contains examples of how you could zip your repository before uploading it:

{% tabs %}
{% tab title="Github" %}
```yaml
## STEP FROM THE GITHUB YAML SAMPLE
# zip everything, except what is defined in the '.zipignore'
  - name: Zip Source Code
    run: zip -r sources.zip . -x@.zipignore
    shell: bash
```
{% endtab %}

{% tab title="Azure Devops" %}
```yaml
## STEP FROM THE AZURE DEVOPS YAML SAMPLE
# zip everything, except what is defined in the '.zipignore'
  - script: zip -r dist/sources_$(Build.BuildNumber).zip . -x@.zipignore
    displayName: Zip source files to package artifact
```
{% endtab %}

{% tab title=".zipignore" %}
```txt
## user generated files
.DS_Store
.idea/*

## Cloud has it's own git folder
.git/*

## no need for pipeline stuff in cloud - unless you just want to have it there also
.github/*
[Dd]evops/*

## Ignore the obj and bin artefacts - cloud builds its own
**/[Bb]in/*
**/[Oo]bj/*

## Do not include node modules - but do included your compiled js/frontend artifacts
node_modules/*
**/node_modules*

## ignore this file
.zipignore
```
{% endtab %}
{% endtabs %}

## Deployment failed

### Cannot apply update because the following packages would be downgraded: Package: Umbraco.{abc}, Version: {x.y.z}

The service goes through all .csproj-files contained in the uploaded package, and compares that to the versions running in your left-most cloud environment.
We do this to try to prevent you from downgrading the crutial Umbraco packages used by cloud.

We recommend that you align versions of the mentioned package in your csproj-files to the version mentioned in the error or a later version. 

The error tells you which package to look for and which version is currently in your left-most cloud environment.

If you have orphaned csproj-files you should remove them or rename them. 
Orphaned would be backup csproj files or files not referenced by the any of the main project-files.

### Could not find '/app/work/repository/Readme.md' to stat: No such file or directory

In some instances we see an issue where filename casing is causing an error. 

Rename the `Readme.md` file in the root of your repository to something different, the file can keep the markdown-extension.
Commit the change to your repository and run the pipeline.

If you want you can change the filename back to `Readme.md` after a successful CI/CD deployment.

## Are you stuck?

Help us get you and others unstuck by sending your queries, questions and comments to Umbraco via email at [umbraco-cicd@umbraco.dk](mailto:umbraco-cicd@umbraco.dk).

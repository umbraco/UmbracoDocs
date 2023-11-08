# Common Pitfalls

{% hint style="warning" %}
This documentation is currently a work in progress.
{% endhint %}

## Deployment failed

### Cannot apply update because the following packages would be downgraded: Package: Umbraco.{abc}, Version: {x.y.z}

The service goes through all .csproj-files contained in the uploaded package, and compares that to the versions running in your left-most cloud environment.
We do this to try to prevent you from downgrading the crutial Umbraco packages used by cloud.

We recommend that you align versions of the mentioned package in your csproj-files to the version mentioned in the error or a later version. 

The error tells you which package to look for and which version is currently in your left-most cloud environment.

If you have orphaned csproj-files you should remove them or rename them. 
Orphaned would be backup csproj files or files not referenced by the any of the main project-files.

## Are you stuck?

Help us get you and others unstuck by sending your queries, questions and comments to Umbraco via email at [umbraco-cicd@umbraco.dk](mailto:umbraco-cicd@umbraco.dk).

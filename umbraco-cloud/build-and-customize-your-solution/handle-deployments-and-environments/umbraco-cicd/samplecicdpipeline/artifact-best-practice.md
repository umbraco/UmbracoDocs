---
description: For a smooth deployment process, it is recommended to follow the best practice guidelines for artifacts outlined in this article.
---

# Deployment Artifact best practice

The zip package you are deploying must contain all things normally present in an Umbraco Cloud environment repository.

Every new Umbraco Cloud project contains a `readme.md` file that explains the structure and how you can adapt it to fit your needs.

{% hint style="info" %}
The sample scripts on GitHub include a way to package the zip. As the scripts are samples, they show a universal way to do this, which works well for most people. But not all projects are alike, and you may not want to use that particular approach.
{% endhint %}

## Exclude .NET Binaries

Don’t include any binary build artifacts coming from the .NET build/publish process. 

The general deployment process on Umbraco Cloud needs the source code, and the system will rebuild it once it is pushed back to the environment.

## Exclude the `.git` directory

The `.git` directory will be ignored in the isolated instance, but the extra megabytes will still slow down the deployment process. Due to these two facts, it is recommended not to include this directory in your deployments.

Also, consider the artifact size limitation below. 

## Include only finished frontend assets

If you are using modern frontend build tools, include only the finished frontend assets that are needed. There is no need to include JavaScript or TypeScript source files if you need to build the frontend. 

## Keep the Artifact as small as possible

It is good practice to keep the zipped artifact as small as possible. 

* Large files will slow down the underlying git operations and, therefore, also the deployment process.
  * Do not include large files like pictures and PDFs in the artifact. 
  * Large files need to be uploaded to the Azure Blob Storage connected to your environment. 
* Remove old and leftover code from the artifact.
  * Orphaned `.csproj` files with outdated package references are a common cause for issues in the deployment process.

Size limitations to consider:

- Version 1 endpoints allow file sizes up to 128 MB. 
- Version 2 endpoints allow file sizes up to 256 MB. 

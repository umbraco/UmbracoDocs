# Deployment Artifact best practice

The zip package you are deploying needs to contain all things that are normally present in an Umbraco Cloud environment repository.

Every new Umbraco Cloud project contains a `readme.md` file which explains the structure and how you can adapt it to suit your needs.

The sample scripts on GitHub include a way to package the zip. As the scripts are samples, they show a universal way to do this, which works well for most people. But not all projects are alike, and you may not want to use that particular approach.

## Do not include .NET Binaries

Don’t include any binary build artifacts coming from the .NET build/publish process. 

The general deployment process on Umbraco Cloud needs the source code, and the system will rebuild it once it is pushed back to the environment.

## Do not include the `.git` directory

The folder will be ignored in the isolated instance, including the extra megabytes will slow down the deployment process. 

Also, consider the artifact size limitation below. 

## Do include the finished frontend assets

If you are using modern frontend build tools, only include the finished frontend assets that are needed. There is no need to include JavaScript or TypeScript source files if you need to build the frontend. 

## Keep the Artifact as small as possible

It is good practice to keep the zipped artifact as small as possible. 

* Large files will slow down the underlying git operations and, therefore, also the deployment process.
  * Do not include large files like pictures and PDFs in the artifact. 
  * Large files need to be uploaded to the blob storage connected to your environment. 
* Remove old and leftover code from the artifact. 
  * Orphaned `.csproj` files with outdated package references are a common cause for issues in the deployment process.

Size limitations to consider:

- The version 1 endpoints will allow file sizes up to 128 MB. 
- In version 2 endpoints, the size limit is increased to 256 MB. 

# Deployment Artifact best practice
The zip package you are deploying needs to contain all things that normally is present in an Umbraco Cloud environment-repository.

Every new Umbraco Cloud project contains a readme.md file which explains the structure and how you can adapt it to suit your needs.

The sample scripts on github includes a way to package the zip. As the scripts are samples they show a universal way to do this which works well for most people. But not all projects are alike, and you way not want to use that particular approach.
 

## Do not include Dotnet Binaries
Don’t include any binary build artifacts coming from the DotNet build/publish process. 

The general deployment process on Umbraco Cloud needs the source code and the system will rebuild it once it is pushed back to the environment.

## Do not include the .git directory
The folder will be ignored in the isolated instance, including the extra megabytes will slow down the deployment process. 

Also consider the artifact size limitation below. 

## Do include the finished frontend assets
If you are using modern frontend build tools, ideally only include the finished frontend assets that are actually needed. No need to include javascript or typescript source files if you need to build the frontend. 

## Keep the Artifact as small as possible
It is good practice to keep the zipped artifact as small as possible. 
* Large files will slow down the underlying git operations and therefore also the deployment process.
  * Do not include large files like pictures and pdf’s in the artifact. 
  * Large files need to be uploaded to the blob storage connected to your environment. 
* Remove old and leftover code from the artifact. 
  * Orphaned Csproj-files with outdated package-references are common causes for issues in the deployment process.

Size limitations to consider:
- The V1 endpoint will allow file sizes up to 128 MB. 
- In the V2 endpoint we have increased the size limit to 256 MB. 

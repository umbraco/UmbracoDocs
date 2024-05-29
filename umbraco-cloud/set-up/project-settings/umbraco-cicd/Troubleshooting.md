# Troubleshooting
## Special Cases

### Using RestorePackagesWithLockFile in your CSPROJ-file
In instances where people used the `RestorePackagesWithLockFile` set to true, we saw that no changes were made to the website. This happened even though the CICD-deployments were completed successfully, and files were updated as expected in the Cloud-repository.

The reason was that the KUDU-deploy process failed. This process takes the newly committed files from the cloud repository and runs restore, build, and publish on the cloud environment.

Removing the `RestorePackagesWithLockFile` allowed deployments to come all the way through.

## Upload Errors

### Failed to read the request form. Multipart body length limit 134217728 exceeded

We currently have a size limit set to 134217728 bytes or about ~128 MB. 

Make sure that the package you are trying to upload does not contain anything unnecessary.

You can see an example of how you could zip your repository before uploading it, by referring to our [Github](samplecicdpipeline/github-actions.md) or [Azure Devops](samplecicdpipeline/azure-devops.md) samples. 

## Deployment failed

### Cannot apply update because the following packages would be downgraded: Package: Umbraco.{abc}, Version: {x.y.z}

The service goes through all .csproj-files contained in the uploaded package, and compares that to the versions running in your left-most cloud environment.
We do this to try to prevent you from downgrading the crucial Umbraco packages used by cloud.

We recommend that you align versions of the mentioned package in your csproj-files to the version mentioned in the error or a later version. 

The error tells you which package to look for and which version is currently in your left-most cloud environment.

If you have orphaned csproj-files you should remove them or rename them. 
Orphaned would be backup csproj files or files not referenced by the any of the main project-files.

### Could not find '/app/work/repository/Readme.md' to stat: No such file or directory

In some instances we see an issue where filename casing is causing an error. 

Rename the `Readme.md` file in the root of your repository to something different, the file can keep the markdown-extension.
Commit the change to your repository and run the pipeline.

If you want you can change the filename back to `Readme.md` after a successful CI/CD deployment.

### The site can't be upgraded as it's blocked with the following markers: updating

In rare cases deployments fail, and the cloud infrastructure doesn't clean up correctly. This leaves behind an "updating" marker.
The next time you try to deploy through your pipeline you will encounter an error.

In order to fix this issue, you need to use [KUDU](../../power-tools/README.md) to remove the leftover marker file.

1. Access KUDU on the "left-most" environment
  * If you only have one environment you want the live environment
  * If you have more than one environment, you want the development environment

3. Navigate to `site` > `locks` folder  In there, there should be a file named `updating`

4. Remove the `updating` file.

Once the marker file is removed, run your pipeline again.

## Are you stuck?

Help us get you and others unstuck by sending your queries, questions and comments to Umbraco via email at [umbraco-cicd@umbraco.dk](mailto:umbraco-cicd@umbraco.dk).
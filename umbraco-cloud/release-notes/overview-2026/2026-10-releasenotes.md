# October 2026

## Key Takeaways

* **Sweden Region Available** - Umbraco Cloud now has a Sweden region.
* **Automatic NuGet cache cleanup** - Superseded NuGet packages are removed from your environments after each deployment, so long-lived projects no longer fill their disk with old package versions.
* **Leftover `global.json` no longer breaks deployments** - The temporary `global.json` file written during a Git deployment is now removed when a build fails or the deployment is interrupted.

## Sweden Region Available

Umbraco Cloud now has a Sweden region, allowing you to host your projects in Sweden.\
This is particularly beneficial for organizations with data residency requirements or those looking to enhance performance for users in the Nordics.

## Automatic NuGet cache cleanup

Every deployment and upgrade restores NuGet packages into the NuGet cache on your environment. Older package versions were never removed from the cache. On long-lived projects, the cache could grow to several gigabytes and use up the disk space of the environment.

Umbraco Cloud now cleans up the NuGet cache 15 minutes after each completed deployment. The cleanup works as follows:

* **Package versions your site uses are kept.** These are read from the `*.deps.json` files of the deployed site.
* **The newest version of build-only packages is kept.** These are packages used during the build, such as analyzers and SDK packs.
* **All other versions are removed.**

## Leftover `global.json` no longer breaks deployments

During a Git deployment, Umbraco Cloud writes a temporary `global.json` file to the repository in the environment. The file selects a .NET SDK that can build your project and is removed again after a successful build.

When a build failed, or the deployment was interrupted, the file was left behind. The leftover `global.json` could then cause the next deployment to fail.

The temporary `global.json` file is now removed in both cases:

* **Failed builds** - The repository on the environment is cleaned up when the build fails, the same way as after a successful build.
* **Interrupted deployments** - Umbraco Cloud checks the repository once the deployment has finished and removes a leftover `global.json` file.

---
description: When rebooting an Umbraco CMS website is it common to distinguish between hot and cold restarts dependent on your setup.
---

# Hot vs. cold restarts

The load time of your site is dependent on a few different things. TWhen talking about hot vs. cold restarts of your Umbraco CMS website it comes down to whether or not NuCache needs to rebuild.

* **Cold restart**: When ["In Memory Auto"](../templating/modelsbuilder/builder-modes.md#in-memory) mode is enabled and the NuCache needs to rebuild.
* **Hot start**: When NuCache does not need to rebuild.

## Hot start

When no cache needs to be rebuild, the restart of your site is generally faster. This is why it is referred to as a **hot restart**.

## Cold start

The **cold restart** expression is generally used about a site with ["In Memory Auto"](../templating/modelsbuilder/builder-modes.md#in-memory) mode enabled. This means that the startup time will be slightly slower as the NuCache needs to rebuild amongst other things.

## Troubleshooting slow startup

Different things could be in play when your site is slow to startup after a reboot/restart.

Below is a list of some of the more common reasons:

* NuCache needs to rebuild (cold restart).
* Examine indexes needs to rebuild - for large sites, this can take some time.
* The custom code on the website is not optimized and does not live up to .NET standards.

## Legacy Umbraco

In earlier versions of Umbraco the difference between hot and cold restarts were more distinct as more components where involved with this process.

[Learn more about the different restart processes in the legacy documentation](https://our.umbraco.com/documentation/Reference/Events/Hot-vs-Cold-restarts).

The process for [troubleshooting slow startup times is also slightly different for earlier version of Umbraco](https://our.umbraco.com/documentation/Reference/Events/Troubleshooting-Slow-Startup).

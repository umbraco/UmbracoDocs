---
description: When rebooting an Umbraco CMS website it is common to distinguish between hot and cold restarts depending on your setup.
---

# Hot vs. cold restarts

The load time of your site is dependent on a few different things. When talking about hot vs. cold restarts of your Umbraco CMS website it comes down to whether the search indexes need to be rebuilt.

* **Cold restart**: When the search indexes need to rebuild.
* **Hot start**: When the search indexes do not need to rebuild.

## Hot start

When no cache needs to be rebuild, the restart of your site is generally faster. This is why it is referred to as a **hot restart**.

## Cold start

The **cold restart** expression is generally used for when the search indexes need to rebuild. This will resolve in a slower startup time, depending on the amount of content on the site. Generally speaking, the more content you have the longer a cold boot will take.

## Troubleshooting slow startup

Different things could be in play when your site is slow to startup after a reboot/restart.

Below is a list of some of the more common reasons:

* The search indexes need to rebuild (cold restart).
* Examine indexes need to rebuild - for large sites, this can take some time.
* The custom code on the website is not optimized and does not live up to .NET standards.

## In Memory Auto

Another factor that can slow down time to first page load is the [In Memory Auto models builder](../templating/modelsbuilder/builder-modes.md#in-memory) setting. Having this setting enabled will result in the first page load being slower. The reason for this is that when the first page is requested, the strongly typed models needs to be compiled and loaded in.

This is, however, less noticeable on consecutive restarts, a bit like hot and cold restarts. Since the compiled models will be cached on disk, they don't need to be recompiled until the models change again.

## Legacy Umbraco

In earlier versions of Umbraco, the difference between hot and cold restarts was more distinct as more components were involved with this process.

[Learn more about the different restart processes in the legacy documentation](https://our.umbraco.com/documentation/Reference/Events/Hot-vs-Cold-restarts).

The process for [troubleshooting slow startup times is also slightly different for earlier version of Umbraco](https://our.umbraco.com/documentation/Reference/Events/Troubleshooting-Slow-Startup).

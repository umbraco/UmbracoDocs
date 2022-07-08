---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Common issues

_Here you can find common issues with Courier and possible solutions_

## Try this first
For all issues, always try these steps first:

1. Ensure you have the latest version - [Download the latest version on Nightly Umbraco](http://nightly.umbraco.org/?container=umbraco-courier-release)
2. Enable debugging in /config/courier.config and restart the app to see if courier has problems with loading dlls.
3. Clear the cache folder in /app_data/courier/cache.

If you are using custom data types and/or packages that are not part of Umbraco out of the box, you need to add data resolvers for these.

To get data resolvers for the most commonly used community packages, download and add the [Courier.Contrib](https://github.com/umbraco/Umbraco.Courier.Contrib) package to your sites.

:::note
Even though Nested Content is part of Umbraco (since version 7.7), you need the Courier.Contrib package installed, for Courier to be able to handle Nested Content data.
:::

You can also create your own data resolvers. Read the [Data Resolvers](Developer/DataResolvers.md) article to learn more about that.

## Most common issues, and how to solve them

### Key not found exception
*Caused by:* Courier not being able to find a specific provider, commonly the datalayer provider. Usually, because Courier didn't load the datalayer dll or one of its dependencies.

*How to spot:* Enable debugging in `/config/courier.config`, restart the app and check the
`/app_data/courier/logs/error_log.txt` file for exceptions related to loading providers. Usually, it will say which dll had issues loading.

If no exceptions in the log, it might be missing the dll, or have the dll for the wrong version.

Courier for V6 expects to have `umbraco.courier.persistence.v6.nhibernate.dll` and for V4 it should have
`umbraco.courier.persistence.v4.nhibernate.dll`.

*Solution:* Ensure that all dlls are loaded properly and that it has all the dlls expected. Also, it should only have
the proper dlls for the specific versions.

Get the dlls from the latest version [here](http://nightly.umbraco.org/?container=umbraco-courier-release) and copy to `/bin`.

### Courier cannot package data type, Could not load assembly for type
*Caused by:* Courier not able to find a data types assembly or .cs class file which contains the interface used
by the data type.

*How to spot:* Courier returns `Cannot package GUID from data types provider`.

*Solution:* Make sure you have all your data type dependencies in place. Usually its components and similar projects
that are missing dlls. If you don't use a data type, delete it from your site, so you don't accidentally
transfer a broken data type. Make sure to clear Courier cache and restart the application.

### Latest changes aren't deployed / courier can't detect changes
*Caused by:* When changes are made, Courier stores a serialized copy in its cache folder, in some cases, it cannot update
the files due to permissions or locks.

*How to spot:* Find the corresponding item in `/app_data/courier/cache` and see if it changes on save/publish.

*Solution:* Clear the `/app_data/courier/cache` folder and retry packaging. In some cases caching might need to be turned off.
This will make transfers slower but can be set in `/config/courier.config` file.

### Properties and tabs are not sorted correctly after transfer
*Caused by:* Umbraco core doesn't register a sortorder on properties and tabs except if they are sorted manually.

*How to spot:* Properties and tab changes order after transfer.

*Solution:* Sort properties and tabs manually on the source site to ensure the core registers the sort order,
save item and re-transfer.

### Sort order on documents is not transferred
*Caused by:* Courier not logging sort order changes, due to the way the core does sorting from its API.

*How to spot:* Change sorting order on a collection of document, then transfer their parent + children. The sort order will not
be correct on the destination site.

*Solution:* Clear the `/app_data/courier/cache` folder and re-package the items.

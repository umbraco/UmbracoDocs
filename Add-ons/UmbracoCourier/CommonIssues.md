# Common issues

_Document to outline commonly found issues with Courier and possible solutions_

### Try this first
For all issues, always try these steps first:
- Enable debugging in /config/courier.config and restart the app to see if courier has problems with loading dlls.
- Clear the cache folder in /app_data/courier/cache.
- Ensure you have the latest version.

### Get the latest version here:
**Nightly.umbraco.org** contains all builds. We always recommended running the latest version, which contains all the latest bug fixes.

[Access all the builds on Nightly Umbraco](http://nightly.umbraco.org/?container=umbraco-courier-release).

### Key not found exception
*Caused by:* Courier not being able to find a specific provider, commonly the datalayer provider. Usually, because Courier didn't load the datalayer dll or one of its dependencies. 

*How to spot:* Enable debugging in /config/courier.config, restart the app and check the 
/app_data/courier/logs/error_log.txt file for exceptions related to loading providers. Usually, it will say which dll had issues loading. 

If no exceptions in the log, it might be missing the dll, or have the dll for the wrong version.

Courier for V6 expects to have umbraco.courier.persistence.v6.nhibernate.dll and for V4 it should have 
umbraco.courier.persistence.v4.nhibernate.dll

*Solution:* Ensure that all dlls are loaded properly and that it has all the dlls expected. Also, for it should only have
the proper dlls for the specific versions. 

Get the dlls from the latest version [here](http://nightly.umbraco.org/?container=umbraco-courier-release) and copy to /bin.

### Courier cannot package data type, Could not load assembly for type
*Caused by* Courier not able to find a data types assembly or .cs class file which contains the Interface used
by the data type.

*How to spot* Courier returns "cannot package GUID from data types provider".

*Solution* Make sure you have all your data type dependencies in place, usually its components and similar projects
that are missing dlls, also, if you don't use a data type, delete it from your site, so you don't accidentally 
transfer a broken data type. Make sure to clear courier cache and restart the application.

### Courier cannot package items on V4
*Caused by:* Missing dlls or dlls from the wrong Courier version.

*How to spot:* On v6 sites, it has dlls from V4 distribution, on V4 sites it has V6 dlls, or are missing dlls. To debug,
put Courier in debug mode in /config/courier.config and restart application, it should throw exceptions to 
/app_data/courier/logs/log_error.txt about missing dependencies or wrong versions.

*Solution:* Uninstall courier, and reinstall the latest version from Nightly Umbraco.

[Access all the builds on Nightly Umbraco](http://nightly.umbraco.org/?container=umbraco-courier-release).

### Latest changes aren't deployed / courier can't detect changes
*Caused by:* When changes are made, Courier stores a serialized copy in its cache folder, in some cases, it cannot update
the files due to permissions or locks.

*How to spot* find the corresponding item in /app_data/courier/cache and see if it changes on save/publish.

*Solution:* Clear the /app_data/Courier/cache folder and retry packaging, in some cases caching might need to be turned off
this will make transfers slower but can be set in /config/courier.config file.

### Content are deployed but not published
*Caused by:* Exception during extraction which might get the publish event not to fire.

*How to spot:* Content transfers with no error, but changes are not visible on the website.

*Solution:* upgrade to the latest version, which has a bug fix.

[Access all the builds on Nightly Umbraco](http://nightly.umbraco.org/?container=umbraco-courier-release).

### Tabs don't inherit on Umbraco 6
*Caused by:* Changes in the V6 datalayer in the way tabs are inherited from parent document types.

*How to spot:* Inherited tabs are created as new tabs on the document type.

*Solution:* Upgrade to the latest version.

[Access all the builds on Nightly Umbraco](http://nightly.umbraco.org/?container=umbraco-courier-release).

### Files on NAS are not transferred
*Caused by:* file paths break the way courier looks up files and cannot find them when transferring.

*How to spot:* Files are not included in the revisions.

*Solution:* Upgrade to the latest version.

[Access all the builds on Nightly Umbraco](http://nightly.umbraco.org/?container=umbraco-courier-release).

### Files are transferred as 0 byte files
*Caused by:* Courier not able to find file, then loads nothing into the file object.

*How to spot:* Files are transferred but end up as 0 byte files on the destination.

*Solution:* Fixed issue, upgrade to the latest version.

[Access all the builds on Nightly Umbraco](http://nightly.umbraco.org/?container=umbraco-courier-release).

### StackOverflowException during deployment
*Caused by:* template or other file starting with the '_' character.

*How spot:* Transfer never completes, and the task manager just clears out the task with no error or feedback.

*Solution:* Fixed: Upgrade to the latest version.

[Access all the builds on Nightly Umbraco](http://nightly.umbraco.org/?container=umbraco-courier-release).

### Properties and tabs are not sorted correctly after transfer
*Caused by:* Umbraco core doesn't register a sortorder on properties and tabs except if they are sorted manually.

*How to spot:* Properties and tab changes order after transfer.

*Solution:* Sort properties and tabs manually on the source site to ensure the core registers the sort order,
save item and re-transfer to fix.

### Courier express can't find repository
*Caused by:* Licensing limitation prohibiting the repository from loading.

*How to spot:* Registered repository is not listed in the UI, or you get an exception during packaging.

*Solution:* Ensure all registered dlls are allowed in the licensing, upgrade to the latest version which is less strict on domain 
restrictions.

[Access all the builds on Nightly Umbraco](http://nightly.umbraco.org/?container=umbraco-courier-release).

### Dll is not allowed to call Courier API
*Caused by:* Courier express licensing prohibits 3rd party dlls to call the API, so some dlls were not allowed to 
load.

*How to spot:* Save a content item, Courier should throw an exception, saying the dll is not allowed to call Courier's
API.

*Solution:* upgrade to the latest version, since this has been fixed since **2.7.6**.

[Access all the builds on Nightly Umbraco](http://nightly.umbraco.org/?container=umbraco-courier-release).

### Sort order on documents is not transferred
*Caused by:* Courier not logging sort order changes, due to the way the core does sorting from its API.

*How to spot:* Change sorting order on a collection of document, then transfer their parent + children. The sort order will not 
be correct on the destination site.

*Solution:* clear the /app_data/courer/cache folder and re-package the items.

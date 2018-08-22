# Configuration Files

_This section will explain the many configuration options in Umbraco and what they do_

### [web.config](webconfig/index.md)
This file can be found at the following path: /web.config

### [404handlers.config](404handlers/index.md)
Configuration file for legacy NotFoundHandlers

This file can be found at the following path: /config/404handlers.config

### [applications.config](applications/index.md)
Configuration options of setting up sections within the Umbraco Backoffice.

This file can be found at the following path: /config/applications.config

### [dashboards.config](dashboard/index.md)
Configuration options for controlling which dashboards appear in which sections of the backoffice and who has the permissions to see them.

This file can be found at the following path: /config/Dashboard.config


### [EmbeddedMedia.config](EmbeddedMedia/index.md)
This configuration file lists the Embedded Media Providers configured for use in your Umbraco site.

This file can be found at the following path: /config/EmbeddedMedia.config

### [ExamineIndex.config](ExamineIndex/index.md)
The 'ExamineIndex.config' file contains the configuration for the Examine IndexSets used for storing indexed content in an Umbraco installation.

This file can be found at the following path: /config/ExamineIndex.config

### [ExamineSettings.config](ExamineIndex/index.md)
The 'ExamineIndex.config' file contains the configuration for the Examine IndexSets used for storing indexed content in an Umbraco installation.

This file can be found at the following path: /config/ExamineSettings.config

### [fileSystemProviders.config](fileSystemProviders/index.md)
The 'fileSystemProviders.config' file contains the configuration for the file system providers used by Umbraco to interact with file systems.

This file can be found at the following path: /config/FileSystemProviders.config


### [BaseRestExtensions.config](BaseRestExtensions/index.md)
The 'BaseRestExtension.config' contains the data necessary for the /Base system when exposing the methods in your class library.

This file can be found at the following path: /config/BaseRestExtensions.config

### [tinyMceConfig.config](tinyMceConfig/index.md)
The 'tinyMceConfig.config' contains configuration options for the [TinyMce](https://www.tinymce.com/) editors in the Umbraco Backoffice. 

This file can be found at the following path: /config/tinyMceConfig.config

### [trees.config](trees/index.md)
The 'trees.config' file contains the configuration for trees that are loaded within each section of the Umbraco Backoffice.

This file can be found at the following path: /config/trees.config

### [umbracoSettings.config](umbracoSettings/index.md)

Contains many Umbraco options. Generally the default values work well in most installs; however, in some cases some of these options may need adjusting depending on each installation.

This file can be found at the following path: /config/umbracoSettings.config

## clientdependency.config

The ClientDependency configuration options can be found on the [ClientDependency website](https://github.com/Shandem/ClientDependency/wiki/Configuration).

This file can be found at the following path: /config/ClientDependency.config

## log4net.config

The log4net configuration options can be found on the [log4net website](https://logging.apache.org/log4net/release/manual/configuration.html).

This file can be found at the following path: /config/log4net.config

## UrlRewriting.config

This is now obsolete and there are better ways to do UrlRewriting, such as within [IIS](https://docs.microsoft.com/en-us/iis/extensions/url-rewrite-module/creating-rewrite-rules-for-the-url-rewrite-module). However, the UrlRewriting documentation can be [downloaded in PDF format](https://github.com/aspnetde/UrlRewritingNet/blob/master/docs/UrlRewritingNet20_English.pdf) for legacy projects.

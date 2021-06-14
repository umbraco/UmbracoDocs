---
versionFrom: 9.0.0
meta.Title: "Umbraco configuration"
meta.Description: "Information on configuring Umbraco"
state: partial
verified-against: beta-3
update-links: false
---

# Configuration Files

In V9, we have moved away from the previous conifuration using .config files, now instead using the netcore built in configuration pattern. This means that all configuration is now in the `appsettings.json` file.

## Development specific configuration

You might have some specific configuration you want to use for development, for instance you might want to use localhost as smtp settings, to do this you can use the `appsettings.Development.json` file, as long as the `ASPNETCORE_ENVIRONMENT` environment variable is set to `Development`, any settings in this file will override the ones in `appsettings.json`.

## IntelliSesnse

A great thing about the `appsettings.json` is that it allows for intellisense with a schema file. For most ediors this should work out of the box, without having configure anything, since the schema is specified in the top of the file like so `"$schema": "https://json.schemastore.org/appsettings.json"`.


## Configuration options

There is many settings that you can configure in Umbraco so to help you get an overview they're divided into sections

* [Global settings](GlobalSettings/index-v9.md)
* [Content settings](ContentSettings/index-v9.md)
* [Security setting](SecuritySettings/index-v9.md)
* [Hosting settings](HostingSettings/index-v9.md)
* [Keep alive settings](KeepAliveSettings/index-v9.md)
* [Request handler settings](RequestHandlerSettings/index-v9.md)
* [Runtime minification settins](RuntimeMinificationSettings/index-v9.md)
* [Tours settings](ToursSettings/index-v9.md)

## The following Configuration Files remain in Umbraco 8

### [web.config](webconfig/)
This file can be found at the following path: /web.config

### [tinyMceConfig.config](tinyMceConfig/index.md)
The 'tinyMceConfig.config' contains configuration options for the [TinyMce](https://www.tinymce.com/) editors in the Umbraco Backoffice.

This file can be found at the following path: /config/tinyMceConfig.config

### [umbracoSettings.config](umbracoSettings/index.md)

Contains many Umbraco options. Generally the default values work well in most installs; however, in some cases some of these options may need adjusting depending on each installation.

This file can be found at the following path: /config/umbracoSettings.config

### clientdependency.config

The ClientDependency configuration options can be found on the [ClientDependency website](https://github.com/Shandem/ClientDependency/wiki/Configuration).

This file can be found at the following path: /config/ClientDependency.config

### healthchecks.config

The configuration for backoffice healthcheck notifications.

This file can be found at the following path: /config/HealthChecks.config

### Image Processor 

The configuration for the Image Processor the library responsible for the on the fly processing of images in Umbraco.

There are three configuration files
/imageprocessor/cache.config
/imageprocessor/security.config
/imageprocessor/processing.config

## Replaced by code

### [404handlers.config](404handlers/index.md)
Configuration file for legacy NotFoundHandlers

### [applications.config](applications/index.md)
Configuration options of setting up sections within the Umbraco Backoffice.

### [BaseRestExtensions.config](BaseRestExtensions/index.md)
The 'BaseRestExtension.config' contains the data necessary for the /Base system when exposing the methods in your class library.

### [dashboards.config](dashboard/index.md)
Configuration options for controlling which dashboards appear in which sections of the backoffice and who has the permissions to see them.

### [EmbeddedMedia.config](EmbeddedMedia/index.md)
This configuration file lists the Embedded Media Providers configured for use in your Umbraco site.

### [ExamineIndex.config](ExamineIndex/index.md)
The 'ExamineIndex.config' file contains the configuration for the Examine IndexSets used for storing indexed content in an Umbraco installation.

### [ExamineSettings.config](ExamineSettings)
The 'ExamineIndex.config' file contains the configuration for the Examine IndexSets used for storing indexed content in an Umbraco installation.

### [fileSystemProviders.config](fileSystemProviders/index.md)
The 'fileSystemProviders.config' file contains the configuration for the file system providers used by Umbraco to interact with file systems.

### sections.config
The 'sections.config' file contains the configuration for custom sections loaded in the Umbraco Backoffice.

### [trees.config](trees/index.md)
The 'trees.config' file contains the configuration for trees that are loaded within each section of the Umbraco Backoffice.

### UrlRewriting.config

This is now obsolete and there are better ways to do UrlRewriting, such as within [IIS](https://docs.microsoft.com/en-us/iis/extensions/url-rewrite-module/creating-rewrite-rules-for-the-url-rewrite-module). However, the UrlRewriting documentation can be [downloaded in PDF format](https://github.com/aspnetde/UrlRewritingNet/blob/master/docs/UrlRewritingNet20_English.pdf) for legacy projects.

## New to Umbraco 8

### [SeriLog.config](Serilog/index.md)

In v8 Serilog is used for logging, use these files to configure this:

* `/config/serilog.config` is used to modify the main Umbraco logging pipeline
* `/config/serilog.user.config` which is a sublogger and allows you to make modifications without affecting the main Umbraco logger




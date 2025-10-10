# Running Umbraco in Docker

Exactly how you choose to compose your Dockerfile will depend on your project specific needs. This section is not intended as a comprehensive guide, rather as an overview of topics to be aware of when hosting in Docker.

## What is Docker

Docker is a platform for developing, shipping, and running applications in containers. Multiple services exist for hosting these containers.  For more information, refer to the [official Docker Documentation](https://docs.docker.com/)

## The Docker file system

By default, files created inside a container are written to an ephemeral, writable container layer.
This means that the files don't persist when the container is removed, and it's challenging to get files out of the container. Additionally, this writable layer is not suitable for performance-critical data processing.

This has implications when running Umbraco in Docker.

For more information, refer to the [Docker documentation on storage](https://docs.docker.com/engine/storage/).

### General file system consideration

In general, when working with files and Docker you work in a "push" fashion with read-only layers. When you build, you take all your files and "push" them into this read-only layer.

This means that you should avoid making files on the fly, and instead rely on building your image.

In an Umbraco context, this means you should not create or edit template, script or stylesheet files via the backoffice. These should be deployed as part of your web application and not managed via Umbraco.

Similarly, you shouldn't use InMemory modelsbuilder, since that also relies on creating files on the disk. While this is not a hard requirement, it doesn't provide any value unless you are live editing your site.

Instead, configure models builder to use "source code" mode in development, and "none" in production, as [described when using runtime modes](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/runtime-modes).

### Logs

Umbraco writes logs to the `/umbraco/Logs/` directory. Due to the performance implications of writing to a writable layer, and the limited size, it is recommended to mount a volume to this directory.

You may prefer to avoid writing to disk for logs when hosting in containers. If so, you can disable this default behavior and register a custom Serilog sink to alternative storage, such as Azure Table storage.

You can also provide an alternative implementation of a common abstraction for the log viewer. In this way you can read logs from the location where you have configured them to be written.

For more on this please read the article on Umbraco's [log viewer](../../backoffice/logviewer.md).

### Data

The `/umbraco/Data/` directory is used to store temporary files, such as file uploads. Considering the limitations of the writable layer, you should also mount a volume to this directory.

### Media

It's recommended to not store media in the writable layer. This is for similar performance reasons as logs,
but also for practical hosting reasons. You likely want to persist media files between containers.

One solution is to use bind mounts. The ideal setup, though, is to store the media and ImageSharp cache externally. For more information, refer to the [Azure Blob Storage documentation](https://docs.umbraco.com/umbraco-cms/extending/filesystemproviders/azure-blob-storage).

### Required files

Your solution may require some specific files to run, such as license files. You will need to pass these files into the container at build time, or mount them externally.

## HTTPS

When running websites in Docker, it's common to do so behind a reverse proxy or load balancer.
In these scenarios you will likely handle SSL termination at the reverse proxy. This means that Umbraco will not be aware of the SSL termination, and will complain about not using HTTPS.

Umbraco checks for HTTPS in two locations:

1. The `HstsCheck` health check - This will result in a failed healthcheck.
2. The `UseHttpsValidator` - This will result in a build error, if Production runtime mode is used.

To avoid these checks failing, you can remove them in your project.

### Health Check

The health check must be removed via configuration, through the `appsettings.json` file, environment variables, or similar. For more information see the [Health Check documentation](../../../reference/configuration/healthchecks.md).

The `HstsCheck` key is `E2048C48-21C5-4BE1-A80B-8062162DF124` so the appsettings will look something like:

```json
  "Umbraco": {
    "CMS": {
      "HealthChecks" : {
        "DisabledChecks": [
          {
            "Id": "E2048C48-21C5-4BE1-A80B-8062162DF124"
          }
        ]
      },
      {...}
```

### Runtime mode validator

The `UseHttpsValidator` must be removed through code For more information see the [Runtime mode documentation](runtime-modes.md).

The code to remove the validator can look something like:

```C#
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Infrastructure.Runtime.RuntimeModeValidators;

namespace MySite;

public class DockerChecksRemover : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.RuntimeModeValidators().Remove<UseHttpsValidator>();
}

```

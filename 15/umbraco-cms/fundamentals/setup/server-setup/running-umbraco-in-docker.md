# Running Umbraco in Docker

Exactly how you choose to compose your Dockerfile depends on your needs, and your project. This section is not intended as a guide, 
but as a general overview of what to be aware of when hosting in Docker.

## What is Docker

Docker is a platform for developing, shipping, and running applications in containers. There exist multiple services for hosting these containers, 
for more information, [refer to the official Docker documentation](https://docs.docker.com/)

## The Docker file system

By default, all files created inside a container are written to an ephemeral writable container layer. 
This means that the files don't persist when the container is removed, and it's challenging to get files out of the container. Additionally, this writable layer is not suitable for performance-critical data processing.
This has implications when running Umbraco in Docker. For more information, refer to the [Docker documentation on storage](https://docs.docker.com/engine/storage/).

### General file system consideration 

In general, when working with files and Docker you work in a "push" fashion with the read-only layers. WWhen you build, you take all your files and "push" them into the read-only layer.
This means that you should avoid making files on the fly, and instead rely on building your image. You should not create or edit template files on the fly, the same goes for script and style files. 

Similarly, you shouldn't use InMemory modelsbuilder, since that also relies on creating files on the disk. While this is not a hard requirement, it doesn't provide any value if not live editing your site. Instead, use source code in development, and none in production, as [described when using runtime modes](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/runtime-modes).


### Logs

Umbraco writes logs to the `/umbraco/Logs/` directory. Due to the performance implications of writing to a writable layer, 
and the limited size of the writable layer, it is recommended to mount a volume to this directory.

### Data

The `/umbraco/Data/` directory is used to store temporary files, such as file uploads. Considering the limitations of the writable layer, you should also mount a volume to this directory.

### Media

Similarly to logs, it's recommended to not store media in the writable layer, both for performance reasons, 
but also for practical development reasons. You likely want to persist media files between containers. 

One possible solution here is to again use bind mounts, however the ideal solution is store the media and ImageSharp cache externally, 
for more information on this, refer to the [Azure Blob Storage documentation](https://docs.umbraco.com/umbraco-cms/extending/filesystemproviders/azure-blob-storage).

### Required files

If your solution requires some files to run, for instance license files, you need to pass these files into the container at build time, or mount them externally. 

## HTTPS

When running in websites in Docker, it's common to use do so behind a reverse proxy, or load balancers.
In these scenarios you're likely to handle SSL termination at the reverse proxy, this means that Umbraco will not be aware of the SSL termination, and will likely complain about not using HTTPS.

Umbraco checks for HTTPS in two locations:

1. The `HstsCheck` health check - This will result in a failed healthcheck.
2. The `UseHttpsValidator` - This will result in a build error, if Production runtime mode is used.

To avoid these checks failing, you can remove them in your project.

### Health Check

The health check must be removed via configuration, either through the `appsettings.json`, environment variables, or similar, for more information see the [Health Check documentation](../../../reference/configuration/healthchecks.md).

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

The `UseHttpsValidator` must be removed through code, for more information see the [Runtime mode documentation](runtime-modes.md).

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

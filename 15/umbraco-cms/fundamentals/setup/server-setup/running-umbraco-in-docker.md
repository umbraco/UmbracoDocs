# Running Umbraco in Docker

Exactly how you chose to compose your Dockerfile depends on your needs, and your project, so this section is not intended as a guide, 
but as a general overview of what to be aware of when hosting in Docker.

## What is Docker

Docker is a platform for developing, shipping, and running applications in containers. There exist various services for hosting these containers, 
for more information, [refer to the official Docker documentation](https://docs.docker.com/)

## The Docker file system

By default, all files created inside a container is written to a ephemeral writable container layer. 
This means that the files don't persist when the container is removed, and it's difficult to get files out of the container. Additionally, this writable layer is not suitable for performance-critical data processing.
This has several implications when running Umbraco in Docker. For more information refer to the [Docker documentation on storage](https://docs.docker.com/engine/storage/).

### General file system consideration 

In general, when working with files and Dockcer you work in a "push" fashion with the read-only layers, that is when you build you take all your files and "push" them into the read-only layer.
This means that you should avoid making files on the fly, and instead rely on building your image, this means that you should not create or edit template files on the fly, the same goes for script and style files. 

Similarly, you shouldn't use InMemory modelsbuilder, since that also relies on creating files on the disk, instead you should use source code in development, and none in production, as [described when using runtime modes](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/runtime-modes).


### Logs

Umbraco writes logs to the `/umbraco/Logs/` directory, due to the performance implications of writing to a writable layer, 
and the limited size of the writable layer, it is recommended to mount a volume to this directory.

### Media

Similarly to logs, it's recommended to not store media in the writable layer, both for performance reasons, 
but also for practical development reason, you likely want to persist media files between containers. 

One possible solution here is to again use bind mounts, however the ideal solution is store the media and ImageSharp cache externally, 
for more information on this, refer to the [Azure Blob Storage documentation](https://docs.umbraco.com/umbraco-cms/extending/filesystemproviders/azure-blob-storage).


## HTTPS

When running in websites in Docker, it's common to use do so behind a reverse proxy, or load balancers.
In these scenarios you're likely to handle SSL termination at the reverse proxy, this means that Umbraco will not be aware of the SSL termination, and will likely complain about not using HTTPS.


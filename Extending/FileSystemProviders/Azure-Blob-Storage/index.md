---
state: complete
verified-against: 9.0.0
versionFrom: 9.0.0
meta.Title: "Using Azure Blob Storage for Media and ImageSharp Cache"
meta.Description: "Setup your site to use Azure Blob storage for media and ImageSharp cache"
---

# Setup Your Site to use Azure Blob Storage for Media and ImageSharp Cache

For Umbraco sites there are some scenarios when you may want or need, to consider using Azure Blob Storage for your media. Particularly if your site contains large amounts of media.  Having your site's media in Azure Blob Storage can also help your deployments complete more quickly and have the potential to positively affect site performance as the ImageSharp cache is moved to Azure Blob Storage.  It also allows you to serve your media from the Azure CDN.

The setup consists of adding a package to your site, setting the correct configuration, and adding the services and middleware. Before you begin you’ll need to create an Azure Storage Account and a container for your media and ImageSharp cache. In this example, we assume your container name is "mysitestorage". You can, optionally, enable an Azure CDN for this storage container and use it in the appsettings.json below.

See [Microsoft documentation](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-portal) for information on how you set up blob storage container. 

## Installing the package

First things first we need to install the `Umbraco.StorageProviders.AzureBlob` NuGet package, there are two approaches to this. You can use your favorite IDE and open up NuGet package manager, and find it there, but you can also use the command line to install the package.

### Installing through command line

First, you need to navigate to your project folder, which is the folder that contains your `.csproj` file. Now use the dotnet add package command like so:

```
dotnet add package Umbraco.StorageProviders.AzureBlob
```

and the correct package will been installed in your project.


## Configuring Blob storage

The next step is to configure your blob storage, there are multiple approaches for this, but in this document, we're going to do it through `appsettings.json`, for more configuration options see the [readme](https://github.com/umbraco/Umbraco.StorageProviders#umbracostorageproviders) on the Github repository.

Open up your `appsettings.json` file, we need to add the connection string and container name under `Umbraco:Storage:AzureBlob:Media`, your Umbraco section of appsettings will look something like this:

```json
  "Umbraco": {
    "Storage": {
      "AzureBlob": {
        "Media": {
          "ConnectionString": "DefaultEndpointsProtocol=https;AccountName=<media account name>;AccountKey=<media account key>;EndpointSuffix=core.windows.net",
          "ContainerName": "mysitestorage"
        }
      }
    },
    "CMS": {
      "Hosting": {
        "Debug": false
      },
      {...}
    }
  }
```

Note that in this case the container name is mysitestorage. 

Tip: You can get your connection string from Azure under "Access Keys"

## Setting the services and middleware

We're almost there, the last step we need to do is to set up the required services and middleware, this may sound daunting, but thankfully there are extension methods that do all this for us, all we need to do is invoke them in the `ConfigureServices` and `Configure` methods in the `startup.cs` file.

Invoke the `.AddAzureBlobMediaFileSystem()` extention method in the `ConfigureServices` method:

```C#
        public void ConfigureServices(IServiceCollection services)
        {
#pragma warning disable IDE0022 // Use expression body for methods
            services.AddUmbraco(_env, _config)
                .AddBackOffice()
                .AddWebsite()
                .AddComposers()
                .AddAzureBlobMediaFileSystem() // This configures the required services 
                .Build();
#pragma warning restore IDE0022 // Use expression body for methods

        }
```

Next invoke `UseAzureBlobMediaFileSystem();` in the `.WithMiddleware` call like so:

```C#
public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    if (env.IsDevelopment())
    {
        app.UseDeveloperExceptionPage();
    }

    app.UseUmbraco()
        .WithMiddleware(u =>
        {
            u.UseBackOffice();
            u.UseWebsite();
            // This enables the Azure Blob storage middleware for media.
            u.UseAzureBlobMediaFileSystem();
        })
        .WithEndpoints(u =>
        {
            u.UseInstallerEndpoints();
            u.UseBackOfficeEndpoints();
            u.UseWebsiteEndpoints();
        });
}
```

Now when you launch your site again, the blob storage will be used to store media items as well as the ImageSharp cache. Do note though that the `media` and `cache` folders do not get created until a piece of media is uploaded.


## Existing Media files

Any media files you already have on your site will not automatically be added to the Blob Storage. You will need to copy the contents on the `/wwwroot/media` folder and upload it to the `media` folder on your Blob account. Once you've done that you can safely delete the `wwwroot/media` folder locally, as it is no longer needed.

Any new media files you upload to the site will automatically be added to the Blob Storage.

---

meta.Title: "Using Azure Blob Storage for Media and ImageSharp Cache"
description: "Setup your site to use Azure Blob storage for media and ImageSharp cache"
---

# Setup Your Site to use Azure Blob Storage for Media and ImageSharp Cache

There are some scenarios where you may want or need to consider leveraging Azure Blob Storage. An example would be for media in Umbraco sites with substantial media libraries.

Having your site's media in Azure Blob Storage can help your deployments complete more quickly. This has the potential to positively affect site performance, as the ImageSharp cache is moved to Azure Blob Storage.

The setup consists of adding a package to your site, setting the correct configuration, and adding the services and middleware. Before you begin you’ll need to create an Azure Storage Account and a container for your media and ImageSharp cache. In this example, we assume your container name is "mysitestorage" and has already been created.

See the [Microsoft documentation](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-portal) for a quickstart guide on how to create a blob storage container.

## Installing the package

Before you begin, you need to install the `Umbraco.StorageProviders.AzureBlob` NuGet package. There are two approaches to installing the package:

1. Use your favorite IDE and open up the NuGet Package Manager to search and install the package
1. Use the command line to install the package

### Installing through command line

Navigate to your project folder, which is the folder that contains your `.csproj` file. Now use the following `dotnet add package` command to install the package:

{% tabs %}
{% tab title="Latest version" %}
```none
dotnet add package Umbraco.StorageProviders.AzureBlob
```
{% endtab %}

{% tab title="Umbraco 9" %}
```none
dotnet add package Umbraco.StorageProviders.AzureBlob --version 1.1.1
```
{% endtab %}
{% endtabs %}


The correct package will have be installed in your project.

## Configuring Blob storage

The next step is to configure your blob storage. There are multiple approaches for this, but in this document, we're going to do it through `appsettings.json`. For more configuration options, see the [readme](https://github.com/umbraco/Umbraco.StorageProviders#umbracostorageproviders) on the GitHub repository.

Open up your `appsettings.json` file and add the connection string and container name under `Umbraco:Storage:AzureBlob:Media`. Your Umbraco section of appsettings will look something like this:

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

In this example, the container name is `mysitestorage`. 

{% hint style="info" %}
You can get your connection string from your Azure Portal under "Access Keys".
{% endhint %}

## Setting the services and middleware

You're almost there. The last step is to set up the required services and middleware. This may sound daunting, but thankfully there are extension methods that do all this for you. All you need to do is invoke them in the `ConfigureServices` and `Configure` methods in the `startup.cs` file.

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

{% hint style="info" %}
**If you are using Umbraco 9, follow this step before moving on**:

Next invoke `UseAzureBlobMediaFileSystem();` in the `.WithMiddleware` call, like so:

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
{% endhint %}

Now when you launch your site again, the blob storage will be used to store media items as well as the ImageSharp cache. Do note though that the `/media` and `/cache` folders do not get created until a piece of media is uploaded.


## Existing Media files

Any media files you already have on your site will not automatically be added to the blob storage container. You will need to copy the contents on the `/wwwroot/media` folder and upload them to a new folder called `/media` in your blob storage container. Once you've done that, you can safely delete the `wwwroot/media` folder locally, as it is no longer needed.

Any new media files you upload to the site will automatically be added to the Blob Storage.

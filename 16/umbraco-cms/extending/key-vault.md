---
description: A guide for configuring Azure Key Vault
---

# Configuring Azure Key Vault

From a security perspective, storing your application secrets in Azure Key Vault is always a good solution. This could be a connection string or other keys.

This article tells you how to configure your application so it is ready to use a Key Vault.

Depending on your hosting situation there are a few approaches to incorporating Azure Key Vault into your application.

1. [Install Key Vault via Nuget (for most Hosting scenarios)](key-vault.md#install-key-vault-via-nuget)
2. [Use Key Vault references for Azure App Service (For Azure Web App Hosting)](key-vault.md#use-key-vault-references-for-azure-app-service)

## Install Key Vault via Nuget

Before you begin, you need to install the `Azure.Extensions.AspNetCore.Configuration.Secrets` and the `Azure.Identity` NuGet packages. There are two approaches to installing the packages:

1. Use your favorite Integrated Development Environment (IDE) and open up the NuGet Package Manager to search and install the packages
2. Use the command line to install the package

### Installing through command line

Navigate to your project folder, which is the folder that contains your `.csproj` file. Now use the following `dotnet add package` command to install the packages:

```
dotnet add package Azure.Extensions.AspNetCore.Configuration.Secrets
dotnet add package Azure.Identity
```

### Configuration

{% hint style="info" %}
You can find the database connection string under the `Umbraco:CMS:ConnectionStrings` section in the `appsettings.json` file. For more information, see the [Connection strings settings](../reference/configuration/connectionstringssettings.md) article.
{% endhint %}

The next step is to add the Azure Key Vault endpoint to the `appsettings.json` file (or create as an Environment Variable). You can add this endpoint in the root or anywhere in the `appsettings.json` as long as it is resolved in the `ConfigureAppConfiguration` method.

```json
{
  "AzureKeyVaultEndpoint": "https://{your-key-vault-name}.vault.azure.net",
}
```

After adding the endpoint in the appsettings, it's time to add configuration so that the KeyVault is used. One way to achieve this is to write an extension method for the `WebApplicationBuilder`:

```csharp
using System;
using Azure.Identity;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

namespace My.Website;

public static class WebApplicationBuilderExtensions
{
	public static WebApplicationBuilder ConfigureKeyVault(this WebApplicationBuilder builder)
	{
		var keyVaultEndpoint = builder.Configuration["AzureKeyVaultEndpoint"];
		if (!string.IsNullOrWhiteSpace(keyVaultEndpoint) && Uri.TryCreate(keyVaultEndpoint, UriKind.Absolute, out var validUri))
		{
			builder.Configuration.AddAzureKeyVault(validUri, new DefaultAzureCredential());
		}

		return builder;
	}
}
```

After creating the extension method, it's possible to call it from the `Program.cs` class, like so:

```csharp
using Microsoft.AspNetCore.Builder;
using My.Project;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.ConfigureKeyVault();

builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

WebApplication app = builder.Build();

await app.BootUmbracoAsync();

app.UseUmbraco()
    .WithMiddleware(u =>
    {
        u.UseBackOffice();
        u.UseWebsite();
    })
    .WithEndpoints(u =>
    {
        u.UseBackOfficeEndpoints();
        u.UseWebsiteEndpoints();
    });

await app.RunAsync();
```

### Authentication

There are different ways to access the Azure Key Vault. It is important that the user you are logging in with has access to the Key Vault. You can assign roles using the Azure Portal.

1. Navigate to your Key Vault.
2. Select Access Control.
3. Select Add -> Add role assignment.
4. Select the preferred role.
5. Search for the user.
6. Click review + assign

## Use Key Vault references for Azure App Service

Azure Web Apps offers the ability to directly reference Key Vault secrets as App Settings. The benefit of this is you can securely store your secrets in Key Vault without any code changes required in your application.

### Create a System Assigned Managed Identity

To begin we first need to create a **Managed Identity** for the Azure Web App. This enables us to grant granular permissions to an identity representing the Web App.

Head over to your Azure Web App and find **Identity** under **Settings**:

![image](https://user-images.githubusercontent.com/11179749/196052374-cebcfbc3-848f-4866-8e0f-70a57e776f60.png)

Under **System assigned** change the Status from Off to **On**.

![image](https://user-images.githubusercontent.com/11179749/196052406-2205c1bc-504a-41be-86bf-81b1cabbc17f.png)

A GUID will then be generated called **Object (principal) ID**. Take note of this ID as we will need it further on.

### Update your Key Vault Access Policy

{% hint style="info" %}
Alternatively, you can use Role-Based Access Control on your Azure Key Vault.

Learn more about the difference between the two approaches and how to migrate between them on the [Azure Documentation platform](https://learn.microsoft.com/en-us/azure/key-vault/general/rbac-access-policy).
{% endhint %}

It is assumed you already have a Key Vault set up with a few Umbraco secrets inside. In your Key Vault head to **Access Policies**.

![image](https://user-images.githubusercontent.com/11179749/196052540-e1368016-ad7a-4b69-b05c-2875a4f11998.png)

At the top select **+ Create**. We are now going to add the **System Managed Identity** for the Web App to Key Vault.

![image](https://user-images.githubusercontent.com/11179749/196052612-e3b2041c-785f-46f5-b9b5-d8ad33b893ac.png)

You will now be presented with different permissions to set for your Web App. You only need **Get** and **List** for **Secret Permissions** only. Click **Next** to continue:

![image](https://user-images.githubusercontent.com/11179749/196052668-124d1496-4486-4098-9198-eff809876c80.png)

Enter the GUID you took note of earlier, into the **Search Box**. You will see your Web App listed.

![image](https://user-images.githubusercontent.com/11179749/196052706-15431bf4-80ea-4bb7-b40e-ebda45264fb7.png)

Click your Web App to Select and click Next and then Create:

![image](https://user-images.githubusercontent.com/11179749/196052849-970a97c5-e945-415a-9469-a67f485424ea.png)

If you visit the **Access Policies** section again you should now see your web app in the list and its permissions:

![image](https://user-images.githubusercontent.com/11179749/196052924-0d0559c0-a414-4bbd-ab91-94fc25dc720f.png)

### Link our Key Vault Secret to an Azure Web App

In your Azure Web App head to **Configuration** under **Settings**.

![image](https://user-images.githubusercontent.com/11179749/196053006-3a95fc5f-1038-4228-9ae4-467050ea5759.png)

Here we can add **App Settings** and **Connection Strings** to the environment.&#x20;

1. Let us start off with the **Umbraco Database Connection String**.

Under Connection Strings, select **Advanced Edit**.

![image](https://user-images.githubusercontent.com/11179749/196053130-8fb6c2b9-61c7-4c02-a419-8570174c6646.png)

Once you click on "**Advanced Edit"** a new window will open up. There you will need to paste in the following JSON Object inside the square brackets. Ensure you update `{keyvault-name}`, `{secret-name}` and `{version-id}`.

```json
{
    "name": "umbracoDbDSN",
    "value": "@Microsoft.KeyVault(SecretUri=https://{keyvault-name}.vault.azure.net/secrets/{secret-name}/{version-id}/)",
    "type": "Custom",
    "slotSetting": false
}
```

{% hint style="info" %}
You can obtain the Secret Uri by visiting the specific version of your secret and copying the Url:
{% endhint %}

![image](https://user-images.githubusercontent.com/11179749/196054001-cc215c04-d29c-435a-ae7b-6e8efb7f3faa.png)

The ID is optional but recommended as it enables you to control which version of the secret is used at your discretion. Leave it out if you always want the Web App to pull the latest version of the secret.

Wait a moment and refresh the screen. You should see a Green tick. If you do not have a Green tick you need to review your Access Policies in the previous step.

![image](https://user-images.githubusercontent.com/11179749/196053419-f53feba2-b8ed-4b98-99f0-ee68f58ac8e4.png)

2. We will perform the same approach for our **App Settings**. We will be updating the following App Settings for Azure Blob Storage.

```json
"Umbraco": {
    "Storage": {
      "AzureBlob": {
        "Media": {
          "ConnectionString": "",
          "ContainerName": ""
        }
      }
    }
```

Due to the secrets being nested we need to use double underscore `__` to correctly reference the value on our Web App.

On the Web App select **Advanced Edit** for Application Settings:&#x20;

<figure><img src="https://user-images.githubusercontent.com/11179749/196053630-dd90f240-0116-4471-bf7e-73bdbcfcc28a.png" alt=""><figcaption></figcaption></figure>

When clicking on "Advanced Edit", a new window will open up. There you will need to paste in the following JSON Objects inside the square brackets. Ensure you update `{keyvault-name}`, `{secret-name}` and `{version-id}`.

```json
{
    "name": "Umbraco__Storage__AzureBlob__Media__ConnectionString",
    "value": "@Microsoft.KeyVault(SecretUri=https://{keyvault-name}.vault.azure.net/secrets/{secret-name}/{version-id}/)",
    "slotSetting": false
},
{
    "name": "Umbraco__Storage__AzureBlob__Media__ContainerName",
    "value": "@Microsoft.KeyVault(SecretUri=https://{keyvault-name}.vault.azure.net/secrets/{secret-name}/{version-id}/)",
    "slotSetting": false
}
```

The ID is optional but recommended as it enables you to control which version of the secret is used at your discretion. Leave it out if you always want the Web App to pull the latest version of the secret.

Wait a moment and refresh the screen. You should see Green ticks for both values. If you do not have a Green tick you need to review your Access Policies in the previous step.&#x20;

<figure><img src="https://user-images.githubusercontent.com/11179749/196053743-e507f057-8fe7-4a68-9e2f-7229f1a340d7.png" alt=""><figcaption></figcaption></figure>

### Local Development

1. [Sign in to Visual Studio using the credentials that can access the Key Vault.](https://docs.microsoft.com/en-us/visualstudio/ide/signing-in-to-visual-studio)
2. [Use Azure CLI to store your preferred account into the credential cache.](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli)
3. [An example of extending and referencing secrets in `appsettings.json` in your local development environment.](https://gist.github.com/tgreensill/26659111871fdc54d0ac20cc21e602e1)

### Staging/Production

1. [Managed identities for Azure resources](https://docs.microsoft.com/en-us/aspnet/core/security/key-vault-configuration?view=aspnetcore-6.0#use-managed-identities-for-azure-resources)
2. [X.509 certificate for non-Azure-hosted apps](https://docs.microsoft.com/en-us/aspnet/core/security/key-vault-configuration?view=aspnetcore-6.0#use-application-id-and-x509-certificate-for-non-azure-hosted-apps)
3. [Use Key Vault references for App Service and Azure Functions](https://learn.microsoft.com/en-us/azure/app-service/app-service-key-vault-references)

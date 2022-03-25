---
versionFrom: 9.0.0
state: complete
meta.Title: "Azure Key Vault"
meta.Description: "A guide configuring an Azure Key Vault"
---

# Configuring an Azure Key Vault

From a security perspective, it's always a good solution to store your application secrets such as a connection string and others keys in an Azure Key Vault. This article tells you how to configure your application so that it's ready to use a Key Vault

## Installing the package

Before you begin, you need to install the `Microsoft.Extensions.Configuration.AzureKeyVault` NuGet package. There are two approaches to installing the package:

1. Use your favorite IDE and open up the NuGet Package Manager to search and install the package
1. Use the command line to install the package

## Installing through command line

Navigate to your project folder, which is the folder that contains your .csproj file. Now use the following dotnet add package command to install the package:

```
dotnet add package Microsoft.Extensions.Configuration.AzureKeyVault
```

## Configuration
The next step is to add the Azure Key Vault endpoint to the 'appsettings.json' file. 

```json
{
  "AzureKeyVaultEndpoint": "https://{your-key-vault-name}.vault.azure.net",
}
```

After adding the Key Vault endpoint you have to update the `CreateHostBuilder` method which you can find in the `Program.cs` class. 

```csharp
public static IHostBuilder CreateHostBuilder(string[] args) =>
    Host.CreateDefaultBuilder(args)
        .ConfigureLogging(x => x.ClearProviders())
        .ConfigureAppConfiguration((context, config) =>
        {
            var settings = config.Build();
            var keyVaultEndpoint = settings["AzureKeyVaultEndpoint"];
            if (!string.IsNullOrWhiteSpace(keyVaultEndpoint))
            {
                var azureServiceTokenProvider = new AzureServiceTokenProvider();
                var keyVaultClient =
                    new KeyVaultClient(
                        new KeyVaultClient.AuthenticationCallback(azureServiceTokenProvider
                            .KeyVaultTokenCallback));
                config.AddAzureKeyVault(keyVaultEndpoint, keyVaultClient, new DefaultKeyVaultSecretManager());
            }
        })
        .ConfigureWebHostDefaults(webBuilder => webBuilder.UseStartup<Startup>());
```

## Authentication 

There are several ways to access the Azure Key Vault. It is important that the user you are logging in with has access to the Key Vault. You can assign roles using the Azure Portal. 

1. Navigate to your Key Vault. 
1. Select Access Control.
1. Select Add -> Add role assignment.
1. Select the preferred role.
1. Search for the user. 
1. Click review + assign


### Local Developement 

1. [Sign in to Visual Studio using the credentials that can access the Key Vault.](https://docs.microsoft.com/en-us/visualstudio/ide/signing-in-to-visual-studio) 
1. [Use Azure CLI to store your preferred account into the credential cache.](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli)

### Staging/Production

1. [Managed identities for Azure resources](https://docs.microsoft.com/en-us/aspnet/core/security/key-vault-configuration?view=aspnetcore-6.0#use-managed-identities-for-azure-resources)
1. [X.509 certificate for non-Azure-hosted apps](https://docs.microsoft.com/en-us/aspnet/core/security/key-vault-configuration?view=aspnetcore-6.0#use-application-id-and-x509-certificate-for-non-azure-hosted-apps)
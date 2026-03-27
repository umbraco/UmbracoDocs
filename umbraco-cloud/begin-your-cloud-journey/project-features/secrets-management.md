---
description: >-
  Learn how to securely store, manage, and use secrets in Umbraco Cloud
  environments using Shared and Environment Secrets.
---

# Secrets Management

If your Umbraco Cloud project uses sensitive information such as API keys, encryption keys, or connection strings, you should store these as secrets.

You can add secrets to your Cloud project in two ways: **Environment Secrets** or **Shared Secrets**.

**Environment Secrets** are used within a specific environment during runtime of your Umbraco solution.

**Shared Secrets** are available across all environments and are automatically included in any new environment you create. Shared Secrets are well-suited for credentials needed during project development, such as access to private NuGet feeds.

{% hint style="warning" %}
Do not use environment-specific secrets for NuGet feeds. Use **Shared Secrets** to avoid environment creation failures.
{% endhint %}

Typical secrets are **Private keys**, **third-party API tokens**, **database passwords**, and other **sensitive data** that must be kept secure.

When secrets are added, they are exposed only to the assigned environments. Each secret is assigned as an environment variable at runtime using the secret name. The environment accesses the secret through a Key Vault reference secured by the environment’s managed identity.

{% hint style="info" %}
Starter Plans have a limit of 5 secrets per environment, whereas higher-tier plans do not have a limit
{% endhint %}

## How to add Secrets

{% hint style="warning" %}
#### Important

When adding a secret to your environment, the environment will restart.

Secrets are stored as environment variables. The underlying platform has a maximum size limit for all environment variables combined. If too many secrets are added, or if secret values are too large, your environment may fail to start.

**Recommendations:**

* Keep secrets small and concise.
* Store only sensitive values as secrets (for example, API keys and connection strings).
* Use `appsettings.json` for general configuration values.
{% endhint %}

To add a secret to your environment, follow these steps:

1. Go to your Umbraco Cloud project
2. Go to **Security**.
3. Select **Secrets**.
4. Choose **Shared Secrets** or the environment where you want to add the secret.
5. Click **Edit secrets**.
6. Select **Add secret**.
7. Enter the **Key** and the **Value** in the **Create secret** window.
8. Click **Add secret**.
9. Click **Save secrets** to save the secret.

## Working locally with Secrets

When developing locally, you cannot access secrets stored in the Key Vault for a Cloud environment.

It is recommended to use standard methods for handling secrets locally, such as the `appsettings.development.json`. Do not commit this file to your code repository. Add it to your `.gitignore` file to prevent accidental commits.

For example, if you have a secret in a Cloud environment with the key name `ApiKey`, you can create a corresponding entry in your `appsettings.development.json`:

```json
{
   "Serilog": {
     …
   },
   "Umbraco":{
     …
   },
   "ApiKey": "Value",
}
```

## Access secrets in an Umbraco Solution

Secrets for cloud environments are stored in a Key Vault and loaded by the App Service (using a Key Vault reference) as environment variables. This allows you to retrieve the value at runtime like any other environment variable.

You can access a secret in .NET using the System namespace:

`_secretMessage = Environment.GetEnvironmentVariable("SecretMessage");`

Secrets can also be used to override app settings defined in `appsettings.json` files. For this to work, when adding the secret, the key value should be all the settings names joined by double underscores.

For example, to change the Serilog default options under `Serilog:MinimumLevel:Default`, the Secret key would be: `Serilog__MinimumLevel__Default` .

The value defined in `appsettings.json` file will be overwritten by the Cloud secret value.

## Naming standards for Secrets

When naming a secret, you can use alphanumeric characters and underscores (`_`).

{% hint style="info" %}
If you need to use a dot (`.`) as part of an app setting, it should be replaced with a single underscore.

The app setting `Umbraco:Licenses:Products:Umbraco.Commerce` should become `Umbraco__Licenses__Products__Umbraco_Commerce`.
{% endhint %}

#### Reserved names

The following names are reserved and cannot be used:

* `COMMAND`
* `HOME`
* `PORT`
* `REMOTE`
* `DEBUGGING`
* `VERSION`
* `REGION_NAME`
* `CONNECTIONSTRINGS__UMBRACODBDSN`

#### Restricted prefixes

The following prefixes are not allowed:

* `UMBRACO_`
* `WEBSITE_`
* `SCM_`
* `SDEPLOY_`
* `DEPLOYMENT_`
* `DOCKER_`
* `CONTAINER_`
* `DIAGNOSTICS_`
* `APPSERVICEAPPLOGS_`
* `DOTNET_`
* `IDENTITY_`
* `MSI_`
* `WEBJOBS_`
* `FUNCTIONS_`
* `AzureWebJobsWP_`
* `PHP_`
* `FILE_`
* `DATABASE_`
* `WORDPRESS_`
* `MACHINEKEY_`
* `SQLCONNSTR`
* `SQLAZURECONNSTR_`
* `POSTGRESQLCONNSTR_`
* `CUSTOMCONNSTR_`
* `MYSQLCONNSTR_`
* `AZUREFILESSTORAGE_`
* `AZUREBLOBSTORAGE_`
* `NOTIFICATIONHUBCONNSTR_`
* `SERVICEBUSCONNSTR_`
* `EVENTHUBCONNSTR_`
* `DOCDBCONNSTR_`
* `REDISCACHECONNSTR_`
* `FILESHARESTORAGE_`

{% hint style="info" %}
The list of restricted prefixes is incomplete and will be updated as new cases arise.
{% endhint %}

### Accepted Prefixes

The following prefixes are allowed for Secrets on Umbraco Cloud:

* `Umbraco__CMS__Global__Smtp__`
* `Umbraco__Forms__Security__FormsApiKey__`
* `Umbraco__Forms__FieldTypes__Recaptcha__`
* `Umbraco__CMS__Integrations__`
* `Umbraco__CMS__DeliveryAPI__`
* `UMBRACO__LICENSES__`
* `UMBRACO__AUTHORIZEDSERVICES__`
* `UMBRACO__COMMERCE__`,
* `UMBRACO__AI__`,
* `Umbraco__CMS__Imaging__HMACSecretKey`

You can also use secrets to store API keys, passwords, and reCAPTCHA keys for Umbraco products on Umbraco Cloud.

If you have an existing or new secret that conflicts with the naming restrictions, contact Umbraco Support, and your request will be reviewed.

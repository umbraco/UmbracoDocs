---
description: >-
  If your Umbraco Cloud project uses sensitive information such as API keys,
  encryption keys, and connection strings, it is recommended to store these as
  secrets.
---

# Secrets Management

There are two ways to add secrets to your Cloud project, as an Environment Secrets or as a Shared Secrets.

Environment Secrets are intended to be utilized exclusively within a particular environment during the runtime of your Umbraco solution.

Shared Secrets are utilized across all environments and will be seamlessly integrated into any new environment you create. Shared Secrets are particularly well-suited for safeguarding credentials necessary for project development, such as access to private NuGet feeds.

{% hint style="warning" %}

Utilizing environment-specific secrets for private NuGet feeds will result in the unsuccessful creation of new environments due to the unknown status of the secret. In such instances, **Shared Secrets** should be used.

{% endhint %}

Typical secrets are **Private Keys**, **3rd-party API tokens**, **database passwords**, or otherwise **sensitive data** that needs to be kept secret.

When the secrets have been added they will be exposed exclusively to the assigned environments.

It will be assigned as an environment variable at runtime using the assigned name for the secret.

It will then use a reference that only the managed identity of the environment has access to.

{% hint style="info" %}
Starter Plans have a limit of 5 secrets per environment, whereas higher-tiered plans have no limit.
{% endhint %}

## How to add secrets

{% hint style="warning" %}
When adding a secret to your environment it will restart.
{% endhint %}

{% hint style="warning" %}

## Important

Secrets are stored as environment variables in your project.
The underlying platform has a maximum size limit for all environment variables combined.
If too many secrets are added, or if secret values are too large, your project may fail to start.

We Recommend:

- Keeping secrets small and concise.
- Storing only sensitive values as secrets (for example: API keys, connection strings).
- Using appsettings.json for general configuration values.
{% endhint %}

To add a secret to your environment follow these steps:

1. Go to your Umbraco Cloud project
2. Go to the Settings section and go to Secret Management
3. Choose either shared or environment secrets
4. Choose the environment to add the secret and click Add secret
5. Add the Key and the Value in the fields and click Add secret
6. Save the key to the environment.

## Working locally with secrets

When you develop locally, you cannot access secrets that are stored in the key vault associated with a cloud environment.

We recommend that you use common methods for handling secrets locally, such as using app settings in the `appsettings.development.json`.

The app setting should not be committed to the code repository or it needs to be ignored via a `gitignore` file.

An example could be that you have a secret in a cloud environment with the key name "ApiKey",

You should specify this with a corresponding name in a configuration file such as `appsettings.development.json`:

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

## Access secrets in a Umbraco Solution

Secrets for cloud environments are stored in a key vault and loaded by the app service (using a key vault reference) as an environment variable.

This enables you to get the value at runtime as you normally would fetch an environment variable.

You can use the method, getting it from the System namespace in .NET as below:

`_secretMessage = Environment.GetEnvironmentVariable("SecretMessage");`

Secrets can also be used to override AppSettings defined in `appsettings.json` files.

In order for this to work, when adding the secret, the Key value should be all the settings' names joined by double underscores.

For example, to change the Serilog's default options under `Serilog:MinimumLevel:Default`, the Secret key would look like this:

`Serilog__MinimumLevel__Default`

The value defined in `appsettings.json` file will be overwritten with the Cloud Secret's value.

## Naming standards for secrets

When naming a secret, it is possible to use alphanumeric characters as well as '\_' (underscore).

Some words are reserved and **cannot** be accepted:

* `COMMAND`
* `HOME`
* `PORT`
* `REMOTE`
* `DEBUGGING`
* `VERSION`
* `REGION_NAME`
* `CONNECTIONSTRINGS__UMBRACODBDSN`

The following prefixes are **not** accepted.

The list consists of:

* `UMBRACO_`
* `WEBSITE_`
* `SCM_`
* `SDEPLOY_`
* `DEPLOYMENT_`
* `DOCKER_`
* `CONTAINER_`
* `DIAGNOSTICS_`
* `APPSERVICEAPPLOGS_`
* `WEBSITE_`
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
The provided list of restricted prefixes is incomplete but will be continuously updated as new cases arise.
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
* `UMBRACO__COMMERCE__`

It is also possible to use Secrets to save API keys, Passwords, and ReChaptcha for all our Umbraco products on Umbraco Cloud.

Do you have an existing or new secret that you want to add to a key vault that conflicts with the name restrictions?

Then please contact Umbraco support, then we will consider it as soon as possible.

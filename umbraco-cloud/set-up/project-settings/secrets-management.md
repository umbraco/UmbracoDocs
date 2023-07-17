# Secrets Management

Secrets can be added for each of the environments that you have added to your Cloud project.

Typical secrets are **Private Keys**, **3rd-party API tokens**, **database passwords**, or otherwise **sensitive data** that needs to be kept secret.

When the secrets have been added they will be exposed exclusively to the assigned environments.

It will be assigned as an environment variable at runtime using the assigned name for the secret.

Then it will use a reference that only the managed identity of the environment has access to.

{% hint style="info" %}
You can add secrets to your Umbraco Cloud environments if you are on a standard plan or higher.
{% endhint %}

## How to add secrets

{% hint style="warning" %}
When adding a secret to your environment it will restart.
{% endhint %}

To add a secret to your environment follow these steps:

1. Go to your Umbraco Cloud project
2. Go to the settings section and go to Secret Management
3. Choose the environment to add the secret and click Add secret
4. Add the Key and the Value in the fields and click Add secret
5. Save the key to the environment.

## Working locally with secrets

When you develop locally, you cannot access secrets that are stored in the key vault associated with a cloud environment.

We recommend that you use common methods for handling secrets locally, such as using app settings in the `appsettings.development.json`.

The app setting should not be committed to the code repository or it needs to be ignored via a `gitignore` file.

An example could be that you have a secret in a cloud environment with the key name "ApiKey",

you should specify this with a corresponding name in a configuration file such as `appsettings.development.json`:

```json
{
   “Serilog”: {
     …
   },
   “Umbraco”:{
     …
   },
   “ApiKey”: “Value”,
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

When naming a secret, it is possible to use alphanumeric characters as well as '-' and '\_' (dash and underscore).

There are some reserved words that cannot be accepted:

* `COMMAND`
* `HOME`
* `PORT`
* `REMOTE`
* `DEBUGGING`
* `VERSION`
* `REGION_NAME`
* `CONNECTIONSTRINGS__UMBRACODBDSN`

There is also a number of prefixes that are not accepted.

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

### Accepted Prefixes

While we have a number of prefixes that are not accepted, we do allow the use of the below prefixes for Secrets on Umbraco Cloud:

* `Umbraco__CMS__Global__Smtp__`
* `Umbraco__Forms__Security__FormsApiKey`
* `Umbraco__Forms__FieldTypes__Recaptcha`
* `Umbraco__CMS__Integrations`
* `UMBRACO__CMS__DeliveryAPI` &#x20;

It is also possible to use Secrets to save API keys, Passwords, and ReChaptcha for all our Umbraco products on Umbraco Cloud.

Do you have an existing or new secret that you want to add to a key vault that conflicts with the name restrictions?

Then please contact Umbraco support, then we will then consider it as soon as possible.\\

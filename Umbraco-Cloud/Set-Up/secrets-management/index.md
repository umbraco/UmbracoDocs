# Secret Management on Umbraco Cloud

In this article, we will show how you can use secrets on your Umbraco Cloud Environments.

Secrets can be added for each of the environments that you have added to your Cloud project.

When the secrets have been added they will be exposed exclusively to the assigned environments.

It will be assigned as an environment variable at runtime using the assigned name for the secret.

Then it will use a reference that only the managed identity of the environment has access to.

:::note
You can add secrets to your Umbraco Cloud environments if you are on a standard plan or higher.
:::

## How to add secrets

:::warning
When adding a secret to your environment will restart.
:::

To add a secret to your environment follow the following steps:

1. Go to your Umbraco Cloud project
2. Go to the settings section and go to **Secret Management**
3. Choose the environment to add the secret and click **Add secret**
4. Add the Key and the Value in the fields and click **Add secret**
5. Save the key to the environment.

## Working locally with secrets

When you develop locally, you cannot access secrets that are stored in the key vault associated with a cloud environment.

We recommend that you use common methods for handling secrets locally, such as using app settings in the appsettings.development.json.

The app setting should not be committed to the code repository or it needs to be ignored via a gitignore file.

An example could be that you have a secret in a cloud environment with the key name "ApiKey", 

you should specify this with a corresponding name in a configuration file such as appsettings.development.json:

```JSON
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

You can use the method ```GetEnvironmentVariable```, getting it from the System namespace in .NET.

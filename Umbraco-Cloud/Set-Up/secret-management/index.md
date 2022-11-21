# Secret Management on Umbraco Cloud

In this article, we will show how you can use secrets on your Umbraco Cloud Environments.

Secrets can be added for each of the environments that you have added to your Cloud project.

When the secrets have been added they will be exposed exclusively to the assigned environments.

it will be assigned as an environment variable at runtime using the assigned name for the secret.

Then it will use a reference that only the managed identity of the environment has access to.

## How to add secrets

You can add secrets to your Umbraco Cloud environments if you are on a standard plan or higher.

To add a secret to your environment follow the following steps:

1. Go to your Umbraco Cloud project
2. Go to the settings section and go to **Secret Management**
3. Choose the environment to add the secret and click **Add secret**
4. Add the Key and the Value in the fields and click **Add secret**
5. Once the key has been added, save it to the environment.

Once the key has been saved the environment will be restarted.
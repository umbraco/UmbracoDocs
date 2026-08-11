# September 2023

## Key Takeaways

* **Shared Secrets** - Streamline your build process, enhance security, and say goodbye to repetitive environment configurations with "Shared Secrets" on Umbraco Cloud.
* **Upgraded "Usage" Page for Custom Plans** - If you've added extra bandwidth or media storage to your cloud project, our updated "Usage" page on Umbraco Cloud now accurately reflects those additions.

## Shared Secrets

We are thrilled to announce an important update to Umbraco Cloud’s _Secrets Management_ Page. You now have the ability to manage **Shared Secrets**, in addition to the existing capability of handling environment-specific secrets. This feature is specifically designed to increase flexibility, streamline deployments, and enhance security within your Umbraco projects.

The new "Shared Secrets" panel lets you define secrets that are critical during the build process of your Umbraco solution. These secrets are available across all environments, making it easier to manage configurations that are common to each environment.

![Shared Secrets](../../../.gitbook/assets/SharedSecrets.gif)

**The key benefits of shared secrets are:**

* **Universal Access**: Shared secrets offer you the convenience of a one-time setup. Once a shared secret is set, it will be seamlessly integrated into existing environments and any new environment you create.
* **Enhanced Security**: Like environment-specific secrets, shared secrets are securely stored in Azure Key Vault, with end-to-end encryption, ensuring that they are only exposed during runtime.
* **Ideal for Private NuGet Feeds**: If your project uses a private NuGet feed, shared secrets provide a way to securely manage feed credentials. This way, you don't have to manually configure each environment, making your DevOps process much smoother.

Besides the new shared secrets, we still have the **Environment Secrets**: For secrets that are specific to individual environments, continue to use the existing "Environment Secrets" panel. These secrets remain locked to the selected environment and won't be accessible by others.

For more detailed information on how to leverage secrets, visit our [documentation](https://docs.umbraco.com/umbraco-cloud/set-up/project-settings/secrets-management).

## Upgraded "Usage" Page for Custom Plans

We've specifically updated the "Usage" page for those who have added extra bandwidth or media storage to their project plan. Now, you'll see those custom additions accurately displayed. For example, if on a Professional plan, you purchase an additional 3000GB of bandwidth, your "Usage" page will show 3000GB instead of the default 1000GB.

![Extra usage 2](../../../.gitbook/assets/UsageExtra2.png)

If you are considering expanding your resources, you can contact our Sales team to add even more bandwidth or storage to your existing plan. You can also switch to a plan with dedicated resources for greater flexibility.

Feel free to reach out for any further assistance or clarification.

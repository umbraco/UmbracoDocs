# September 2023

## Key Takeaways

* **Shared Secrets** - Streamline your build process, enhance security, and say goodbye to repetitive environment configurations with "Shared Secrets" on Umbraco Cloud.

## Shared Secrets

We are thrilled to announce an important update to Umbraco Cloud’s _Secrets Management_ Page. You now have the ability to manage **Shared Secrets**, in addition to the existing capability of handling environment-specific secrets. This feature is specifically designed to increase flexibility, streamline deployments, and enhance security within your Umbraco projects.

The new "Shared Secrets" panel lets you define secrets that are critical during the build process of your Umbraco solution. These secrets are available across all environments, making it easier to manage configurations that are common to each environment.

**The key benefits of shared secrets are:**
- **Universal Access**: Shared secrets offer you the convenience of a one-time setup. Once a shared secret is set, it will be seamlessly integrated into existing environments and any new environment you create.
- **Enhanced Security**: Just like environment-specific secrets, shared secrets are securely stored in Azure Key Vault, with end-to-end encryption, ensuring that they are only exposed during runtime.
- **Ideal for Private NuGet Feeds**: If your project uses a private NuGet feed, shared secrets provide an easy way to securely manage feed credentials. This way, you don't have to manually configure each environment, making your DevOps process much smoother.

Besides the new shared secrets, we still have the Environment Secrets: For secrets that are specific to individual environments, continue to use the existing "Environment Secrets" panel. These secrets remain locked to the selected environment and won't be accessible by others.

For more detailed information on how to leverage these new features, please visit our documentation. Feel free to reach out with any questions or feedback; we always aim to provide solutions that best serve your needs.

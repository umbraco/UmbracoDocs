# March 2026

## Key Takeaways

* **CI/CD Deploy to any target** - Enables CI/CD Flow deployments to all environments in your project, giving you full control over which environment receives each deployment.

## CI/CD Deploy to any target

By default, CI/CD Flow only allows deployments to the left-most or the flexible environment. With the new **"Deploy to any target"** toggle in the `Configuration -> CI/CD Flow` advanced configuration section, you can now enable CI/CD Flow deployments to all environments in your project.

<figure><img src="../../../../.gitbook/assets/cicd-advanced-configuration.png" alt="CI/CD Flow Advanced configuration section with Deploy to any target toggle"><figcaption><p>CI/CD Flow - Advanced configuration section showing the "Deploy to any target" toggle.</p></figcaption></figure>

When enabled, deploying between environments through the Cloud Portal is disabled. All deployments must be handled through CI/CD Flow. As a result, the environments overview will no longer show:

- **Pending changes indicator** — the Portal will not track how far ahead environments are relative to each other.
- **Deploy button** — you can no longer push changes forward using the Cloud Portal UI.

<figure><img src="../../../../.gitbook/assets/cicd-changed-environment-overview.png" alt="Updated environment overview without Deploy button and pending changes"><figcaption><p>Example of the updated environment overview when "Deploy to any target" is enabled.</p></figcaption></figure>

Instead, each environment card shows which artifact is currently deployed.

{% hint style="warning" %}
Enabling "Deploy to any target" means each CI/CD deployment creates a unique commit per environment. The more you use the feature, the more environments will diverge. Disabling the feature later requires realigning all environments, which is a time-consuming process.
{% endhint %}

For more information on setting up pipelines that deploy to multiple environments, see [Advanced Setup: Deploy to multiple targets](../../build-and-customize-your-solution/handle-deployments-and-environments/umbraco-cicd/samplecicdpipeline/advanced-multiple-targets.md).

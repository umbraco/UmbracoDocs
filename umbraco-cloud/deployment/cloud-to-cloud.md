---
updatedLinks: true
---

# Deploying between environments

When your are Working in your Development environment, changes made through the Backoffice are automatically detected and committed to the site's Git repository. This includes Umbraco-specific items like Document types and templates.

Changes made on your Cloud environments will show up in the Umbraco Cloud portal. You'll be able to see what files have been added/changed and who made the changes.

To deploy metadata changes from one Cloud environment to another, click the **'Deploy changes to ..'** button on the environment where the changes have been made.&#x20;

<figure><img src="../.gitbook/assets/image (39).png" alt=""><figcaption></figcaption></figure>

The deployment initiates, and you can see the process in the **Overview of your project.**

<figure><img src="../.gitbook/assets/image (41).png" alt="Deployment in progress"><figcaption><p>Deployment in progress</p></figcaption></figure>

Once it's done, the changes will be deployed to the next Cloud environment. If you have more Cloud environments, follow the same procedure to deploy the changes up to your Live site.

## Important Notes

When you deploy, for example, from your Development environment to your Live environment, changes are made to the Live environment. These changes will then be merged back into the Development environment.

Here are the auto-magical steps Umbraco Cloud goes through when you hit the _"Deploy changes to .."_ button:

* Before pushing your changes from the source environment, the engine running Umbraco Cloud - **Umbraco Deploy** - looks for changes in the repository on the target environment
* If changes are found, Umbraco Deploy _merges_ the changes from the target environment into the repository on the source environment.
* After the merge, the changes from the source environment are pushed to the repository on the target environment.
* Finally, the changes pushed to the target repository are extracted to the site, and you will now see your changes reflected in the Backoffice and on the Frontend.

If you have more than one Umbraco Cloud environment, we strongly recommend that you **only make changes to metadata on the Development environment**. Making changes directly on your Staging and/or Live environments can cause merge conflicts when you deploy from your Development environment.

{% hint style="danger" %}
It is important to be aware of how deletions work between environments. Some deletions are environment-specific and others are not. For more information see the [Deploying Deletions article](deploying-deletions.md).
{% endhint %}

Refer to our troubleshooting documentation about [how to resolve collision errors](../troubleshooting/deployments/structure-error.md), if you should run into issues while deploying between your Umbraco Cloud environments.



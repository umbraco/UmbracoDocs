# January 2023

## Highlights video

{% embed url="https://youtu.be/IofB31h-Lpc" %}
Cloud highlights January 2023
{% endembed %}

## UK Region Hosting

With an increasing interest in using Umbraco Cloud as the development and hosting platform for Umbraco projects. We’ve also seen an increased demand for additional regional hosting options. Especially when it comes to privacy and data policy requirements, the physical location of the data matters.

Regional Hosting Options make it possible to choose where your Umbraco Cloud project, including all environments and data, is served and stored.

Umbraco Cloud has reached a new milestone with the addition of a UK regional hosting option. This is fantastic news for everyone based in and working with clients in the UK.

![Cloud-artboard](../../images/umbraco-cloud-update-artboard-1-2x.png)

This means can now choose to create new Umbraco Cloud projects in "West Europe", "US East", and "UK South".

## Display of Multi-factor Authentication Setting for Organization Members

Since October last year, users has the opportunity to enable Multi-Factor Authentication and authenticate with either phone, email, or an authenticator app.

Now we deliver the second part of the planned three steps of the Multi-Factor Authentication feature. We ensure that administrators in a cloud organization can see the multi-factor authentication settings for all organization members.

![OrgMfaDisplay](../../images/OrgMfaDisplay2.png)

The third and final step will be the enforcement of Multi-Factor-Authentication per user level based on an organization setting. This means that an administrator can set the desired Multi-Factor-Authentication type (email, phone, or authenticator app) for each individual user. This will then be imposed on the user at the next login to Umbraco Cloud. The enforcement of multi-factor authentication for organization members is expected to be delivered in the first quarter of 2023.

## [Prefixes for Naming Secrets](https://docs.umbraco.com/umbraco-cloud/set-up/project-settings/secrets-management)

In December the Secrets Management feature was released in Umbraco Cloud. This enables Cloud projects on the Standard and Pro plans to securely store secrets in Azure key vaults and manage them in the Portal. These can then be referenced and accessed during the runtime of the application on a per-environment basis.

Naming secrets is subject to some restrictions to ensure that reserved words and application settings cannot be accidentally overwritten.

However, it is now possible to change parameters for namespaces related to adding a Simple Mail Transfer Protocol (SMTP) to the Umbraco CMS, saving the Umbraco Forms API key, or using ReChaptcha for Umbraco Forms.

These namespaces are:

* Umbraco:CMS:Global:Smtp
* Umbraco:Forms:Security:FormsApiKey
* Umbraco:Forms:FieldTypes:Recaptcha

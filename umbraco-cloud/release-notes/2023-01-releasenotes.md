# Release Notes, January 2023

## Key Takeaways

* **UK Region Hosting** - Umbraco Cloud expands with UK regional hosting.
* **Display of Multi-factor authentication setting for organization members** - As an administrator at a cloud organization, you can see the multi-factor authentication setting for all the organization's members.
* **Prefixes for naming secrets** - When naming secrets, you can reference the security-related settings for Umbraco:CMS:Global:Smtp, Umbraco Forms API-key, and field reCAPTCHAS.

## UK Region Hosting

With an increasing interest in using Umbraco Cloud as the development and hosting platform for Umbraco projects, we’ve also seen an increased demand for additional regional hosting options. Especially when it comes to privacy and data policy requirements, the physical location of the data matters.

Regional Hosting Options make it possible to choose where your Umbraco Cloud project, including all environments and data, is served and stored.

Umbraco Cloud has reached a new milestone with the addition of a UK regional hosting option. This is fantastic news for everyone based in and working with clients in the UK. 

![Cloud-artboard](images/umbraco-cloud-update-artboard-1-2x.png)

You are now able to create a new Umbraco Cloud project in "West Europe", "US East", or "UK South" to the delight of the majority of our European and American customers.

## Display of Multi-factor authentication setting for organisation members

Since October last year, users has the opportunity to enable Multi-Factor Authentication (MFA) and authenticate with either phone, email, or an authenticator app.

Now we deliver the second part of the planned three steps of the MFA feature, by ensuring that an administrator in a cloud organization can see the multi-factor authentication settings for all organization members.

![OrgMfaDisplay](images/OrgMfaDisplay2.png)

The third and final step will be the enforcement of MFA per user level based on an organization setting. This means that an administrator can set the desired MFA type (email, phone or authenticator app) for each individual user, which will then be imposed on the user at the next login to Umbraco Cloud. The enforcement of multi-factorr authentication for organisation members is expected to be delivered in the first quarter of 2023.

## [Prefixes for naming secrets](https://docs.umbraco.com/umbraco-cloud/set-up/project-settings/secrets-management)

In December the Secrets Management feature was released in Umbraco Cloud, enabling all Cloud projects on the Standard and Pro plans to securely store secrets in Azure key vaults and manage them in the Cloud portal. These can then be referenced and accessed during the runtime of the application on a per-environment basis.

The naming of secrets is subject to some restrictions to ensure that reserved words and application settings cannot be accidentally overwritten.

Certain application settings should, however, be overwritten precisely under the auspices of security. Whereby it is now possible to overwrite the following three namespaces
- Umbraco:CMS:Global:Smtp
- Umbraco:Forms:Security:FormsApiKey
- Umbraco:Forms:FieldTypes:Recaptcha  

There namespaces are relevant to consider when adding a SMTP to the Umbraco CMS, saving the Umbraco Forms API key, or using the ReChaptcha for Umbraco Forms.

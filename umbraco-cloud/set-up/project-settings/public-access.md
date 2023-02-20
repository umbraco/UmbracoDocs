---
description: In this article, we show how you can enable public access for your Umbraco Cloud project, so only people with whitelisted IPs can access your project.
---

# Public Access

{% hint style="info" %}
Public access is by default available for projects created after the 10th of January 2023.

The [Umbraco.Cloud.Cms.PublicAccess](https://www.nuget.org/packages/Umbraco.Cloud.Cms.PublicAccess) package can be installed to enable Public access for projects created before the 10th of January 2023.
{% endhint %}

Public access lets you deny access to your Umbraco Cloud project.

When enabled only team members on the project and users whose IPs have been allowed, can access the frontend of the project.

All environments on Umbraco Cloud projects can be protected by Public access. It requires you to enter your Cloud credentials in order to view the frontend.

By default, we add **Basic Authentication** to all trials and non-live environments.      

## How to enable Basic Authentication and allow IPs

1. Go to **Public Access** in the **project settings** tab
2. Enable **Basic Authentication** on the project
   
![Hostnames Specific Security Settings](../images/basic_auth.png)

3. Once enabled **Allow** IPs for users that need access to the project
   
![Hostnames Specific Security Settings](../images/allow_ip.png)

Once **Basic Authentication** has been enabled, users not on the project or with IPs not added to the allowlist will be prompted to log in.




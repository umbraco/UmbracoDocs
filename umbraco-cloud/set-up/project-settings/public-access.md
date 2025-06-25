---
description: >-
  In this article, we show how you can enable public access for your Umbraco
  Cloud project, so only people with whitelisted IPs can access your project.
---

# Public Access

{% hint style="info" %}
Public access is by default available for projects created after the 10th of January 2023.

The [Umbraco.Cloud.Cms.PublicAccess](https://www.nuget.org/packages/Umbraco.Cloud.Cms.PublicAccess) package can be installed to enable Public access for projects created before the 10th of January 2023.

The public access feature is available for all Umbraco Cloud projects on the standard plan or higher.
{% endhint %}

**Public Access** lets you deny access to your Umbraco Cloud project.

When enabled only team members on the project and users whose IPs have been allowed, can access the frontend of the project.

All environments on Umbraco Cloud projects can be protected by Public access. It requires you to enter your Cloud credentials in order to view the frontend.

{% hint style="info" %}
By default, **Basic Authentication** is enabled on trial projects.
{% endhint %}

## How to enable Basic Authentication and allow IPs

1. Go to **Public Access** in the **project settings** tab
2. Enable **Basic Authentication** on the project

![Enable Basic Authentication](../images/basic_auth.png)

3. Once enabled **Add IPs** for users that need access to the project

![Allow IPs for your Umbraco Cloud Project](../images/allow_ip.png)

Once **Basic Authentication** has been enabled, users not on the project or with IPs not added to the allowlist will be prompted to log in.

### CMS Basic Authentication

The **Public Access** feature in Umbraco Cloud is built on top of the **Basic Authentication** implementation in CMS core. This means the `appsettings` related to Basic Authentication are controlled by Umbraco Cloud, and your Cloud Environment has access to them. 

This setup allows you to configure an `HttpClient` that can do a loop back request without being blocked, by adding the **Shared Secret** Header if needed.

```csharp
// Setup http client that does loop back requests
var basicAuthEnabled = Environment.GetEnvironmentVariable("UMBRACO__CMS__BASICAUTH__ENABLED") == "True";
if (basicAuthEnabled) {
    var headerName = Environment.GetEnvironmentVariable("UMBRACO__CMS__BASICAUTH__SHAREDSECRET__HEADERNAME");
    var headerValue = Environment.GetEnvironmentVariable("UMBRACO__CMS__BASICAUTH__SHAREDSECRET__VALUE");
    
    loopbackHttpClient.DefaultRequestHeaders.Add(headerName, headerValue));
}
```

- [CMS Configuration: Reading Configuration in Code](https://docs.umbraco.com/umbraco-cms/reference/configuration#reading-configuration-in-code)
- [CMS Configuration Options: Basic Authentication Settings](https://docs.umbraco.com/umbraco-cms/reference/configuration/basicauthsettings)


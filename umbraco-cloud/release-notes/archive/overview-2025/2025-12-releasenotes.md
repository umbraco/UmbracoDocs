# December 2025

## Key Takeaways

* **Custom Login Provider out of beta** – You can now integrate your organization's identity provider to manage access to the Cloud Portal and projects.
* **Transport Layer Security (TLS) cipher suite updates** – New projects now have legacy cipher suites disabled by default for improved security.
* **Improved usage notifications** – Reduced notification noise and added repeated threshold alerts based on partner feedback.
* **Testing Dedicated Resources in the US market** – Dedicated Resources is being tested as the default option for new projects in the US region.
* **End-of-Service policy now available** – A predictable timeline for Umbraco Cloud projects reaching end-of-life.

## Custom Login Provider out of beta

Custom Login Provider support for Umbraco Cloud is now generally available. You can integrate your organization's identity provider to manage access to the Cloud Portal and projects. Use your existing authentication flows and policies.

See the [Organization Login Providers documentation](../../begin-your-cloud-journey/the-cloud-portal/organizations/organization-login-providers.md) for more details.

## TLS cipher suite updates

New Umbraco Cloud projects now have legacy cipher suites disabled by default for improved security. You can toggle each cipher suite on or off, giving you full control over your project's transport security.

Cipher suites are categorized by security recommendation:

- **Modern**: Highest security with TLS 1.2-1.3 and authenticated encryption. Recommended for maximum security and performance.
- **Compatible**: Balanced security with broader client support. Enabled by default alongside Modern ciphers.
- **Legacy**: Basic security for outdated clients. Disabled by default on new projects.

Adjust these settings under **Security > Transport Security** in your project settings. Enable legacy ciphers only when supporting older clients that cannot use modern encryption.

No action is required for existing projects. As always, periodically review your security configurations to ensure they align with current best practices.

See the [Managing Transport Security documentation](../../../build-and-customize-your-solution/set-up-your-project/security/managing-transport-security.md) for more details.

## Improved handling and notifications for project usage limits

Based on partner feedback, Umbraco Cloud now communicates usage limits for bandwidth and media storage more efficiently. Daily warning emails have been removed to reduce unnecessary noise. Repeated threshold alerts notify you each time your media storage exceeds the limit. For example, if you reduce usage and then exceed the limit again, you receive another alert.

Combined with the [recently added daily bandwidth usage graph](2025-10-releasenotes.md), these changes make monitoring your project's resource consumption easier.

## Testing Dedicated Resources as the default in the US market

Dedicated Resources is currently being tested as the default option for new Umbraco Cloud projects in the US region. You can choose Dedicated Resources during project creation, or opt-in to use Shared Resources.

The test is controlled and does not affect existing projects or regions outside the US. Based on feedback and usage, the feature may be rolled out to more regions.

## End-of-Service policy for Umbraco Cloud now available

The policy provides a predictable timeline for all Umbraco Cloud projects that reach end-of-life. You can now do up-front and long-term planning for your clients on Cloud.

[See the full policy in the Umbraco Cloud documentation](../../../optimize-and-maintain-your-site/manage-product-upgrades/end-of-service-policy.md) along with dates and milestones for all major CMS versions.

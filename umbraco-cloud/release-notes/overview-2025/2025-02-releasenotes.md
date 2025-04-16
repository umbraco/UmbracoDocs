# February 2025

## Key Takeaways

* **Updated Bandwidth Methodology** - Only end-user traffic is counted, reducing reported usage and encouraging caching.
* **Custom Identity Provider** - Configure your own login provider directly in Umbraco Cloud and use it to sign into your project.

## Updated Bandwidth Methodology

Measuring bandwidth usage in Umbraco Cloud has been updated to better reflect how other services calculate it.
As of February 1st, 2025, only traffic between the end user and Umbraco Cloud is counted — internal traffic is no longer included.

This change means bandwidth stats now give a more accurate picture of real-world usage.

Bandwidth usage may now show around 50–100% of what you saw before, depending on your setup.


## Custom Identity Provider
You can now connect your Active Directory to Umbraco CMS using OpenID Connect.
This utilizes external login provider support in the CMS, configurable directly through the Umbraco Cloud portal—no coding required.

A secure and convenient way to manage user access with your existing identity setup. It is useful for teams already using centralized authentication.

---
meta.Title: "Umbraco Plumber Licensing"
meta.Description: "Here you can find information about how to use license with Umbraco Plumber"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Licensing

Umbraco Plumber is a licensed product but doesn't require a purchase to use. New installs are defaulted to a trial license, while the paid license is available for purchase. The trial license introduces some restrictions around advanced features but is otherwise a full-featured workflow platform. The paid license is valid for one top-level domain and all its subdomains.

To impersonate the full license on a local site:

1. Create an empty text file named `test.lic`.
2. Copy the `test.lic` file  into `/App_plugins/Plumber`.
   ![Lic Placement](images/lic.png)

:::note
The test license is restricted to naked localhost, localtest domains, or domains ending in `.test` or `.local`.
:::

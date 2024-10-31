# Compare with Umbraco CMS

### Differences between Heartcore and Umbraco CMS

There are some differences between Heartcore and Umbraco CMS.

<details>

<summary>Setup </summary>

You can set up a new project with a few clicks through the [**Umbraco Cloud Portal**](https://umbraco.io/)**.**

Your project will then be up and running within a couple of minutes.

</details>

<details>

<summary>Managed Upgrades</summary>

With **Umbraco Heartcore** you won't need to worry about upgrading your project.

As **Heartcore** is a SasS product, we manage upgrades for your Heartcore project.

</details>

<details>

<summary>Packages</summary>

Heartcore comes out of the box with [**Umbraco Forms**](api-documentation/content-management/forms.md) installed on the starter plan and above.

It is however not possible to install other packages in Umbraco Heartcore as the code base is Closed source.

Instead, other features like **GraphQL**, an out-of-the-box **Content Delivery Network** (CDN) by Cloudflare, and a **Preview API** are available in Umbraco Heartcore.

</details>

<details>

<summary>Template section</summary>

Umbraco Heartcore is a headless offering, meaning the frontend is decoupled from the backend. It is not possible to create templates in Umbraco Heartcore and the section is not available.

</details>

<details>

<summary>Special property aliases</summary>

Some [special property aliases](https://docs.umbraco.com/umbraco-cms/reference/routing/routing-properties) can manipulate the standard Umbraco routing pipeline in the Umbraco CMS.

Since the frontend and backend of Umbraco Heartcore are decoupled, it's not possible to use these aliases in Umbraco Heartcore.

The aliases are:

* `umbracoRedirect`
* `umbracoInternalRedirectId`
* `umbracoUrlAlias`

The `umbracoUrlName` property type alias works correctly in Umbraco Heartcore.

</details>

<details>

<summary>Custom Grid Editor</summary>

In Heartcore, the Grid editor is working a bit differently compared to the CMS.\
To see how to work with the Grid editor in Heartcore, have a look at the Creating a Custom Grid Editor Tutorial.

</details>

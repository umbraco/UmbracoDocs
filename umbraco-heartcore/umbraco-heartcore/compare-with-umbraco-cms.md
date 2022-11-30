# Compare with Umbraco CMS

### Differences between Heartcore and Umbraco CMS

There are four differences between Heartcore and Umbraco CMS.

<details>

<summary>Package Section</summary>

As a SaaS, it is not possible to install packages in Umbraco Heartcore as the code base is Closed source.

Instead, other features like **GraphQL**, an out-of-the-box **Content Delivery Network** (CDN) by Cloudflare and a **Preview API** are available in Umbraco Heartcore.

</details>

<details>

<summary>Template section</summary>

Umbraco Heartcore is a headless offering, meaning the frontend is decoupled from the backend. It is not possible to create templates in Umbraco Heartcore and the section is not available.

</details>

<details>

<summary>Special property aliases</summary>

Some special property aliases can manipulate the standard Umbraco routing pipeline in the Umbraco CMS.

Since the frontend and backend of Umbraco Heartcore are decoupled, it's not possible to use these aliases in Umbraco Heartcore.

The aliases are:

* umbracoRedirect
* umbracoInternalRedirectId
* umbracoUrlName
* umbracoUrlAlias

</details>

<details>

<summary>Custom Grid Editor</summary>

In Heartcore, the Grid editor is working a bit differently compared to the CMS.\
To see how to work with the Grid editor in Heartcore, have a look at the Creating a Custom Grid Editor Tutorial.

</details>

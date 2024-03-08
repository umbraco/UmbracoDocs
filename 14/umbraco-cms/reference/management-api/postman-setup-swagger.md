---
description: Setup OAuth authorization for swagger via Postman
---

# Overview

{% hint style="info" %}

This guide is created by a community member and is not managed by Umbraco HQ. Some attributes may change in the future because of the integration with Postman (third-party tool).

{% endhint %}

This guide covers how to set up OAuth authorization for Swagger using Postman. It showcases a starting point on how to set up a basic OAuth authorization for those who are not that familiar with OAuth integration.

Before proceeding, make sure to read the [Management API](./README.md) article. It provides information about Authorization and why it is needed in this article.

This guide covers the following:

1. [Importing the collection](#importing-the-collection)
2. [Setup authorization](#setup-authorization)
3. [Get a token for a new user](#get-a-token-for-a-new-user)
4. [Common pitfalls and errors](#common-pitfalls-and-errors)

# Importing the collection

1. Open the swagger UI at `{yourdomain}/umbraco/swagger`.
2. Choose **Umbraco Management API** from **Select a definition**.
3. Open the JSON file, which you can find right underneath the **Title**:

![JSON file location](../images/postman-setup-swagger-json-file.png)

4. Save the JSON file to disk. The name of the file will be saved by default with the name of `swagger.json`.
5. Click to [create a new collection](https://learning.postman.com/docs/collections/using-collections/#creating-collections) in Postman.
6. Import the `swagger.json` file.
7. Choose **Postman Collection** when prompted.

![Postman import JSON file as collection](../images/postman-setup-swagger-import.png)

Once imported, you will see a new collection called **Umbraco Management API**.

# Setup Authorization

## Setup Variables Values

1. Click on **Variables** tab in the **Umbraco Management API** collection.
2. Add a new variable called `baseUrl` and in the **Initial** and **Current** values add your URL, which in this example we use the `localhost URL` (without trailing slashes):

```http
https://localhost:44331
```

{% hint style="info" %}

The localhost URL might vary from this example. Make sure to change the URL to the current localhost URL your project is running on.

{% endhint %}

3. Save the changes.

## Setup Authorization Values

In the **Umbraco Management API** collection click on **Authorization** tab and follow these steps:

1. On **Type** choose `OAuth 2.0`
2. Check if those attributes are setup:

* **Add auth data** is set to `Request Headers`
* **Auto-refresh token** is `Disabled`

### Configure Token

Now let's setup a new token:

1. Add a **Token name** called `BackofficeSwagger` under **Configure New Token**. The token name can be anything.
2. On **Grant Type** choose `Authorization Code (With PKCE)`.
3. On **Callback URL** click to enable `Authorize using browser`.
4.  Add the following on **Auth URL**:

```http
{{baseUrl}}/umbraco/management/api/v1/security/back-office/authorize
```

5. On **Access Token URL** add:

```http
{{baseUrl}}/umbraco/management/api/v1/security/back-office/token
```

6. On **Client ID** add `umbraco-postman`.
7. On **Code Challenge Method** choose `SHA-256`.
8. On **Client Authentication** choose `Send Client credentials in body`.
9. Any other field should be empty or auto-filled by default. **Save** and then:

* Click on **Get New Access Token**. Then a window will popup to authenticate into the Backoffice. Follow the given instructuction to **Open in Postman**.
* Then in Postman you will see a new **Manage access tokens** window. Click **Use Token**.

# Get a token for a new user

1. Click on **Authorization** tab in the **Umbraco Management API** collection .
2. Click on `Clear Cookies` at the bottom of the page above the **Get New Access Token**.
3. Open your localhost instance of Umbraco in the browser. Example: `https://localhost:44331`.
4. Inspect the page, go to **Application** tab and clear the `UmbracoBackOffice` cookie.
5. Go to Postman and click on **Get New Access Token** and once authenticated click on **Use Token**.

# Common pitfalls and errors

## Missing agent

When trying to obtain a token you might run into an error when trying to obtain a token. When looking in the postman console and see the following `Error: localhost request not supported`. This means you are missing the postman agent. You can get this from the [Postmant website](https://www.postman.com/downloads/postman-agent/) and try again.

## SSL Certificate verification

When requesting a token, you might get an error that reads `Error: unable to verify the first certificate` in the console.
To resolve this, next to **Invite** button, click on the **Settings** cog wheel in top right corner:

![Postman Cog Wheel Location](../images/postman-setup-swagger-cog-wheel.png)

Click on **Settings** and disable `SSL certificate verification`.

## Making a request

When making a request for the first time, follow these steps:

1. Click on the **Authorization** tab in the **Umbraco Management API** collection.
2. Choose `Inherit auth from parent` from **Type**.
3. Disable any parameters you are not using as Postman sets their value to default sometimes.
4. Click **Save**

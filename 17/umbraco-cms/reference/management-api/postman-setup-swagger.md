---
description: Setup OAuth authorization for swagger via Postman
---

# Setup OAuth using Postman

## Overview

{% hint style="info" %}
This guide is created by a community member and is not managed by Umbraco HQ. Some attributes may change in the future because of the integration with Postman (third-party tool).
{% endhint %}

This guide covers how to set up OAuth authorization for the Management API using Postman.

Before proceeding, make sure to read the [Management API](./) article. It provides information about Authorization and why it is needed in this article.

This guide covers the following:

1. [Importing the collection](postman-setup-swagger.md#importing-the-collection)
2. [Setup authorization](postman-setup-swagger.md#setup-authorization)
3. [Get a token for a new user](postman-setup-swagger.md#get-a-token-for-a-new-user)
4. [Common pitfalls and errors](postman-setup-swagger.md#common-pitfalls-and-errors)

## Importing the collection

1. Open the OpenAPI UI at `{yourdomain}/umbraco/openapi`.
2. Choose **Umbraco Management API** from **Select a definition**.
3. Open the JSON file, which you can find right underneath the **Title**:

![JSON file location](../../.gitbook/assets/postman-setup-swagger-json-file.png)

4. Save the JSON file to disk. The name of the file will be saved by default with the name of `swagger.json`.
5. Click to [create a new collection](https://learning.postman.com/docs/collections/using-collections/#creating-collections) in Postman.
6. Import the `swagger.json` file.
7. Choose **Postman Collection** when prompted.

![Postman import JSON file as collection](../../.gitbook/assets/postman-setup-swagger-import.png)

Once imported, you will see a new collection called **Umbraco Management API**.

## Setup Authorization

### Setup Variables Values

1. Click on **Variables** tab in the **Umbraco Management API** collection.
2. Add a new variable called `baseUrl` and in the **Initial** and **Current** values add your URL, which in this example we use the `localhost URL` (without trailing slashes):

```http
https://localhost:44331
```

{% hint style="info" %}
The localhost URL might vary from this example. Make sure to change the URL to the current localhost URL your project is running on.
{% endhint %}

3. Save the changes.

### Setup Authorization Values

To set up authorization values, follow these steps:

1. Click on **Authorization** tab in the **Umbraco Management API** collection.
2. Choose `OAuth 2.0` from **Type**
3. Check if these attributes are set:

* **Add auth data** is set to `Request Headers`
* **Auto-refresh token** is `Disabled`

#### Configure Token

Now let's setup a new token:

1. Add a **Token name** called `BackofficeSwagger` under **Configure New Token**. The token name can be anything.
2. Choose `Authorization Code (With PKCE)` from **Grant Type**.
3. Click to enable `Authorize using browser` on **Callback URL**.
4. Add the following on **Auth URL**:

```http
{{baseUrl}}/umbraco/management/api/v1/security/back-office/authorize
```

5. Add the following on **Access Token URL**:

```http
{{baseUrl}}/umbraco/management/api/v1/security/back-office/token
```

6. Add `umbraco-postman` on **Client ID**.
7. Choose `SHA-256` from **Code Challenge Method** .
8. Choose `Send Client credentials in body` from **Client Authentication**.
9. Any other field should either be empty or auto-filled by default.
10. Click **Save**.
11. Click on **Get New Access Token**.\
    A window appears to authenticate into the Backoffice. Follow the given instruction to **Open in Postman**.

* You will see a new **Manage access tokens** window in Postman.

12. Click **Use Token**.

## Get a token for a new user

1. Click on **Authorization** tab in the **Umbraco Management API** collection .
2. Click on `Clear Cookies` at the bottom of the page above the **Get New Access Token**.
3. Open your localhost instance of Umbraco in the browser. Example: `https://localhost:44331`.
4. Inspect the page, go to **Application** tab and clear the `UmbracoBackOffice` cookie.
5. Click on **Get New Access Token** in Postman and
6. Click on **Use Token** after authentication.

## Common pitfalls and errors

### Missing agent

When trying to obtain a token you might run into an error. If you see the message `Error: localhost request not supported` in the Postman console, it means the Postman agent is missing. To resolve this issue, you can download the Postman agent from the Postman website [Postman website](https://www.postman.com/downloads/postman-agent/) and try again.

### SSL Certificate verification

When requesting a token, you might get an error that reads `Error: unable to verify the first certificate` in the console.\
To resolve this:

1. Click on the **Settings** cog wheel in the top right corner next to the **Invite** button.

![Postman Cog Wheel Location](../../.gitbook/assets/postman-setup-swagger-cog-wheel.png)

2. Click on **Settings** and disable `SSL certificate verification`.

### Making a request

When making a request for the first time, follow these steps:

1. Click on the **Authorization** tab in the **Umbraco Management API** collection.
2. Choose `Inherit auth from parent` from **Type**.
3. Disable any parameters you are not using as Postman sets their value to default sometimes.
4. Click **Save**

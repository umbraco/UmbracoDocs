---
description: Get started with the Management API.
---

# Management API

## Management API

The Management API delivers headless management capabilities built directly into Umbraco. The Management API is used by the backoffice to communicate with the backend.

The Management API can also be used for Custom apps or Workflows with OpenID Connect.

{% hint style="info" %}
The Management API is a replacement for the backoffice controllers that lacked RESTful capabilities.
{% endhint %}

### OpenAPI Documentation

Umbraco uses OpenAPI to document the Management API. The OpenAPI documents and Swagger UI are based on [Microsoft.AspNetCore.OpenApi](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/openapi/overview) and are available at `{yourdomain}/umbraco/swagger`. For security reasons, both are disabled in production environments.

The OpenAPI documentation allows you to select a definition and go to either Umbraco Management API or Content Delivery API. If you are extending the Management API with your own controllers, you can also create custom documentation for these. See [Custom Backoffice API](../custom-backoffice-api.md) and [Creating a backoffice API](../../tutorials/creating-a-backoffice-api/) articles for details.

![Umbraco Management API documentation in Swagger UI](../../.gitbook/assets/management-api-swagger.png)

In the Umbraco Management API OpenAPI document, you can find a collection of available endpoints in this version of Umbraco.

### Authorization

The Management API endpoints are protected by the backoffice authorization policies and need an authentication token to interact with them.

To set the authorization, click on the **Authorize** button:

![Umbraco Management API Authorize Button](../../.gitbook/assets/management-api-swagger-authorize-button.png)

Then a popup will appear with some setup information and a login form for authorization:

![Umbraco Management API Authorize Login](../../.gitbook/assets/management-api-swagger-authorize-instructions.png)

The available integration for the authorization is done via a backoffice user with the integration of `OAuth2, authorizationCode with PKCE`. Swagger UI is only enabled in non-production environments, so if you need to access the Management API in production, you need a different client.

{% hint style="info" %}
In production environment, only `umbraco-back-office` **client** is allowed to connect to the Management API. In non-production environments, the `umbraco-swagger` and `umbraco-postman` **clients** can be used.

You can see an example of how to connect a backoffice user via OAuth2 in Postman in the [Swagger Setup in Postman](postman-setup-swagger.md) article.
{% endhint %}

## Test an Endpoint

To test a Management API endpoint, follow these steps:

1. Authenticate via the **Authorize** button. Make sure you use `umbraco-swagger` as the `client_id`:

![Umbraco Management API when Authenticated](../../.gitbook/assets/management-api-swagger-authenticated.png)

{% hint style="info" %}
In non-production environments, you will always need only the `client_id` to authenticate. The `client_secret` should always be left blank, as the authentication flow does not use a client secret.
{% endhint %}

2. Expand the first endpoint of **Audit Log** and click **Try it out**

![Umbraco Management API Endpoint - Try it Out Button](../../.gitbook/assets/management-api-try-it-out.png)

3. You now have the option to change the values of the **parameters**. In this case, let´s leave the default values as they are.
4. Click on **Execute** so that we can get some data for our **Audit Log** endpoint.

![Umbraco Management API Endpoint - Execute - Response](../../.gitbook/assets/management-api-execute-response.png)

In the **Response Body** we get the details of the **Audit Log** that we have requested.

5. You can continue changing the default **parameters**, **clear** the query, or **cancel** the trial of the endpoint.

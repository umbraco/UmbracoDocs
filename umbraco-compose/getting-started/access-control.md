---
description: >-
  This article explains authentication and authorization in Umbraco Compose,
  covering access control methods and how to secure API access using scoped
  credentials.
---

# Access Control

All requests to the Umbraco Compose APIs must be authenticated and authorized.

Compose supports two different methods of access control. They are summarized in the table below.

| Authentication Method | Valid For...                   | Best Suited To...                                                                      |
| --------------------- | ------------------------------ | -------------------------------------------------------------------------------------- |
| Personal Access Token | Ingestion, GraphQL             | Accessing Compose as a user - during development, exploring APIs, etc.                 |
| Client Credentials    | Ingestion, GraphQL, Management | Accessing Compose from another system - ingesting or retrieving data, automation, etc. |

## Personal Access Tokens

Personal Access Token are also known as API keys. They are used to authenticate to the [Ingestion](../apis/ingestion/) and [GraphQL](../apis/graphql/) APIs of Umbraco Compose.

Personal Access Tokens can be managed from the [Umbraco Cloud Portal](https://www.s1.umbraco.io/compose/apikeys). Personal access tokens are valid for one Compose project, selected at time of creation.

### Scopes

Personal Access Tokens can be assigned different scopes that affect which APIs and endpoints they are authorized to call. The following scopes are available:

| Scope                 | Supported Operations                                                                      |
| --------------------- | ----------------------------------------------------------------------------------------- |
| ingestion             | Adding or removing content to or from Umbraco Compose via the Ingestion API.              |
| graphql               | Querying content from the GraphQL API. Does not allow retrieving type schema information. |
| graphql:introspection | Retrieving type schema information from the GraphQL API via introspection queries.        |

Assigning a scope grants the respective access over all environments in the project.

## Client Credentials

Applications can authorize to Umbraco Compose using an OAuth-compliant client credentials flow.

### Creating an API Application

To support the client credentials flow, you must first create an API application from the [Umbraco Cloud Portal](https://www.s1.umbraco.io/compose/).

During creation of an API application you will be given two values which can later be exchanged for an access token. These values are a `client_id` and a `client_secret`.

* The `client_id` is a unique identifier for your API application.
* The `client_secret` is a shared secret that you should store securely. It allows access to applications that integrate with Compose.

{% hint style="info" %}
Client secrets are only retrievable immediately after creating an API application. If you lose a `client_secret`, it can be re-generated through the [Management API](../apis/management/).
{% endhint %}

### Scopes

API applications support the same [project-level scopes](access-control.md#scopes) as Personal Access Tokens. On top of that, they also optionally allow finer-grained access over individual environments or entities.

Supported environment scopes are:

| Scope                 | Supported Operations                                                                      |
| --------------------- | ----------------------------------------------------------------------------------------- |
| ingestion             | Adding or removing content to or from Umbraco Compose via the Ingestion API.              |
| graphql               | Querying content from the GraphQL API. Does not allow retrieving type schema information. |
| graphql:introspection | Retrieving type schema information from the GraphQL API via introspection queries.        |
| typeschema:read       | All operations that read type schemas                                                     |
| typeschema:write      | All operations involving type schemas                                                     |

Including a project scope will grant authorization for that action across all environments, irrespective of environment-specific scopes. For example, consider the following two scopes granted on a single project:

* The `graphql` scope has been granted at project level, and
* The `graphql` scope has been granted for the `dev` environment, but not for `live`.

The application will still be able to make GraphQL queries on the `live` environment. It is recommended to use the least-privilege scopes that your applications strictly need.

### Getting an Access Token

Once you have an application and client credentials, you can generate an access token using the `/v1/auth/token` endpoint. Since access tokens are short-lived, this process should typically be automated.

Unlike other endpoints in the Management API, the `auth/token` endpoint expects an `application/x-www-form-urlencoded` payload. It should look like the following, where `{client_id}` and `{client_secret}` are replaced with the values from your application.

```http
POST /v1/auth/token HTTP/1.1
Host: management.umbracocompose.com
Content-Type: application/x-www-form-urlencoded
 
grant_type=client_credentials&
client_id={client_id}&
client_secret={client_secret}
```

### Developer tooling

Since tokens exchanged for client credentials are short lived, working with them manually is generally not recommended.

Many developer tools for calling APIs support automatically refreshing access tokens. Instead of configuring and manually including the token, consider using your tool's inbuilt OAuth support.

Two tools that support automatically refreshing tokens are [Bruno](https://docs.usebruno.com/auth/oauth2-2.0/client-credentials) and [Postman](https://learning.postman.com/docs/sending-requests/authorization/oauth-20/#using-client-credentials).

## Usage

When making a call to Compose APIs, include your (personal or client credential) access token as a bearer token in the `Authorization` header. For example:

```http
POST /v1/{your-project}/{your-environment} HTTP/1.1
Host: graphql.germanywestcentral.umbracocompose.com
Content-Type: application/json
Authorization: Bearer {your-access-token}

{
  "query": "..."
}
```

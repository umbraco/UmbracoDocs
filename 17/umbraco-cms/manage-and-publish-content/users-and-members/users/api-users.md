---
description: >-
  This guide will explain the concept of API Users, how they differ from regular
  Users, and how to define them
---

# API Users

API Users allow for authorizing [external access](../../../develop-with-umbraco/headless-and-apis/management-api/external-access.md) to the Management API.

An API User is identical to a [regular User](./) except for one thing: It has no password. In fact, API Users are not allowed to log into the backoffice like regular Users.

Instead, API Users hold the Client Credentials used to authorize against the Management API. When an external source authorizes using Client Credentials, it effectively assumes the identity of the API User.

Since API Users are identical to regular Users their backoffice access can be controlled in the same way. This allows for imposing detailed access control on the external sources connected to the Management API.

![An API User in the backoffice](../../../.gitbook/assets/api-user.png)

{% hint style="info" %}
Client IDs for API Users are explicitly prefixed with `umbraco-back-office-`. This guards against API Users accidentally taking over one of the Client IDs used by the Umbraco core.
{% endhint %}

## Access to API Users

API Users follow the same access rules as regular Users:

* Your user group needs access to the **Users** section to view or manage API Users.
* Only members of the **Administrators** user group can view users in the **Administrators** user group. Other users don't see these users in the **Users** list.

## Creating an API User

To create an API User:

1. Go to the **Users** section in the backoffice.
2. Select **Create -> API User**.
3. Enter the **Name** and **Email** of the new API user.
4. Select which **User group** the new user should be added to.
5. Click **Create user**.

## Troubleshooting

### "Access denied to this user"

This message appears when you open an API User that is in the **Administrators** user group, and you aren't. This can happen when you open the user from a direct link. The same applies to regular users in that group.

To resolve this, do one of the following:

* Ask an administrator to open or manage the API User.
* Ask an administrator to move the API User to a different user group, if it doesn't need administrator access.

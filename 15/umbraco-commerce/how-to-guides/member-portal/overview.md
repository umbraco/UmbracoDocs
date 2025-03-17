# Member Portal

A customer portal is a private space for Members in Umbraco where they are able to view details on latest orders, pending orders, etc.

To design this we would use a couple of APIs:
* Umbraco Membership API
* Umbraco Commerce API for retrieving member orders

Through custom implementations we will be able to register and sign in members of a specific type, and display order history for logged in users.

## Workflow

Upon trying to access the portal, users that are not logged in will be redirected to the login page.

![member-portal](../images/member-portal/member-portal.png)

We can use the following evaluation to check if a user is logged in or not.

````csharp
var isLoggedIn = Context.User?.Identity?.IsAuthenticated ?? false;
````

![login-page](../images/member-portal/login-page.png)

From the login page, users have the option to register:

![register-page](../images/member-portal/register-page.png)

Then get redirected to their private portal:

![order-history](../images/member-portal/order-history.png)

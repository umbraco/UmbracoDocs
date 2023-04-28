# Release Notes, April 2023

## Key Takeaways

* **Reset Authenticator App settings** - It is now a easy task for your cloud organization administrator to reset your authenticator app settings if you start using a new mobile or want to switch to another authenticator app.
* **Other Umbraco Cloud updates** - Umbraco Cloud has been updated with a few other features and updates worth mentioning.

## Reset Authenticator App settings

The latest addition to the multi-factor-authentication feature of Umbraco Cloud is the option for **administrators of an organization to reset the authenticator app settings**. This can be done for every member of the organization that is using an authenticator app during the login process to Umbraco Clou.

![ResetAuthenticatorApp](images/ResetAuthenticatorApp.gif)

This could be very handy in situations where the member is switching to another authenticator app, starts using a new phone, or due to another reason want to reset the current entry in his authenticator app.

When the setting has been reset, the member will during his next login in Umbraco Cloud have to re-register an entry in his authenticator app of choice.

## Other Umbraco Cloud Portal updates

During March and April, we made multiple minor fixes and improvements to the Umbraco Cloud Portal. Here are some of the highlights.

- The **auto-upgrade** feature and its handling of particular Umbraco7 and Umbraco8 projects have been **improved** significantly. We consider the upgrade feature to be more solid than ever.
- When a user starts a new project creation flow based on a baseline project, the **potential baselines will load a lot faster** than earlier.
- New versions of the project subpages **“Security”** and **“CDN Caching and Optimization”** have been released and the documentation updated accordingly.
- When a user decides to send a project invite to an email that represents a user that already is part of the project, an **informative error message** will be shown.
- The **UmbracoID login dialog** has received some minor tweaks in the front end.
- And a whole lot of other minor tweaks and improvements.

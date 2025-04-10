---
description: >-
  In this article you can learn about how to create Member registration and
  login functionality for the frontend of your application.
---

# Member Registration and Login

With a fresh Umbraco CMS install, you can create frontend registration, login functions, and restrict site access based on the system.

By the end of this tutorial, you will learn how to:

- Implement a basic register/login functionality on your website,
- Hide pages from non-logged-in members, and 
- Assign newly registered members to specific member groups.

## Prerequisites

1. Install the latest [dotnet templates](../fundamentals/setup/install/install-umbraco-with-templates.md): `dotnet new umbraco`.

2. Install the Umbraco Starter Kit: `dotnet add package Umbraco.TheStarterKit`

3. Run the project: `dotnet run`

4. Complete the installer and login to the backoffice.

## Create partial views for Registration and Login

1. Navigate to the Settings section in the backoffice.
2. Locate the Partial Views entry under Templating in the left-hand section.
3. Click the "+" to create a new partial view.

4. Choose **New partial view from snippet...**.

![Create a new partial view](images/v14-create-partial-view-from-snippet.png)

5. Pick the **Login** snippet from the list.

![Create a new partial view from the Login snippet](images/v14-create-partial-view-from-login-snippet.png)

6. Name the partial view **Login** and save it:

![Edit and save the "Login" partial view](images/v14-create-login-partial-view.png)

7. Repeat the above steps using the _Register Member_ and _Login Status_ snippets. 
8. Save the partial views as "Register" and "LoginStatus" respectively.

The Partial Views list should now look like this:

![The list of partial views](images/v14-list-of-partial-views.png)

## Create a new Document Type for Registration and Login

To render these partial views, we need a new Document Type with a dedicated template (see also [Defining Content](../fundamentals/data/defining-content/README.md)):

1. Create a new **Document Type with a template** and name it "Login".
2. Setup the "Login" Document Type to be composed by the "Content Base" and "Navigation Base" Document Types.

![Composition View](images/composition-view.png)

{% hint style="info" %}
The "Content Base" and "Navigation Base" Document Types are available once the Umbraco Starter Kit is installed. For more information, see the [Prerequisites](#prerequisites) section.
{% endhint %}

3. Allow the "Login" Document Type as a child under the "Home" Document Type.

## Render the partial views in the template

Locate the newly created "Login" template, and overwrite its content with this:

{% code title="Login.cshtml" %}
```cshtml
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@{
    Layout = "master.cshtml";
}

@Html.Partial("~/Views/Partials/SectionHeader.cshtml")

<section class="section">

    <div class="container">

        <div class="col-md-3">
            <nav class="nav-bar nav-bar--list">
                @Html.Partial("~/Views/Partials/Navigation/SubNavigation.cshtml")
            </nav>
        </div>

        <div class="col-md-9">
            <article>
                @await Html.GetBlockGridHtmlAsync(Model, "bodyText")
            </article>
            <article>
                @await Html.PartialAsync("partials/loginStatus")
                @await Html.PartialAsync("partials/register")
                @await Html.PartialAsync("partials/login")
            </article>
        </div>
    </div>

</section>

<link rel="stylesheet" href="@Url.Content("~/css/umbraco-starterkit-blockgrid.css")" />
```
{% endcode %}

## Create the Register/Login page

Halfway there!

1. Navigate to the Content section. 
2. Create a new page based on the "Login" Document Type Under the _Home_ node: 

![Creating the Register/Login page](images/v14-create-register-login-page.png)

3. Save and publish the page. 

The Register and Login functionality is rendered by the "Login" template:

![The Register/Login functionality rendered](images/v14-register-login-page-rendered.png)

You can now use the page to register new Members. Every registered person will show up in the Members section in the backoffice:

![Overview of created Members](images/v14-members-overview.png)

The "LoginStatus" partial view comes into play after registering as a new Member (or logging in as an existing Member). It will render a welcome message and a "log out" button:

![Login status rendering](images/v14-login-status.png)

{% hint style="info" %}
In a real-life scenario, you probably don't want all this functionality on a single page. However, you can still use the partial views as a basis for your own implementation.
{% endhint %}

## Member-only pages/Restricted access

{% hint style="info" %}
If you are on Umbraco Cloud you need to do the following steps to be able to restrict access for your users:

1. Go to the Users section in the Backoffice.
2. Select your User.
3. Add the "Sensitive Data" Group.

Once you have added the "Sensitive Data" group go to the Members section in the backoffice. In the Members section you need to select each member and approve them by toggling the Approved button.

Once the users have been approved, you can go ahead and continue the tutorial.
{% endhint %}

Now that we have the options to:

* Register a member
* Log in as a member
* Check the current login status
* Log out a member

We can take this a bit further and specify which parts of our website should be accessible to logged-in members. To do this:
 1. Go to the Member section in the Backoffice.
 2. Create a new Member Group.

![Create a new member group](images/v14-create-member-group.png)

3. Give the group a name.
4. Save the Member Group.

![Naming the new member group](images/v14-create-member-group-step-2.png)

5. Navigate back to the created Member. 
6. Assign the newly created Member Group.
7. Save the member:

![Assign the new Member group to the created Member](images/v14-assign-member-group.png)

Almost there!

1. Navigate to the Content section. 
2. Create a new page that should only be visible to "Premium" members.

 3. Click the menu icon (•••) to bring up the page options, and pick "Restrict Public Access" once created.

![Restricting public access to content](images/v14-restrict-content-access.png)

You will be able to restrict access to a specific member, or a specific group. Choose the latter option. In the dialog that follows you must define:

- The group(s) that will have access to the page.
- The page with the login form.
- The page to display if the content page is inaccessible to the logged-in member.

![Configuring public access for content](images/v14-configure-public-access.png)

{% hint style="info" %}
It is recommended to have a dedicated page for the "No access" page - though you can use any page you have.
{% endhint %}

Congratulations! With all of that setup, the "Premium Content" page is only accessible to logged-in "Premium" Members. When not logged in, the website visitors will automatically be redirected to the "Register/Login" page.

However, with the above approach, members will not be assigned to any group automatically. For this to happen, we would need to write a bit of custom code.

## Assigning new members to groups automatically

We can leverage the [built-in Notifications](../reference/notifications/README.md) to handle the automatic Member Group assignment. Specifically the `MemberSavedNotification`, which is triggered whenever a Member is saved.

{% hint style="info" %}
This notification is triggered when _any_ Member is saved. Make sure test its usage carefully.
{% endhint %}

The following code automatically assigns Members to the "Premium" Member Group.

{% code title="AssignMembersToPremiumRoleHandler.cs" %}
```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;

namespace UmbracoDocs.Samples;

public class AssignMembersToPremiumRoleHandler : INotificationHandler<MemberSavedNotification>
{
    private const string RoleName = "Premium";

    private readonly IMemberService _memberService;
    private readonly ILogger<AssignMembersToPremiumRoleHandler> _logger;

    public AssignMembersToPremiumRoleHandler(
        IMemberService memberService,
        ILogger<AssignMembersToPremiumRoleHandler> logger)
    {
        _memberService = memberService;
        _logger = logger;
    }

    public void Handle(MemberSavedNotification notification)
    {
        foreach (IMember member in notification.SavedEntities)
        {
            if (_memberService.GetAllRoles(member.Id).Contains(RoleName))
            {
                continue;
            }
            _logger.LogInformation("Automatically assigning member with ID: {memberId} to role: {roleName}", member.Id, RoleName);
            _memberService.AssignRole(member.Id, RoleName);
        }
    }
}
```
{% endcode %}

{% hint style="info" %}
Member Groups are also referred to as "Roles" in the service layers.
{% endhint %}

To enable the notification handler, we also need a composer:

{% code title="AssignMembersToPremiumRoleComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Notifications;

namespace UmbracoDocs.Samples;

public class AssignMembersToPremiumRoleComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.AddNotificationHandler<MemberSavedNotification, AssignMembersToPremiumRoleHandler>();
}
```
{% endcode %}

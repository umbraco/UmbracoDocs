---
description: >-
  A tutorial on setting up Google authentication for the Umbraco CMS backoffice
  users.
---

# Add Google Authentication

The Umbraco Backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Entra ID/Azure Active Directory, Identity Server, Google, or Facebook.

In this tutorial, we will take you through the steps of setting up a Google login for the Umbraco CMS backoffice.

## What is a Google Login?

When you log in to the Umbraco Backoffice, you need to enter your username and password. Integrating your website with Google authentication adds a button that you can click to log in with your Google account.

![Google login screen](images/googleLoginScreen_v13.png)

## Why?

I'm sure a lot of content editors and implementors of your Umbraco sites would love to have one less password to remember. Click **Sign in with Google** and if you are already logged in with your Google account, it will log you in directly.

### What the tutorial covers

1. [Setting up a Google OAuth API](add-google-authentication.md#id-1.-setting-up-a-google-oauth-api)
2. [Integrating Google Auth in your project](add-google-authentication.md#id-2.-integrating-google-auth-in-your-project)
3. [Configuring the solution to allow Google logins](add-google-authentication.md#id-3.-configuring-the-solution-to-allow-google-logins)

### Prerequisites

For this tutorial, you need:

* [Visual Studio](https://visualstudio.microsoft.com/) installed.
* A [Google](https://myaccount.google.com/) account.
* A working [Umbraco solution](https://umbraco.com/products/umbraco-cloud/).

## 1. Setting up a Google OAuth API

The first thing to do is set up a Google API. To do this, you need to go to [https://console.developers.google.com/](https://console.developers.google.com/) and log in with your Google account.

### Setup a Google Console Project

1.  Click the project dropdown and select **New Project**.

    ![Project dropdown list](images/Project_dropdown_list_v13.png)
2. Enter a **Project name**, **Organization**, and **Location**.
3. Click **Create**.

### Enable the Google+ API

1. Open the newly created project from the project dropdown.
2.  Click **Enable APIs and Services**.

    ![Enable APIs](images/Enable_Apis_v13.png)
3. Type **Google+ API** in the **Search** field.
4.  Select it and then **Enable** it.

    ![Enable Google APIs](images/Enable_Google_API_v13.png)

### Set up an OAuth Consent Screen

Before you can create the credentials, you need to configure your consent screen.

1. Click **OAuth consent screen** from the left-side navigation menu.
2. Choose the **User Type** that fits your setup.
3.  Click **Create**.

    ![Select User Type](images/User_Type_v13.png)
4. Fill in the required information:
   * App name
   * User support email
   * Developer contact information
5. Click **Save and Continue**.
6. Select the scopes your project needs.
7. Click **Save and Continue**.
8. Verify the details you have provided.
9. Click **Back to Dashboard** to complete creating the Consent screen.

### Create credentials

1. Click **Credentials** from the left-side navigation menu.
2. Click **Create Credentials**.
3.  Select **OAuth Client ID** from the dropdown.

    ![Select OAuth Client ID](images/OAuth_Client_Id_v13.png)
4. Select **Web Application** from the **Application type** dropdown.
5.  Enter the following details:

    * Application **Name**
    * **Authorized JavaScript origins**
    * **Authorized redirect URIs**

    ![Credentials](images/credentials_v13.png)
6. Click **Create**.

A popup appears displaying the **Client Id** and **Client Secret**. You will need these values later while configuring your solution.

{% hint style="info" %}
The **Client Id** and **Client Secret** can always be accessed from the **Credentials** tab in the **APIs & Services** menu.
{% endhint %}

## 2. Integrating Google Auth in your project

Once the Google API is set up it is time to install the Google Auth provider on the Umbraco project.

If you are working with a Cloud project, see the [Working locally](https://docs.umbraco.com/umbraco-cloud/set-up/working-locally) article to complete this step.

### Installing a Nuget Package

You can install and manage packages in a project.

1. Navigate to your project/solution folder.

{% hint style="info" %}
If you have cloned down an Umbraco Project, navigate to the `src` folder where you can see a `.csproj` file.
{% endhint %}

2. Open a command-line of your choice such as "Command Prompt" at the mentioned location.
3.  Run the following command to install the `Microsoft.AspNetCore.Authentication.Google` package.

    ```cli
    dotnet add package Microsoft.AspNetCore.Authentication.Google
    ```
4.  Once the package is installed, open the **.csproj** file to ensure if the package reference is added:

    ```js
    <ItemGroup>
        <PackageReference Include="Microsoft.AspNetCore.Authentication.Google" Version="8.0.3" />
    </ItemGroup>
    ```

{% hint style="info" %}
You can check the [latest version of the package](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.Google) before installing it.
{% endhint %}

For more information on installing and using a package with the .Net CLI, see [Microsoft Documentation](https://learn.microsoft.com/en-us/nuget/quickstart/install-and-use-a-package-using-the-dotnet-cli).

## 3. Configuring the solution to allow Google logins

To use an external login provider such as Google on your Umbraco CMS project, you have to implement a couple of new classes:

* A custom-named configuration class.
* A static extension class.

You can create these files in a location of your choice. In this tutorial, the files will be added to an `ExternalUserLogin/GoogleAuthentication` folder.

1. Create a new class:`GoogleBackOfficeExternalLoginProviderOptions.cs`.
2. Add the following code to the file:

{% code title="GoogleBackOfficeExternalLoginProviderOptions.cs" lineNumbers="true" %}
```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Web.BackOffice.Security;

namespace MyCustomUmbracoProject.ExternalUserLogin.GoogleAuthentication;

public class GoogleBackOfficeExternalLoginProviderOptions : IConfigureNamedOptions<BackOfficeExternalLoginProviderOptions>
{
    public const string SchemeName = "OpenIdConnect";
    public void Configure(string? name, BackOfficeExternalLoginProviderOptions options)
    {
        ArgumentNullException.ThrowIfNull(name);

        if (name != Constants.Security.BackOfficeExternalAuthenticationTypePrefix + SchemeName)
        {
            return;
        }

        Configure(options);
    }

    public void Configure(BackOfficeExternalLoginProviderOptions options)
    {
        // Customize the login button
        options.ButtonStyle = "btn-danger";
        options.Icon = "icon-cloud";

        // The following options are only relevant if you
        // want to configure auto-linking on the authentication.
        options.AutoLinkOptions = new ExternalSignInAutoLinkOptions(

            // Set to true to enable auto-linking
            autoLinkExternalAccount: true,

            // [OPTIONAL]
            // Default: "Editor"
            // Specify User Group.
            defaultUserGroups: new[] { Constants.Security.EditorGroupAlias },

            // [OPTIONAL]
            // Default: The culture specified in appsettings.json.
            // Specify the default culture to create the User as.
            // It can be dynamically assigned in the OnAutoLinking callback.
            defaultCulture: null,

            // [OPTIONAL]
            // Enable the ability to link/unlink manually from within
            // the Umbraco backoffice.
            // Set this to false if you don't want the user to unlink 
            // from this external login provider.
            allowManualLinking: true
        )
        {
            // [OPTIONAL] Callback
            OnAutoLinking = (autoLinkUser, loginInfo) =>
            {
                // Customize the user before it's linked.
                // Modify the User's groups based on the Claims returned
                // in the external ogin info.
            },
            OnExternalLogin = (user, loginInfo) =>
            {
                // Customize the User before it is saved whenever they have
                // logged in with the external provider.
                // Sync the Users name based on the Claims returned
                // in the external login info

                // Returns a boolean indicating if sign-in should continue or not.
                return true;
            }
        };

        // [OPTIONAL]
        // Disable the ability for users to login with a username/password.
        // If set to true, it will disable username/password login
        // even if there are other external login providers installed.
        options.DenyLocalLogin = false;

        // [OPTIONAL]
        // Choose to automatically redirect to the external login provider
        // effectively removing the login button.
        options.AutoRedirectLoginToExternalProvider = false;
    }
}
```
{% endcode %}

{% hint style="info" %}
The code used here, enables [auto-linking](../reference/security/external-login-providers.md#auto-linking) with the external login provider. This enables the option for users to login to the Umbraco backoffice prior to having a backoffice User.

Set the `autoLinkExternalAccount` to `false` in order to disable auto-linking in your implementation.
{% endhint %}

3. Create a new class: `GoogleAuthenticationExtensions.cs`.
4. Add the following code to the file:

{% code title="GoogleAuthenticationExtensions.cs" lineNumbers="true" %}
```csharp
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;
using Microsoft.Extensions.DependencyInjection;

namespace MyCustomUmbracoProject.ExternalUserLogin.GoogleAuthentication;

public static class GoogleAuthenticationExtensions
{
    public static IUmbracoBuilder AddGoogleAuthentication(this IUmbracoBuilder builder)
    {
        // Register ProviderBackOfficeExternalLoginProviderOptions here rather than require it in startup
        builder.Services.ConfigureOptions<GoogleBackOfficeExternalLoginProviderOptions>();

        builder.AddBackOfficeExternalLogins(logins =>
        {
            logins.AddBackOfficeLogin(
                backOfficeAuthenticationBuilder =>
                {

                    // The scheme must be set with this method to work for the back office
                    var schemeName = backOfficeAuthenticationBuilder.SchemeForBackOffice(GoogleBackOfficeExternalLoginProviderOptions.SchemeName);

                    ArgumentNullException.ThrowIfNull(schemeName);

                    backOfficeAuthenticationBuilder.AddGoogle(
                        schemeName,
                        options =>
                        {
                            // Callback path: Represents the URL to which the browser should be redirected to.
                            // The default value is '/signin-google'.
                            // The value here should match what you have configured in you external login provider.
                            // The value needs to be unique.
                            options.CallbackPath = "/umbraco-google-signin";
                            options.ClientId = "YOURCLIENTID"; // Replace with your client id generated while creating OAuth client ID
                            options.ClientSecret = "YOURCLIENTSECRET"; // Replace with your client secret generated while creating OAuth client ID
                        });
                });
        });
        return builder;
    }
}
```
{% endcode %}

5. Replace **YOURCLIENTID** and **YOURCLIENTSECRET** with the values from the **OAuth Client Ids Credentials** window.
6. Update `ConfigureServices` in your `Startup.cs` class to register your configuration with Umbraco.

{% code title="Startup.cs" lineNumbers="true" %}
```csharp
using MyCustomUmbracoProject.ExternalUserLogin.GoogleAuthentication;

public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddComposers()

        // Register your new static extension class
        .AddGoogleAuthentication()

        .Build();
}
```
{% endcode %}

7. Build and run the website.
8. Log in to the backoffice using the Google Authentication option.

{% hint style="info" %}
If auto-linking is disabled, the user will need to follow these steps in order to be able to use the Google Authentication:

1. Login to the backoffice using Umbraco credentials.
2. Select your user profile in the top-right corner.
3. Click **Link your Google account** under External login providers.
4. Choose the account you wish to link.

For future backoffice logins, the user will be able to use Google Authentication to login.
{% endhint %}

![Google login screen](images/googleLoginScreen_v13.png)

## Related Links

* [External login providers](../reference/security/external-login-providers.md)
* [Linking External Login Provider accounts](../reference/security/external-login-providers.md#auto-linking)

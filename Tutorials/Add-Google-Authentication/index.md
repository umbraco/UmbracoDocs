---
versionFrom: 9.0.0
versionTo: 10.0.0
meta.Title: "Add Google Authentication"
meta.Description: "A guide to set up a Google login for the Umbraco Backoffice."
---


# Add Google Authentication

The Umbraco Backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google, or Facebook.

In this tutorial, we will take you through the steps of setting up a Google login for the Backoffice.

## What is a Google Login?

When you log in to the Umbraco Backoffice, you need to enter your username and password. Integrating your website with Google authentication adds a button that you can click to log in with your Google account.

![Google login screen](images/GoogleLoginScreen_v9.png)

## Why?

I'm sure a lot of content editors and implementors of your Umbraco sites would love to have one less password to remember. Click **Sign in with Google** and if you are already logged in with your Google account, it will log you in directly.

### Who is this tutorial for?

**Developers** who won't mind:

1. [Setting up a Google OAuth API](#setting-up-a-google-oauth-api)
2. [Integrating Google Auth in Visual Studio](#integrating-google-auth-in-visual-studio)
3. [Configuring the solution to allow Google logins](#configuring-the-solution-to-allow-google-logins)

Does that sound way too advanced for you? Then this tutorial is just the right fit. Let's get started.

### Prerequisites

For this tutorial, you need:

- [Visual Studio](https://visualstudio.microsoft.com/) installed
- A [Google](https://myaccount.google.com/) account
- A working [Umbraco solution](../../Fundamentals/Setup/index.md)

## Setting up a Google OAuth API

The first thing to do is set up a Google API. To do this, you need to go to [https://console.developers.google.com/](https://console.developers.google.com/) and log in with your Google account.

### Setup a Google Console Project

1. At the top of the page, next to the Google Cloud Platform logo, select the project dropdown and click **New Project**.
    ![Project dropdown list](images/Project_dropdown_list.png)

2. Enter the **Project name**, **Organization**, **Location** and click **Create**.
    ![Project details](images/Project_Details.png)

### Enable Google+ API

1. From the project dropdown list, select the project you just created and click **Enable APIs and Services**.
    ![Enable Apis](images/Enable_Apis.png)
2. In the **Welcome to the API Library** window, type **Google+ API** in the search field.
3. Click **Enable** to enable the API.
    ![Enable Google API](images/Enable_Google_API.png)

### Create Credentials

1. Before creating the credentials, you will need to configure your consent screen. Click on **OAuth Consent Screen** from the left-side navigation menu.
    ![Navigate to OAuth Consent Screen](images/OAuth_Consent_Screen.png)

2. In the **OAuth consent screen** window, select the **User Type** depending on how you want to configure and register your app. Click **Create**.
    ![User Type](images/User_Type.png)

3. In the **OAuth consent screen** tab of the **Edit app registration** window, enter the **App information**, **App domain**, **Authorized domains**, **Developer contact information** and click **Save and Continue**.

4. In the **Scopes** tab, select the scopes your project uses. Click **Save and Continue**.

5. [Optional] In the **Test Users** tab, add the test users that can access the application. Click **Save and Continue**.

6. In the **Summary** tab, verify the details provided. Click **Back to Dashboard** or **Submit for verification**.

7. Click on **Credentials** from the left-side navigation menu. Click on **Create Credentials** and select **OAuth Client ID**.
    ![OAuth Client Id](images/OAuth_Client_Id.png)

8. Select **Web Application** from the **Application type** drop-down.

9. Enter the application **Name**, **Authorized JavaScript origins**, **Authorized redirect URIs** and click **Create**.
    ![Credentials Details](images/Credentials_v9.png)

A popup appears displaying the **ClientId** and **ClientSecret**. You will need these values later while configuring your solution.

:::note
The **ClientId** and **ClientSecret** can always be accessed from the **Credentials** tab in **APIs & Services** menu.
:::

## Integrating Google Auth in Visual Studio

Now that you have the Google API set up, open your existing solution in Visual Studio. If you don't know how to clone down a Cloud site, see the [Working with Visual Studio](../../Umbraco-Cloud/Set-Up/Working-with-Visual-Studio/) article.

### Installing a Nuget Package

You can install and manage packages in Visual Studio either using the Package Manager Console (PowerShell) or the NuGet Package Manager.

#### Option 1: Package Manager Console (PowerShell)

The NuGet Package Manager Console lets you use NuGet PowerShell commands to find, install, uninstall, and update NuGet packages. You can use this option if you are comfortable using the Package Manager Console (PowerShell). The command listed below is specific to the Package Manager Console in Visual Studio:

1. Open your project/solution in Visual Studio.
2. Go to **Tools** -> **NuGet Package Manager** -> **Package Manager Console**. A package manager console appears at the bottom where you can install packages with commands. In this console, type the following:

    ```js
    Install-Package Microsoft.AspNetCore.Authentication.Google -Version 5.0.0
    ```

#### Opton 2: NuGet Package Manager

The NuGet Package Manager UI in Visual Studio on Windows allows you to easily install, uninstall, and update NuGet packages in projects and solutions.

1. Go to **Tools** -> **NuGet Package Manager** -> **Manage NuGet Packages for Solution**.
2. In the Browse tab, type `Microsoft.AspNetCore.Authentication.Google` in the search field.
3. Select the **version** from the drop-down and click **Install**.
    ![Install Package](images/Install_Package.png)

For more information on installing and managing packages in Visual Studio, see the [Microsoft Documentation](https://docs.microsoft.com/en-us/nuget/consume-packages/install-use-packages-visual-studio).

## Configuring the solution to allow Google logins

1. To enable a user to link their user account to an external login provider such as Google in the Umbraco Backoffice, you have to implement a custom named configuration  `BackOfficeExternalLoginProviderOptions` for users.

    You can create a `GoogleBackOfficeExternalLoginProviderOptions.cs` file in a location of your choice. For tutorial purposes, I have created the file in `App_Code/Google_Authentication` folder. 
    
    Add the following code in the `GoogleBackOfficeExternalLoginProviderOptions.cs` file.

    ```csharp
    using Microsoft.Extensions.Options;
    using Umbraco.Cms.Core;
    using Umbraco.Cms.Web.BackOffice.Security;

    namespace MyCustomUmbracoProject.App_Code.Google_Authentication
    {
        public class GoogleBackOfficeExternalLoginProviderOptions : IConfigureNamedOptions<BackOfficeExternalLoginProviderOptions>
        {
            public const string SchemeName = "OpenIdConnect";
            public void Configure(string name, BackOfficeExternalLoginProviderOptions options)
            {
                if (name != "Umbraco." + SchemeName)
                {
                    return;
                }

                Configure(options);
            }

            public void Configure(BackOfficeExternalLoginProviderOptions options)
            {
                options.ButtonStyle = "btn-danger";
                options.Icon = "fa fa-cloud";
                options.AutoLinkOptions = new ExternalSignInAutoLinkOptions(
                    // must be true for auto-linking to be enabled
                    autoLinkExternalAccount: true,

                    // Optionally specify default user group, else
                    // assign in the OnAutoLinking callback
                    // (default is editor)
                    defaultUserGroups: new[] { Constants.Security.EditorGroupAlias },

                    // Optionally specify the default culture to create
                    // the user as. If null it will use the default
                    // culture defined in the web.config, or it can
                    // be dynamically assigned in the OnAutoLinking
                    // callback.

                    defaultCulture: null,
                    // Optionally you can disable the ability to link/unlink
                    // manually from within the back office. Set this to false
                    // if you don't want the user to unlink from this external
                    // provider.
                    allowManualLinking: false
                )
                {
                    // Optional callback
                    OnAutoLinking = (autoLinkUser, loginInfo) =>
                    {
                        // You can customize the user before it's linked.
                        // i.e. Modify the user's groups based on the Claims returned
                        // in the externalLogin info
                    },
                    OnExternalLogin = (user, loginInfo) =>
                    {
                        // You can customize the user before it's saved whenever they have
                        // logged in with the external provider.
                        // i.e. Sync the user's name based on the Claims returned
                        // in the externalLogin info

                        return true; //returns a boolean indicating if sign-in should continue or not.
                    }
                };

                // Optionally you can disable the ability for users
                // to login with a username/password. If this is set
                // to true, it will disable username/password login
                // even if there are other external login providers installed.
                options.DenyLocalLogin = false;

                // Optionally choose to automatically redirect to the
                // external login provider so the user doesn't have
                // to click the login button. This is
                options.AutoRedirectLoginToExternalProvider = false;
            }
        }
    }
    ```

2. Create a new static extension class called `GoogleAuthenticationExtensions.cs`. Add the following code in the `GoogleAuthenticationExtensions.cs` file.

    ```csharp
    using Umbraco.Cms.Core.DependencyInjection;
    using Umbraco.Extensions;
    using Microsoft.Extensions.DependencyInjection;

    namespace MyCustomUmbracoProject.App_Code.Google_Authentication
    {
        public static class GoogleAuthenticationExtensions
        {
            public static IUmbracoBuilder AddGoogleAuthentication(this IUmbracoBuilder builder)
            {
                builder.AddBackOfficeExternalLogins(logins =>
                {
                    logins.AddBackOfficeLogin(
                        backOfficeAuthenticationBuilder =>
                        {
                            backOfficeAuthenticationBuilder.AddGoogle(
                                // The scheme must be set with this method to work for the back office
                                backOfficeAuthenticationBuilder.SchemeForBackOffice(GoogleBackOfficeExternalLoginProviderOptions.SchemeName),
                                options =>
                                {
                                    //  By default this is '/signin-google' but it needs to be changed to this
                                    options.CallbackPath = "/umbraco-google-signin";
                                    options.ClientId = "YOURCLIENTID"; // Replace with your client id generated while creating OAuth client ID
                                    options.ClientSecret = "YOURCLIENTSECRET"; // Replace with your client secret generated while creating OAuth client ID
                                });
                        });
                });
                return builder;
            }
        }
    }
    ```

    :::note
    Ensure to replace **YOURCLIENTID** and **YOURCLIENTSECRET** in the code with the values from the **OAuth Client Ids Credentials** window.
    :::

3. Update `ConfigureServices` in your `Startup.cs` class to register your configuration with Umbraco. For example:

    ### Umbraco 9
    ```csharp
    using MyCustomUmbracoProject.App_Code.Google_Authentication;

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddUmbraco(_env, _config)
            .AddBackOffice()
            .AddWebsite()
            .AddComposers()
            .AddGoogleAuthentication()
            .Build();
    }
    ```
    
    ### Umbraco 10
    ```csharp
    using MyCustomUmbracoProject.App_Code.Google_Authentication;

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddUmbraco(_env, _config)
            .AddBackOffice()
            .AddWebsite()
            .AddComposers()
            .AddGoogleBackofficeAuthentication()
            .Build();
    }
    ```

4. Build and run the website. The first time you will have to link the provider to your account from the Backoffice.

5. Log in to the Backoffice. Click on your user profile in the top-right corner and select **Link your Google account**:
    ![Link to Google Account from Backoffice](images/Link_Google_Account_Backoffice.png)

6. In the **Choose an account** window, select the account you wish to link with the google console project.
    ![Choose Google Sign-in account](images/Link_Google-sign-in.png)

7. For future Backoffice logins, you can click on the **Sign in with Google** button and you will be logged in to the Backoffice with just a click!
    ![Google login screen](images/GoogleLoginScreen_v9.png)

## Related Links

- [External login providers](https://our.umbraco.com/documentation/Reference/Security/External-login-providers/)
- [Linking External Login Provider accounts](https://our.umbraco.com/Documentation/Reference/Security/auto-linking/)
- [Two-factor authentication](https://our.umbraco.com/documentation/Reference/Security/Two-factor-authentication/)

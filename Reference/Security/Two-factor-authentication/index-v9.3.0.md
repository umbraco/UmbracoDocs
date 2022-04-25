---
versionFrom: 9.3.0
keywords: 2fa, security, members
meta.Title: "Two-factor authentication"
meta.Description: "Umbraco users and members support a two-factor authentication (2FA) abstraction for implementing a 2FA provider of your choice"
---

# Two-factor authentication for Members
Two-factor authentication (2FA) for Umbraco members is activated by implementing an `ITwoFactorProvider` interface and registering the implementation. The implementation can use third-party packages to archive for example support for authentication apps like Microsoft- or Google Authentication App.

Because Umbraco does not control how the UI is for member login and profile edit, the UI for 2FA is shipped as part of the snippets for macros. These can be used as a starting point, before styling the page as you would like.

### Example implementation for Authenticator Apps
In the following example, we will use the [GoogleAuthenticator NuGet Package](https://www.nuget.org/packages/GoogleAuthenticator/).
Despite the name, this package works for both Google and Microsoft authenticator apps and can be used to generate the QR code needed to activate the app for the website.

```Csharp
using System;
using System.Threading.Tasks;
using Google.Authenticator;
using Umbraco.Cms.Core.Security;
using Umbraco.Cms.Core.Services;

namespace Umbraco9
{
    /// <summary>
    /// Model with the required data to setup the authentication app.
    /// </summary>
    public class QrCodeSetupData
    {
        /// <summary>
        /// The secret unique code for the user and this ITwoFactorProvider.
        /// </summary>
        public string Secret { get; init; }

        /// <summary>
        /// The SetupCode from the GoogleAuthenticator code.
        /// </summary>
        public SetupCode SetupCode { get; init; }
    }

    /// <summary>
    /// App Authenticator implementation of the ITwoFactorProvider
    /// </summary>
    public class UmbracoAppAuthenticator : ITwoFactorProvider
    {
        /// <summary>
        /// The unique name of the ITwoFactorProvider. This is saved in a constant for reusability.
        /// </summary>
        public const string Name = "UmbracoAppAuthenticator";

        private readonly IMemberService _memberService;

        /// <summary>
        /// Initializes a new instance of the <see cref="UmbracoAppAuthenticator"/> class.
        /// </summary>
        public UmbracoAppAuthenticator(IMemberService memberService)
        {
            _memberService = memberService;
        }

        /// <summary>
        /// The unique provider name of ITwoFactorProvider implementation.
        /// </summary>
        /// <remarks>
        /// This value will be saved in the database to connect the member with this  ITwoFactorProvider.
        /// </remarks>
        public string ProviderName => Name;

        /// <summary>
        /// Returns the required data to setup this specific ITwoFactorProvider implementation. In this case it will contain the url to the QR-Code and the secret.
        /// </summary>
        /// <param name="userOrMemberKey">The key of the user or member</param>
        /// <param name="secret">The secret that ensures only this user can connect to the authenticator app</param>
        /// <returns>The required data to setup the authenticator app</returns>
        public Task<object> GetSetupDataAsync(Guid userOrMemberKey, string secret)
        {
            var member = _memberService.GetByKey(userOrMemberKey);

            var twoFactorAuthenticator = new TwoFactorAuthenticator();
            SetupCode setupInfo = twoFactorAuthenticator.GenerateSetupCode("My application name", member.Username, secret, false);
            return Task.FromResult<object>(new QrCodeSetupData()
            {
                SetupCode = setupInfo,
                Secret = secret
            });
        }

        /// <summary>
        /// Validated the code and the secret of the user.
        /// </summary>
        public bool ValidateTwoFactorPIN(string secret, string code)
        {
            var twoFactorAuthenticator = new TwoFactorAuthenticator();
            return twoFactorAuthenticator.ValidateTwoFactorPIN(secret, code);
        }

        /// <summary>
        /// Validated the two factor setup
        /// </summary>
        /// <remarks>Called to confirm the setup of two factor on the user. In this case we confirm in the same way as we login by validating the PIN.</remarks>
        public bool ValidateTwoFactorSetup(string secret, string token) => ValidateTwoFactorPIN(secret, token);
    }
}
```

First, we create a model with the information required to set up the 2FA provider and then we implement the `ITwoFactorProvider` with the use of the `TwoFactorAuthenticator` from the GoogleAuthenticator NuGet package.

Now we need to register the `UmbracoAppAuthenticator` implementation. This can be done on the `IUmbracoBuilder` in your startup or a composer.

```Csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Security;
using Umbraco.Extensions;

namespace Umbraco9
{
    public class UmbracoAppAuthenticatorComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            var identityBuilder = new MemberIdentityBuilder(builder.Services);
            identityBuilder.AddTwoFactorProvider<UmbracoAppAuthenticator>(UmbracoAppAuthenticator.Name);
        }
    }
}
```


At this point the 2FA is actually active, but no members have setup 2FA yet.
The setup of 2FA depends on the type. In the case of App Authenticator, we will add the following to our view showing the edit profile of the member.

```Csharp
@using Umbraco.Cms.Core.Services
@using Umbraco.Cms.Web.Website.Controllers
@using Umbraco.Cms.Web.Website.Models
@using Umbraco9  @* Or whatever your namespace with the QrCodeSetupData model is *@
@inject MemberModelBuilderFactory memberModelBuilderFactory;
@inject ITwoFactorLoginService twoFactorLoginService
@{
    // Build a profile model to edit
    var profileModel = await memberModelBuilderFactory
        .CreateProfileModel()
        .BuildForCurrentMemberAsync();

    // Show all two factor providers
    var providerNames = twoFactorLoginService.GetAllProviderNames();
    if (providerNames.Any())
    {
        <div asp-validation-summary="All" class="text-danger"></div>
        foreach (var providerName in providerNames)
        {
            var setupData = await twoFactorLoginService.GetSetupInfoAsync(profileModel.Key, providerName);
            if (setupData is null)
            {
                @using (Html.BeginUmbracoForm<UmbTwoFactorLoginController>(nameof(UmbTwoFactorLoginController.Disable)))
                {
                    <input type="hidden" name="providerName" value="@providerName"/>
                    <button type="submit">Disable @providerName</button>
                }
            }
            else if(setupData is QrCodeSetupData qrCodeSetupData)
            {
                @using (Html.BeginUmbracoForm<UmbTwoFactorLoginController>(nameof(UmbTwoFactorLoginController.ValidateAndSaveSetup)))
                {
                    <h3>Setup @providerName</h3>
                    <img src="@qrCodeSetupData.SetupCode.QrCodeSetupImageUrl"/>
                    <p>Scan the code above with your authenticator app <br /> and enter the resulting code here to validate:</p>
                    <input type="hidden" name="providerName" value="@providerName"  />
                    <input type="hidden" name="secret" value="@qrCodeSetupData.Secret"  />
                    <input type="text" name="code"  />
                    <button type="submit">Validate & save</button>
                }
            }
        }
    }
}
```

In this razor-code sample, we get the current member's unique key and list all registered `ITwoFactorProvider` implementations.

If the `setupData` is `null` for the specified `providerName` it means the provider is already <span class="x x-first x-last">set up</span>. In this case<span class="x x-first x-last">,</span> we show a disable button. Otherwise<span class="x x-first x-last">,</span> we check the type and show the UI for how to <span class="x x-first x-last">set up </span>the App Authenticator, by showing the QR Code and <span class="x x-first x-last">an</span> input field to validate the code from the App Authenticator.

The last part required is to use the `Login` Partial Macro snippet.

## Notification when 2FA is requested for a member
When a 2FA login is requested for a member, the `MemberTwoFactorRequestedNotification` is published.
This notification can also be used to send the member a one-time password on e-mail or phone, even though these 2FA types are [not considered as secure](https://docs.microsoft.com/en-us/aspnet/core/security/authentication/mfa?view=aspnetcore-6.0#mfa-sms) as App Authentication, it is still a massive improvement compared to no 2FA.

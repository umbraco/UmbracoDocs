---
description: >-
  Umbraco users and members support a two-factor authentication (2FA)
  abstraction for implementing a 2FA provider of your choice.
---

# Two-factor Authentication

This article includes guides for implementing two-factor authentication options for both backoffice users and website members:

* [Two-Factor Authentication for Members](#two-factor-authentication-for-members)
* [Two-Factor Authentication for Users](#two-factor-authentication-for-users)

Two-factor authentication (2FA) for Umbraco Users and Members is activated by implementing an `ITwoFactorProvider` interface and registering the implementation. The implementation can use third-party packages to support authentication apps like the Microsoft- or Google Authentication Apps.

{% hint style="info" %}
If you are using [Umbraco Cloud](https://umbraco.com/products/umbraco-cloud/), you can enable multi-factor authentication in Umbraco ID. For more information, see the [Multi-Factor Authentication](https://docs.umbraco.com/umbraco-cloud/set-up/multi-factor-authentication-on-cloud) article.
{% endhint %}

## Two-factor authentication for Members

The following guide will take you through implementing an option for your website members to enable two-factor authentication.

{% hint style="info" %}
A setup for members needs to be implemented on your website in order for you to follow this guide. This setup should include:

* Login and logout options.
* Public access restriction configured on at least 1 content item.

[Learn more about setting up a members section in Umbraco.](../../tutorials/members-registration-and-login.md)
{% endhint %}

As an example, the guide will use the [GoogleAuthenticator NuGet Package](https://www.nuget.org/packages/GoogleAuthenticator/). This package works for both Google and Microsoft authenticator apps. It can be used to generate the QR code needed to activate the app for the website.

1. Install the GoogleAuthenticator Nuget Package on your project.
2. Create a new file in your project: `UmbracoAppAuthenticator.cs`.
3. Update the file with the following code snippet.

{% code title="UmbracoAppAuthenticator.cs" lineNumbers="true" %}

```csharp
using Google.Authenticator;
using System.Runtime.Serialization;
using Umbraco.Cms.Core.Security;
using Umbraco.Cms.Core.Services;

namespace My.Website;

/// <summary>
/// Model with the required data to setup the authentication app.
/// </summary>

[DataContract]
public class QrCodeSetupData : ISetupTwoFactorModel
{
    /// <summary>
    /// The secret unique code for the user and this ITwoFactorProvider.
    /// </summary>
    public string? Secret { get; init; }

    /// <summary>
    /// The SetupCode from the GoogleAuthenticator code.
    /// </summary>
    public SetupCode? SetupCode { get; init; }
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
    public Task<ISetupTwoFactorModel> GetSetupDataAsync(Guid userOrMemberKey, string secret)
    {
        var member = _memberService.GetByKey(userOrMemberKey);

        var applicationName = "testingOn15";
        var twoFactorAuthenticator = new TwoFactorAuthenticator();
        SetupCode setupInfo = twoFactorAuthenticator.GenerateSetupCode(applicationName, member.Username, secret, false);
        return Task.FromResult<ISetupTwoFactorModel>(new QrCodeSetupData()
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
```

{% endcode %}

4. Update `namespace` on line 7 to match your project.
5. Customize the `applicationName` variable on line 64.
6. Create a Composer and register the `UmbracoAppAuthenticator` implementation as shown below.

{% code title="UmbracoAppAuthenticatorComposer.cs" lineNumbers="true" %}

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Security;

namespace My.Website;

public class UmbracoAppAuthenticatorComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        var identityBuilder = new MemberIdentityBuilder(builder.Services);
        identityBuilder.AddTwoFactorProvider<UmbracoAppAuthenticator>(UmbracoAppAuthenticator.Name);
    }
}
```

{% endcode %}

At this point, the 2FA is active, but no members have set up 2FA yet. The setup of 2FA depends on the type. In the case of App Authenticator, the **view** showing the option to edit member profiles needs to be modified.

{% hint style="info" %}
If you already have a members-only page with the edit profile options, you can skip directly to step 8.
{% endhint %}

7. Add or choose a members-only page that should have the two-factor authentication setup.
    * The page needs to be behind the public access.
    * The page should **not** be using strongly types models.
8. Open the view file for the selected page.
9. Add the following code:

{% code title="ExampleMemberPage.cshtml" lineNumbers="true" %}

```csharp
@using Umbraco.Cms.Core.Services;
@using Umbraco.Cms.Web.Website.Controllers;
@using Umbraco.Cms.Web.Website.Models;
@using My.Website;
@inject MemberModelBuilderFactory memberModelBuilderFactory
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

            // If the `setupData` is `null` for the specified `providerName` it means the provider is already set up.
            // In this case, a button to disable the authentication is shown.
            if (setupData is null)
            {
                @using (Html.BeginUmbracoForm<UmbTwoFactorLoginController>(nameof(UmbTwoFactorLoginController.Disable)))
                {
                    <input type="hidden" name="providerName" value="@providerName"/>
                    <button type="submit">Disable @providerName</button>
                }
            }
            // If `setupData` is not `null` the type is checked and the UI for how to set up the App Authenticator is shown.
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

{% endcode %}

10. Update the `@using` in line 4 to match the namespace of your project.
11. [Optional] Customize the text fields and buttons to match your websites tone of voice (lines 33-39).

![The QR Code is shown along with a field to enter a value to set up the two factor authentication.](images/2fa-members-configuration.png)

### Test the set up for Members

1. Login to the website using a test member.
2. Navigate to the page where the QR code was added.
3. Scan the QR code and add the verification code.
4. Logout of the website.
5. Login and verify that it asks for the two factor authentication.

You can also check that the **Two-factor Authentication** option is checked on the member in the Umbraco backoffice.

![Check the Member profile in the Umbraco backoffice to verify whether two-factor authentication is enabeld.](images/2fa-member-backoffice.png)

### Notification when 2FA is requested for a member

When a 2FA login is requested for a member, the `MemberTwoFactorRequestedNotification` is published. This notification can also be used to send the member a one-time password via e-mail or phone. Even though these 2FA types are [not considered secure](https://docs.microsoft.com/en-us/aspnet/core/security/authentication/mfa?view=aspnetcore-6.0#mfa-sms) as App Authentication, it is still a massive improvement compared to no 2FA.

## Two-factor authentication for Users

The following guide will take you through implementing an option for backoffice users to enable two-factor authentication.

This guide will not cover setting up the UI for user login and edits as this is handled elsewhere in the CMS.

### Example implementation for Authenticator Apps for Users

As an example, the guide will use the [GoogleAuthenticator NuGet Package](https://www.nuget.org/packages/GoogleAuthenticator/). This package works for both Google and Microsoft authenticator apps. It can be used to generate the QR code needed to activate the app for the website.

1. Install the GoogleAuthenticator Nuget Package on your project.
2. Create a new file in your project: `UmbracoUserAppAuthenticator.cs`.
3. Update the file with the following code snippet.

{% code title="UmbracoUserAppAuthenticator.cs" lineNumbers="true" %}

```csharp
using System.Runtime.Serialization;
using Google.Authenticator;
using Umbraco.Cms.Core.Models.Membership;
using Umbraco.Cms.Core.Security;
using Umbraco.Cms.Core.Services;

namespace My.Website;

[DataContract]
public class TwoFactorAuthInfo : ISetupTwoFactorModel
{
    [DataMember(Name = "qrCodeSetupImageUrl")]
    public string? QrCodeSetupImageUrl { get; set; }

    [DataMember(Name = "secret")]
    public string? Secret { get; set; }
}

/// <summary>
/// App Authenticator implementation of the ITwoFactorProvider
/// </summary>
public class UmbracoUserAppAuthenticator : ITwoFactorProvider
{
    /// <summary>
    /// The unique name of the ITwoFactorProvider. This is saved in a constant for reusability.
    /// </summary>
    public const string Name = "UmbracoUserAppAuthenticator";

    private readonly IUserService _userService;

    /// <summary>
    /// Initializes a new instance of the <see cref="UmbracoUserAppAuthenticator"/> class.
    /// </summary>
    public UmbracoUserAppAuthenticator(IUserService userService)
    {
        _userService = userService;
    }

    /// <summary>
    /// Gets the unique provider name of ITwoFactorProvider implementation.
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
    public Task<ISetupTwoFactorModel> GetSetupDataAsync(Guid userOrMemberKey, string secret)
    {
        IUser? user = _userService.GetByKey(userOrMemberKey);

        ArgumentNullException.ThrowIfNull(user);

        var applicationName = "My application name";
        var twoFactorAuthenticator = new TwoFactorAuthenticator();
        SetupCode setupInfo = twoFactorAuthenticator.GenerateSetupCode(applicationName, user.Username, secret, false);
        return Task.FromResult<ISetupTwoFactorModel>(new TwoFactorAuthInfo()
        {
            QrCodeSetupImageUrl = setupInfo.QrCodeSetupImageUrl,
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
```

{% endcode %}

4. Update `namespace` on line 7 to match your project.
5. Customize the `applicationName` variable on line 59.
6. Create a new file in your project: `UmbracoUserAppAuthenticatorComposer.cs`.
7. Implement a new composer and register the `UmbracoUserAppAuthenticator` implementation as shown below.

{% code title="UmbracoUserAppAuthenticatorComposer.cs" lineNumbers="true" %}

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Security;

namespace My.Website;

public class UmbracoUserAppAuthenticatorComposer : IComposer
{
 public void Compose(IUmbracoBuilder builder)
 {
  var identityBuilder = new BackOfficeIdentityBuilder(builder.Services);

  identityBuilder.AddTwoFactorProvider<UmbracoUserAppAuthenticator>(UmbracoUserAppAuthenticator.Name);
 }
}
```

{% endcode %}

8. Update the `namespace` on line 4 to match your project.

With the 2FA in place, the provider needs to be registered in the backoffice client in order for the user to be able to use it.

9. Add a new file to your project directory: `~/App_Plugins/TwoFactorProviders/umbraco-package.json`.
10. Add the following code to the new file:

{% code title="~/App_Plugins/TwoFactorProviders/umbraco-package.json" lineNumbers="true" %}

```json
{
  "$schema": "../../umbraco-package-schema.json",
  "name": "2fa providers",
  "version": "1.0.0",
  "extensions": [
    {
      "type": "mfaLoginProvider",
      "alias": "UmbracoUserAppAuthenticator",
      "name": "UmbracoUserAppAuthenticator",
      "forProviderName": "UmbracoUserAppAuthenticator",
      "meta": {
        "label": "Google Authenticator"
      }
    }
  ]
}
```

{% endcode %}

At this point, the 2FA is active, but no users have set up 2FA yet.

### Test the set up for Users

Each user can now enable the configured 2FA providers on their user.

1. Access the Umbraco backoffice.
2. Click the user avatar in the top-right corner.

![User panel](images/user-panel.jpg)

3. Select `Configure Two-Factor` button to get a list of all enabled two-factor providers.

![Configure 2fa](images/configure-2fa.jpg)

4. Select `Enable` to show the configured view.

![Enable 2fa](images/enable-2fa.jpg)

5. Follow the instructions to configure 2FA.

When the authenticator is enabled correctly, a disable button is shown instead.

![Disable 2fa](images/disable-2fa.jpg)

To disable the two-factor authentication on your user, it is required to enter the verification code.

![Verify disable](images/verify-disable.jpg)

If the code is correct, the provider is disabled.

### Notification when 2FA is requested for a user

When a 2FA login is requested for a user, the `UserTwoFactorRequestedNotification` is published. This notification can also be used to send the user a one-time password via e-mail or phone. Even though these 2FA types are [not considered secure](https://docs.microsoft.com/en-us/aspnet/core/security/authentication/mfa?view=aspnetcore-6.0#mfa-sms) as App Authentication, it is still a massive improvement compared to no 2FA.

### Login with 2FA enabled

When a user with 2FA enabled logs in, they will be presented with a screen to enter the verification code:

While the 2FA is enabled, the user will be presented with this screen after entering the username and password.

![Default 2FA login](images/2fa-login-default-view.jpg)

If the code is correct, the user will be logged in. If the code is incorrect, the user will be presented with an error message.

This screen is set up to work well with 2FA providers that require a one-time code to be entered. The code field follows best practices for accessibility in terms of labeling and autocompletion.

{% hint style="info" %}
A user can have more than one 2FA provider activated simultaneously. In this case, the user will be presented with a dropdown to choose which provider to use before entering a code.
{% endhint %}

## Customizing the 2FA experience

The 2FA experience can be customized in Umbraco. This can be done by creating a custom view for the activation screen and the login screen. This is useful if you have a 2FA provider that requires something else than a one-time code to be entered.

The following examples show how to customize the 2FA activation screen and the 2FA login screen.

The examples are using the [Lit](https://lit.dev/) library to create custom elements. This is the recommended way of creating custom elements in Umbraco. Lit is a light-weight library that augments the [Custom Elements API](https://developer.mozilla.org/en-US/docs/Web/API/Web_components/Using_custom_elements) to provide a declarative, performant, and interoperable way to create web components.

The examples are using the `@umbraco-cms/backoffice` package to get access to the Umbraco backoffice components and services. This package is included in Umbraco and can be used to create custom elements that look and feel like the rest of the Umbraco backoffice.

They are written in vanilla JavaScript and C#, but the same principles can be applied to other languages. For more information about creating custom elements in Umbraco with a bundler and TypeScript, see the [Development Flow](../../customizing/development-flow/) article.

### Customizing the 2FA activation screen

The 2FA activation screen can be customized. This should be done if you have a 2FA provider that does not require a one-time code to be entered.

To customize the 2FA activation screen, you need to create a JavaScript module. The module should export a default custom element to be used in the activation screen. This module should be placed in the `App_Plugins/TwoFactorProviders` folder.

{% code title="~/App_Plugins/TwoFactorProviders/2fa-activation.js" lineNumbers="true" %}
```javascript
import { UserService } from '@umbraco-cms/backoffice/external/backend-api';
import { css, html } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import { isApiError, tryExecuteAndNotify } from '@umbraco-cms/backoffice/resources';
import { UMB_NOTIFICATION_CONTEXT } from '@umbraco-cms/backoffice/notification';
import { UmbTextStyles } from '@umbraco-cms/backoffice/style';

export default class My2faActivationElement extends UmbLitElement {
    static get properties() {
        return {
            providerName: { type: String },
            displayName: { type: String },
            callback: { type: Function },
            close: { type: Function },
            _loading: { type: Boolean, state: true, attribute: false },
            _qrCodeSetupImageUrl: { type: String, state: true, attribute: false },
            _buttonState: { type: String, state: true, attribute: false },
        };
    }

    constructor() {
        super();

        this.consumeContext(UMB_NOTIFICATION_CONTEXT, (context) => {
            this.notificationContext = context;
        });
    }

    async firstUpdated() {
        await this.#load();
        this._loading = false;
    }

    async #load() {
        if (!this.providerName) {
            this.peek('Provider name is required', 'danger');
            throw new Error('Provider name is required');
        }
        const { data: _data } = await tryExecuteAndNotify(
            this,
            UserService.getUserCurrent2FaByProviderName({ providerName: this.providerName }),
        );
        const data = _data;
        if (!data) {
            this.peek('No data returned', 'danger');
            throw new Error('No data returned');
        }

        // Verify that there is a secret
        if (!data.secret) {
            this.peek('The provider did not return a secret.', 'danger');
            throw new Error('No secret returned');
        }

        this._secret = data.secret;
        this._qrCodeSetupImageUrl = data.qrCodeSetupImageUrl;
    }

    render() {
        if (this._loading) {
            return html`<uui-loader-bar></uui-loader-bar>`;
        }

        return html`
   <uui-form>
    <form id="authForm" name="authForm" @submit=${this.submit} novalidate>
     <umb-body-layout headline=${this.displayName}>
      <div id="main">
       <uui-box .headline=${this.localize.term('member_2fa')}>
        <div class="text-center">
         <p>
          <umb-localize key="user_2faQrCodeDescription">
           Scan this QR code with your authenticator app to enable two-factor authentication
          </umb-localize>
         </p>
         <img
          id="qrCode"
          src=${this._qrCodeSetupImageUrl}
          alt=${this.localize.term('user_2faQrCodeAlt')}
          title=${this.localize.term('user_2faQrCodeTitle')}
          loading="eager" />
        </div>
        <uui-form-layout-item class="text-center">
         <uui-label for="code" slot="label" required>
          <umb-localize key="user_2faCodeInput"></umb-localize>
         </uui-label>
         <uui-input
          id="code"
          name="code"
          type="text"
          inputmode="numeric"
          autocomplete="one-time-code"
          required
          required-message=${this.localize.term('general_required')}
          label=${this.localize.term('user_2faCodeInputHelp')}
          placeholder=${this.localize.term('user_2faCodeInputHelp')}></uui-input>
        </uui-form-layout-item>
       </uui-box>
      </div>
      <div slot="actions">
       <uui-button
        type="button"
        look="secondary"
        .label=${this.localize.term('general_close')}
        @click=${this.close}>
        ${this.localize.term('general_close')}
       </uui-button>
       <uui-button
        .state=${this._buttonState}
        type="submit"
        look="primary"
        .label=${this.localize.term('buttons_save')}>
        ${this.localize.term('general_submit')}
       </uui-button>
      </div>
     </umb-body-layout>
    </form>
   </uui-form>
  `;
    }

    /**
     * Show a peek notification with a message.
     * @param message {String} The message to show.
     * @param color {"positive" | "danger" | undefined} The color of the notification.
     */
    peek(message, color) {
        this.notificationContext.peek(color ?? 'positive', {
            data: {
                headline: this.localize.term('member_2fa'),
                message,
            },
        });
    }

    /**
     * Submit the form with the code and secret back to the opener.
     * @param e {SubmitEvent} The submit event
     */
    async submit(e) {
        e.preventDefault();
        const codeField = this.shadowRoot.getElementById('code');
        codeField?.setCustomValidity('');

        const form = e.target;

        if (!form.checkValidity()) return;

        const formData = new FormData(form);
        const code = formData.get('code');

        if (!code) return;

        this._buttonState = 'waiting';
        const { error } = await this.callback(this.providerName, code, this._secret);

        if (!error) {
            this.peek(this.localize.term('user_2faProviderIsEnabledMsg', this.displayName ?? this.providerName));
            this._buttonState = 'success';
            this.close();
        } else {
            this._buttonState = 'failed';
            if (isApiError(error)) {
                if (error.body?.operationStatus === 'InvalidCode') {
                    codeField?.setCustomValidity(this.localize.term('user_2faInvalidCode'));
                    codeField?.focus();
                } else {
                    this.peek(
                        this.localize.term('user_2faProviderIsNotEnabledMsg', this.displayName ?? this.providerName),
                        'warning',
                    );
                }
            } else {
                this.peek(error.message, 'warning');
            }
        }
    }

    static get styles() {
        return [
            UmbTextStyles,
            css`
                #authForm {
                    height: 100%;
                }

                #qrCode {
                    width: 100%;
                    aspect-ratio: 1;
                }

                #code {
                    width: 100%;
                    max-width: 300px;
                }

                .text-center {
                    text-align: center;
                }
            `,
        ];
    }
}

customElements.define('my-2fa-activation', My2faActivationElement);
```
{% endcode %}

This module will show a QR code and an input field for the user to enter the code from the authenticator app. When the user submits the form, the code will be sent to the server to validate. If the code is correct, the provider will be enabled.

To replace the default activation screen with the custom view, you need to register the element in the `umbraco-package.json` file that you created before. The final form of the file should look like this:

{% code title="~/App_Plugins/TwoFactorProviders/umbraco-package.json" lineNumbers="true" %}
```json
{
  "$schema": "../../umbraco-package-schema.json",
  "name": "2fa providers",
  "version": "1.0.0",
  "extensions": [
    {
      "type": "mfaActivationProvider",
      "alias": "UmbracoUserAppAuthenticator",
      "name": "UmbracoUserAppAuthenticator",
      "forProviderName": "UmbracoUserAppAuthenticator",
      "element": "/App_Plugins/TwoFactorProviders/2fa-activation.js", // This line is the only change
      "meta": {
        "label": "Google Authenticator"
      }
    }
  ]
}
```
{% endcode %}

### Customizing the login screen

The 2FA login screen can also be customized. This should be done if you have a 2FA provider that requires something else than a one-time code to be entered.

You should only customize the 2FA login screen in certain cases, for example:

* If you have a provider that requires a non-numeric field or additional info.
* If you have a provider that requires the user to scan a QR code, you should additionally show the QR code.
* If you need to authenticate the user in a different way than the default option.

You need to create a JavaScript module that exports a default custom element to be used in the login screen. This module should be placed in the `App_Plugins` folder. The module should be registered using a composer.

You can use the following code as a starting point. This will give you a view looking like this, where the user can enter a code and click a button to verify the code. This is similar to the built-in view in Umbraco. In a real world scenario, you would probably want to authenticate the user in a different way.

![Custom 2FA login](images/2fa-login-custom-view.png)

The following code is an example of a custom 2FA login screen using [Lit](https://lit.dev/). This is the recommended way of creating a custom 2FA login screen. Lit is a light-weight library that augments the [Custom Elements API](https://developer.mozilla.org/en-US/docs/Web/API/Web_components/Using_custom_elements) to provide a declarative, performant, and interoperable way to create web components.

The element registers two properties: providers and returnPath. These properties are used to render the view. The providers property is an array of strings, where each string is the name of a 2FA provider. The returnPath is the path to redirect to after a successful login. Both supplied by the login screen automatically.

{% code title="~/App_Plugins/TwoFactorProviders/Custom2faLogin.js" lineNumbers="true" %}
```javascript
import { css, html } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';

export default class My2faViewElement extends UmbLitElement {
  static get properties() {
    return {
      providers: { type: Array },
      returnPath: { type: String },
      buttonState: { type: String, state: true, attribute: false }
    };
  }

  get codeField() {
    return this.shadowRoot.getElementById('code');
  }

  /**
   * @param evt {SubmitEvent}
   * @param provider {String}
   * @returns {Promise<void>}
   */
  async onSubmit(evt, provider) {
    evt.preventDefault();

    this.codeField.error = false;
    this.codeField.setCustomValidity('');
    this.errorMessage = '';

    /**
     * @type {HTMLFormElement}
     */
    const form = evt.target;

    const isValid = form.checkValidity();
    if (!isValid) {
      return;
    }

    this.buttonState = 'loading';
    const formData = new FormData(form);
    const code = formData.get('code');

    const authContext = await this.getContext('UmbAuthContext');
    if (!authContext) {
      this.errorMessage = 'Error: No auth context';
      this.buttonState = 'failed';
      return;
    }

    const { error } = await authContext.validateMfaCode(code, provider);

    if (error) {
      this.codeField.error = true;
      this.codeField.errorMessage = error;
      this.codeField.focus();
      this.buttonState = 'failed';
      return;
    }

    this.buttonState = 'success';

    if (this.returnPath) {
      window.location.href = this.returnPath;
    }
  }

  renderProvider(provider) {
    return html`
      <uui-form>
        <form method="post" @submit=${(e) => this.onSubmit(e, provider)} novalidate>
          <h3>${provider}</h3>
          <p>You are about to sign-in with ${provider}.</p>
          <uui-form-layout-item>
            <uui-label for="code" slot="label" required>Type the authentication code from your device</uui-label>
            <uui-input id="code" type="text" name="code" autocomplete="one-time-code" inputmode="numeric" placeholder="123456" required>
              <div slot="prepend">
                <uui-icon name="wand"></uui-icon>
              </div>
            </uui-input>
          </uui-form-layout-item>

          <div>
            <uui-button type="submit" id="button" look="primary" .state=${this.buttonState}>
              <uui-icon name="icon-cloud"></uui-icon>
              Authenticate
            </uui-button>
          </div>

          <div id="error">
            ${this.errorMessage}
          </div>
        </form>
      </uui-form>
    `;
  }

  render() {
    return html`
      ${this.providers.length ? this.providers.map(provider => this.renderProvider(provider)) : html`<p>Error: No providers available</p>`}
    `;
  }

  static styles = css`
    :host {
      display: block;
      width: 100%;
    }
    #button {
      width: 100%;
    }
    #error {
      color: red;
    }
  `;
}

customElements.define('my-2fa-view', My2faViewElement);
```
{% endcode %}

We need to register the custom view using a composer. This can be done on the `IUmbracoBuilder` in your startup or a composer. In this case, we will add a composer to your project. This composer will overwrite the `IBackOfficeTwoFactorOptions` to use the custom view.

{% code title="TwoFactorConfiguration.cs" lineNumbers="true" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Web.BackOffice.Security;

namespace My.Website;

/// <inheritdoc />
public class TwoFactorConfiguration : IBackOfficeTwoFactorOptions
{
    /// <inheritdoc />
    public string GetTwoFactorView(string username) => "/App_Plugins/TwoFactorProviders/Custom2faLogin.js";
}

public class TwoFactorConfigurationComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddSingleton<IBackOfficeTwoFactorOptions, TwoFactorConfiguration>();
    }
}

```
{% endcode %}

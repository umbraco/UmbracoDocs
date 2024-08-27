---
description: >-
  In this article you can learn the various ways of customizing the Umbraco
  backoffice login screen and form.
---

# Login

To access the backoffice, you will need to login. You can do this by adding `/umbraco` at the end of your website URL, for example `http://mywebsite.com/umbraco`.

You will be presented with a login form similar to this:

![Login screen](../../../../13/umbraco-cms/fundamentals/backoffice/images/login-backoffice-login.png)

The **login** screen contains a short greeting, a **login form** and an optional **Forgotten password** link.

Below, you will find instructions on how to customize the login screen.

## Greeting

The login screen features a greeting text: The "Welcome" headline. You can personalize this by overriding the existing language translation keys.

To do this, register a 'localization' manifest for the default language of your Umbraco site, (usually en-US) to override the greetings.

{% code title="App_Plugins/Login/umbraco-package.json" lineNumbers="true" %}
```json
{
    "alias": "login.extensions",
    "name": "Login extensions",
    "version": "1.0.0",
    "allowPublicAccess": true,
    "extensions": [
        {
            "type": "localization",
            "alias": "Login.Localize.EnUS",
            "name": "English",
            "meta": {
                "culture": "en-US",
                "translations": {
                    "auth": {
                        "greeting0": "It is Sunday",
                        "greeting1": "It is Monday",
                        "greeting2": "It is Tuesday",
                        "greeting3": "It is Wednesday",
                        "greeting4": "It is Thursday",
                        "greeting5": "It is Friday",
                        "greeting6": "It is Saturday"
                    }
                }
            },
        }
    ]
}
```
{% endcode %}

This will override the default greetings with the ones you provide. The login screen will now display "It is Sunday" instead of "Welcome" for example.

{% hint style="info" %}
The login screen has its own set of localization files independent of the rest of the Backoffice. You can read more about Backoffice localization in the [UI Localization](../../extending/language-files/ui-localization.md) article.
{% endhint %}

You can customize other text on the login screen as well. First, grab the default values and keys from the [en.ts](https://github.com/umbraco/Umbraco-CMS/blob/contrib/src/Umbraco.Web.UI.Login/src/localization/lang/en.ts) in the Umbraco CMS Github repository. Thereafter copy the ones you want to translate into `~/App_Plugins/Login/umbraco-package.json` file.

## Password reset

The **Forgotten password?** link allows your backoffice users to reset their password. To use this feature, you will need to add the following key to the `Umbraco.Cms.Security` section in the `appsettings.json` file:

```json
"Umbraco": {
    "CMS": {
      "Security": {
        "AllowPasswordReset": true
      }
   }
}
```

Set it to `true` to enable the password reset feature, and `false` to disable the feature.

You will also need to configure a Simple Mail Transfer Protocol (SMTP) server in your `appsettings.json` file. When you get a successful result on the SMTP configuration when running a health check in the backoffice, you are good to go!

An example:

```json
"Umbraco": {
    "CMS": {
      "Global": {
        "Id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "Smtp": {
          "From": "noreply@test.com",
          "Host": "127.0.0.1",
          "Username": "username",
          "Password": "password"
        }
      }
    }
}
```

## Custom background image and logo

It is possible to customize the background image and the logo for the backoffice login screen by adding the `"Content"` section in the `appsettings.json` file:

```json
"Umbraco": {
    "CMS": {
      "Content": {
        "LoginBackgroundImage": "../myImagesFolder/myLogin.jpg",
        "LoginLogoImage": "../myImagesFolder/myLogo.svg",
        "LoginLogoImageAlternative": "../myImagesFolder/myLogo.svg"
      }
   }
}
```

The `LoginBackgroundImage`, `LoginLogoImage`, and `LoginLogoImageAlternative` are referenced from the `/wwwroot/umbraco/` folder.

The `LoginLogoImage` is displayed on top of the `LoginBackgroundImage` and the `LoginLogoImageAlternative` is displayed when the `LoginLogoImage` is not available, for example on small resolutions.

## Custom CSS

You can also customize the login screen by adding a custom CSS file. To do this, you will need to add a new file inside the `~/App_Plugins` folder, for example `~/App_Plugins/MyCustomLoginScreen/my-custom-login-screen.css`.

You can then add your custom CSS to the file:

```css
:root {
    --umb-login-curves-color: rgba(0, 0, 0, 0.1);
}
```

This will change the color of the SVG graphics (curves) shown on the login screen. You can also hide the curves by adding the following CSS:

```css
:root {
    --umb-login-curves-display: none;
}
```

### Load the custom CSS file

To tell Umbraco about your custom CSS file, you will need to add a `umbraco-package.json` file. The `umbraco-package.json` file should look like this:

```json
{
    "alias": "login.extensions",
    "name": "Login extensions",
    "version": "1.0.0",
    "allowPublicAccess": true,
    "extensions": [
        {
            "type": "appEntryPoint",
            "alias": "MyCustomLoginScreen",
            "name": "My Custom Login Screen",
            "js": "/App_Plugins/MyCustomLoginScreen/my-custom-login-screen.js"
        }
    ]
}
```

Next add a JavaScript file, for example `~/App_Plugins/MyCustomLoginScreen/my-custom-login-screen.js`, and add the following code to load the custom CSS file:

```javascript
import './my-custom-login-screen.css';
```

This will load the custom CSS file into Umbraco.

{% hint style="warning" %}
Be aware that the custom CSS file will be loaded on all Umbraco screens, not only the login screen.
{% endhint %}

### Custom CSS properties reference

The following CSS properties are available for customization:

| CSS Property                             | Description                                    | Default Value                                                                              |
| ---------------------------------------- | ---------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `--umb-login-background`                 | The background of the layout                   | `#f4f4f4`                                                                                  |
| `--umb-login-primary-color`              | The color of the headline                      | `#283a97`                                                                                  |
| `--umb-login-text-color`                 | The color of the text                          | `#000`                                                                                     |
| `--umb-login-header-font-size`           | The font-size of the headline                  | `3rem`                                                                                     |
| `--umb-login-header-font-size-large`     | The font-size of the headline on large screens | `4rem`                                                                                     |
| `--umb-login-header-secondary-font-size` | The font-size of the secondary headline        | `2.4rem`                                                                                   |
| `--umb-login-image`                      | The background of the image wrapper            | The value of the [LoginBackgroundImage](login.md#custom-background-image-and-logo) setting |
| `--umb-login-image-display`              | The display of the image wrapper               | `flex`                                                                                     |
| `--umb-login-image-border-radius`        | The border-radius of the image wrapper         | `38px`                                                                                     |
| `--umb-login-content-background`         | The background of the content wrapper          | `none`                                                                                     |
| `--umb-login-content-display`            | The display of the content wrapper             | `flex`                                                                                     |
| `--umb-login-content-width`              | The width of the content wrapper               | `100%`                                                                                     |
| `--umb-login-content-height`             | The height of the content wrapper              | `100%`                                                                                     |
| `--umb-login-content-border-radius`      | The border-radius of the content wrapper       | `0`                                                                                        |
| `--umb-login-align-items`                | The align-items of the main wrapper            | `unset`                                                                                    |
| `--umb-login-button-border-radius`       | The border-radius of the buttons               | `45px`                                                                                     |
| `--umb-login-curves-color`               | The color of the curves                        | `#f5c1bc`                                                                                  |
| `--umb-login-curves-display`             | The display of the curves                      | `inline`                                                                                   |

The CSS custom properties may change in future versions of Umbraco. You can always find the latest values in the [login layout element](https://github.com/umbraco/Umbraco-CMS/blob/v13/dev/src/Umbraco.Web.UI.Login/src/components/layouts/auth-layout.element.ts) in the Umbraco CMS Github repository.

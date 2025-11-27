---
description: >-
  In this article you can learn the various ways of customizing the Umbraco
  backoffice login screen and form.
---

# Login

To access the backoffice, you will need to login. You can do this by adding `/umbraco` at the end of your website URL, for example `http://mywebsite.com/umbraco`.

You will be presented with a login form similar to this:

![Login screen](images/login-backoffice-login-v14.png)

The **login** screen contains a short greeting, a **login form** and an optional **Forgotten password** link.

Below, you will find instructions on how to customize the login screen.

## Greeting

The login screen features a greeting text: The "Welcome" headline. This can be personalized by overriding the existing language translation keys.

To do this follow the steps below:

1. Register a 'localization' manifest for the default language of your Umbraco site, (usually en-US) to override the greetings.

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
            "js": "/App_Plugins/Login/en-us.js",
            "meta": {
                "culture": "en-US"
            }
        }
    ]
}
```
{% endcode %}

2. Add an `en-us.js` file containing the following:

{% code title="App_Plugins/Login/en-us.js" %}
```javascript
export default {
  auth: {
    instruction: "Log in again to continue",
    greeting0: "Is is Sunday",
    greeting1: "Is is Monday",
    greeting2: "Is is Tuesday",
    greeting3: "Is is Wednesday",
    greeting4: "Is is Thursday",
    greeting5: "Is is Friday",
    greeting6: "Is is Saturday",
  }
}
```
{% endcode %}

This will override the default greetings with the ones you provide. The login screen will now display "It is Sunday" instead of "Welcome" for example.

{% hint style="info" %}
The login screen has its own set of localization files independent of the rest of the Backoffice. You can read more about Backoffice localization in the [UI Localization](../../customizing/foundation/localization.md) article.
{% endhint %}

You can customize other text on the login screen as well. First, grab the default values and keys from the [en.ts](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Web.UI.Login/src/localization/lang/en.ts) in the Umbraco CMS GitHub repository. Thereafter copy the ones you want to translate into `~/App_Plugins/Login/umbraco-package.json` file.

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

You can also customize the login screen by adding a custom CSS file. To do this, you will need to add a new file inside the `~/App_Plugins` folder, for example `~/App_Plugins/Login/my-custom-login-screen.css`.

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
            "js": "/App_Plugins/Login/my-custom-login-screen.js"
        }
    ]
}
```

Next add a JavaScript file, for example `~/App_Plugins/Login/my-custom-login-screen.js`, and add the following code to load the custom CSS file:

```javascript
const link = document.createElement('link');
link.rel = 'stylesheet';
link.href = '/App_Plugins/Login/my-custom-login-screen.css';
document.head.appendChild(link);
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

The CSS custom properties may change in future versions of Umbraco. You can always find the latest values in the [login layout element](https://github.com/umbraco/Umbraco-CMS/blob/v14/dev/src/Umbraco.Web.UI.Login/src/components/layouts/auth-layout.element.ts) in the Umbraco CMS GitHub repository.

## The Time Out Screen

![Time out screen](images/timeout-screen.jpg)

The time out screen is displayed when the user has been inactive for a certain amount of time. The screen resembles the login screen in many ways and the two are sometimes confused. The most notable difference is that the time out screen does not have a login form. It only has a message and a button to log in again with Umbraco.

If you have added more than one login provider, the users will also see this screen first. This is because they need to choose which provider to use first. In that case, the screen is also referred to as the **Choose provider screen**.

You can customize the time out screen in the same way as the login screen. The time out screen uses the same localization files as the rest of the Backoffice and **not** those of the login screen. The notable difference is that the time out screen is scoped to the `login` section. The login screen is scoped to the `auth` section of the localization files.

### Greeting

To update the greeting message on this screen, you will have to change the section to `login`:

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
            "js": "/App_Plugins/Login/en-us.js",
            "meta": {
                "culture": "en-US"
            }
        }
    ]
}
```
{% endcode %}

The `en-us.js` file should contain the following:

{% code title="App_Plugins/Login/en-us.js" %}
```javascript
export default {
  auth: {
    instruction: "Log in again to continue",
    greeting0: "Is is Sunday",
    greeting1: "Is is Monday",
    greeting2: "Is is Tuesday",
    greeting3: "Is is Wednesday",
    greeting4: "Is is Thursday",
    greeting5: "Is is Friday",
    greeting6: "Is is Saturday",
  }
}
```
{% endcode %}

The `instruction` key is shown when the user has timed out, and the `greeting0..6` keys are shown when the user has to choose a login provider.

### Image

You can update the image on the time out screen through a custom CSS variable. The default value is `--umb-login-image` and it is set to the same value as the login screen. You can override this value in your custom CSS file:

```css
:root {
    --umb-login-image: url(../myImagesFolder/myTimeout.jpg);
}
```

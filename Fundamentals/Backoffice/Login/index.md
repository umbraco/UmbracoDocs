---
meta.Title: "Configure and customize the Login screen"
meta.Description: "In this article you can learn the various ways of customizing the Umbraco backoffice login screen and form."
versionFrom: 9.0.0
---

# Login screen

To access the backoffice, you will need to login. You can do this by adding `/umbraco` at the end of your website URL, e.g. http://mywebsite.com/umbraco.

You will be presented with a login form similar to this:

![Login screen](images/backoffice-login.png "The login screen has a greeting, username/password field and optionally a 'Forgotten password' link.")

The **login** screen contains a **Greeting**, **Email**, **Password** field and optionally a **Forgotten password** link

Below, you will find instructions on how to customise the login screen.

## Greeting

The login screen features a greeting which you can personalize by creating (as an example) an `en_us.user.xml` file in a new root directory `~/config/lang/`. For example for en-US you would take the relevant keys below from `~/umbraco/config/lang/en_us.xml` and add them to `~/config/lang/en_us.user.xml`

```xml
<area alias="login">
    <key alias="greeting0">Happy super Sunday</key>
    <key alias="greeting1">Happy manic Monday </key>
    <key alias="greeting2">Happy tubular Tuesday</key>
    <key alias="greeting3">Happy wonderful Wednesday</key>
    <key alias="greeting4">Happy thunderous Thursday</key>
    <key alias="greeting5">Happy funky Friday</key>
    <key alias="greeting6">Happy Caturday</key>
</area>
```
You can customize other text in the login screen as well, grab the default values from `~/umbraco/config/lang/en.xml` and copy the keys you want to translate into a new `~/config/lang/MYLANGUAGE.user.xml` file. Note: the new /config/ folder needs to be created at the site root.

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

You will also need to configure an SMTP server in your `appsettings.json` file. When you get a successful result on the SMTP configuration when running a health check in the backoffice, you are good to go!

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

## Background image

It is possible to customize the background image for the backoffice login screen by adding the `"Content"` section in the `appsettings.json` file:

```json
"Umbraco": {
    "CMS": {
      "Content": {
        "LoginBackgroundImage": "assets/img/login.jpg"
      }
   }
} 
```

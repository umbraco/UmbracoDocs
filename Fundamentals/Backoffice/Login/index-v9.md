---
meta.Title: "Configure and customize the Login screen"
meta.Description: "In this article you can learn the various ways of customizing the Umbraco backoffice login screen and form."
versionFrom: 9.0.0
---

# Login screen

To access the backoffice, you will need to login. You can do this by adding `/umbraco` at the end of your website URL, e.g. http://mywebsite.com/umbraco.

You will be presented with a login form similar to this:

![Login screen](images/backoffice-login.png "The login screen has a greeting, username/password field and optionally a 'Forgotten password' link.")

The login screen contains a greeting, username/password field and optionally a 'Forgotten password' link

Below, you will find instructions on how to customise the login screen.

## Greeting

The login screen features a greeting, which you can personalize by changing the language file of your choice. For example for en-US you would add the following keys to: `~/umbraco/config/lang/en_us.xml`

```xml
<area alias="login">
  <key alias="greeting0">Sunday greeting</key>
  <key alias="greeting1">Monday greeting</key>
  <key alias="greeting2">Tuesday greeting</key>
  <key alias="greeting3">Wednesday greeting</key>
  <key alias="greeting4">Thursday greeting</key>
  <key alias="greeting5">Friday greeting</key>
  <key alias="greeting6">Saturday greeting</key>
</area>
```

You can customize other text in the login screen as well, grab the default values from `~/Umbraco/Config/Lang/en.xml` and copy the keys you want to translate into your `~/Umbraco/Config/Lang/MYLANGUAGE.user.xml` file.

## Password reset

The "Forgotten password?" link allows your backoffice users to reset their password. To use this feature, you will need to add the following key to the `<security>` section in the `appsettings.json` file:

```json
"Security": { 
        "AllowPasswordReset": true
      },
```

Set it to `true` to enable the password reset feature, and to `false` to disable the feature.

You will also need to configure an SMTP server in your `appsettings.json` file. When you get a successful result on the SMTP configuration when running a health check in the backoffice, you are good to go!

An example:

```json
"Global": {
        "Id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "Smtp": {
          "From": "noreply@test.com",
          "Host": "127.0.0.1",
          "Username": "username",
          "Password": "password"
        }
      },
```

## Background image

It is possible to customize the background image for the backoffice login screen by adding the `<Content>` section in the `appsettings.json` file:

```json
"Content": {
        "LoginBackgroundImage": "assets/img/login.jpg"
      }
```

Your `appsettings.json` file should now look like this:
```json
 "Umbraco": {
    "CMS": {
      "Hosting": {
        "Debug": false
      },
      "Global": {
        "Id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "Smtp": {
          "From": "noreply@test.com",
          "Host": "127.0.0.1",
          "Username": "username",
          "Password": "password"
        }
      },
     "Security": { 
        "AllowPasswordReset": true
      },
      "Content": {
        "LoginBackgroundImage": "assets/img/login.jpg"
      }
    }
 }
```

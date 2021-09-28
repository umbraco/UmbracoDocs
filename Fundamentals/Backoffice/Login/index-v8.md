---
meta.Title: "Configure and customize the Login screen"
meta.Description: "In this article you can learn the various ways of customizing the Umbraco backoffice login screen and form."
versionFrom: 8.0.0
---

# Login screen

To access the backoffice, you will need to login. You can do this by adding `/umbraco` to the end of your website URL, e.g. <http://mywebsite.com/umbraco>.

You will be presented with a login form similar to this:

![Login screen](images/backoffice-login.png "The login screen has a greeting, username/password field and optionally a 'Forgotten password' link.")
*The login screen has a greeting, username/password field and optionally a 'Forgotten password' link*

Below, you will find instructions on how to customise the login screen.

## Greeting

The login screen features a greeting, which you can personalize by changing the language file of your choice. For example for en-US you would add the following keys to: `~/Config/Lang/en-US.user.xml`

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

You can customize other text in the login screen as well, grab the default values from `~/Umbraco/Config/Lang/en.xml` and copy the keys you want to translate into your `~/Config/Lang/MYLANGUAGE.user.xml` file.

## Password reset

The "Forgot password?" link allows your backoffice users to reset their password. To setup this feature you will need to add the following key to the `<security>` section in the `~Config/umbracoSettings.config`:

```xml
<allowPasswordReset>true</allowPasswordReset>
```

Set it to `true` to enable the password reset feature, and to `false` to disable the feature.

You will also need to configure an SMTP server in your `web.config` file. When you get a successful result on the SMTP configuration when running a health check in the backoffice, you are good to go!

An example:

```xml
<system.net>
  <mailSettings>
    <smtp from="noreply@test.com">
    <network host="127.0.0.1" userName="username" password="password" />
    </smtp>
  </mailSettings>
</system.net>
```

## Background image

It is possible to customize the background image for the backoffice login screen. In [`~/Config/umbracoSettings.config`](../../../Reference/Config/umbracoSettings/) find the `loginBackgroundImage` and change the path to the image you want to use.

```xml
<settings>
    <content>
        ...
        <loginBackgroundImage>/images/myCustomImage.jpg</loginBackgroundImage>
    </content>
</settings>
```

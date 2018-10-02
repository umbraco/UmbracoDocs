# Login screen
To access the backoffice, you will need to login. You can do this by adding `/umbraco` to the end of your website address e.g. http://www.myUmbracoWebsite.com/umbraco

The login screen will look similiar to this. 

![Login screen](images/umbraco7-6_login.jpg "The login screen has a greeting, username/password field and optionally a 'Forgotten password' link.")
The login screen has a greeting, username/password field and optionally a 'Forgotten password' link.

Below, you will find instructions on how to customise the login screen. 

## Greeting
The login screen features a greeting, which you can personalize by changing the language file of your choice. For example for en-US you would add the following keys to: `~/Config/Lang/en-US.user.xml`

    <area alias="login">
      <key alias="greeting0">Sunday greeting</key>
      <key alias="greeting1">Monday greeting</key>
      <key alias="greeting2">Tuesday greeting</key>
      <key alias="greeting3">Wednesday greeting</key>
      <key alias="greeting4">Thursday greeting</key>
      <key alias="greeting5">Friday greeting</key>
      <key alias="greeting6">Saturday greeting</key>
    </area>

You can customize other text in the login screen as well, grab the default values from `~/Umbraco/Config/Lang/en.xml` and copy the keys you want to translate into your `~/Config/Lang/MYLANGUAGE.user.xml` file. 

## Password reset

The "Forgot password?" link allows your backoffice users to reset their password. For this feature to work properly you will need to configure an SMTP server in your web.config file and the "from" address needs to be specified. An example:

    <system.net>
      <mailSettings>
        <smtp from="noreply@example.com">
          <network host="127.0.0.1" userName="username" password="password" />
        </smtp>
      </mailSettings>
    </system.net>

This feature can be turned off completely using the `allowPasswordReset` configuration, see: [/Documentation/Reference/Config/umbracoSettings/#security](/Documentation/Reference/Config/umbracoSettings/#security) 

## Background image
You can customise the background image for the backoffice login screen. In `~/Config/umbracoSetting.config` find the `loginBackgroundImage`and change the path to the image you want to use.

    <settings>
        <content>
            ...
            <loginBackgroundImage>/images/myCustomImage.jpg</loginBackgroundImage>        
        </content>
    </settings>
    

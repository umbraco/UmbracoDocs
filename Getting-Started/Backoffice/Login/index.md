# Login screen

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

This feature can be turned off completely using the `allowPasswordReset` configuration, see: [/Documentation/Reference/Config/umbracoSettings/#security](/Reference/Config/umbracoSettings/#security) 

## Backgroung image
You can customise the background image for the backoffice login screen. In `~/Config/umbracoSetting.config` find the `loginBackgroundImage`and change the path to the image you want to use.

    <settings>
        <content>
            ...
            <loginBackgroundImage>/images/myCustomImage.jpg</loginBackgroundImage>        
        </content>
    </settings>
    

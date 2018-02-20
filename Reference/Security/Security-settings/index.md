# Umbraco Security Settings

## Password settings

The settings for Umbraco passwords are handled by default through the ASP.NET Membership Providers. There are two Membership Providers in the web.config file. One for Umbraco Members and one for Users.

    <membership defaultProvider="UmbracoMembershipProvider" userIsOnlineTimeWindow="15">
      <providers>
        <clear />
        <add name="UmbracoMembershipProvider" type="Umbraco.Web.Security.Providers.MembersMembershipProvider, Umbraco" minRequiredNonalphanumericCharacters="0" minRequiredPasswordLength="10" useLegacyEncoding="false" enablePasswordRetrieval="false" enablePasswordReset="false" requiresQuestionAndAnswer="false" defaultMemberTypeAlias="Member" passwordFormat="Hashed" allowManuallyChangingPassword="false" maxInvalidPasswordAttempts="50"/>
        <add name="UsersMembershipProvider" type="Umbraco.Web.Security.Providers.UsersMembershipProvider, Umbraco"  enablePasswordRetrieval="false" enablePasswordReset="false" requiresQuestionAndAnswer="false" allowManuallyChangingPassword="false" maxInvalidPasswordAttempts="100"/>
      </providers>
    </membership>

For both of these Membership Providers you can specify the following settings (if the attribute is not specified in the web.config the default value is used):

- minRequiredNonalphanumericCharacters (default 0): The number of minimal non-alphanumeric characters that are required for a password
- minRequiredPasswordLength (default 10): The minimal length of a password
- useLegacyEncoding (default 'false'): Projects that have been upgraded from a pre Umbraco v7.6 version will have this setting set to 'true' as an older password encoding mechanism was used. This setting should not be used for new projects.
- passwordFormat (default 'Hashed', possible options 'Clear', 'Encrypted', 'Hashed'): You can specify the way a password should be stored in the database. The options ‘clear’ and ‘encrypted’ should not be used.
- enablePasswordReset (default 'false'): This setting is not used
- enablePasswordRetrieval (default 'false'): This setting is not used
- requiresQuestionAndAnswer (default 'false'): This setting is not used
- allowManuallyChangingPassword (default 'false'): This setting is not used
- maxInvalidPasswordAttempts (default 5): The number of attempts before an user or member is locked out
- passwordAttemptWindow (default: 10 (minutes)): This setting is not currently used
- passwordStrengthRegularExpression: You could specify a regular expression for a password

## Login screen

### Locking of Users
It's impossible to brute force the authentication on the login screen because after 'maxInvalidPasswordAttempts' the account of the user will be locked, and until that account is unlocked in the Users section, no attempt will succeed.

### Password reset on login screen
The settings for this feature are documented [here](../../Config/umbracoSettings/index.md#security) and [here](../../../Getting-Started/Backoffice/Login/index.md#password-reset)
When you submit the password reset form an email is sent to the user with a link. This link contains a random token for this user that is valid for 24 hours. 

### Password reset of a non-existing user
If the user that is specified in the form does not exist, no e-mail will be sent and there will be no response in the form that this user does not exist. This is done to prevent leaking which users have an account.

### Password reset of a locked user
If an user is locked out, it is possible to do a password reset. After the e-mail with the password reset link is followed the user still will be locked out unless the user has specified the new password in which case the user will automatically be unlocked.

## Other security settings

- [The Umbraco timeout in minutes](../../Config/webconfig/index.md#umbracotimeoutinminutes)
- [disableAlternativeTemplates](../../Config/umbracoSettings/index.md#webrouting) If set to false this can be used to try to render pages in a way that they are not supposed to
- [disableFindContentByIdPath](../../Config/umbracoSettings/index.md#webrouting) If set to false this can be used to do an enumeration of the nodes in your website and find hidden pages.
- Umbraco Forms: [AntiForgeryToken](../../../Add-ons/UmbracoForms/Developer/Configuration/index.md#enableantiforgerytoken) and DisableFormCaching 

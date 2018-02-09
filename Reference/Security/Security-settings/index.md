# Umbraco Security Settings

## Password settings

The settings of passwords are handled by default through the .NET membershipproviders. By default there are listed two membershipprovider in the web.config-file of your project. One for the Members-section, and one for the User-section.

    <membership defaultProvider="UmbracoMembershipProvider" userIsOnlineTimeWindow="15">
      <providers>
        <clear />
        <add name="UmbracoMembershipProvider" type="Umbraco.Web.Security.Providers.MembersMembershipProvider, Umbraco" minRequiredNonalphanumericCharacters="0" minRequiredPasswordLength="10" useLegacyEncoding="false" enablePasswordRetrieval="false" enablePasswordReset="false" requiresQuestionAndAnswer="false" defaultMemberTypeAlias="Member" passwordFormat="Hashed" allowManuallyChangingPassword="false" maxInvalidPasswordAttempts="50"/>
        <add name="UsersMembershipProvider" type="Umbraco.Web.Security.Providers.UsersMembershipProvider, Umbraco"  enablePasswordRetrieval="false" enablePasswordReset="false" requiresQuestionAndAnswer="false" allowManuallyChangingPassword="false" maxInvalidPasswordAttempts="100"/>
      </providers>
    </membership>

For both these membershipproviders you can specify the following settings (If the attribute is not specified in the web.config the default value is used):

- minRequiredNonalphanumericCharacters (default 0): The number of minimal non-alphanumeric characters that are required for a password
- minRequiredPasswordLength (default 10): The minimal length of a password
- useLegacyEncoding (default ‘false’): In older projects you could an older password mechanism. For legacy purposes this setting was created, but you should always set it to ‘false’ if possible. 
- passwordFormat (default ‘Hashed’, possible option ‘Clear’, ‘Encrypted’, ‘Hashed’): You can specify the way a password should be stored in the database. The options ‘clear’ and ‘encrypted’ should never be used.
- enablePasswordReset (default ‘false’): This setting is not used
- enablePasswordRetrieval (default ‘false’): This setting is not used
- requiresQuestionAndAnswer (default ‘false’): This setting is not used
- allowManuallyChangingPassword (default ‘false’): This settings is not used
- maxInvalidPasswordAttempts (default 5): The number of attempts before an user or member is locked out.
- passwordAttemptWindow (default: 10 (minutes)): This setting is currently not used
- passwordStrengthRegularExpression: You could specify a regular expression for a password

## Login screen

### Locking of users
It’s impossible to brute force the authentication on the login screen. After ‘maxInvalidPasswordAttempts’ the account of the user will be locked, and until that account is unlocked in the Users-section, no attempt will succeed.

### Password reset on login screen
Settings for this feature is documented on the pages https://our.umbraco.org/documentation/Reference/Config/umbracoSettings/#security and https://our.umbraco.org/documentation/Getting-Started/Backoffice/Login/#password-reset
When you submit the password reset form an email is sent to the user with a link. This link contains a random token for this user that is valid for 24 hours. Within 24 hours this link can be used.

### Password reset of a non-existing user
If the user that is specified in the form does not exist, no e-mail will be sent and there will be no response in the form that this user does not exist. This is done to prevent leaking which users have an account.

### Password reset of a locked user
If an user is locked out it is possible to do a password reset. After the e-mail with the password reset-link the user still will be locked. If the user has specified the new password, the user will automatically be unlocked.

## Other security settings

- The Umbraco timeout in minutes: https://our.umbraco.org/documentation/Reference/Config/webconfig/#umbracotimeoutinminutes
- disableAlternativeTemplates (https://our.umbraco.org/documentation/Reference/Config/umbracoSettings/#web-routing). If set to false this can be used to try to render pages in a way that they are not supposed to
- disableFindContentByIdPath (https://our.umbraco.org/documentation/Reference/Config/umbracoSettings/#web-routing). If set to false this can be used to do an enumeration of the nodes in your website and find hidden pages.
- Umbraco Forms: AntiForgeryToken and DisableFormCaching (https://our.umbraco.org/documentation/Reference/Config/umbracoSettings/#web-routing)

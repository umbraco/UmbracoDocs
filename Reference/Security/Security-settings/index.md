# Umbraco Security Settings

## Password settings

The settings for Umbraco passwords are handled by default through the ASP.NET Membership Providers. There are two Membership Providers in the web.config file. One for Umbraco Members and one for Users.

```xml
    <membership defaultProvider="UmbracoMembershipProvider" userIsOnlineTimeWindow="15">
      <providers>
        <clear />

        <!-- Used for members in the Member section of Umbraco -->
        <add name="UmbracoMembershipProvider"
             type="Umbraco.Web.Security.Providers.MembersMembershipProvider, Umbraco"
             minRequiredNonalphanumericCharacters="0"
             minRequiredPasswordLength="10"
             useLegacyEncoding="false"
             enablePasswordRetrieval="false"
             enablePasswordReset="false"
             requiresQuestionAndAnswer="false"
             defaultMemberTypeAlias="Member"
             passwordFormat="Hashed"
             allowManuallyChangingPassword="false"
             maxInvalidPasswordAttempts="50"/>
          
        <!-- Used for users who have permission to log into Umbraco's backoffice, listed in the Users section of Umbraco --> 
        <add name="UsersMembershipProvider"
             type="Umbraco.Web.Security.Providers.UsersMembershipProvider, Umbraco"
             enablePasswordRetrieval="false"
             enablePasswordReset="false"
             requiresQuestionAndAnswer="false"
             allowManuallyChangingPassword="false"
             maxInvalidPasswordAttempts="100"/>
          
      </providers>
    </membership>
```

For both of these Membership Providers you can specify the following settings (if the attribute is not specified in the web.config the default value is used):

- `minRequiredNonalphanumericCharacters` (default 0): The number of minimal non-alphanumeric characters that are required for a password
- `minRequiredPasswordLength` (default 10): The minimal length of a password
- `useLegacyEncoding` (default 'false'): Projects that have been upgraded from a pre Umbraco v7.6 version will have this setting set to 'true' as an older password encoding mechanism was used. This setting should not be used for new projects.
- `passwordFormat` (default 'Hashed', possible options 'Clear', 'Encrypted', 'Hashed'): You can specify the way a password should be stored in the database. The options ‘clear’ and ‘encrypted’ should not be used.
- `enablePasswordReset` (default 'false'): This setting is not used
- `enablePasswordRetrieval` (default 'false'): This setting is not used
- `requiresQuestionAndAnswer` (default 'false'): This setting is not used
- `allowManuallyChangingPassword` (default 'false'): Must be set to 'true' if you want to change passwords from code (e.g. calling the MemberService.SavePassword()-function)
- `maxInvalidPasswordAttempts` (default 5): The number of attempts before a user or member is locked out
- `passwordAttemptWindow` (default: 10 (minutes)): This setting is not currently used
- `passwordStrengthRegularExpression` You could specify a regular expression for a password

## Password reset settings

Umbraco backend users can [reset their own password](../password-reset.md), or if they try too much, have a locked out account.

To deactivate the User password reset look at the [Umbraco Settings Security](../../Config/umbracoSettings/index.md#security) Section

To configure password reset verify the [Backoffice Login Password Reset](../../../Getting-Started/Backoffice/Login/index.md#password-reset) Section

## Other security settings

- [The Umbraco timeout in minutes](../../Config/webconfig/index.md#umbracotimeoutinminutes)
- [disableAlternativeTemplates](../../Config/umbracoSettings/index.md#webrouting) If set to false this can be used to try to render pages in a way that they are not supposed to
- [disableFindContentByIdPath](../../Config/umbracoSettings/index.md#webrouting) If set to false this can be used to do an enumeration of the nodes in your website and find hidden pages.
- Umbraco Forms: [AntiForgeryToken](../../../Add-ons/UmbracoForms/Developer/Configuration/index.md#enableantiforgerytoken) and DisableFormCaching

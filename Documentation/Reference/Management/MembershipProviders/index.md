#Membership providers

The Umbraco back office users and front-end members both make use of [ASP.Net Membership Providers. ](https://msdn.microsoft.com/en-us/library/yh26yfzy%28v=vs.140%29.aspx). This means that it is possible to replace the authentication mechanism for either back office users or front-end members.

The 2 default membership providers listed in the web.config with their default options are:

    <add name="UmbracoMembershipProvider" type="Umbraco.Web.Security.Providers.MembersMembershipProvider, Umbraco" minRequiredNonalphanumericCharacters="0" minRequiredPasswordLength="4" useLegacyEncoding="false" enablePasswordRetrieval="false" enablePasswordReset="true" requiresQuestionAndAnswer="false" defaultMemberTypeAlias="Member" passwordFormat="Hashed" />
        
    <add name="UsersMembershipProvider" type="Umbraco.Web.Security.Providers.UsersMembershipProvider, Umbraco" minRequiredNonalphanumericCharacters="0" minRequiredPasswordLength="4" useLegacyEncoding="false" enablePasswordRetrieval="false" enablePasswordReset="true" requiresQuestionAndAnswer="false" passwordFormat="Hashed" />
    
## [MembersMembershipProvider options](properties.md)

list all of the config options available to the MembersMembershipProvider

#Active Directory Membership Provider
<!-- original http://our.umbraco.org/wiki/how-tos/membership-providers/active-directory-membership-provider -->
##Resources

Setting up membership: http://msdn.microsoft.com/en-us/library/ms998360.aspx#paght000026_step3

##Registering the provider in Umbraco

Add it to the web.config under the membership section leave the existing providers in place :

    <membership defaultProvider="UmbracoMembershipProvider" userIsOnlineTimeWindow="15">
      <providers>
    
      <!-- THIS IS THE NEW PROVIDER -->
      <add name="MyADMembershipProvider" type="System.Web.Security.ActiveDirectoryMembershipProvider, System.Web, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" connectionStringName="ADConnectionString" connectionUsername="testdomain\administrator" connectionPassword="password" attributeMapUsername="sAMAccountName"  />
    <!-- END OF AD PROVIDER CODE -->
      </providers>
    </membership>

Additionalily in the web.config file under the connectionStrings section add the ConnectionStringName that was used in the provider.

    <connectionStrings>
      <remove name="LocalSqlServer" />
      <add name="ADConnectionString" connectionString="LDAP://MyDomain.com/ OU=Accounts,DC=MyDomain,DC=com" />
    </connectionStrings>

Add the alias of the provider to the /config/umbracosettings.config file

    <providers>
      <users>
        <!-- if you wish to use your own  membershipprovider for authenticating to the Umbraco back office --> 
        <!-- specify it here (remember to add it to the web.config as well) -->
        <DefaultBackofficeProvider>MyADMembershipProvider</DefaultBackofficeProvider>
      </users>
    </providers>
 

##Notes from other Umbraco users on how to setup AD users

1. Switch DefaultBackofficeProvider to "ADMembershipProvider" (change for your connectionStringName)
2. Login using an authenticated user from Active Directory. You will be shown the default access of a "Writer" (userType = 2 in the umbracoUser database table). This is, by default, only the "Content" application and Browse Node, Create, Update, and Send to Publish permissions.
3. Logout the active directory user
3. Switch DefaultBackofficeProvider back to "UsersMembershipProvider" (the default)
4. Login using the built-in administrator account
5. In the Users app, change the user type to "Administrator" and give permission to view all apps to your recently-used active directory user
6. Logout the built-in administrator
7. Login using the authenticated A.D. user.

Going forward, you can then make user permission settings using the AD user, and the DefaultBackofficeProvider can stay as the ActiveDirectoryMembershipProvider.
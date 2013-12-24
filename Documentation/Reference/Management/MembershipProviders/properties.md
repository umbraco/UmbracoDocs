#UmbracoMembershipProvider properties

<!-- http://our.umbraco.org/wiki/how-tos/membership-providers/umbracomembershipprovider-properties -->

This section covers the properties of the Umbraco Membership Provider which allows additional data to be stored for a Member without the need for custom code.

 Complete web.config section

    <add name="UmbracoMembershipProvider"
      type="umbraco.providers.members.UmbracoMembershipProvider"
      enablePasswordRetrieval="true" 
      enablePasswordReset="false" 
      requiresQuestionAndAnswer="true" 
      defaultMemberTypeAlias="Some Type" 
      passwordFormat="Hashed"
      umbracoApprovePropertyTypeAlias="approved"
      umbracoLockPropertyTypeAlias="lock"     umbracoFailedPasswordAttemptsPropertyTypeAlias="failed_logins"
      umbracoCommentPropertyTypeAlias="comments"
      umbracoLastLoginPropertyTypeAlias="last_login"     umbracoPasswordRetrievalQuestionPropertyTypeAlias="question"    
      umbracoPasswordRetrievalAnswerPropertyTypeAlias="answer" />

**defaultMemberTypeAlias**

This is the alias of the Member Type which you want to be used when Members are created via this membership provider.

 

**umbracoApprovePropertyTypeAlias**

Set the alias of the Member property which use used to indicate the approval status of the membership record.
Common use - providing an Activate Your Account link

 

**umbracoLockPropertyTypeAlias**

Set the alias of the Member property which can be used to lock the membership account.
Common use - automatically locking a user after a certain number of failed login attempts

 

**umbracoFailedPasswordAttemptsPropertyTypeAlias**

Set the alias of the property which indicated the number of failed login attempts an account has had before a successful login occured.

 

**umbracoCommentPropertyTypeAlias**

Set the alias of the property which will store comment data for the membership account.

 

**umbracoLastLoginPropertyTypeAlias**

Set the alias of the property which stores the last login date (the DataType must handle the formatting from a DateTime to its internal type).
Common use - Showing notice to the user of their last login date

 

**umbracoPasswordRetrievalQuestionPropertyTypeAlias**

Set the alias which a secret question is stored to ask the user when they retrieve their login details. This integrates with the [MembershipProvider.RequiresQuestionAndAnswer](http://msdn.microsoft.com/en-us/library/system.web.security.membership.requiresquestionandanswer.aspx) property.

 

**umbracoPasswordRetrievalAnswerPropertyTypeAlias**

Set the alias which the answer to the secret question is used. This integrates with the [MembershipProvider.RequiresQuestionAndAnswer](http://msdn.microsoft.com/en-us/library/system.web.security.membership.requiresquestionandanswer.aspx) property.
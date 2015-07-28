#Use AD LDS to Authenticate and Create Site Members for your Intranet.

This was inspired by/based on [this post](activedirectory-intranet-authenticate.md), but tweaked a little for Active Directory Lightweight Directory Services (ADLDS) and just thought I'd share...

##How it works
Basically what we are doing is writing a few custom events for the asp:Login control and methods to validate the members details and fetch their email from an AD LDS instance.

##Usercontrol

Create a new usercontrol with an asp:Login control with the two event handlers for OnLoggingIn and OnAuthenticate.  I have created a custom template for our login because we store domain users (my.domain.com) as well as "external" accounts (gmail.com, yahoo.com, etc.com) in our ADLDS instance.  This gives us the flexibility to be able to allow a part-time or seasonal employee who doesn't get a network/domain account to still be able to use our internal web sites/applications with thier own account and e-mail address.  If thier e-mail address is not UserName@my.domain.com they can simply change it to UserName@gmail.com or UserName@anymailprovider.com and they are good to go...

    <asp:Login ID="uxLogin" runat="server" OnLoggingIn="uxLogin_OnLoggingIn" OnAuthenticate="uxLogin_OnAuthenticate">
    <LayoutTemplate>
        <asp:TextBox id="UserName" runat="server"></asp:TextBox>
        @
        <asp:TextBox id="UserDomain" runat="server" Text="my.domain.com"></asp:TextBox>
        <br />
        <asp:TextBox id="Password" runat="server" textMode="Password"></asp:TextBox>
        <br />        
        <asp:Checkbox id="RememberMe" runat="server" Text="Stay Logged In"></asp:Checkbox>
        <br />
        <asp:button id="Login" CommandName="Login" runat="server" Text="Login"></asp:button>
        <br />
        <asp:Literal id="FailureText" runat="server"></asp:Literal>
    </LayoutTemplate>
    </asp:Login>

###Fields/Properties/Helpers

I moved some of the authentication and checking outside of the event handlers for the asp:Login control, just made things a little more granular which helped me follow the logic a little easier.  The code below basically replaces the ValidateActiveDirectoryLogin method from the previous post.

    public partial class LoginControl : System.Web.UI.UserControl
    {
        Login uxLogin;
        string UserName { get { return this.uxLogin.UserName; } }
        string UserDomain { get { return ((TextBox)uxLogin.FindControl("UserDomain")).Text; } }
        string UserPassword { get { return this.uxLogin.Password; } }
        string UserPrincipalName { get { return this.UserName + '@' + this.UserDomain; } }
        #region Umbraco Membership
        bool _memberProfileChecked = false;
        Member _memberProfile;
        Member MemberProfile
        {
            get
            {
                if (!this._memberProfileChecked)
                {
                    this._memberProfile = Member.GetMemberFromLoginName(this.UserName);
                    this._memberProfileChecked = true;
                }
                return this._memberProfile;
            }
        }        
        public bool IsMember
        {
            get
            {
                return this.MemberProfile != null;
            }
        }        
        #endregion
        #region ADLds User
        bool _adldsUserChecked = false;
        SearchResult _adldsUser;
        SearchResult ADLdsUser
        {
            get
            {
                if (!this._adldsUserChecked)
                {
                    DirectoryEntry _entry = new DirectoryEntry(
                        "LDAP://***PATH***",
                        this.UserPrincipalName,
                        this.UserPassword,
                        AuthenticationTypes.SecureSocketsLayer & AuthenticationTypes.Encryption);
                    DirectorySearcher _searcher = new DirectorySearcher(_entry);
                    _searcher.Filter = "(&(objectClass=userProxyFull)(userPrincipalName=" + this.UserPrincipalName + "))";
                    this._adldsUser = _searcher.FindOne();
                    this._adldsUserChecked = true;
                }
                return this._adldsUser;
            }
        }
        public bool IsADLdsUser
        {
            get
            {
                return this.ADLdsUser != null;
            }
        }
        #endregion
    //***SNIP***

###OnLoggingIn Event

This event handler first checks to see if there is already a membership account for the current user.  If not, it checks ADLDS for the existence of and validity of the specified account/password and then proceeds to create a membership account in Umbraco if they are valid.

     protected void uxLogin_OnLoggingIn(object sender, System.Web.UI.WebControls.LoginCancelEventArgs e)
        {
            uxLogin = (Login)sender;
            
            //Check Umbraco membership.
            if (!this.IsMember)
            {
                //Current user is NOT an Umbraco member, attempt to validate ADLds user account and create Umbraco membership account.
                if (this.IsADLdsUser)
                {
                    //ADLds user account was valid, create membership.
                    MemberType _memberType = MemberType.GetByAlias("MemberTypeAlias");
                    MemberGroup _memberGroup = MemberGroup.GetByName("MemberGroupName");
                    this._memberProfile = Member.MakeNew(this.UserName, _memberType, new umbraco.BusinessLogic.User(0));
                    this._memberProfile.AddGroup(_memberGroup.Id);
                    this._memberProfile.Email = this.UserPrincipalName;
                    this._memberProfile.LoginName = this.UserName;
                    this._memberProfile.Save();
                }
                //Bad username/password or no ADLds account.
            }
            //Current user already has an Umbraco membership.
        }
###OnAuthenticate Event

This event handler will check to make sure the current user is an Umbraco member as well as check to make sure the credentials supplied validate against the ADLDS instance.  If either one fails, the authenticated status is set to false and they will be presented with the standard failure message generated by the asp:Login control.

    protected void uxLogin_OnAuthenticate(object sender, AuthenticateEventArgs e)
        {
            bool _authenticated = false;
            if (this.IsMember && this.IsADLdsUser)
            {
                Member.AddMemberToCache(this.MemberProfile);
                _authenticated = true;
            }
            e.Authenticated = _authenticated;
        }
A few things to keep in mind...

The code for creating the DirectoryEntry in the property ADLdsUser will need to be updated if:

- You don't use SSL and Encryption on your ADLDS instance.
- You don't use the Object Class userProxyFull for your users in your ADLDS instance.
- You don't use the property userPrincipalName instead of SAMAccountName for your accounts in your ADLDS instance.

Be sure to change the MemberGroupName and MemberTypeAlias to match your environment.
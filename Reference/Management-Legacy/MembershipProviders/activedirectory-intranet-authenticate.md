#Use Active Directory to Authenticate Site Members (Intranet)
<!-- original http://our.umbraco.org/wiki/how-tos/membership-providers/use-active-directory-to-authenticate-site-members-(intranet)
 -->

Here is a simple solution that allows you to use Active Directory to authenticate your site members in an Intranet environment while using Umbraco to control member types, groups and site access.

##How it works
Basically what we are doing is writing a few custom events for the asp:Login control and methods to validate the members details and fetch their email from active directory.

###Usercontrol

Create a new usercontrol with an asp:Login control with the two event handlers for OnLoggingIn and OnAuthenticate.

    <asp:Login ID="Login1" runat="server" OnLoggingIn="Login1_OnLogginIn" OnAuthenticate="Login1_Authenticate">
    </asp:Login>
###OnLogginIn Event

This event is used to check if the member exists in Umbraco.  If it is their first logon I create a new member making sure that I don't set a password for them (we want to query AD for this).

     protected void Login1_OnLogginIn(object sender, System.Web.UI.WebControls.LoginCancelEventArgs e)
        {
            Member m = Member.GetMemberFromLoginName(Login1.UserName.ToString());
            // check to see if the member exists in umbraco
            if (m == null)
            {
                // check if has ad account and create new
                if (ValidateActiveDirectoryLogin(Login1.UserName.ToString(), Login1.Password.ToString()) == true)
                {
                    // new member, Create and map to AD with email
                    MemberType mt = MemberType.GetByAlias("MyMemeberAlias");

                    Member newMember = Member.MakeNew(Login1.UserName.ToString(), mt, new umbraco.BusinessLogic.User(0));

                    //Get email from AD and set login name
                    newMember.Email = getActiveDirectoryEmail(Login1.UserName.ToString(), Login1.Password.ToString());

                    newMember.LoginName = Login1.UserName.ToString();

                    //Add the member to a Group
                    MemberGroup mg = MemberGroup.GetByName("GroupAlias");
                    newMember.AddGroup(mg.Id);

                    newMember.Save();
                }
            }
        }

###OnAuthenticate Event

Instead of validating the members password with Umbraco call a custom method to validate against AD.

    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            bool Authenticated = false;

            Authenticated = ValidateActiveDirectoryLogin(Login1.UserName.ToString(), Login1.Password.ToString());

            e.Authenticated = Authenticated;
        }
 

###ValidateActiveDirectoryLogin

Query AD to validate the members credentials. This method can also be modified to fetch other details from AD like email or display name.

    private bool ValidateActiveDirectoryLogin(string Username, string Password)
        {
            bool Success = false;

            System.DirectoryServices.DirectoryEntry enTry = new System.DirectoryServices.DirectoryEntry("LDAP://***PATH***", Username, Password);
            System.DirectoryServices.DirectorySearcher mySearcher = new System.DirectoryServices.DirectorySearcher(enTry);

            mySearcher.Filter = "(&(objectClass=user)(SAMAccountName=" + Username + ")(!msExchUserAccountControl=2))";

            try
            {
                System.DirectoryServices.SearchResult result = mySearcher.FindOne();

                if (result != null)
                {
                    Member m = Member.GetMemberFromLoginName(Username);
                    if (m != null)
                    {
                        Member.AddMemberToCache(m);
                    }

                    Success = true;
                }
            }
            catch (Exception ex) { }

            return Success;
        }
 

This is still a bit of a work in progress so I'll add to this as I refine the code a bit more. At the moment this solution fits in nicely with our Intranet but if you wanted to get a bit more complicated you would need to look at rolling you own Membership and Role Provider classes.

I hope this helps someone out.
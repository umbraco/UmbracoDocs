# Check user status on login
 
<!-- original documents: http://our.umbraco.org/wiki/how-tos/membership-providers/check-if-user-is-active-before-logging-in
and 
http://our.umbraco.org/wiki/how-tos/membership-providers/check-if-user-is-active-before-logging-in/alternative-method-for-checking-active-membership 
-->


A lot of times an application will require user activation of some sort. Either by expecting a membership payment, email verification, or some other sort of user approval before the member is given access.

This can

    <asp:login id="login1" runat="server" TitleText="" OnLoggingIn="login1_onLogginIn" />
 
and in the code behind

    protected void login1_onLogginIn(object sender, System.Web.UI.WebControls.LoginCancelEventArgs e)
    {
        Member m = Member.GetMemberFromLoginNameAndPassword(login1.UserName, login1.Password);

        if (m.getProperty("memberPaid").Value.ToString() != "1")
        {
            e.Cancel = true;
            // instead of redirect you could also do this:
            // Login1.InstructionText = "Oi! Pay-up or no access :)";

            Response.Redirect("/membershipExpired.aspx");
        }
    }
PS. probably shouldn't hard-code your redirect path here. Use NiceURL() instead...


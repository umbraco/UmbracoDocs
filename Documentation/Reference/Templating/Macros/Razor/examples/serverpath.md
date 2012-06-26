#Get the server path, iis site name and connection string to a site
Many sites on your server? If you ever need to know which path, iis site name and db connection string a particular Umbraco site has, you can run this simple Razor script (remeber to never ever keep the file publicly accessible from outside, I use it together with RazorVisualizer):

    @{

     <p>Server path: @Server.MapPath("/")</p>
     <p>IIS Web Site name: @System.Web.Hosting.HostingEnvironment.ApplicationHost.GetSiteName()</p>
     <p>Connection string: @umbraco.GlobalSettings.DbDSN</p>

    }
# LocalDB
By default when Umbraco Cloud restores a local database it will be an Umbraco.sdf file in `/App_Data` folder. However if LocalDB is installed and configured, the restore will create an Umbraco.mdf file. To use LocalDB ensure `applicationHost.config` is configured with `loadUserProfile="true"` and `setProfileEnvironment="true"`: https://blogs.msdn.microsoft.com/sqlexpress/2011/12/08/using-localdb-with-full-iis-part-1-user-profile/

```xml
<add name="ASP.NET v4.0" autoStart="true" managedRuntimeVersion="v4.0" managedPipelineMode="Integrated">
   <processModel identityType="ApplicationPoolIdentity" loadUserProfile="true" setProfileEnvironment="true" />
</add>
```

Usually `applicationHost.config` is located in this folder for IIS:
`C:\Windows\System32\inetsrv\config`

and in one of these folders for IIS Express:

`C:\Users\<user>\Documents\IISExpress\config\`

If you're using Visual Studio 2015+ check this path:
`$(solutionDir)\.vs\config\applicationhost.config`

In Visual Studio 2015+ you can also configure which `applicationhost.config` file is used by altering the `<UseGlobalApplicationHostFile>true|false</UseGlobalApplicationHostFile>` setting in the project file (eg: MyProject.csproj). (source: MSDN forum)

## Using Custom Tables with Umbraco Cloud
Umbraco Cloud will ensure that your Umbraco related data is always up to date, but it won't know anything about data in custom tables unless told. Nothing new here, it's basically just like any other host when it comes to non-Umbraco data.

The good news is that you have full access to the SQL Azure databases running on Umbraco Cloud and you can create custom tables just like you'd expect on any other hosting provider. The easiest way to do this is to connect using SQL Management Studio.

A recommended way of making sure your custom tables are present, is to use Migrations to ensure that the tables will be created or altered when starting your site. Migrations will ensure that if you are adding environments to your Umbraco Cloud site, then the tables in the newly created databases will automatically be created for you. Check [this blog post](https://cultiv.nl/blog/using-umbraco-migrations-to-deploy-changes/) for a full walkthrough of how to create and use Migrations.

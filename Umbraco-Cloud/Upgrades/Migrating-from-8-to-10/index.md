# Migrating Umbraco 8 Cloud project to Umbraco 10

This article will provide steps on how to migrate a Umbraco 8 Cloud project to Umbraco 10.

:::note
The steps in this article can also be used to upgrade to Umbraco version 9, however, we do recommend always upgrading to the latest version whenever possible.
:::

Since the underlying framework going from Umbraco 8 to 10 has changed there is no direct upgrade path. However, there have been a few changes to the Database schema. You can re-use the database from your Umbraco 8 project on your new Umbraco 10 Cloud project so that you have your content from Umbraco 8.

It is not possible to migrate the custom code as the underlying web framework has been updated from ASP.NET to ASP.NET Core and you will need to re-implement it.

You also need to make sure that the packages that you are using are available for Umbraco 10.

<!--Removed for now, might move it back as we create an article for V8-9
Read the [general article about Content migration](../../../Getting-Started/Setup/Upgrading/migrating-to-v8#limitations) to learn more about limitations and other things that can come into play when migrating your Umbraco site from 7 to 8.
-->

<!--Needs V9 update
## Video tutorial

<iframe width="800" height="450" src="https://www.youtube.com/embed/videoseries?list=PLG_nqaT-rbpxrVkhlMedRKL9frAVIHlve" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
-->

## Prerequisites

* A Umbraco 8 Cloud project running **the latest version of Umbraco 8**.

* A clean Cloud project running the latest version of Umbraco 10 with **at least 2 environments**.

* A backup of your Umbraco 8 project database.

:::note
We strongly recommend having at least **2 environments** on the Umbraco 10 project.

Should something fail during the migration, the Development environment can always be removed and re-added to start over on a clean slate.
:::

## Step 1: Content Migration

* Create a backup of the database from your Umbraco 8 project using the [database backup guide](https://our.umbraco.com/documentation/umbraco-cloud/Databases/Backups/) *OR* clone down the V8 project and take a backup of the local Database. Make sure to restore the content from your cloud environment.

* Import the database backup into SQL Server Management Studio.

* Clone down the **Development** environment from the Umbraco 10 Cloud project, test the project, and make sure to log in to the backoffice.

* Update the connection string in the Umbraco 10 `appsettings.json` file so that it connects to the Umbraco 8 database:

    ```json
    "ConnectionStrings": {
        "umbracoDbDSN": "Server=YourLocalSQLServerHere;Database=NameOfYourDatabaseHere;Integrated Security=true"
    }
    ```

* To authorize the database upgrade, enable [Unattended Upgrades](https://our.umbraco.com/Documentation/Reference/V9-Config/UnattendedSettings/#upgrade-unattended).

* Run the Umbraco 10 project locally.

* Wait for the site to finish upgrading.

* Stop the site and disable unattended upgrade.

* Run the site and log in using Umbraco ID.

:::note
This is **only content migration** and the database will be migrated.

You need to manually upgrade the view files and custom code implementation. For more information, see [Step 3](#Step-3-setup-custom-code-for-umbraco-9) of this guide.
:::

## Step 2: File Migration

* The following files/folders need to be copied into the Umbraco 10 project:

  * `~/Views` - **Do not** overwrite the default Macro and Partial View Macro files unless changes have been made to these.
  * `~/Media`
  * Any files/folders related to Stylesheets and JavaScript.

* In Umbraco 10, config files no longer live in the `Web.Config` file and is instead in the `appsettings.json` file. You will need to make sure that you update the `appsettings.json` file with any custom settings that you had in your Umbraco 8 project to match with the [Configuration Files](../../../Reference/Configuration/index.md).

* In Umbraco Forms version 9.0.0+, it is only possible to store Form data in the database. If Umbraco Forms is used on the Umbraco 8 project:
  * Make sure to first migrate the Forms to the database, see the [Umbraco Forms in the Database](../../../Add-ons/UmbracoForms/Developer/Forms-in-the-Database/index-v8) article.

* Run the Umbraco 10 project locally.
  * It **will** give you a Yellow Screen of Death (YSOD)/error screen on the frontend as none of the Template files have been updated yet.

* Go to the backoffice of your project.

* Navigate to the **Settings** section and go to the **Deploy** dashboard.

* Select `Extract Schema To Data Files` from the **Deploy Operations** drop-down to generate the UDA files.

* Click **Trigger Operation**.

* Once the operation is completed, the status will change to `Last deployment operation completed`.

* Check `~\umbraco\Deploy\Revision` folder to ensure all the UDA files have been generated.

* Select `Schema Deployment From Data Files` from the **Deploy Operations** drop-down to make sure everything checks out with the UDA files that were generated.

* Click **Trigger Operation**.

## Step 3: Custom Code for Umbraco 10

Umbraco 10 is different from Umbraco 8 in many ways. This means that in this step, all custom code, controllers, and models need to be rewritten for Umbraco 10.

:::note
Found something that has not yet been documented? Please [report it on our issue tracker](https://github.com/umbraco/UmbracoDocs/issues).
:::

### Examples of changes

One of the changes is how published content is rendered through Template files. Due to this, it will be necessary to update **all** the Template files (`.cshtml`) to reflect these changes.

Read more about these changes in the [IPublishedContent section of the Documentation](../../../Reference/Querying/IPublishedContent/).

* Template files need to inherit from `Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.HomePage>` instead of `Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.HomePage>`

* Template files need to use `ContentModels = Umbraco.Cms.Web.Common.PublishedModels` instead of `ContentModels = Umbraco.Web.PublishedModels`

Depending on the size of the project that is being migrated and the amount of custom code and implementations, this step is going to require a lot of work.

## Step 4: Member Migration

If you have Members in your Umbraco database these were not transferred when you restored the content from your Cloud environment. You have to migrate them manually using database queries. 

* Open your both your Umbraco 8 database and your Umbraco 10 database in SQL Server Management Studio. Connection details for your database are available in the Cloud Portal.

* Your Umbraco 10 database should not have any Members or Member Groups at this point, but if it does you can delete them all with the following queries:

    ```
	DELETE FROM umbracoPropertyData WHERE versionid in (SELECT id from umbracoContentVersion WHERE nodeId IN (SELECT nodeId FROM cmsMember))
	DELETE FROM umbracoContentVersion WHERE nodeId IN (SELECT nodeId FROM cmsMember)
	DELETE FROM cmsMember2MemberGroup
	DELETE FROM umbracoContent WHERE nodeId IN (SELECT nodeId FROM cmsMember)
	DELETE FROM cmsMember
	DELETE FROM umbracoNode where nodeObjectType IN ('39EB0F98-B348-42A1-8662-E7EB18487560', '366E63B9-880F-4E13-A61C-98069B029728')
    ```

* In your Umbraco 10 database, run the following queries and make a note of the results as you will need them for later queries:

   ```
   SELECT MAX(id) FROM umbracoNode
   SELECT MAX(id) FROM umbracoContentVersion
   SELECT MAX(id) FROM umbracoPropertyData
   ```
* Use the SQL Server Import and Export Wizard to query data from your Umbraco 8 database and insert it into your Umbraco 10 database. You can start the wizard by right-clicking any database and selecting Tasks > Import Data... 
 
    Use the 'Microsoft OLE DB Driver for SQL Server' to connect first to your Umbraco 8 database as the data source, then your Umbraco 10 database as the destination. Next, select 'Write a query to specify the data to transfer', and use the following queries. You will need to run this wizard again from the start for each query. 

    In this query replace `{umbracoNode}` and `{umbracoContentVersion}` with the results from your previous query. After you enter your query in the wizard you'll see the 'Select Source Tables and Views' page of the wizard. Change the destination from `[dbo].[Query]` to `[dbo].[umbracoNode]`. Click 'Edit Mappings...` and tick 'Enable identity insert'. You're now ready to complete the wizard.

   ```
   SELECT id + {umbracoNode} AS id, uniqueid, parentid, level, path, sortOrder, trashed, -1 AS nodeUser, text, nodeObjectType, createDate 
   FROM umbracoNode 
   WHERE nodeObjectType IN ('39EB0F98-B348-42A1-8662-E7EB18487560', '366E63B9-880F-4E13-A61C-98069B029728')
   ```	
   
* Run the wizard again and select your Umbraco 8 database as the data source, then your Umbraco 10 database as the destination. Enter the query below. Replace `{umbracoNode}` with the result from your earlier query. Change the destination to `[dbo].[umbracoContent]`, and this time you don't need to select 'Enable identity insert'.
 
    ```
    SELECT nodeId + {umbracoNode} AS nodeId, contentTypeId 
    FROM umbracoContent 
    WHERE nodeId IN (SELECT nodeId FROM cmsMember)
	```
    
* Run the wizard again and select your Umbraco 8 database as the data source, then your Umbraco 10 database as the destination. Enter the query below. Replace `{umbracoNode}` with the result from your earlier query. Change the destination to `[dbo].[cmsMember]`, and this time you don't need to select 'Enable identity insert'.

    ```
    SELECT nodeId + {umbracoNode} AS nodeId, Email, LoginName, Password 
    FROM cmsMember
    ```
	
* Run the wizard again and select your Umbraco 8 database as the data source, then your Umbraco 10 database as the destination. Enter the query below. Replace `{umbracoContentVersion}` and `{umbracoNode}` with the results from your earlier queries. Change the destination to `[dbo].[umbracoContentVersion]`. This time you **do** need to select 'Enable identity insert'.

    ```
    SELECT id + {umbracoContentVersion} AS id, nodeId + {umbracoNode} AS nodeId, versionDate, userId, [current], [text] 
    FROM umbracoContentVersion 
    WHERE nodeId IN (SELECT nodeId FROM cmsMember) 
    ```
	
* Run the wizard again and select your Umbraco 8 database as the data source, then your Umbraco 10 database as the destination. Enter the query below. Replace `{umbracoNode}` with the result from your earlier query. Change the destination to `[dbo].[cmsMember2MemberGroup]`. This time you don't need to select 'Enable identity insert'.

    ```
    SELECT Member + {umbracoNode} As Member, MemberGroup + {umbracoNode} AS MemberGroup 
    FROM cmsMember2MemberGroup
    ```
   
* Now you need to transfer the properties that belong to the Members. Run the following query on both your Umbraco 8 database and your Umbraco 10 database and note the results, which will probably be different between the two:

    ```
    SELECT id, Alias
    FROM cmsPropertyType
    WHERE contentTypeId = (SELECT nodeId FROM cmsContentType WHERE alias = 'Member')  
    AND Alias NOT LIKE 'umbracoMember%' 
    ORDER BY Alias
    ```
    
    Using those results, run the wizard again and select your Umbraco 8 database as the data source, then your Umbraco 10 database as the destination. Enter the query below. Replace `{umbracoPropertyData}` and `{umbracoContentVersion}` with the results from your first queries above, and replace all the `{umbraco x id for alias xxx}` values with the results from your two queries just now. Change the destination to `[dbo].[umbracoPropertyData]`. This time you **do** need to select 'Enable identity insert'.
    
    ```
    SELECT id + {umbracoPropertyData} AS id, versionid + {umbracoContentVersion} AS versionid,  
    	CASE WHEN propertyTypeId = {umbraco 8 id for alias approvalToken} THEN {umbraco 10 id for alias approvalToken} 
    		 WHEN propertyTypeId = {umbraco 8 id for alias approvalTokenExpires} THEN {umbraco 10 id for alias approvalTokenExpires} 
    		 WHEN propertyTypeId = {umbraco 8 id for alias blockLogin} THEN {umbraco 10 id for alias blockLogin} 
             WHEN propertyTypeId = {umbraco 8 id for alias migratedMemberId} THEN {umbraco 10 id for alias migratedMemberId} 
    		 WHEN propertyTypeId = {umbraco 8 id for alias passwordResetToken} THEN {umbraco 10 id for alias passwordResetToken} 
    		 WHEN propertyTypeId = {umbraco 8 id for alias passwordResetTokenExpires} THEN {umbraco 10 id for alias passwordResetTokenExpires} 
    		 WHEN propertyTypeId = {umbraco 8 id for alias requestedEmail} THEN {umbraco 10 id for alias requestedEmail} 
    		 WHEN propertyTypeId = {umbraco 8 id for alias requestedEmailToken} THEN {umbraco 10 id for alias requestedEmailToken} 
    		 WHEN propertyTypeId = {umbraco 8 id for alias requestedEmailTokenExpires} THEN {umbraco 10 id for alias requestedEmailTokenExpires} 
    		 WHEN propertyTypeId = {umbraco 8 id for alias totalLogins} THEN {umbraco 10 id for alias totalLogins}
      ELSE propertyTypeId END AS propertyTypeId, 
      languageId, segment, intValue, decimalValue, dateValue, varcharValue, textValue
      FROM umbracoPropertyData
      WHERE versionid IN (SELECT id FROM umbracoContentVersion WHERE nodeId IN (SELECT nodeId FROM cmsMember))
    ```

* On your Umbraco 10 database reset the identity seeds where you used Identity Insert:

    ```
    DBCC CHECKIDENT(umbracoNode)
    DBCC CHECKIDENT(umbracoContentVersion)
    DBCC CHECKIDENT(umbracoPropertyData)
    ```
    
You should now be able to see your members and member groups in the Umbraco back office, and login using existing member accounts on your front-end website.

## Step 5: Deploy and Test on Umbraco Cloud

Once the Umbraco 10 project runs without errors on the local setup, the next step is to deploy and test on the Cloud **Development** environment.

* Push the migration and changes to the Umbraco Cloud **Development** environment.

    :::note
    The deployment might take a bit longer than normal.
    :::

* Once everything has been pushed, go to the backoffice of the **Development** environment.

* Go to **Settings** and navigate to the **Deploy** Dashboard.

* Select `Schema Deployment From Data Files` from the **Deploy Operations** drop-down.

* Click **Trigger Operation**.

* The deployment will result in either of the two:
  * `Last deployment operation failed` - something failed during the check.
    * Select `Clear Cached Signatures` from the **Deploy Operations** drop-down.
    * Select `Schema Deployment From Data Files` from the **Deploy Operations** drop-down to clear up the error.
  * `Last deployment operation completed`
    * Everything checks out: The Development environment has been upgraded.

* Transfer Content and Media from the local clone to the **Development** environment.

* Test **everything** in the **Development** environment.

* Deploy to the **Live** environment.

## Step 6: Going live

* Test **everything** in the **Development** environment.
* Once the migration is completed, and the **Live** environment is running without errors, the site is ready for launch.
* Setup [rewrites](../../../Reference\Routing\IISRewriteRules) on the Umbraco 10 site.
* Assign hostnames to the project.

    :::note
    Hostnames are unique and can only be added to one Cloud project at a time.
    :::

## Related Information

* [Issue tracker for known issues with Content Migration](https://github.com/umbraco/UmbracoDocs/issues)
* [Forms on Umbraco Cloud](../../Deployment/Umbraco-Forms-on-Cloud)
* [Working locally with Umbraco Cloud](../../Set-Up/Working-Locally/)
* [KUDU on Umbraco Cloud](../../Set-Up/Power-Tools/)

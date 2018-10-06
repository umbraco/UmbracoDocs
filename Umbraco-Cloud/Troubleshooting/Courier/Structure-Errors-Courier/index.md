# Troubleshooting structure errors

On some occasions, it's possible that you'll encounter an "Error in Courier files containing site structure". This usually means that two Courier files are created for the same entity type.  

For example, there are two files in the `~/data/Revision/documenttypes` folder which contain the same alias for a document type, let's say `home`. Each file has a different file name but the document type they refer to is both `home`. When Courier tries to create the site structure from those files it is expecting each file to try to create a document type with a unique alias.

If two files share that same alias this leads to a conflict, it's impossible for Courier to know which is the "correct" one, so it has to give up and send an error back.

## Cause

The main cause of this problem is when a document type (or media type or member type) gets manually created in two environments using the same alias. If you're new to Umbraco Cloud, for example, and have been using Umbraco for a while, it might actually be surprising that Umbraco takes care of syncing a document type between environments. You might have decided to create the same document type manually in each environment because that's what you're used to doing. 

## Fixing

In order to fix this conflict, you will have to decide which document type is "the most correct" one. For some help with that, the list of all properties in each Courier file will be logged in your `~/App_Data/Logs/CourierTraceLog.txt` file when you see the `Error in Courier files containing site structure` error. This might help you determine: the `home` document type with the extra 3 properties that I added today is the one that I want to have in all of my environments. You can then remove the non-relevant entity type from Git and deploy your changes to the next environment. This should clear up the error and allow you to move on. The log file will list the file names for each conflicting file. 

## Troubleshooting using SQL queries

Sometimes it's hard to determine by eye which one of your document types is "correct" and you might want to have a look in your SQL database to see which one you want to keep. In that case, you can perform a SQL query to find the content type and it's properties so you can compare them.

The courier files in `~/data/Revision/` are usually named after the unique Id of the thing you're trying to find, so in the case of content types you could use the file name (without the `.courier`) extension to find the corresponding type in the database. So if the filename is `efc3208b-efc6-44f8-928c-12c03ccf4700.courier` you might query the database like so:

    SELECT Alias, Name, UniqueID
      FROM cmsPropertyType
      WHERE contentTypeId IN 
      (SELECT umbracoNode.id FROM umbracoNode WHERE uniqueID = 'efc3208b-efc6-44f8-928c-12c03ccf4700')
      ORDER BY Alias

This will give you the properties available on this content type in this environment and you can compare the properties to the ones in your log file to see if the environment you're performing the SQL query in is correct according to what you want the content type to be.

Again, once you've decided which Courier file in `~/App_Data/Revision/` contains the best representation of your content type then you can remove the duplicate from disk and commit the removal to Git. This should unblock your future deploys from popping up this error.

It's important to note that only you can decide which document type you want to keep, Courier cannot guess which document type you think is the most complete.

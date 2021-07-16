---
versionFrom: 7.0.0
---

# Deploying deletions

On Umbraco Cloud deletions are environment specific. This means that in order to delete something entirely from your project, you need to delete it on all environments.

In this article you can read about the correct way of deleting files, schema and content from your Umbraco Cloud project.

When you have an Umbraco Cloud project, you might have several environments - including a local clone of the project. These environments each have their own database. The databases will contain references to all of your content and media, as well as to all of your schema files (e.g. Document Types, Templates etc).

The databases are environment specific. When you deploy from one environment to another, the engine behind Umbraco Cloud will compare incoming schema files with references to these in the databases using both *alias* and *GUID*. If something doesn't add up - e.g. there is a mismatch between the database references and the files deployed - you will see an error. Learn more about this in the [Troubleshooting section](../../Troubleshooting/Deployments).

The workflow described above does not pick up deletions of content and schema from the database, which is why you'll need to delete the content and / or schema on all your environments, in order to fully complete the deletion.

The main reason we do not delete schema and content on deployments, is because it could lead to unrecoverable loss of data. Imagine that you delete a Document Type on your Development environment, and push this deletion to your Live environment where you have a lot of content nodes based on the deleted Document Type. When the deployments goes through, all of those content nodes would be instantly removed with no option to roll back as the Document Type they are based on no longer exists. To avoid anyone ending up in this unfortunate situation, deletes are not automatically handled and will require an active decision from you on each environment in order to take place.

## Example scenario

Let's say you've deleted a Document Type on your Development environment, and now you want to deploy this deletion to the Live environment, along with some other changes you've made.

Before you deploy the changes, the Development environment will show that the following changes are ready to be deployed:

![Changes ready for deployment](images/deletions-of-doctype.png)

Following the **Activity log** in the browser, you'll see that the UDA file for the Document Type is deleted, and that other files containing changes are copied into the new environment.

```
Remote: Copying file: 'css\umbraco-starterkit-style.css'
Remote: Deleting file: 'data\revision\document-type__79f0600e71ab45eba3ebc2e44f216a05.uda'
Remote: Copying file: 'Views\ContentPage.cshtml'
```

Once the deployment is complete, you will notice the following:

* The css file is correctly updated
* The template is correctly updated
* The Document Type you deleted on Development is still present in the backoffice on the Live environment

You might wonder why the Document Type that you have deleted, is still there. The reason is, that we only delete the associated UDA file, and not the actual Document Type in the database.

In order to completely delete the Document Type from your entire project, you need to delete it from the backoffice of any of the other environments you have as well. When the Document Type has been deleted from the backoffice of all environments and no UDA file exists, you can consider it completely gone.

You should however keep in mind that if you at any point during the process, save your Document Type again, a UDA file will be regenerated and when you start deploying changes between environments, this will likely end up recreating your deleted Document Type.

## Which deletions are deployed?

Every **file** that's deleted, will also be deleted on the next environment when you deploy. However, there are some differences depending on what you have deleted.

Here's an overview of what happens when you deploy various deletions to the next environment.

### Deleting Schema (Document Types, Datatypes etc.)

Deleted:
* The associated `.UDA` file

Not deleted:
* The entry in the database
* The item will still be visible in the backoffice

### Deleting a Template

Deleted:
* The associated `.UDA` file
* The associated `.cshtml` file (the view file)

Not deleted:
* The entry in the database
* The template file will be empty, but still be visible in the backoffice

### Deleting files (css files, config files etc.)

As these are **only** files, everything will be deleted on the next environment upon deployment.

### Deleting content and / or media

Content and media deletions will not be picked up by deployments and will have to be deleted on each environment you wish to delete the content or media on.

### Deleting backoffice languages

Deleted:
* The associated `.UDA` file

Not deleted:
* The entry in the database
* The language will still be visible in the backoffice/content dashboard (for multilingual content)

Deleting the language in the backoffice on the target environment will ensure the environments are in sync.

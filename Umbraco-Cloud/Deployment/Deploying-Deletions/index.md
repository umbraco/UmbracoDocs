# Deploying deletions

In this article you can read about the correct way of deleting files, schema and content from your Umbraco Cloud project.

When you have an Umbraco Cloud project, you might have several environments - including a local clone of the project. These environments each have their own database. The databases will contain references to all of your content and media, and to all of your schema files. 

The databases are environment specific. When you deploy from one environment to another, the engine behind Umbraco Cloud will compare incoming schema files with references to these in the databases. If something doesn't add up - e.g. there are a mismatch between the database refenreces and the files deployed - you will see an error. Learn more about in the Troubleshooting section.

The workflow described above does not pick up deletions of content and schema - these deletions are environment specific.

## Example scenario

Let's say you've deleted a Document Type on your Development environment, and now you want to deploy this deletion along with some other changes you've made, to the Live environment.

Before I deploy the changes, the Development environment will show that the following changes are ready to be deploy:

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

You might wonder why the Document Type that you've just deleted, is still there. The reason is, that we only delete the associated UDA file, and not the database entry that references the Document Type. In order to delete the Document Type complete from your project, you need to delete it from the Live environment as well. This will also delete the reference to the Document Type in the Live database, and you will be completely rid of the Document Type.


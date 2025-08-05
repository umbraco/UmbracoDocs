# Deploying Deletions

On Umbraco Cloud, deletions are environment specific. To delete something entirely from your project, you need to delete it in all environments.

In this article, you can read about the correct way of deleting files, schema, and content from your Umbraco Cloud project.

When you have an Umbraco Cloud project, you might have couple of environments including a local clone of the project. Each of these environments have their own database. These databases store references to your content, media, and schema files, such as Document Types and Templates.

The databases are environment specific. During deployment across environments, Umbraco Cloud's engine compares schema files with database references using _alias_ and _GUID_ for accuracy. If something doesn't add up, for example, there is a mismatch between the database references and the files deployed, you will see an error. Learn more about this in the [Troubleshooting section](../../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/deployments/).

The workflow described above does not recognize deletions of content and schema from the database. You'll need to delete the content and/or schema on all your environments to fully complete the deletion.

The main reason not to delete schema and content on deployments is that it could lead to an unrecoverable loss of data.

Here's an example of what can happen when a Document Type is deleted and deployed:

* A Document Type is deleted in the left-most mainline environment.
* This deletion is then pushed to the Live environment, where many content nodes depend on the deleted Document Type.
* When the deployment is completed, all those content nodes would be instantly removed.

In the scenario described above, there is no option to roll back because the Document Type they rely on no longer exists. To prevent such situations, manual deletion is necessary. You must actively decide on each environment for the process to occur. Below is the same scenario explained in more detail.

## Example scenario

The following example will build in the scenario outlined above, calling the left-most mainline environment the **Development** environment. In addition to the deletion, additional changes that have been made will also be deployed.

Before you deploy the changes, the Development environment will show that the following changes are ready to be deployed:

<figure><img src="../../../.gitbook/assets/image (42).png" alt=""><figcaption><p>Changes ready for deployment</p></figcaption></figure>

Following the **Activity log** in the browser, you'll notice that the `.uda` file for the Document Type gets deleted. Additionally, other files with changes are copied to the Live environment.

Once the deployment is completed, the following changes has taken place:

* The template is correctly updated.
* The Document Type you deleted on the Development environment is still present in the backoffice on the Live environment.

The reason for the Document Type to still be there is, that the associated `.uda` file is deleted. The Document Type still exists in the database.

To delete the Document Type from your entire project, you need to delete it from the backoffice of the other environments. When the Document Type has been deleted from the backoffice of all the environments and no `.uda` file exist, it is fully removed.

If you save your Document Type during the process, a new `.uda` file is generated. This can recreate your deleted Document Type when deploying changes between environments.

## Which deletions are deployed?

Every **file** that's deleted, will also be deleted on the next environment when you deploy. However, there are some differences depending on what you have deleted.

Here's an overview of what happens when you deploy deletions to the next environment.

### Deleting Schema (Document Types, Datatypes, etc.)

| Deleted                     | Not Deleted                                       |
| --------------------------- | ------------------------------------------------- |
| The associated `.uda` file. | The entry in the database.                        |
|                             | The item will still be visible in the backoffice. |

### Deleting a Template

| Deleted                                       | Not Deleted                                                              |
| --------------------------------------------- | ------------------------------------------------------------------------ |
| The associated `.uda` file.                   | The entry in the database.                                               |
| The associated `.cshtml` file (the view file) | The template file will be empty, but still be visible in the backoffice. |

### Deleting Files (CSS files, config files, etc.)

All files are deleted in the next environment upon deployment.

### Deleting Content and/or Media

Deletions of content and media won't be detected during deployments. You must manually delete them on each environment where removal is desired.

### Deleting Backoffice Languages

| Deleted                     | Not Deleted                                                                                        |
| --------------------------- | -------------------------------------------------------------------------------------------------- |
| The associated `.uda` file. | The entry in the database.                                                                         |
|                             | The language will still be visible in the Backoffice/Content dashboard (for multilingual content). |

Deleting the language in the backoffice on the target environment will ensure the environments are in sync.

# Power Tools (Kudu)

Kudu is an open-source engine behind Git deployments to Azure. It gives us basic access to the file system through the command line or PowerShell, all from the comfort of a web browser. It also powers the way we deploy to Umbraco Cloud sites.

To access Kudu, you will have to be an admin on the project.

Kudu is available for each environment on your Umbraco Cloud project. You can find the link by clicking the environment name in the Umbraco Cloud portal. When you are prompted to log in, use your Umbraco Cloud credentials.

{% embed url="https://www.youtube.com/embed/vy6fRXMA9mE?rel=0" %}
Using Kudu on Umbraco Cloud
{% endembed %}

## What can you do from Kudu?

The power tools can be used for various things, we often refer to the tools in our troubleshooting guides.

* [The file structure](file-structure-on-cloud.md)
* [Run an extraction manually](manual-extractions.md)
* [Generate UDA files](generating-uda-files.md)

## Showing more than 299 items in Kudu

Larger sites can often have more than 299 items in various folders and by default, you can only view 299 files/folders.

This number can be increased by doing the following:

1. Go to your **Kudu** site.
2. Open the browser developer tools (F12).
3. Type `window.localStorage['maxViewItems'] = 999` in the **Console** where 999 will be the new limit. This can be set to anything you like.
4. Hit **Enter**.
5. Navigate back into the folder you want to view the files in.
6. You should now be able to view the folders/files up to the limit you've set it to.

{% hint style="info" %}
If you refresh the page, the limit will go back to the standard 299.
{% endhint %}

## Important notes

Kudu is **not** a tool meant for adding and removing files on your project. This should always be done via Git ([Local to Cloud](../build-and-customize-your-solution/working-locally.md)) and the Deploy engine([Cloud to Cloud](broken-reference)).

We recommend that you **only** use Kudu when you are following one of our guides.

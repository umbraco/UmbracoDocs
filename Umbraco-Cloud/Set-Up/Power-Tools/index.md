# Power tools (Kudu)

Kudu is an open source engine behind git deployments to Azure. It gives us basic access to the file system through command line or powershell, all from the comfort of a web browser. It also powers the way we deploy to Umbraco Cloud sites.

In order to access Kudu you will have to be an admin on the project.

Kudu is available for each environment on your Umbraco Cloud project. You can find the link by clicking the environment name in the Umbraco Cloud portal. When you are prompted to login, use your Umbraco Cloud credentials.

<iframe width="800" height="450" src="https://www.youtube.com/embed/rXQP4cMi1lc?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## What can you do from Kudu?

The power tools can be used for various things, we often refer to the tools in our troubleshooting guides.

* [The file structure](File-structure-on-cloud)
* [Run an extraction manually](Manual-extractions)
* [Generate UDA files](generating-uda-files)

## Important notes

Kudu is **not** a tool meant for adding and removing files on your project. This should always be done via Git([Local to Cloud](../../Deployment/Local-to-Cloud)) and the Deploy engine([Cloud to Cloud](../../Deployment/Cloud-to-Cloud)).

We recommend that you **only** use Kudu when you are following one of our guides.

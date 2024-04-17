---
description: >-
  In this guide, we show you how you can connect and work with your Cloud
  Database on Mac.
---

# Connecting to the Database on Mac

## Prerequisite

* An Umbraco Cloud project
* [Whitelisted IP](https://docs.umbraco.com/umbraco-cloud/databases/cloud-database#opening-the-firewall) on Umbraco Cloud
* [Azure Data Studio ](https://azure.microsoft.com/en-us/products/data-studio)

### Connecting to the Database

Follow the steps below to connect and work with your Umbraco Cloud Database on a Mac.

1. Go to the Connection Details Page on your Umbraco Cloud project.
2. Copy the connection details from the Connection Details Page.

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1).png" alt=""><figcaption><p>SQL Connection Details on Umbraco Cloud</p></figcaption></figure>

3. Open Azure Data Studio.
4. Click "Create a connection" on the welcome page in Azure Data Studio.

<figure><img src="../../.gitbook/assets/image (2) (1) (1).png" alt=""><figcaption><p>Create a Connection in Azure Data Studio</p></figcaption></figure>

5. Change the Authentication type to SQL Login and enter the connection details copied from Umbraco Cloud.

<div data-full-width="false">

<figure><img src="../../.gitbook/assets/image (3) (1) (1).png" alt="" width="375"><figcaption><p>Entering connection details in Azure Data Studio</p></figcaption></figure>

</div>

6. Click Connect once the connection details have been filled out.

You have now connected to your database. You can work with the databases on Umbraco Cloud like you could on any other host. Remember to let Umbraco Cloud do the work when it comes to the Umbraco-related tables (`Umbraco*` and `CMS*` tables).

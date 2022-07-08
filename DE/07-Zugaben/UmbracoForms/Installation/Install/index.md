---
versionFrom: 9.0.0
versionTo: 10.0.0

meta.Title: "Installing Umbraco Forms"
meta.Description: "Installing Umbraco Forms"
---

# Extending Umbraco with the Forms Section

Since Umbraco v7.2, Umbraco contains the **Forms** section, by default. You will see a similar interface, when you click on the **Forms** section in the **Umbraco Backoffice**.

![Form section in backoffice](images/Forms_Section_Backoffice.png)

## Installing Umbraco Forms

To install the Umbraco Forms package (**Umbraco.Forms**), follow these steps:

1. Run the following command on a command prompt of your choice:

    ```cli
    dotnet add package Umbraco.Forms
    ```

2. Restart the web application using the following command:

   ```cli
    dotnet run
    ```

## Start Building Forms

Once the installation is successful, you will see a similar screen in the Forms section:

![Create form](images/start-with-forms-v9.png)

## Using Forms

For details on using Forms, see the [Editor Documentation](../../Editor).

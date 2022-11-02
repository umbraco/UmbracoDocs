---
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Overview of the Prevalue Source Types

There are some default prevalue source types that can be used.

In Umbraco Forms version 8, for each prevalue source you setup, a `json` file will be generated in `~/App_Data/UmbracoForms/Data/prevaluesources`.

:::note
In Umbraco Forms version 9.0.0, it is *only* possible to store Forms data in the database. If upgrading to Umbraco version 9 and using Forms, you should first migrate the Forms to the database using Forms version 8. For more information, see [Umbraco Forms in the Database](../../../Developer/Forms-in-the-Database/index.md).
:::

Here is a quick overview of the default types:

- **Get values from textfile**

    Upload a textfile that contains the prevalues. Each prevalue should have its own line in the file. Once the file has been uploaded, you can find it in `~/wwwroot/App_Data/UmbracoForms/Data/PreValueTextFiles/{GUID}` where the `{GUID}`is replaced with the pre-value ID.

- **Umbraco Documents**

    Allows to use content nodes from a specific source as prevalues. You can define the root node by either

  - Choosing a node directly from the Content tree or
  - Using XPath

    ![Umbraco Documents as prevalue sources](images/umbraco-documents-v9.png)

    Additional settings can be applied:

    - Select **Use current page as root** instead of choosing a specific root node. Note that the preview is not available when this setting is enabled.
    - Select a specific **Document type**, if the selected root node contains a different document type.
    - Select to include **Grand children** of the selected root node.

- **SQL Database**

    Connect to a OleDB compatible database table and construct a prevalue source from it. Once selected, it will be editable from the Forms interface.

    The following configurations need to be set:

  - Connection string (either choose one from your web.config or add another from a textfield)
  - Connection String from configuration
  - Table Name
  - Key Column
  - Value Column

- **Umbraco Data Type Prevalues**

    Choose an Umbraco data type to use its configured prevalue collection.

    In the example below, the prevalue collection from a data type called `Home - Font - Radio button` is used:

    ![Data Type prevalues](images/datatype-prevalues.png)

---

Prev: [Defining and attaching prevalue sources](../index.md)

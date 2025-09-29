# Migrate from Plumber to Workflow

Umbraco Workflow is backwards compatible with Plumber data. However, with a new default namespace constituting a major breaking change any existing customization or extension needs to be updated.

To migrate from an Umbraco installation with an existing Plumber installation to Umbraco Workflow, follow these steps:

{% tabs %}
{% tab title="Site running on SQL Server database" %}
1. Uninstall Plumber and remove the `/App_Plugins/Plumber` folder.
2. Upgrade your project to Umbraco 11.
3. Install Umbraco Workflow 11. See the [Installing Umbraco Workflow](../installation/installing-workflow.md) article.
4. Build the application.

{% hint style="info" %}
SQL is the preferred database provider for production websites.
{% endhint %}
{% endtab %}

{% tab title="Site running on SQLite database" %}
1. Uninstall Plumber and remove the `/App_Plugins/Plumber` folder.
2. Upgrade your project to Umbraco 11.
3. Make a copy of the `Value` column from the `WorkflowSettings` table.
4. Delete the `WorkflowSettings` table.
5. Update `WorkflowTaskInstance` table to allow null values in the GroupId column.
6. Install Umbraco Workflow 11. See the [Installing Umbraco Workflow](../installation/installing-workflow.md) article.
7. Build the application.
8. Update the `WorkflowSettings` table to restore the previous data to the `Value` column.
{% endtab %}
{% endtabs %}

{% hint style="info" %}
All your existing workflow data and settings are not affected and will be available on your upgraded site.
{% endhint %}

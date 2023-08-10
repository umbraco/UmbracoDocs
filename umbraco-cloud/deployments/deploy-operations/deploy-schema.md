# Deploying Schema from Data Files

When you deploy from one environment to another on your Umbraco Cloud project, the files from the Git repository are merged into the files used on the site. The Deploy engine then deploys your schema from your data files. This means that the files on the disk will be deserialized into the database in the Cloud environment.

You can run a deployment of schema manually by following these steps:

1. Go to the Backoffice.
2. Navigate to the **Settings** section.
3. Go to the **Deploy** dashboard.
4. Select **Schema Deployment From Data Files** from the **Deploy Operations** dropdown.
5. Click **Trigger Operation**. The Deploy engine will start the process and the status will change to `Read pending`.
6. Once the operation is done, you'll see the status has changed to one of the two possible outcomes:
   1. `Last deployment operation completed`: The deployment succeeded and your environment is in good shape.
   2. `Last deployment operation failed`: The deployment has failed. Go to the Cloud portal, to see the error message.

![Run manual schema deployment](../../.gitbook/assets/schema-deployments-v10.gif)

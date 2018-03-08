# Troubleshooting Content deployments on Umbraco Cloud

## When working on Umbraco Cloud

If the schema (this includes DocumentTypes, MediaTypes, DataTypes, Templates, Macros and Dictionary items) is different between the two environments you are deploying between, you will need to deploy the updates for these before you can complete the Content transfer (this can contain Media from the Media section as well). Environments need to be in-sync before a Content and/or Media transfer can succeed.

While Content and Media transfers are done using the Umbraco backoffice you use the Umbraco Cloud Portal in order to deploy the schema changes, which exists on disk and are deployed through the underlying git repository. 

The deployment between your Umbraco Cloud environments is simple to do - simply follow the steps outlined the [Cloud to Cloud](https://our.umbraco.org/documentation/Umbraco-Cloud/Deployment/Cloud-to-Cloud/) article.

If you continue to see conflicts between the schema parts that were deployed then please refer to the Debugging section below.

## Debugging

When you run into schema mismatch errors, they will usually look something like this:

![Schema Mismatch error message](images/schema-mismatch-on-transfer.png)

In this error message, you are able to see exactly which schema mismatches is preventing the content transfer. If you do not have any pending deployments in your source environment (Development or Staging) in the Umbraco Cloud Portal, there are two ways to go about resolving the schema mismatch:

1. On the source environment (Development or Staging) make a minor change to the schema with mismatches (in the example above it would be the **Homepage** document type). Deploy the change to the next environment
    * This will update your schema in the target environment (Staging or Live) and ensure it's in sync with the source environment
2. If the mismatches are differences to `aliases` or `names`, changing these manually on the target environment will enable you to transfer your content
    * Do **not** make any major schema changes or create new schema on the Staging or Live environments. There is no way to sync these changes down to your *lower* environments

**NOTE**: If your project is using Umbraco Courier, please refer to this article instead: [Schema Mismatches with Courier](../../Courier/Schema-Mismatch-Courier)

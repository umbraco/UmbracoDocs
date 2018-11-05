# Schema mismatches

When transferring or restoring content between two Umbraco Cloud environments, you might run into **Schema mismatch** errors. These usually occur when the schema (this includes Document Types, Media Types, Data Types, Templates, Macros and Dictionary items) isn't in sync between the *source environment* and the *target environment*.

In this article you can learn how to resolve schema mismatch issues, and how you can avoid them in the future.

## Video Tutorial

<iframe width="800" height="450" src="https://www.youtube.com/embed/uygPdVoLcvU?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## Step-by-step

When you run into schema mismatch errors, they will usually look something like this:

![Schema Mismatch error message](images/schema-mismatch-on-transfer.png)

In this error message, you are able to see exactly which schema mismatch(es) is preventing the content transfer / restore.

First step in resolving this error is to check for pending deployments on the source environments. If you are working locally, check for and push any uncommitted changes through Git. Are you transferring between two Umbraco Cloud environments, you can see and deploy pending changes through the Umbraco Cloud Portal.

Are there no pending deployments in your source environment, there are two ways to go about resolving the schema mismatch:

1. Make a minor change to the schema with mismatches on the source environment (in the example above it would be the **Homepage** document type). 
2. Deploy the change to the next environment
    * This will update your schema in the target environment and ensure it is in sync with the source environment

If the mismatches involves differences to `aliases` or `names`, changing these manually on the target environment will enable you to transfer your content.

:::note
If your project is using Umbraco Courier, please refer to this article instead: [Schema Mismatches with Courier](../../Courier/Schema-Mismatch-Courier)
:::

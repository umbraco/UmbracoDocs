---
versionFrom: 7.0.0
---

# Usage on your Umbraco Cloud project

In the Umbraco Cloud Settings menu you can find a page called Usage.

From here you can see your current usage of content nodes (published/unpublished pages on your website), custom domains added to the project, the size of the media library as well as the bandwidth usage of the project.

You can also get an overview of the usage limitations for your Umbraco Cloud project as well as the plan that the project is on.

![Usage on Cloud](images/Usage2.png)

## Usage limits

On the image below you can see the Usage limitatons for the specific plans on Umbraco Cloud.

![Usage limits on a starter plan](images/Plan_limitations.png)

On Umbraco Cloud you can always upgrade your project to a higher plan if you have reached the limit of what you are allowed on your project.

This can also be done from the setting tab on your project.

You can see the prices for the different plans on Umbraco Cloud on our [website](https://umbraco.com/umbraco-cloud-pricing/) or when you are upgrading your plan.

## Manually check usage on our project

First, to clarify what content nodes are:

1. Published nodes
2. Unpublished nodes

Here's what they are not:
1. Thrashed nodes
2. Nested content
3. Member data
4. Media nodes

Prerequisites:
1. Admin access to the project.
2. MS SQL Management Studio or another DB management software of your liking.

Here's how to check the number of content nodes:
1. First of all, you'll need admin access to the project.
2. Once you have that, navigate to the /connection-details of the project you want to check on the Cloud.
3. Open MS SQL Management Studio or another DB management software of your liking.
4. Connect to the database of the site you want to check.
5. Open a new query.
6. Enter this:

```
SELECT *
  FROM umbracoNode
  WHERE nodeObjectType = 'C66BA18E-EAF3-4CFF-8A22-41B16D66A972'
  AND [path] NOT LIKE '-1,-20%'
```
7. Scroll all the way down and check the count at the bottom.

:::note
This approach works on both v7 and v8 projects

You can also do this on a project that you wish to migrate to Umbraco Cloud to check which plan would fit for it.
:::


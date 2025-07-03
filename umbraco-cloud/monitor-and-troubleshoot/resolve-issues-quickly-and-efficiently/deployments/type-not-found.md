# Extraction error: "Type not found! "

This issue will present itself as an extraction error on your target environment for a deploy.

<figure><img src="../../../.gitbook/assets/image (56).png" alt=""><figcaption></figcaption></figure>

The extraction error happens with two Document Types where one of them have been allowed as a child node type for the other Document Type.

If the Document Type that has been allowed as the child is then deleted, the references for the child Document Type are not removed from the parent Document Type.

Because the parent Document Type still has the references from the deleted child Document Type, the environment will throw an extraction error when trying to deploy to the next environment. The error will tell us that it can not find the Document Type that is allowed as a child.

## How to resolve the extraction error

Open the **More info** to see the details for the error message.

![Extraction error on Live](../../../troubleshooting/deployments/images/Extraction_Error.png)

In the case illustrated above the extraction error is saying:

```
Document type c3bedefc-7eab-4ee2-9941-920ecc9b09b2 not found! This Document type is listed as an allowed child content type of parent Document type Test1 with id: 1087, and guid: 4a06f910-7b1b-4ad6-84db-72481b1ae529
```

To resolve the extraction error go to the backoffice of the environment, which you are deploying from and find the Document Type that is listed as the parent for the deleted Document Type in the error message.

In this case that is the Document Type _"test1"_.

Resave the parent Document Type so that the references to the deleted child Document Type will be removed from the parent Document Type.

After the Document Type has been saved again make a new deploy and you will see that the deploy will go through.

The environment will be green and the deployment has successfully gone through without any errors.

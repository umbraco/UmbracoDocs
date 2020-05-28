---
versionFrom: 7.0.0
---

# Extraction error: "Type not found! "

## Why do you get the extraction error?

The issue will present itself as an extraction error on your target environment for the deploy.

![Extraction error on Live](images/Error_Environment.png)

This error happens with two document types where one of them have been allowed as a child node types for the other document type.

If the document type that have been allowed as the child is then deleted the references for the child document type is not removed from the parent document type.

Because the parent document type still have the references from the deleted child document type the environment will throw an extraction error telling that it can not find the document type that is allowed as a child when trying to deploy to the next environment.

## How to resolve the extraction error

Open the **More info** to see the details for the error message.

![Extraction error on Live](images/Extraction_error.png)

In the case illustrated above the extraction error is saying:

    "Document type c3bedefc-7eab-4ee2-9941-920ecc9b09b2 not found! This document type is listed as an allowed child content type of parent document type Test1 with id: 1087, and guid: 4a06f910-7b1b-4ad6-84db-72481b1ae529"

To resolve this extraction error go to the backoffice of the environment which you are deploying from and find the document type that is listed as
the parent for the deleted document type in the error message, which in this case is the document type *"test1"*.

Re-save the parent document type so that the references to the deleted child document type will be removed from the parent document type.

After the document type have been saved again make a new deploy and you will see that the deploy will go through and the environment will be green and the deploy have successfully gone through without any errors.

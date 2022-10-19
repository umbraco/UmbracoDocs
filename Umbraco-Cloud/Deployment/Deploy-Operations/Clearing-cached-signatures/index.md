---
versionFrom: 8.0.0
---

# Clearing Cached Signatures

Umbraco Deploy improves the efficiency of transfers by caching signatures of each artifact in the database for each environment. The signature is a string-based, hashed representation of the serialized artifact.

Sometimes you might see that Deploy is performing poorly, throwing unexpected issues and so on. In this case, a good approach to solving these issues is to clear the cached signatures.

## Clearing Cached Signatures Manually

Follow these steps to clear the cached signatures:

1. Go to the Backoffice.
2. Navigate to the **Settings** section.
3. Go to the **Deploy** dashboard.
4. Select **Clear cached signatures** from the **Deploy Operations** dropdown.
5. Click **Trigger Operation**. The Deploy engine will clear all the cached signatures.

The **Deploy Status** will change to *Clear signatures pending*. Once the operation is done, you'll see the status has changed to `Last deployment operation completed`. To check that you can deploy the schema, see the [**Deploying Schema from Data Files on your Cloud Environments**](../Deploy-schema) article.

![Clear cached signatures](images/clear-cached-signatures-v10.gif)

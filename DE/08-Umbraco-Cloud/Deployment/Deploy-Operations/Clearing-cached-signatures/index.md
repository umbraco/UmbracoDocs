---
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Clearing Cached Signatures

Umbraco Deploy improves the efficiency of transfers by caching signatures of each artifacts in the database for each environment. The signature is a string based, hashed representation of the serialized artifact.

Sometimes you might see that Deploy is performing poorly, throwing unexpected issues or the like. In this case a good approach of solving these issues is to clear the cached signatures.

## Clearing Cached Signatures Manually

Follow these steps to clear the cached signatures:

1. Go to the backoffice.
2. Navigate to the **Settings** section.
3. Go to the **Deploy** dashboard.
4. Select `Clear cached signatures` from the **Deploy Operations** dropdown.
5. Click **Trigger Operation**. The Deploy engine will clear all the cached signatures. The status will change to `Clear signatures pending`.
6. When it's done you'll see the status has changed to `Last deployment operation completed`.
7. Final step is to check that you can deploy the schema. See the [**Deploying Schema from Data Files on your Cloud Environments**](../Deploy-schema) article.

![Clear cached signatures](images/clear-cached-signatures-v10.gif)

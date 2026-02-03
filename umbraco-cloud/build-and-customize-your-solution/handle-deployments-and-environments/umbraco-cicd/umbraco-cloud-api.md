---
description: Learn how to use the Umbraco Cloud APIs' publicly accessible endpoints with your CI/CD setup.
---

# Cloud API For CI/CD Flow

The Umbraco Cloud API is a publicly accessible endpoint that customers can use to execute relevant tasks.

{% hint style="info" %}
**Changes between endpoints for version 1 and 2**

With the endpoints for version 2, you are given more control over the process.

These are the most important benefits of using version 2 instead of version 1:

* Target a flexible environment or the left-most environment.
* More options are available when deploying.
* Use a simplified API call flow: Uploading an artifact is decoupled from the actual deployment.

[Do you want to migrate from V1 to V2 endpoints?](samplecicdpipeline/migrate.md)

[The version 1 endpoints are still available](v1-umbraco-cloud-api.md).
{% endhint %}

## Getting started

To integrate Umbraco Cloud into your CI/CD pipeline, you'll need to make API calls to the `https://api.cloud.umbraco.com` endpoint in combination with:

**Path for artifacts**

* `/v2/projects/$projectId/deployments/artifacts`

**Paths for deployments**

* `/v2/projects/$projectId/deployments`
* `/v2/projects/$projectId/deployments/$deploymentId`

**Paths for querying deployments and fetching changes**

* `/v2/projects/$projectId/deployments`
* `/v2/projects/$projectId/deployments/$latestCompletedDeploymentId/diff`

You will find relevant examples using `HTTP Request Syntax` in the sections below.

### How to enable the CI/CD Integrator in the Umbraco Cloud Portal

To authenticate with the Umbraco Cloud API, you'll need your Project ID and API Key. These credentials can be found under **Configuration > CI/CD Flow** in the Umbraco Cloud portal.

![Umbraco CI/CD Flow](../../../.gitbook/assets/Advanced-Section.png)

The two elements you need for the authentication are:

* **Cloud Project ID**: The ID of your Umbraco project.
* **CI/CD API Key**: Your unique identifier.

By including the API key header in your HTTP requests, you ensure secure access to your Umbraco Cloud project's resources.

For enhanced security, it's important to store the provided API key in a secure location. Options include a variable group in Azure DevOps or using the Secrets feature in GitHub Actions.

Each API key is tightly coupled with a specific Umbraco Cloud project and can only be used for deployments related to that project.

### How to authenticate your requests

To authenticate your API requests, you'll need to include your API key in a custom HTTP header named `Umbraco-Cloud-Api-Key`.

{% tabs %}
{% tab title="HTTP Request Syntax" %}
```http
GET https://api.cloud.umbraco.com/v2/projects/{{projectId}}/deployments  
Umbraco-Cloud-Api-Key : {{apiKey}}
```
{% endtab %}

{% tab title="Powershell" %}
```powershell
Invoke-RestMethod -Uri https://api.cloud.umbraco.com/v2/projects/$projectId/deployments -Headers @{ "Umbraco-Cloud-Api-Key" = $apiKey } -Method Get
```
{% endtab %}

{% tab title="Curl" %}
```
curl -s -X GET https://api.cloud.umbraco.com/v2/projects/$projectId/deployments -H "Umbraco-Cloud-Api-Key: $apiKey"
```
{% endtab %}
{% endtabs %}

## Deployment Artifacts

In the following sections, you can learn more about the process of deploying artifacts.

### Upload artifact

Artifacts are tied to a project. The uploaded artifact will be available to use in any deployment made to an environment on that project.

The artifact must be a zip file containing the source code required to build your website.

[Read about artifact Best Practices](samplecicdpipeline/artifact-best-practice.md).

```http
@projectId = Get this value from the portal
@apiKey = Get this value from the portal
@description = my awesome optional description text
@version = my awesome optional version text
@file = path to file + filename

POST https://api.cloud.umbraco.com/v2/projects/{{projectId}}/deployments/artifacts
Umbraco-Cloud-Api-Key: {{apiKey}}
Content-Type: multipart/form-data; boundary=--TheFormDataBoundary

----TheFormDataBoundary
Content-Disposition: form-data; name="file"; filename="package.zip"
content-type: application/octet-stream

< {{file}}
----TheFormDataBoundary
Content-Disposition: form-data; name="description"

{{description}}
----TheFormDataBoundary
Content-Disposition: form-data; name="version"

{{version}}
----TheFormDataBoundary--
```

Once the file is uploaded, you will get a response that uses the following JSON schema:

```json
{
  "artifactId": string,
  "fileName": string,
  "blobUrl": string,
  "filesize" : number,
  "createdUtc": string,
  "description": string,
  "version": string
}
```

### List artifacts

It is possible to configure how the uploaded artifacts are listed. The endpoint is paged and accepts the options `skip` and `take`. If `skip` is not supplied, its value will default to 0. If `take` is not supplied, its value will default to 10.

```http
@skip = 0
@take = 10
@projectId = Get this value from the portal
@apiKey = Get this value from the portal

GET https://api.cloud.umbraco.com/v2/projects/{{projectId}}/deployments/artifacts?skip={{skip}}&take={{take}}
Umbraco-Cloud-Api-Key: {{apiKey}}
Content-Type: application/json
```

The response would look like the following:

```json
{
  "projectId": string,
  "data":
    [
      {
        "artifactId": string,
        "fileName": string,
        "blobUrl": string,
        "filesize" : number,
        "createdUtc": string,
        "description": string,
        "version": string
      }
    ],
  "totalItems": number,
  "skippedItems": number,
  "takenItems": number
}
```

## Deployments

The following sections cover how deployments are managed.

### Start the deployment

The Create Deployment endpoint starts a new deployment and returns a unique `deploymentId`.

The following options are available to use in the request payload:

| Parameter | Requirement | Description |
| :--- | :--- | :--- |
| `artifactId` | **REQUIRED** | The ID of the artifact you want to deploy. |
| `targetEnvironmentAlias` | **REQUIRED** | The alias of the environment you want to deploy to. |
| `commitMessage` | **OPTIONAL** | The commit message you want stamped in the Umbraco Cloud environment repository. |
| `noBuildAndRestore` | **OPTIONAL** | An option to skip the restore and build in the isolated instance. Default: `false`. |
| `skipVersionCheck` | **OPTIONAL** | An option to skip the version check in the isolated instance. Default: `false`. |

```http
@projectId = Get this value from the portal
@apiKey = Get this value from the portal
@targetEnvironmentAlias = left-most or flexible environment alias
@artifactId = Use artifact id from recent upload
@commitMessage = My awesome commit message for cloud
@noBuildAndRestore = false
@skipVersionCheck = false

POST https://api.cloud.umbraco.com/v2/projects/{{projectId}}/deployments
Umbraco-Cloud-Api-Key: {{apiKey}}
Content-Type: application/json

{
    "commitMessage": {{commitMessage}},
    "artifactId": {{artifactId}},
    "targetEnvironmentAlias": {{targetEnvironmentAlias}},
    "noBuildAndRestore": {{noBuildAndRestore}},
    "skipVersionCheck": {{skipVersionCheck}}
}
```

The API response should be an HTTP 201 Created response including a `deploymentId`.

```json
{
  "deploymentId": string,
  "projectId": string,
  "environmentAlias": string,
  "deploymentState": string,
  "deploymentStatusMessages":
  [
    {
      "message": string,
      "timestampUtc": string
    },
  ],
  "createdUtc": string,
  "completedUtc": string,
  "modifiedUtc": string
}
```

You can use the `deploymentId` to query the Get Deployment status endpoint.

{% hint style="info" %}
 **Use `skipVersionCheck` with care.** This setting exists to prevent version regression (overwriting newer Umbraco packages with older ones). Only set this to `true` if you intentionally need to deploy an older artifact.

Enabling the `noBuildAndRestore` only disables the restore and build inside the isolated instance. Once the system pushes the source code to the environment, a build and publish operation will run as usual. Enabling this option lets you save one or more minutes during the deployment process.

For more information on using the `skipVersionCheck` and `noBuildAndRestore` settings in the pipeline, see the [Advanced Setup: Deployment options](samplecicdpipeline/advanced-deployment-options.md) article.
{% endhint %}

### Get Deployment status

To monitor the status of a deployment, you can periodically query the 'Get Deployment Status' API. This API endpoint is an HTTP GET request to the Umbraco Cloud API. It requires both the `projectId` and the `deploymentId` obtained from previous steps to be included in the path.

Deployments in Umbraco services can take varying amounts of time to complete. Therefore, it's advisable to poll this API regularly to stay updated on the deployment's current state.

For example, you might choose to poll the API every 25 seconds for 15 minutes. These figures are a starting point. The optimal polling frequency and duration may differ for your specific pipeline.

A query parameter is available to limit the `deploymentStatusMessages`. As a value for the query parameter, you can use the `modifiedUtc` value from a previous response.

| Parameter | Requirement | Description |
| :--- | :--- | :--- |
| `lastModifiedUtc` | **OPTIONAL** | Only show new deploymentStatusMessages since this point in time. |

```http
@projectId = Get this value from the portal
@apiKey = Get this value from the portal
@deploymentId = Get this value from the response of the endpoint above
@lastModifiedUtc = Get this value from a previous call to this endpoint

GET https://api.cloud.umbraco.com/v2/projects/{{projectId}}/deployments/{{deploymentId}}?lastModifiedUtc={{lastModifiedUtc}}
Umbraco-Cloud-Api-Key: {{apiKey}}
Content-Type: application/json
```

The response from this API call will return the same deployment object in JSON format as you would receive from other API interactions. Ultimately, the `deploymentState` field will indicate either 'Completed' or 'Failed'.

Should the deployment fail, check the `deploymentStatusMessages` for more information.

```json
{
  "deploymentId": string,
  "projectId": string,
  "environmentAlias": string,
  "deploymentState": string,
  "deploymentStatusMessages":
  [
    {
      "message": string,
      "timestampUtc": string
    },
  ],
  "createdUtc": string,
  "completedUtc":string,
  "modifiedUtc": string,
  "cloudRepositoryUpdated": boolean
}
```

## Query Deployments and fetch Changes

You can use the following sections to learn more about querying deployments and fetching changes.

### Get Deployments

The endpoint retrieves a list of deployments that have created a change in the Git repository of the Cloud environment. A deployment can have the state **Completed** or **Failed**.

It only lists deployments that have been run through the API.

The API allows you to filter and limit the number of returned deployments using the following query parameters:

| Parameter | Requirement | Description |
| :--- | :--- | :--- |
| `Skip` | **OPTIONAL** | Zero or a positive integer. Must be used together with `Take`. |
| `Take` | **OPTIONAL** | Zero or a positive integer. Must be used together with `Skip`. |
| `Includenulldeployments` | **OPTIONAL** | Boolean. Default: `true`. |
| `TargetEnvironmentAlias` | **OPTIONAL** | Will query only for deployments to a specific environment. |

With `includenulldeployments` set to true, you will get all completed deployments, including those that didn't change the Cloud repository.

```http
@projectId = Get this value from the portal
@apiKey = Get this value from the portal
@skip = Defaults to zero
@take = Defaults to 100
@includeNullDeployments = 
@targetEnvironmentAlias = 

GET https://api.cloud.umbraco.com/v2/projects/{{projectId}}/deployments?skip={{skip}}&take={{take}}&includeNullDeployments={{includeNullDeployments}}&targetEnvironmentAlias={{targetEnvironmentAlias}}
Umbraco-Cloud-Api-Key: {{apiKey}}
Content-Type: application/json

```

The response from this API call will return an object containing a list of deployment objects. The deployment objects are consistent with the structure used in other API responses. Deployments are listed in descending order based on creation timestamp.

```json
{
  "projectId": string,
  "data":
    [
      {
        "id": string,
        "artifactId": string,
        "targetEnvironmentAlias": string,
        "state": string,
        "createdUtc": string,
        "modifiedUtc": string,
        "completedUtc": string,
        "cloudRepositoryUpdated": boolean
      }
    ],
  "totalItems": number,
  "skippedItems": number,
  "takenItems": number
}
```

### Get Deployment diff

Sometimes updates are done directly on the Umbraco Cloud repository. It is encouraged not to do any actual work there, but auto-upgrades and environment changes will affect the Umbraco Cloud git repositories.

To keep track of such changes, you can use the 'Get Deployment Diff' API. This API endpoint will provide you with a git-patch file detailing the changes between a specific deployment and the current state of the repository. To make this API call, you'll need to include both the `projectId` and the `deploymentId` of the deployment you want to check against. This is a standard HTTP GET request.

The required query parameter has been added to the endpoint:

| Parameter | Requirement | Description |
| :--- | :--- | :--- |
| `TargetEnvironmentAlias` | **REQUIRED** | The intended deployment target environment for the diff. |

```http
@projectId = Get this value from the portal
@apiKey = Get this value from the portal
@deploymentId = 
@targetEnvironmentAlias = 

GET https://api.cloud.umbraco.com/v2/projects/{{projectId}}/deployments/{{deploymentId}}/diff?targetEnvironmentAlias={{targetEnvironmentAlias}}
Umbraco-Cloud-Api-Key: {{apiKey}}
Content-Type: application/json

```

The API response will vary depending on whether there are changes to report. If no changes are detected, you'll receive an HTTP 204 No Content status. If there are changes, the API will return an HTTP 200 OK status along with a git-patch file as the content. This git-patch file can then be applied to your local repository to sync it with the changes.

{% hint style="info" %}

It is only possible to generate git-patch files when the selected `deploymentId` points to a deployment where the `targetEnvironmentAlias` is the same as in this request.

{% endhint %}

## Possible errors

When interacting with the Umbraco Cloud API, you may encounter HTTP status codes that indicate the success or failure of your API request. Below is a table summarizing the possible status codes, their corresponding errors, and basic root causes to guide your troubleshooting:

| Status Code | Error               | Basic Root Cause                                                                     |
| ----------- | ------------------- | ------------------------------------------------------------------------------------ |
| 400         | BadRequest          | Check the requested path, supplied headers, and query parameters.                    |
| 401         | Unauthorized        | Check the Project ID and Api Key.                                                    |
| 404         | NotFound            | Usually related to the supplied deploymentId in the path not being found.            |
| 409         | Conflict            | The state of the referenced deployment is not ready for the work you are requesting. |
| 500         | InternalServerError | InternalServerError.                                                                 |

Most errors have a response body that corresponds to this JSON, and the “detail” field will have a more complete error message.

```json
{
  "title": string,
  "status": number,
  "detail": string
}
```

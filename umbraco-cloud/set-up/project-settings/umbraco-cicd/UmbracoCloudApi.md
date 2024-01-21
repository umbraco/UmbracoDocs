# Cloud API For CI/CD Flow

The Umbraco Cloud API serves as a publicly accessible endpoint that customers can utilize to execute relevant tasks.&#x20;

While its initial focus is on automating and managing deployments in Umbraco Cloud projects via the "Umbraco CI/CD Flow," future enhancements will broaden its capabilities to encompass a wider range of activities and options for Umbraco Cloud users.&#x20;

For the scope of this discussion, we will concentrate solely on the endpoints associated with interactions within the Umbraco CI/CD Flow. 

## Getting started

To integrate Umbraco Cloud into your CI/CD pipeline, you'll need to make API calls to the following endpoint [`https://api.cloud.umbraco.com`](https://api.cloud.umbraco.com):&#x20;

* `/$projectId/deployments`
* `/$projectId/deployments/$deploymentId`
* `/$projectId/deployments/$deploymentId/package`
* `/$projectId/deployments/$latestCompletedDeploymentId/diff`

You will find relevant examples using `Curl` and `Powershell` in the sections below.

### How to enable CI/CD Integrator in the Umbraco Cloud Portal

To authenticate with the Umbraco Cloud API, you'll need your Project ID and API Key. These credentials can be found in your cloud project under the 'Settings' tab, and then navigating to the 'Advanced' page.

![Umbraco CI/CD Flow](../../images/Advanced-Section.png)

The two elements to be used for the authentication are:

* **Cloud Project ID**: The ID of your Umbraco project.
* **CI/CD API Key**: Your unique identifier.

By including the API key header in your HTTP requests, you ensure secure access to your Umbraco Cloud project's resources.

For enhanced security, it's crucial to store the provided API key in a secure location. Options include a variable group in Azure DevOps or using the Secrets feature in GitHub Actions. It's important to note that each API key is tightly coupled with a specific Umbraco Cloud project and can only be used for deployments related to that project.

### How to authenticate your requests

To authenticate your requests, include the API key in a custom HTTP header named API key.

_PowerShell_ is a command-line shell and scripting language commonly used for automating tasks and managing configurations. It offers a versatile set of cmdlets that allow you to interact with APIs, manipulate files, and much more. Within the context of the Umbraco Cloud API, PowerShell can be employed to authenticate your requests by incorporating your unique API key.

_Curl_ (Client URL) is a command-line tool commonly used for making HTTP requests. It's a versatile utility that allows you to interact with APIs, download files, and more. In the context of Umbraco Cloud API, curl can be used to authenticate your requests by including your unique API key.

To authenticate your API requests using curl, you'll need to include your API key in a custom HTTP header named Umbraco-Cloud-Api-Key. Here's how typical Powershell and curl commands would look for this purpose:

{% tabs %}
{% tab title="Powershell" %}
```powershell
Invoke-RestMethod -Uri $url -Headers @{ "Umbraco-Cloud-Api-Key" = $apiKey } -Method Get
```
{% endtab %}

{% tab title="Curl" %}
```
curl -s -X GET $url -H "Umbraco-Cloud-Api-Key: $apiKey"
```
{% endtab %}
{% endtabs %}

## Endpoints
### Cloud Sync

You will need to call these endpoints to be able to sync you repository with the current state of the repository in cloud.

The order needs to be:
1. [Get Deployments](#get-deployments)
2. [Get Deployment diff](#get-deployment-diff)


{% swagger method="GET" path="/projects/{id}/deployments" baseUrl="https://api.cloud.umbraco.com/v1" summary="Get Deployments" %} {% swagger-description %} The endpoint lets you retrieve a list of completed deployments. It can only list deployments that has been run through the api. {% endswagger-description %}
{% swagger-parameter in="path" name="id" type="String" required="true" %} The API key for the Umbraco Cloud public API {% endswagger-parameter %}
{% swagger-parameter in="header" name="Umbraco-Cloud-Api-Key" type="String" required="true" %} The API key for the Umbraco Cloud public API {% endswagger-parameter %}
{% swagger-parameter in="header" name="Content-Type" type="String" required="true" %} application/json {% endswagger-parameter %}
{% swagger-parameter in="query" name="skip" type="integer" required="false" %} If used, must be combined with the "take" query parameter {% endswagger-parameter %}
{% swagger-parameter in="query" name="take" type="integer" required="false" %} If used, must be combined with the "skip" query parameter {% endswagger-parameter %}
{% swagger-parameter in="query" name="includenulldeployments" type="boolean" required="false" %} Recommended to be set to false. With `includenulldeployments` set to true, you will get all completed deployments, including those that did not create any new changes in the cloud repository. {% endswagger-parameter %}

{% swagger-response status="200: OK" description="A list of completed deployment" %}
The response from this API call will return an object containing a list of deployment objects. The deployment-objects are consistent with the structure used in other API responses.
Deployments are listed in descending order based on their creation timestamp.

```json
{
  "projectId": "abcdef12-cef8-4e92-8887-ceb123456789",
  "deployments":
    [
      {
        "deploymentId": "bc0ebd6f-cef8-4e92-8887-ceb862a83bf0",
        "projectId" : "abcdef12-cef8-4e92-8887-ceb123456789",
        "projectAlias": "cicd-demo-site",
        "deploymentState": "Completed",
        "updateMessage": "...",
        "errorMessage": "",
        "created": "2023-05-02T07:16:46.4183912",
        "lastModified": "2023-05-02T07:18:48.8544387",
        "completed": "2023-05-02T07:22:48.8544387"
      }
    ]
}
```
{% endswagger-response %}
{% swagger-response status="400: Bad Request" description="ProblemDetails" %}
For all error responses [see possiple errors](#possible-errors) for a general description.
{% endswagger-response %} 
{% endswagger %}

```sh
# Curl example
...
url="https://api.cloud.umbraco.com/v1/projects/$projectId/deployments?skip=0&take=1&includenulldeployments=false"

response=$(curl -s -X GET $url \
    -H "Umbraco-Cloud-Api-Key: $apiKey" \
    -H "Content-Type: application/json")
latestDeploymentId=$(echo $response | jq -r '.deployments[0].deploymentId')

```

{% swagger method="GET" path="/projects/{id}/deployments/{olderDeploymentId}/diff" baseUrl="https://api.cloud.umbraco.com/v1" summary="Get Deployment diff" %} {% swagger-description %} Sometimes updates are done directly on the Umbraco Cloud repository. We encourage you to not do any actual work there, but auto-upgrades and environment changes will affect the umbraco-cloud-git-repos. To keep track of such changes, you can use the 'Get Deployment Diff' API. This API endpoint will provide you with a git-patch file detailing the changes between a specific deployment and the current state of the repository. To make this API call, you'll need to include both the `projectId` and the `deploymentId` of the deployment you want to check for differences against. This is a standard HTTP GET request. {% endswagger-description %}
{% swagger-parameter in="path" name="id" type="String" required="true" %} The API key for the Umbraco Cloud public API {% endswagger-parameter %}
{% swagger-parameter in="path" name="olderDeploymentId" type="String" required="true" %} The API key for the Umbraco Cloud public API {% endswagger-parameter %}
{% swagger-parameter in="header" name="Umbraco-Cloud-Api-Key" type="String" required="true" %} The API key for the Umbraco Cloud public API {% endswagger-parameter %}

{% swagger-response status="200: OK" description="Changes are detected and a diff file is downloaded" %}
{% endswagger-response %}
{% swagger-response status="204: No Content" description="No changes are detected and nothing to download" %}
{% endswagger-response %}
{% swagger-response status="404: Not Found" description="ProblemDetails" %}
{% endswagger-response %} 
{% swagger-response status="409: Conflict" description="ProblemDetails" %}
{% endswagger-response %}
{% swagger-response status="40x Status" description="ProblemDetails" %}
For all error responses [see possiple errors](#possible-errors) for a general description.
{% endswagger-response %} 
{% endswagger %}

```sh
# Curl example
url="https://api.cloud.umbraco.com/v1/projects/$projectId/deployments/$olderDeploymentId/diff"
downloadFolder="tmp"
mkdir -p $downloadFolder # ensure folder exists

curl -s -w "%{http_code}" -L -o "$downloadFolder/git-patch.diff" -X GET $url \
    -H "Umbraco-Cloud-Api-Key: $apiKey" \
    -H "Content-Type: application/json"
```

### Cloud Deployment

You will need to call these endpoints to be able to create and complete a deployment trough the CI/CD Flow api.

The order needs to be:
1. [Create Deployment](#create-the-deployment)
2. [Upload src package](#upload-zip-src-file)
3. [Start deployment](#start-deployment)
4. [Get deployment status](#get-deployment-status)

{% swagger method="POST" path="/projects/{id}/deployments" baseUrl="https://api.cloud.umbraco.com/v1" summary="Create the deployment" %} {% swagger-description %}
The Create Deployment endpoint initiates a new deployment and returns a unique `deploymentId`. 
The request body should contain a JSON object with the commit message, see example below.

{%endswagger-description %}

{% swagger-parameter in="path" name="id" type="String" required="true" %} GUID of the project {% endswagger-parameter %}
{% swagger-parameter in="header" name="Content-Type" type="String" required="true" %} application/json {% endswagger-parameter %}
{% swagger-parameter in="header" name="Umbraco-Cloud-Api-Key" type="String" required="true" %} The api key you need to create a deployment {% endswagger-parameter %}
{% swagger-parameter in="body" name="commitMessage" type="String" required="true" %} The commit message you want in the cloud repository for this deployment.

{% endswagger-parameter %}
{% swagger-response status="201: Created" description="Deployment has been created" %}
Part of the returned response will be the actual `deploymentId`. This ID can be stored in the pipeline variables so it can be used in later steps.

```json
{
    "deploymentId": "bc0ebd6f-cef8-4e92-8887-ceb862a83bf0",
    "projectId" : "abcdef12-cef8-4e92-8887-ceb123456789",
    "projectAlias": "",
    "deploymentState": "Created",
    "updateMessage": "",
    "errorMessage": "",
    "created": "2023-05-02T07:16:46.4183912",
    "lastModified": "2023-05-02T07:16:48.8544387",
    "completed": null
}
```
{% endswagger-response %}
{% swagger-response status="400: Bad Request" description="ProblemDetails" %}
{% endswagger-response %}
{% swagger-response status="401: Unauthorized" description="ProblemDetails" %}
{% endswagger-response %}
{% swagger-response status="409: Conflict" description="ProblemDetails" %}
{% endswagger-response %} 
{% swagger-response status="40x Status" description="ProblemDetails" %}
For all error responses [see possiple errors](#possible-errors) for a general description.
{% endswagger-response %} 
{% endswagger %}

Sample of a request body:
```json
{
    "commitMessage": "New dashboard for customer sales numbers"
}
```

{% tabs %}
{% tab title="Powershell" %}
```powershell
...
$url = "https://api.cloud.umbraco.com/v1/projects/$projectId/deployments"
$headers = @{
    "Umbraco-Cloud-Api-Key" = $apiKey
    "Content-Type" = "application/json"
}

$body = @{
    commitMessage = $commitMessage
} | ConvertTo-Json

Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body $body
```
{% endtab %}

{% tab title="Curl" %}
```sh
...
url="https://api.cloud.umbraco.com/v1/projects/$projectId/deployments"

curl -s -X POST $url \
    -H "Umbraco-Cloud-Api-Key: $apiKey" \
    -H "Content-Type: application/json" \
    -d "{\"commitMessage\":\"$commitMessage\"}"
```
{% endtab %}
{% endtabs %}


{% swagger method="POST" path="/projects/{id}/deployments/{deploymentId}/package" baseUrl="https://api.cloud.umbraco.com/v1" summary="Upload zip source file" %} {% swagger-description %} Upload src Package to be deployed for specified deployment id {% endswagger-description %}

{% swagger-parameter in="path" name="id" type="String" required="true" %} GUID of the project {% endswagger-parameter %}

{% swagger-parameter in="path" name="deploymentId" type="String" required="true" %} GUID of the deployment obtained from the [Create the deployment](#create-the-deployment) endpoint {% endswagger-parameter %}

{% swagger-parameter in="header" name="Umbraco-Cloud-Api-Key" type="String" required="true" %} The API key for the Umbraco Cloud public API {% endswagger-parameter %}

{% swagger-parameter in="header" name="Content-Type" type="String" required="true" %} multipart/form-data {% endswagger-parameter %}
{% swagger-parameter in="body" name="file" type="binary" required="true" %}
File must be a zip-file.
File must be uploaded as part of a multipart/form-data request. We recommend to use tools like `curl` or `Invoke-WebRequest` to handle this.  
{% endswagger-parameter %}
{% swagger-response status="202: Accepted" description="Deployment has been created" %}
```json
{
    "deploymentId": "bc0ebd6f-cef8-4e92-8887-ceb862a83bf0",
    "projectId" : "abcdef12-cef8-4e92-8887-ceb123456789",
    "projectAlias": "cicd-demo-site",
    "deploymentState": "Pending",
    "updateMessage":"Project information set\nDeployment pending\nDownloadUri set",
    "errorMessage": "",
    "created": "2023-05-02T07:16:46.4183912",
    "lastModified": "2023-05-02T07:17:48.8544387",
    "completed": null
}
```
{% endswagger-response %}
{% swagger-response status="400: Bad Request" description="ProblemDetails" %}
{% endswagger-response %}
{% swagger-response status="404: Not found" description="ProblemDetails" %}
{% endswagger-response %}
{% swagger-response status="409: Conflict" description="ProblemDetails" %}
{% endswagger-response %}
{% swagger-response status="40x Status" description="ProblemDetails" %}
For all error responses [see possiple errors](#possible-errors) for a general description.
{% endswagger-response %} 
{% endswagger %}

```sh
# Curl example
...
url="https://api.cloud.umbraco.com/v1/projects/$projectId/deployments/$deploymentId/package"

curl -s -X POST $url \
    -H "Umbraco-Cloud-Api-Key: $apiKey" \
    -H "Content-Type: multipart/form-data" \
    --form "file=@$file"
```

### Zip-Package requirements
The deployment content should be packaged as a ZIP file, which must mirror the expected structure of the Umbraco Cloud repository. This ZIP file should include all relevant files such as project and solution files, and compiled frontend code. If your setup includes a frontend project with custom elements, the build artifacts from that project should also be included in the ZIP file, and placed in the appropriate directory within the repository structure.

The ZIP file must be structured the same way as described in the `Readme.md` included in all cloud projects starting from Umbraco 9. This also means if you need to change the name and/or structure of the project, you should follow the guide in the same Readme.

By adhering to these guidelines, you ensure that the uploaded content is an exact match with what is expected in the Umbraco Cloud repository, facilitating a seamless deployment process.

The purpose of packaging your content into a ZIP file is to replace the existing content in the Umbraco Cloud repository upon unpackaging. This ensures that the repository is updated with the latest version of your project files.

Make sure your ZIP archive does not contain .git folder. You should do this by excluding `.git/*` when creating the zip-package. If you're using the `cloud.zipignore` file from the samples, the git-folder is already excluded. 

#### A note about .gitignore

Umbraco Cloud environments are using git internally. This means you should be careful about the `.gitignore` file you add to the package. If you have “git ignored” build js assets locally, you need to handle this so that this is not being ignored in the cloud repository.

**Note:** If the `.gitignore` file within the ZIP package does not exclude bin/ and obj/ directories, these will also be committed to the Umbraco Cloud repository.

**Best Practice:** If you have frontend assets your local repository's .gitignore file will most likely differ from the one intended for the Umbraco Cloud repository, it's advisable to create a separate .cloud\_gitignore file. Include this file in the ZIP package and rename it to .gitignore before packaging. This ensures that only the necessary files and directories are uploaded and finally committed to the Umbraco Cloud repository. *The samples we provide uses this approach.*

{% swagger method="PATCH" path="/projects/{id}/deployments/{deploymentId}" baseUrl="https://api.cloud.umbraco.com/v1" summary="Start Deployment" %} {% swagger-description %} Upload src Package to be deployed for specified deployment id {% endswagger-description %}

{% swagger-parameter in="path" name="id" type="String" required="true" %} GUID of the project {% endswagger-parameter %}
{% swagger-parameter in="path" name="deploymentId" type="String" required="true" %} GUID of the deployment obtained from the [Create the deployment](#create-the-deployment) endpoint {% endswagger-parameter %}

{% swagger-parameter in="header" name="Umbraco-Cloud-Api-Key" type="String" required="true" %} The API key for the Umbraco Cloud public API {% endswagger-parameter %}

{% swagger-parameter in="body" name="deploymentState" type="string" required="true" %} Value must be "Queued". The request body should contain a simple JSON object with the deploymentState, see example below.
 {% endswagger-parameter %}

{% swagger-response status="202: Accepted" description="Deployment has been created" %}
The response of this call will be the same deployment object (in JSON) as when creating a new deployment, but the deploymentState should now be 'Queued':
```json
{
    "deploymentId": "bc0ebd6f-cef8-4e92-8887-ceb862a83bf0",
    "projectId" : "abcdef12-cef8-4e92-8887-ceb123456789",
    "projectAlias": "cicd-demo-site",
    "deploymentState": "Queued",
    "updateMessage": "Project information set\nDeployment pending\nDownloadUri set\nDeployment queued",
    "errorMessage": "",
    "created": "2023-05-02T07:16:46.4183912",
    "lastModified": "2023-05-02T07:18:48.8544387",
    "completed": null
}
```
{% endswagger-response %}
{% swagger-response status="400: Bad Request" description="ProblemDetails" %}
{% endswagger-response %}
{% swagger-response status="404: Not found" description="ProblemDetails" %}
{% endswagger-response %}
{% swagger-response status="409: Conflict" description="ProblemDetails" %}
{% endswagger-response %} 
{% swagger-response status="40x Status" description="ProblemDetails" %}
For all error responses [see possiple errors](#possible-errors) for a general description.
{% endswagger-response %} 
{% endswagger %}

Sample of a request body:
```json

{
  "deploymentState": "Queued"
}
```

Invoke endpoint with curl:

```sh
#Curl example
...
url="https://api.cloud.umbraco.com/v1/projects/$projectId/deployments/$deploymentId"

curl -s -X PATCH $url \
    -H "Umbraco-Cloud-Api-Key: $apiKey" \
    -H "Content-Type: application/json" \
    -d "{\"deploymentState\": \"Queued\"}"
```

{% swagger method="GET" path="/projects/{id}/deployments/{deploymentId}" baseUrl="https://api.cloud.umbraco.com/v1" summary="Get Deployment status" %} {% swagger-description %} 
To monitor the status of a deployment—whether it's completed, successful, or otherwise — you can periodically query the 'Get Deployment Status' API. This API endpoint is an HTTP GET request to the Umbraco Cloud API, and it requires both the `projectId` and the `deploymentId` obtained from previous steps to be included in the path.

Deployments in Umbraco services can take varying amounts of time to complete. Therefore, it's advisable to poll this API at regular intervals to stay updated on the deployment's current state. For example, in a simple project, you might choose to poll the API every 15 seconds for a duration of 15 minutes. These figures are just a starting point; the optimal polling frequency and duration may differ for your specific pipeline. Based on initial experience, a 15-minute window generally suffices, but we welcome your feedback to fine-tune these parameters.
 {% endswagger-description %}

{% swagger-parameter in="path" name="id" type="String" required="true" %} GUID of the project {% endswagger-parameter %}
{% swagger-parameter in="path" name="deploymentId" type="String" required="true" %} GUID of the deployment obtained from the [Create the deployment](#create-the-deployment) endpoint {% endswagger-parameter %}

{% swagger-parameter in="header" name="Umbraco-Cloud-Api-Key" type="String" required="true" %} The API key for the Umbraco Cloud public API {% endswagger-parameter %}
{% swagger-parameter in="header" name="Content-Type" type="String" required="true" %} application/json {% endswagger-parameter %}

{% swagger-response status="200: OK" description="" %}
The response from this API call will return the same deployment object in JSON format as you would receive from other API interactions. Ultimately, the `deploymentState` field will indicate either 'Completed' or 'Failed'. Should the deployment fail, the 'ErrorMessage' field will provide additional details regarding the issue.
```json
{
    "deploymentId": "bc0ebd6f-cef8-4e92-8887-ceb862a83bf0",
    "projectId" : "abcdef12-cef8-4e92-8887-ceb123456789",
    "projectAlias": "cicd-demo-site",
    "deploymentState": "Completed",
    "updateMessage":"Project information set\nDeployment pending\nDownloadUri set\nDeployment queued\nDeployment triggered\nDeployment started\nCheck blocking markers\nCreate updating marker\nGit Clone\nDownload update\nExtract Update\nChecking versions\nDeleting repository files\nCopying files to repository\nNuGet Restore\nDotnet Build\nGit Stage\nGit Commit\nGit Tag\nGit Push\nDelete updating marker\nDeployment successful",
    "errorMessage": "",
    "created": "2023-05-02T07:16:46.4183912",
    "lastModified": "2023-05-02T07:20:48.8544387",
    "completed": "2023-05-02T07:20:49.8544387"
}
```
{% endswagger-response %}
{% swagger-response status="404: Not found" description="ProblemDetails" %}
For all error responses [see possiple errors](#possible-errors) for a general description.
{% endswagger-response %} {% endswagger %}


```sh
#Curl example
...
url="https://api.cloud.umbraco.com/v1/projects/$projectId/deployments/$deploymentId"

curl -s -X GET $url \
  -H "Umbraco-Cloud-Api-Key: $apiKey" \
  -H "Content-Type: application/json"
```

### Promote Deployment

Currently, the feature to transition from a development environment to staging or live, and from staging to live, is pending implementation. In the meantime, you can manage these transitions manually through the [Umbraco Cloud Portal](https://www.s1.umbraco.io/projects).


## Possible errors

When interacting with the Umbraco Cloud API, you may encounter various HTTP status codes that indicate the success or failure of your API request. Below is a table summarizing the possible status codes, their corresponding errors, and basic root causes to guide your troubleshooting:

| Status Code | Error               | Basic Root Cause                                                                    |
| ----------- | ------------------- | ----------------------------------------------------------------------------------- |
| 400         | BadRequest          | Check the requested path, supplied headers and query-parameters                     |
| 401         | Unauthorized        | Check the Project Id and Api Key                                                    |
| 404         | NotFound            | Usually related to the supplied deploymentId in path not being found                |
| 409         | Conflict            | The state of the referenced deployment is not ready for the work you are requesting |
| 500         | InternalServerError | InternalServerError                                                                 |

### ProblemDetails model
Most errors have a response body that corresponds to this JSON, and the “detail” field will have a more complete error message.

```json
{
  “title”: string,
  “status”: number,
  “detail”: string
}
```

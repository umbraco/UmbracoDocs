# Cloud API For CI/CD Flow v2

For the v2 endpoints we want to give you even more control over the process. You can target more environments and you have more options when starting a deployment. 
We have tried to simplified the api calling process: Upload your artifact, and when you're ready to run the deployment you now need to reference the uploaded artifact.
The big change here is that the artifact is not connected to a deployment before the api is invoked with a reference to an artifact to deploy.

## Getting started

To integrate Umbraco Cloud into your CI/CD pipeline, you'll need to make API calls to the following endpoint [`https://api.cloud.umbraco.com`](https://api.cloud.umbraco.com):

Path for artifacts
* `/v2/projects/$projectId/deployments/artifacts`

Path for deployments
* `/v2/projects/$projectId/deployments`
* `/v2/projects/$projectId/deployments/$deploymentId`
* `/v2/projects/$projectId/deployments/$latestCompletedDeploymentId/diff`

You will find relevant examples using `HTTP Request Syntax` in the sections below.

### How to enable CI/CD Integrator in the Umbraco Cloud Portal

To authenticate with the Umbraco Cloud API, you'll need your Project ID and API Key. These credentials can be found under **Configuration > Advanced** in the Umbraco Cloud portal.

![Umbraco CI/CD Flow](../../images/Advanced-Section.png)

The two elements to be used for the authentication are:

* **Cloud Project ID**: The ID of your Umbraco project.
* **CI/CD API Key**: Your unique identifier.

By including the API key header in your HTTP requests, you ensure secure access to your Umbraco Cloud project's resources.

For enhanced security, it's crucial to store the provided API key in a secure location. Options include a variable group in Azure DevOps or using the Secrets feature in GitHub Actions. 
It's important to note that each API key is tightly coupled with a specific Umbraco Cloud project and can only be used for deployments related to that project.

### How to authenticate your requests

To authenticate your API requests you'll need to include your API key in a custom HTTP header named Umbraco-Cloud-Api-Key. 

{% tabs %}
{% tab title="HTTP Request Syntax" %}
```http
GET https://api.cloud.umbraco.com/v2/projects/{{projectId}}/deployments  
Umbraco-Cloud-Api-Key = {{apiKey}}
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

## How to upload artifacts

### Upload artifact

The process of uploading an artifact is tied to a project. The uploaded artifact is will be available to use in any deployment.
The artifact need to be a zip-file with source code needed to build your website.
TODO link to best practice for packing artifacts. 

{% tabs %}
{% tab title="HTTP Request Syntax" %}
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
{% endtab %}
{% endtabs %}

Once the file is uploaded you will get a response which follows the following JSON schema: 

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
List artifacts uploaded related to a project. The endpoint is paged and accepts the options skip and take. 
If skip is not supplied its value will default to 0. 
If take is not supplied its value will default to 10.

{% tabs %}
{% tab title="HTTP Request Syntax" %}
```http
@skip = 0
@take = 10
@projectId = Get this value from the portal
@apiKey = Get this value from the portal

GET https://api.cloud.umbraco.com/v2/projects/{{projectId}}/deployments/artifacts?skip={{skip}}&take={{take}}
Umbraco-Cloud-Api-Key: {{apiKey}}
Content-Type: application/json
```
{% endtab %}
{% endtabs %}

## How to make a deployment to Umbraco Cloud using the Umbraco CI/CD API

### Start the deployment

The Create Deployment endpoint start a new deployment and returns a unique `deploymentId`. 

Some new options are available to use in the request payload:
- `artifactId` *REQUIRED* Points to the artifact you want to deploy
- `targetEnvironmentAlias` *REQUIRED* Points to the environment you want to deploy to
- `commitMessage` *OPTIONAL* The commit message you want stamped in the environment repository on Umbraco Cloud.
- `noBuildAndRestore` *OPTIONAL* Set to true it will skip the restore and build in the isolated instance, default to false

```http
POST https://api.cloud.umbraco.com/v2/projects/{{projectId}}/deployments
Umbraco-Cloud-Api-Key: {{apiKey}}
Content-Type: application/json

{
    "commitMessage": "My awesome commit",
    "artifactId": "bc0ebd6f-cef8-4e92-8887-ceb862a83bf0",
    "targetEnvironmentAlias": "Development",
    "noBuildAndRestore": true
}
```

Part of the returned response will be the actual `deploymentId`. The response from the API should be an HTTP 201 Created response including a `deploymentId`. This ID can be stored in the pipeline variables so it can be used in later steps.

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

### Get Deployment status

To monitor the status of a deployment—whether it's completed, successful, or otherwise — you can periodically query the 'Get Deployment Status' API. This API endpoint is an HTTP GET request to the Umbraco Cloud API, and it requires both the `projectId` and the `deploymentId` obtained from previous steps to be included in the path.

Deployments in Umbraco services can take varying amounts of time to complete. Therefore, it's advisable to poll this API at regular intervals to stay updated on the deployment's current state. For example, in a simple project, you might choose to poll the API every 15 seconds for a duration of 15 minutes. These figures are just a starting point; the optimal polling frequency and duration may differ for your specific pipeline. Based on initial experience, a 15-minute window generally suffices, but we welcome your feedback to fine-tune these parameters.

Using a curl command, polling for the deployment status would look like this:

```http
...
url="https://api.cloud.umbraco.com/v1/projects/$projectId/deployments/$deploymentId"

# Define a function to call API and check the status
function call_api {
  response=$(curl -s -X GET $url \
    -H "Umbraco-Cloud-Api-Key: $apiKey" \
    -H "Content-Type: application/json")
  echo "$response"
  status=$(echo $response | jq -r '.deploymentState')
}

# Call API and check status
call_api
while [[ $status == "Pending" || $status == "InProgress" || $status == "Queued" ]]; do
  echo "Status is $status, waiting 15 seconds..."
  sleep 15
  call_api
  if [[ $SECONDS -gt 900 ]]; then
    echo "Timeout reached, exiting loop."
    break
  fi
done

# Check final status
if [[ $status == "Completed" ]]; then
  echo "Deployment completed successfully."
elif [[ $status == "Failed" ]]; then
  echo "Deployment failed."
  exit 1
else
  echo "Unexpected status: $status"
  exit 1
fi

```

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

### Get Deployments

The endpoint lets you retrieve a list of completed deployments. It can only list deployments that has been run through the api.

The API allows you to filter and limit the number of returned deployments using query parameters:

* _Skip_ : optional, zero or positive integer
* _Take_ : optional, zero or positive integer
* _Includenulldeployments_ : optional, boolean, defaults to true

The "skip" and "take" parameters, while optional, are always required to be used together.

With `includenulldeployments` set to true, you will get all completed deployments, including those that did not create any new changes in the cloud repository.

To fetch the list of deployments using a curl command, the syntax would be as follows:

```sh
...
url="https://api.cloud.umbraco.com/v1/projects/$projectId/deployments?skip=0&take=1&includenulldeployments=false"

response=$(curl -s -X GET $url \
    -H "Umbraco-Cloud-Api-Key: $apiKey" \
    -H "Content-Type: application/json")
latestDeploymentId=$(echo $response | jq -r '.deployments[0].deploymentId')

```

The response from this API call will return an object containing a list of deployment objects. The deployment-objects are consistent with the structure used in other API responses. Deployments are listed in descending order based on their creation timestamp.

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

### Get Deployment diff

Sometimes updates are done directly on the Umbraco Cloud repository. We encourage you to not do any actual work there, but auto-upgrades and environment changes will affect the umbraco-cloud-git-repos. To keep track of such changes, you can use the 'Get Deployment Diff' API. This API endpoint will provide you with a git-patch file detailing the changes between a specific deployment and the current state of the repository. To make this API call, you'll need to include both the `projectId` and the `deploymentId` of the deployment you want to check for differences against. This is a standard HTTP GET request.

Using a curl command, fetching the potential differences would look like this:

```sh
url="https://api.cloud.umbraco.com/v1/projects/$projectId/deployments/$latestCompletedDeploymentId/diff"
downloadFolder="tmp"
mkdir -p $downloadFolder # ensure folder exists

responseCode=$(curl -s -w "%{http_code}" -L -o "$downloadFolder/git-patch.diff" -X GET $url \
    -H "Umbraco-Cloud-Api-Key: $apiKey" \
    -H "Content-Type: application/json")

if [[ 10#$responseCode -eq 204 ]]; then # Http 204 No Content means that there are no changes
  echo "No changes"
  rm -fr $downloadFolder/git-patch.diff
elif [[ 10#$responseCode -eq 200 ]]; then # Http 200 downloads the file and set a few variables for pipeline
  echo "Changes - check file - $downloadFolder/git-patch.diff"
else
  echo "Unexpected status: $responseCode"
  exit 1
fi

```

The API response will vary based on whether or not there are changes to report. If no changes are detected, you'll receive an HTTP 204 No Content status. On the other hand, if there are changes, the API will return an HTTP 200 OK status along with a git-patch file as the content. This git-patch file can then be applied to your local repository to sync it with the changes.

### Possible errors

When interacting with the Umbraco Cloud API, you may encounter various HTTP status codes that indicate the success or failure of your API request. Below is a table summarizing the possible status codes, their corresponding errors, and basic root causes to guide your troubleshooting:

| Status Code | Error               | Basic Root Cause                                                                    |
| ----------- | ------------------- | ----------------------------------------------------------------------------------- |
| 400         | BadRequest          | Check the requested path, supplied headers and query-parameters                     |
| 401         | Unauthorized        | Check the Project Id and Api Key                                                    |
| 404         | NotFound            | Usually related to the supplied deploymentId in path not being found                |
| 409         | Conflict            | The state of the referenced deployment is not ready for the work you are requesting |
| 500         | InternalServerError | InternalServerError                                                                 |

Most errors have a response body that corresponds to this JSON, and the “detail” field will have a more complete error message.

```
{
  “title”: string,
  “status”: number,
  “detail”: string,
}
```

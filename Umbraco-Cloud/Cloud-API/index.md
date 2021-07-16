---
versionFrom: 7.0.0
meta.Title: "Public Umbraco Cloud REST API"
meta.Description: "A guide to using the public Umbraco Cloud REST API"
---

# Public Umbraco Cloud REST API

Umbraco Cloud has a REST API that you can use to automatically create new projects. This can come in really handy if you are going to create a lot of projects within a short period of time or if you want to automate project creation or team management.

:::note
Do note that the /create endpoint can only be used for creating <b>v7</b> projects.

It's currently not possible to create Heartcore or Uno projects using the Cloud API.
:::

In this article you'll learn how to setup Umbraco Cloud projects using the REST API, and also how to invite and add users to these projects.

## Authentication

In order to start using the API you will need to have a **valid access token**. The token will be used in the **HTTP Authorization header** that you need to send along with every request you make to the API. Please contact our support about how to acquire a token, either through the chat on [Umbraco.io](https://www.s1.umbraco.io) or through contact@umbraco.com.

The scheme we use is called `token` and it's constructed by combining the email you are using with Umbraco.io and the provided token with a colon:

    user-email@example.com:6a5b0c687b7973db4b2568a59f2c446ee1ee9f9f06322f1bd6983718a48b5a6c

This then needs to be `base64` encoded (encoding should be UTF8):

    dXNlci1lbWFpbEBleGFtcGxlLmNvbTo2YTViMGM2ODdiNzk3M2RiNGIyNTY4YTU5ZjJjNDQ2ZWUxZWU5ZjlmMDYzMjJmMWJkNjk4MzcxOGE0OGI1YTZj

The resulting header should look like this:

    Authorization: token dXNlci1lbWFpbEBleGFtcGxlLmNvbTo2YTViMGM2ODdiNzk3M2RiNGIyNTY4YTU5ZjJjNDQ2ZWUxZWU5ZjlmMDYzMjJmMWJkNjk4MzcxOGE0OGI1YTZj

## Project endpoints

### Create project

The following endpoint should be used for creating new projects on Umbraco Cloud:

    POST https://www.s1.umbraco.io/api/public/project/create

**BEWARE** that this endpoint is subject to throttling; you can only create x number of projects every x number of minutes (the actual numbers can vary but will be written in the HTTP message). If you get an HTTP status code of `409 (Conflict)` it means that you are being throttled.

To use this endpoint, make a request like this:

**Request**

    POST https://www.s1.umbraco.io/api/public/project/create
    Authorization: token dXNlci1lbWFpbEBleGFtcGxlLmNvbTo2YTViMGM2ODdiNzk3M2RiNGIyNTY4YTU5ZjJjNDQ2ZWUxZWU5ZjlmMDYzMjJmMWJkNjk4MzcxOGE0OGI1YTZj
    Content-Type: application/json

    {
        "projectName": "Name of the project", // Required
        "plan": "Single", // Required. Options are: "Single, Standard or Studio". Plan names are case sensitive.
        "ownerId": "c5821a98-ce88-4796-be90-e29f0a05fa39", // Optional. Can be a GUID of an organization or an email. If nothing is provided the owner becomes the user the token is associated with
        "baselineAlias": "an-alias-of-a-baseline" // Optional. If the project needs to be a child, then you can provide the alias of the baseline
    }
    
:::note
You'll notice the "plan" parameter takes either "Single", "Standard" or "Studio" as valid options. The terminology used for these plans has since changed for the "Single" and "Studio" plans. "Single" will create a "Starter" plan whereas "Studio" a "Professional" one.
:::

If everything went as expected, the endpoint will return a `HTTP 200` status code and a JSON object that looks like this:

**Response**

```json
{
    "url": "https://www.s1.umbraco.io/project/alias-of-the-project,
    "alias": "alias-of-the-project",
    "projectId: "2af1dc0e-a454-4956-ba26-59036ac4bb99",
    "projectIsReady": false,
    "creationStatus": "Creating",
    "creationStatusEndpoint": "https://www.s1.umbraco.io/api/public/project/creationstatus"
}
```

Because the creation of a project happens asynchronously we are providing you with another endpoint for checking the status of the creation (the creationStatusEndpoint listed in the above object) if you need to know when it is done. Read more about this endpoint below.

### Project creating status

The following endpoint is used to check the status of a project creation:

    POST https://www.s1.umbraco.io/api/public/project/creationstatus

The project id needs to passed along as a HTTP header called `X-Project-Id` - e.g. `X-Project-Id: 2af1dc0e-a454-4956-ba26-59036ac4bb99`

**Request**

    POST https://www.s1.umbraco.io/api/public/project/creationstatus
    Authorization: token dXNlci1lbWFpbEBleGFtcGxlLmNvbTo2YTViMGM2ODdiNzk3M2RiNGIyNTY4YTU5ZjJjNDQ2ZWUxZWU5ZjlmMDYzMjJmMWJkNjk4MzcxOGE0OGI1YTZj
    X-Project-Id: 2af1dc0e-a454-4956-ba26-59036ac4bb99
    Content-Type: application/json

The request above will return a JSON object with a `creationStatus` which will tell you whether a project is created or still in the process of being created.

In the example below the project creation is still under-way:

**Response**

```json
{
    "projectIsReady": false,
    "creationStatus": "Creating",
    "creationStatusEndpoint": "https://www.s1.umbraco.io/api/public/project/creationstatus",
    "backofficeUrl": ""
    "environments": null
}
```

You should keep polling this until the `creationStatus` changes to "Created" (or `projectIsReady=true`). The `backofficeUrl` will also be filled with the correct url to the backoffice once the project has been created.

Here's how a responce for a created project would loo like:

```json
{
    "projectIsReady": true,
    "creationStatus": "Created",
    "creationStatusEndpoint": "https://www.s1.umbraco.io/api/public/project/creationstatus",
    "backofficeUrl": "https://alias-of-the-project.s1.umbraco.io/umbraco/#/?dashboard=starter",
    "environments": [
        {
            "environmentType": "Development",
            "environmentId": "8027b915-425c-4e23-a7b2-ee1eb4e895f4",
            "backofficeUrl": "https://alias-of-the-project.s1.umbraco.io/umbraco/"
        },
        {
            "environmentType": "Live",
            "environmentId": "0d4b0677-5a0d-4460-8f1e-24d6678ad188",
            "backofficeUrl": "https://alias-of-the-project.s1.umbraco.io/umbraco/"
        }
    ]
}
```


### Invite to project

The following endpoint is used for inviting users to a project.

    POST https://www.s1.umbraco.io/api/public/project/invite

If the user is a new user we will create the user and send an activation email to the provided email and then add the project to the users overview. If the user is an existing user they will get an email telling them that they have been invited to the project.

**Request**

    POST https://www.s1.umbraco.io/api/public/project/invite
    Authorization: token dXNlci1lbWFpbEBleGFtcGxlLmNvbTo2YTViMGM2ODdiNzk3M2RiNGIyNTY4YTU5ZjJjNDQ2ZWUxZWU5ZjlmMDYzMjJmMWJkNjk4MzcxOGE0OGI1YTZj
    X-Project-Id: 2af1dc0e-a454-4956-ba26-59036ac4bb99
    Content-Type: application/json

    {
        "email": "user-email@example.com", // Required
        "name": "The users name", // Required
        "isAdmin": false, // Optional
        "title": "A title that goes into the title of the mail sent to the user", // Optional
        "message": "A message that goes into the message of the mail sent to the user" // Optional
    }

This will return an appropriate HTTP status code and a JSON object like this:

**Response**

```json
{
    "message": "An invitation to collaborate on 'Project Name' has been sent to 'user-email@example.com'"
}
```

## User endpoints

### Create a user

The following endpoint is used for creating a user on Umbraco.io, and not necessarily add them to a project right away.

    POST https://www.s1.umbraco.io/api/public/user/create

**Request**

    POST https://www.s1.umbraco.io/api/public/user/create
    Authorization: token dXNlci1lbWFpbEBleGFtcGxlLmNvbTo2YTViMGM2ODdiNzk3M2RiNGIyNTY4YTU5ZjJjNDQ2ZWUxZWU5ZjlmMDYzMjJmMWJkNjk4MzcxOGE0OGI1YTZj
    Content-Type: application/json

    {
        "email": "user-email@example.com", // Required
        "name": "The users name", // Required
        "password": "dontReuseOrRecycleYourPassword" // Required
    }

This will return an appropriate HTTP status code and a JSON object like this:

**Response**

```json
{
    "message": "User created"
}
```

---

## Console application example

This is a (very crude) example of how the API could be used from a C# Console application. It creates a project, checks the status of the creation and when it is ready, lets you invite a user to the project:

```csharp
using System;
using System.Dynamic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading;
using Newtonsoft.Json;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Token:");
            var token = Console.ReadLine();

            var client = new HttpClient();
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("token", token);

            Console.WriteLine("Project Name:");
            var projectName = Console.ReadLine();

            Console.WriteLine("Plan:");
            var plan = Console.ReadLine();

            Console.WriteLine("BaselineAlias:");
            var baselineAlias = Console.ReadLine();

            var createdProject = MakeRequest(client, "https://www.s1.umbraco.io/api/public/project/create", null, new { projectName, plan, baselineAlias});
            if (createdProject.creationStatus == "Creating")
            {
                Console.WriteLine("Project was initiated for creation. Start checking status.");
                var status = string.Empty;
                var finishedCreating = false;
                do
                {
                    Thread.Sleep(1000);
                    var creationStatus = MakeRequest(client, createdProject.creationStatusEndpoint, createdProject.projectId);
                    finishedCreating = creationStatus.projectIsReady;
                    status = creationStatus.creationStatus.ToString();
                    Console.WriteLine($"CreationStatus checked. ProjectIsReady: {finishedCreating}, CreationStatus: {status}.");
                } while (finishedCreating == false);
            }

            Console.WriteLine("Project creation via API done");
            Console.WriteLine("");
            Console.WriteLine("Invite user to the project");

            Console.WriteLine("Email:");
            var email = Console.ReadLine();

            Console.WriteLine("Name:");
            var name = Console.ReadLine();

            var inviteUserStatus = MakeRequest(client, "https://www.s1.umbraco.io/api/public/project/invite", createdProject.projectId, new { email, name});
            Console.WriteLine(inviteUserStatus.message.ToString());
            Console.ReadLine();
        }

        private static dynamic MakeRequest(HttpClient client, string endpoint, string projectId = null, object content = null)
        {
            var message = new HttpRequestMessage(HttpMethod.Post, endpoint);
            if (projectId != null)
                message.Headers.Add("X-Project-Id", projectId);
            if (content != null)
                message.Content = new StringContent(
                    JsonConvert.SerializeObject(content),
                    Encoding.UTF8,
                    "application/json"
                );
            var response = client.SendAsync(message).Result;
            if (response.IsSuccessStatusCode)
                return JsonConvert.DeserializeObject(response.Content.ReadAsStringAsync().Result);

            throw new Exception(response.Content.ReadAsStringAsync().Result);
        }
    }
}
```

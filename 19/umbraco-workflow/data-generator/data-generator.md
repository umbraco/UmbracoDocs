# Data Generator

The Umbraco Workflow DataGenerator tool is an extension package for quickly generating Umbraco users and Workflow approval groups and permissions.

The generator gets you up and running for testing or product evaluation without having to manually create any Workflow configuration.

## Installation

{% hint style="info" %}
The package should only be used in testing or product evaluation environments.
{% endhint %}

To install the Umbraco Workflow DataGenerator package (Umbraco.Workflow.DataGenerator), follow these steps:
1. Update appSettings.development.json to enable the Workflow test license. This removes limits on group creation, and enables all features:

```
{
  ...
  "Umbraco": {
    "Workflow": {
        "EnableTestLicense": true
    }
  }
}
```

2. Run the following command to add the required package references to your Umbraco project:

```
dotnet add package Umbraco.Workflow // if not already installed
dotnet add package Umbraco.Workflow.DataGenerator
```

3. Restart the web application using the following command:

```
dotnet run
```

When the application restarts, it will automatically install [The Starter Kit](https://docs.umbraco.com/umbraco-cms/tutorials/starter-kit).

## Getting started

The package adds new API endpoints for creating and removing Workflow configuration. There is no Backoffice interface, instead the API should be accessed via Swagger.

The package makes use of Umbraco's Delivery API configuration, to configure an API key in the request headers. Note in the configuration example below `PublicAccess` is disabled. If an API key is not provided, the API will return a 401 Unauthorized response.

```
{
   "Umbraco": {
      "Cms": {
         "DeliveryApi": {
            "Enabled": true,
            "PublicAccess": false,
            "ApiKey": "workflow"
         }
      }
   }
}
```

## Usage
1. Run the application and navigate to `/umbraco/swagger/`
2. Select the `Umbraco Workflow Data Generator API` definition in the dropdown.
3. Click on the `POST /umbraco/workflow/data-generator/api/v1/generator` endpoint.
4. Click on `Try it out!` and set the parameters for the endpoint before executing.
5. The endpoint will now generate the specified number of groups, users and relate configuration as a background task.
   - To see the current generation status, use the `GET /umbraco/workflow/data-generator/api/v1/generator/status` endpoint.
6. Go to the Umbraco backoffice and navigate to the `Workflow` section, and click on `Approval Groups` to verify the new groups have been created.

The available settings are explained below.

* **Number of approval groups** - determines how many Workflow approval groups will be created. Defaults to two.
* **Number of users** - determines how many Umbraco users will be created. Defaults to two.
* **Number of groups per workflow** - determines how the created groups are allocated into the generated workflows. Defaults to 0, which allocates a random number of groups to each workflow.
* **Number of users per group** - determines how the created users are allocated into the generated workflow approval groups. Defaults to 0, which allocates a random number of users to each approval group.

Groups and users are created with arbitrary names, feel free to rename these to suit.

### Reset

Once Workflow configuration has been updated, the environment must be reset before regenerating. Resetting cancels all active workflows and deletes all workflow configuration. Umbraco users are not deleted, but will be reused in future data generation actions.

# Adding server-side data to a property editor

## Overview

In this tutorial, we will add a server-side API controller, which will query a custom table in the Umbraco database. It will then return the data to an angular controller + view.

The result will be a person-list, populated from a custom table. When clicked it will store the ID of the selected person.

## Setup the database

The first thing we need is some data; below is an SQL Script for creating a `people` table with some random data in it. You could also use [https://generatedata.com](https://generatedata.com) for larger amounts of data:

```sql
CREATE TABLE people (
    id INTEGER NOT NULL IDENTITY(1, 1),
    name VARCHAR(255) NULL,
    town VARCHAR(255) NULL,
    country VARCHAR(100) NULL,
    PRIMARY KEY (id)
);
GO

INSERT INTO people(name,town,country) VALUES('Myles A. Pearson','Tailles','United Kingdom');
INSERT INTO people(name,town,country) VALUES('Cora Y. Kelly','Froidchapelle','Latvia');
INSERT INTO people(name,town,country) VALUES('Brooke Baxter','Mogi das Cruzes','Grenada');
INSERT INTO people(name,town,country) VALUES('Illiana T. Strong','Bevel','Bhutan');
INSERT INTO people(name,town,country) VALUES('Kaye Frederick','Rothesay','Turkmenistan');
INSERT INTO people(name,town,country) VALUES('Erasmus Camacho','Sint-Pieters-Kapelle','Saint Vincent and The Grenadines');
INSERT INTO people(name,town,country) VALUES('Aimee Sampson','Hawera','Antigua and Barbuda');`
```

## Setup ApiController routes

Next, we need to define an `ApiController` to expose a server-side route that our application will use to fetch the data.

For this, you can create a new class at the root of the project called `PersonApiController.cs`

In the `PersonApiController.cs` file, add:

```csharp
    using Umbraco.Cms.Web.BackOffice.Controllers;
    using Umbraco.Cms.Web.Common.Attributes;
    using Umbraco.Cms.Infrastructure.Scoping;



    namespace YourProjectName;
    [PluginController("My")]
    public class PersonApiController : UmbracoAuthorizedJsonController
    {
        // we will add a method here later
    }
```

This is a basic API controller that inherits from `UmbracoAuthorizedJsonController`. This specific class will only return JSON data and only to requests that are authorized to access the backoffice.

## Setup the GetAll() method

Now that we have a controller, we need to create a method, which can return a collection of people, which our editor will use.

So first of all, we add a `Person` class to the `My.Controllers` namespace:

```csharp
public class Person
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Town { get; set; }
    public string Country { get; set; }
}
```

We will use this class to map our table data to a C# class, which we can return as JSON later.

Now we need the `GetAll()` method which returns a collection of people, insert this inside the `PersonApiController` class:

```csharp
public IEnumerable<Person> GetAll()
{

}
```

Inside the `GetAll()` method, we write a bit of code. The code connects to the database, creates a query, and returns the data, mapped to the `Person` class above:

```csharp
private readonly IScopeProvider scopeProvider;


public PersonApiController(IScopeProvider scopeProvider)
{
    this.scopeProvider = scopeProvider;
}

public IEnumerable<Person> GetAll()
{
    using (var scope = scopeProvider.CreateScope(autoComplete: true))
    {
        // build a query to select everything the people table
        var sql = scope.SqlContext.Sql().Select("*").From("people");

        // fetch data from the database with the query and map to the Person class
        return scope.Database.Fetch<Person>(sql);
    }
}
```

We are now done with the server side of things, with the file saved you can now open the URL: `/umbraco/backoffice/My/PersonApi/GetAll`.

This will return our JSON data.

## Create a Person Resource

Now that we have the server side in place and a URL to call, we will set up a service to retrieve our data. As an Umbraco-specific convention, we call these services a _resource_, so we always indicate what services fetch data from the DB.

Create a new file as `person.resource.js` and add:

```javascript
// adds the resource to umbraco.resources module:
angular.module('umbraco.resources').factory('personResource',
    function($q, $http, umbRequestHelper) {
        // the factory object returned
        return {
            // this calls the ApiController we setup earlier
            getAll: function () {
            return umbRequestHelper.resourcePromise(
                $http.get("backoffice/My/PersonApi/GetAll"),
            "Failed to retrieve all Person data");
            }
        };
    }
);
```

This uses the standard angular factory pattern, so we can now inject this into any of our controllers under the name `personResource`.

The `getAll()` method returns a promise from an `$http.get` call, which handles calling the URL, and will return the data when it's ready. You'll notice that the `$http.get` method is wrapped inside `umbRequestHelper.resourcePromise`, the `umbRequestHelper.resourcePromise` will automatically handle any 500 errors for you which is why the 2nd string parameter is there - it defines the error message displayed.

## Create the view and controller

We will now finally set up a new view and controller, which follows previous tutorials, so you can refer to those for more details:

### The view

```html
<div ng-controller="My.PersonPickerController">
    <ul>
        <li ng-repeat="person in people">
            <a href ng-click="model.value = person.Name">{{person.Name}}</a>
        </li>
    </ul>
</div>
```

#### The controller

```javascript
angular.module("umbraco")
    .controller("My.PersonPickerController", function($scope, personResource){
        personResource.getAll().then(function(response){
            $scope.people = response.data;
        });
    });
```

## The flow

So with all these bits in place, all you need to do is register the property editor in a package.manifest - have a look at the first tutorial in this series. You will need to tell the package to load both your `personpicker.controller.js` and the `person.resource.js` file on app start.

With this, the entire flow is:

1. The view renders a list of people with a controller
2. The controller asks the personResource for data
3. The personResource returns a Promise and asks the my/PersonAPI ApiController
4. The ApiController queries the database, which returns the data as strongly typed Person objects
5. The ApiController returns those `Person` objects as JSON to the resource
6. The resource resolves the Promise
7. The controller populates the view

There is a good amount of things to keep track of, but each component is tiny and flexible.

## Wrap-up

The important part of the above is the way you create an `ApiController` call to the database for your own data. And finally, expose the data to angular as a service using `$http`.

For simplicity, you could have skipped the service part and called `$http` directly in your controller. However, having your data in services it becomes a reusable resource for your entire application.

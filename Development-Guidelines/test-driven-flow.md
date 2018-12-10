# Working with the backoffice UI AngularJS project 

_This document tries to outline what is required to have a test-driven setup for
angular development in Umbraco 7. It goes through the setup process as well as how
to add new services that require mocking as well as how to use gulp to run tests automatically_

## Setup
Make sure to have all the node dependencies in order when you start, these are updated regularly in case we need to go to a new version of a dependency, or new dependencies are added.

Simply open a terminal / cmd in the Umbraco.Web.UI.Client folder and run:

	npm install

This should setup the entire gulp, Karma and jsint set up we use for tests and pruning.

## Automated testing
To start working on the client files, and have them automatically built and merged into the client project, as well as the VS project, simply run the command

	gulp dev

This will start a webserver on :8080 and tell Karma to run tests every time a .js or .less file is changed. 
After linting and tests have passed, all the client files are copied to umbraco.web.ui/umbraco folder, so it also keeps the server project up to date on any client changes. This should all happen in the background.

## Adding a new service
The process for adding or modifying a service should always be based on passed tests. So if we need to change the footprint of the contentservice, and the way any controller calls this service, we need to make sure the tests pass with our mocked services.

This ensures 3 things: 
- we test our controllers
- we test our services
- we always have mocked data available, if you want to run the client without IIS


### Example: 
We add a service for fetching macros from the database, the initial implementation of this service should happen in `/src/common/resources/macro.resource.js`

The macro.resource.js calls `$http` as normal, but no server implementation should be needed at this point.

Next, we describe how the rest service should return data, this is done in /common/mocks/umbraco.httpbackend.js, where we can define what data a certain url
would return. 

So in the case of getting tree items we define:

```javascript
$httpBackend
	.whenGET( urlRegex('/umbraco/UmbracoTrees/ApplicationTreeApi/GetApplicationTrees') )
	.respond(returnApplicationTrees);
```

The `returnApplicationTrees` function then looks like this: 

```javascript
function returnApplicationTrees(status, data, headers){
	var app = getParameterByName(data, "application");
	var tree = _backendData.tree.getApplication(app);
	return [200, tree, null];
}
```

It returns an array of 3 items, the http status code, the expected data and finally, it can return a collection of http headers.

```javascript
_backendData.tree.getApplication(app);
```

Refers to a helper method in `umbraco.httpbackend.helper.js` which contains all the helper methods we use to return static json. 

### In short
So to add a service, which requires data from the server we should:

- add the .service.js as normal
- add the .resource.js as normal
- call $http as normal
- define the response data in umbraco.httpbackend.helper.js
- define the url in umbraco.httpbackend.js

### ServerVariables
There is a static servervariables file in /mocks which describes the urls used by the rest service, this is currently needed as we don't have this set as an angular service, and no real conventions for these urls yet. Longer-term it would be great to have a urlBuilder which could do

```javascript
urlService.url("contentTypes", "GetAllowedChildren");
// would return /<umbracodir>/<apibaseDir>/contentyTypes/getAllowedChildren
```

But for now, they are set in the servervariables file.	
=======
# Working with the backoffice UI AngularJS project 

_This document tries to outline what is required to have a test-driven setup for
angular development in Umbraco 7. It goes through the setup process as well as how
to add new services that require mocking as well as how to use gulp to run tests automatically_

## Setup
Make sure to have all the node dependencies in order when you start, these are updated regularly in case we need to go to a new version of a dependency, or new dependencies are added.

Simply open a terminal / cmd in the Umbraco.Web.UI.Client folder and run:

	npm install

This should setup the entire gulp, Karma and jsint setup we use for tests and pruning.

## Automated testing
To start working on the client files, and have them automatically built and merged into the client project, as well as the VS project, simply run the command

	gulp dev

This will start a webserver on :8080 and tell Karma to run tests every time a .js or .less file is changed. 
After linting and tests have passed, all the client files are copied to umbraco.web.ui/umbraco folder, so it also keeps the server project up to date on any client changes. This should all happen in the background.

## Adding a new service
The process for adding or modifying a service should always be based on passed tests. So if we need to change the footprint of the `ContentService`, and the way any controller calls this service, we need to make sure the tests pass with our mocked services.

This ensures 3 things: 
- we test our controllers
- we test our services
- we always have mocked data available, if you want to run the client without IIS


### Example: 
We add a service for fetching macros from the database, the initial implementation of this service should happen in `/src/common/resources/macro.resource.js`

The macro.resource.js calls `$http` as normal, but no server implementation should be needed at this point.

Next, we describe how the rest service should return data, this is done in /common/mocks/umbraco.httpbackend.js, where we can define what data a certain url
would return. 

So in the case of getting tree items we define:

```javascript
$httpBackend
	.whenGET( urlRegex('/umbraco/UmbracoTrees/ApplicationTreeApi/GetApplicationTrees') )
	.respond(returnApplicationTrees);
```

The `returnApplicationTrees` function then looks like this: 

```javascript
function returnApplicationTrees(status, data, headers){
	var app = getParameterByName(data, "application");
	var tree = _backendData.tree.getApplication(app);
	return [200, tree, null];
}
```

It returns an array of 3 items, the http status code, the expected data and finally it can return a collection of http headers.

```javascript
_backendData.tree.getApplication(app);
```

Refers to a helper method in `umbraco.httpbackend.helper.js` which contains all the helper methods we use to return static json. 

### In short
So to add a service, which requires data from the server we should:

- add the .service.js as normal
- add the .resource.js as normal
- call $http as normal
- define the response data in umbraco.httpbackend.helper.js
- define the url in umbraco.httpbackend.js

### ServerVariables
There is a static server variables file in /mocks which describes the urls used by the rest service, this is currently needed as we don't have this set as an angular service, and no real conventions for these urls yet. Longer-term it would be great to have a urlBuilder which could do

```javascript
urlService.url("contentTypes", "GetAllowedChildren");
// would return /<umbracodir>/<apibaseDir>/contentTypes/getAllowedChildren
```

But for now, they are set in the server variables file.

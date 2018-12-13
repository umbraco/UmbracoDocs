# Umbraco-Headless-Client-NodeJs

JavaScript Client Library for working with the Umbraco Headless API.

The following assumes that you have already installed [NodeJs](https://nodejs.org/)

NodeJs version 8.11.2 LTS or later is recommended but it might work fine with previous releases as well.

## Getting started

Install the umbraco-headless package through npm.<br/>
Create a new empty folder and type the following `npm` commands

```
npm init
npm install umbraco-headless
```

Get access to the api by including it in your project and supplying site and
credentials:

```js
var UmbracoHeadless = require('umbraco-headless');

// this will change when proper token authentication is added
var config = {
    url: "https://domain.s1.umbraco.io",
    username: "email@umbraco.com",
    password: "secret",
    imageBaseUrl: "https://domain.s1.umbraco.io"
};

// to use async / await we must run all code inside a async function
async function run(){

    // create a new instance of the client
    var headlessService = new UmbracoHeadless.HeadlessService(config);

    // the client will implicitly authenticate if you don't do it manually
    await headlessService.authenticate();

    // client is connected and ready

    // get the site
    // NOTE: this currently will not work without a content item as it needs to be implemented.
    // getSite will only work when called WITH a content item argument (getting the ancestor site of that content item).
    // var site = await headlessService.getSite(content);
    // console.log("site name: " + site.name);
    // until implemented - get the site using a query or a Id.
	
    // get a specific item by id
    var site = await headlessService.getById(1000);
	
    // the returned node contains all properties
    console.log("my custom property:", site.myPropertyAlias);

    // it can also be used to navigate by
    var firstChild = await headlessService.getFirstChild(site);

    // multiple results will be wrapped in a paged result
    var children = await headlessService.getChildren(site);
    console.log("total results: ", children.totalResults);
    
    // results on the page can be iterated in the .results array
    console.log("first result of this paged result: ", children.results[0]);
    
    // get a content item by url
    // NOTE: not implemented yet!
    // var contentByUrl = await headlessService.getByUrl("/my-content");
}

// run the async function
run();
```

Copy the entire code above into a file called `index.js` and run the file with node:

```
node .
```

### Using VS Code?
If you are using VSCode as your editor then you can easily set up the editor to debug and easily inspect the values returned from the Umbraco Headless site by configuring the `.vscode/launch.json` file like so

```json5
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [        
        {
            "type": "node",
            "request": "launch",
            "name": "Debug example Umbraco Headless app",
            "program": "${workspaceFolder}\\index.js"
        }
    ]
}
```

## Client

Create as a new with a site configuration

```js
var headlessService = new UmbracoHeadless.HeadlessService(config);
```

You can choose to either authenticate explicitly or let the client authenticate when first used.

```js
var UmbracoHeadless = require('umbraco-headless');
var headlessService = new UmbracoHeadless.HeadlessService(config);
await headlessService.authenticate();
```

### Everything is Async

All methods are async so must be returned as either a promise or using
async/await:

```js
async function run(){
  var content = await headlessService.getById(1123);
  console.log(content.name);
}

run();

// or

headlessService.getById(1123).then(function(content){
  console.log(content.name);
});
```

### Return values

Queries returning a single content item will return the item itself.

This item will have all standard Umbraco properties, along with any custom properties.
It will also contain a collection of links, which is used by the API client to navigate.

All queries returning a collection of items returns a paged result with paging metadata.
The actual results of the query can be iterated in the `.results` property which is an
array of content items.

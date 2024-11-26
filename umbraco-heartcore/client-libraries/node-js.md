# Node.js Client library

In this article you will be able to read about our Node.js Client library. You will be able to see a code sample showing you how to create a client and fetch some data from an Umbraco Heartcore project.

If you are unfamiliar with Node.js you can read more in [the official Node.js documentation](https://nodejs.org/en/docs/).

{% hint style="info" %}
You will have to have Node.js version 10 or above to be able to work with this client library.
{% endhint %}

## Download and install

You can find the Client library on GitHub: [Umbraco Heartcore Node.js](https://github.com/umbraco/Umbraco.Headless.Client.NodeJs).

You can either clone or download the Client library from GitHub or you can install it with npm.

```
npm install @umbraco/headless-client
```

## Node.js Sample

Once you have installed the client library you can create a Client and start fetching data from a project. In the following sample we are fetching content from the root of a project and a media item targeted by its Id, and then logging the results in the console.

```js
//Importing the Client Library
const { Client } = require('@umbraco/headless-client')

//Connecting to the Heartcore project on Cloud
const client = new Client({ projectAlias: 'demo-headless' })

//If protection is turned on you will have to add the API Key that has been assigned to your user 
client.setAPIKey('')

//Create an async function to fetch all content from the root of the project
async function run() {

    //Getting the content from the method where root is targeted
    const contentResult = await client.delivery.content.root()

    //Getting the content from the method where a media item is targeted by its Id
    const mediaResult = await client.delivery.media.byId('b21f3fc4-7d8e-47f7-885b-65b770cb5374')

    //Printing to the console as JSON with indentation for readability
    console.log(JSON.stringify(contentResult, null, 2))
    
    console.log(JSON.stringify(mediaResult, null, 2))
}

run()
```

## Methods to call the API

The Node.js library consists of a long list of different methods you can use in order to fetch and manage data from your Umbraco Heartcore project.

### Calls to the Content Delivery API

The methods to use when fetching content or media from the Content Delivery API uses the following convention:

```js
content.delivery.content.root()

content.delivery.media.root()
```

In the examples above all content / media from the `root` is called. You can also call specific content items by ID or URL, and you can even get related content items by calling e.g. `children()` or `ancestors()`. Find a full list of the available methods for the Content Delivery API on the [sample repository on GitHub](https://github.com/umbraco/Umbraco.Headless.Client.NodeJs#content-delivery).

### Calls to the Content Management API

When using the Content Management API to manage content, media and the various types in your Umbraco Heartcore project, you need to use the following convention:

```js
content.management.content.create()

content.management.contentType.all()
```

In the examples above, the first method shows how to _create new content_  using the Content Management API. The second method gives an example of how to retrieve a list of all available content types. Find a full list of the available methods for the Content Management API on the [sample repository on GitHub](https://github.com/umbraco/Umbraco.Headless.Client.NodeJs#content-management).

## References

* [The official Node.js documentation](https://nodejs.org/en/docs/)
* [API Documentation for Umbraco Heartcore](../api-documentation/)
* [Create an Umbraco Heartcore project](../getting-started/creating-a-heartcore-project.md)

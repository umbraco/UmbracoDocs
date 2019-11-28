---
versionFrom: 8.0.0
---

# Node JS Client library

In this article you will be able to read a little about our Node.js Client library and you will be able to see a code samples showing you how to create a client and fetch some data from a Heartcore project.

If you are unfamiliar with Node.js you can read more at their [documentation](https://nodejs.org/en/docs/).

:::note
You will have to have Node.js version 10 or above to be able to work with this client library.
:::

## Download and install

You are able to find the Client library on Github: [Umbraco Heartcore Node.js](https://github.com/umbraco/Umbraco.Headless.Client.NodeJs).

You can either clone or download the Client library from Github or you can install it with npm.

```
npm install @umbraco/headless-client
```

## Node.js Sample

Once you have installed the client library you can create a Client and start fetching data from a project. In the following sample we are fetching content from the root of a project and a media item targeted by its Id.

```js

//Importing the Client Library
const { Client } = require('@umbraco/headless-client')

//Connecting to the Heartcore project on Cloud
const client = new Client({ projectAlias: 'demo-headless' })

//If protection is turned on you will have to add the API Key that has been asigned to your user 
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

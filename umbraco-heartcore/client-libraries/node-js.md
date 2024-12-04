---
description: >-
  Learn how to fetch content and media from your Umbraco Heartcore project 
  using Node.js and the Umbraco.Headless.Client.NodeJs Library.
---

# Node.js Client library

This article showcases how to fetch content and media from your Umbraco Heartcore project using the official Node.js Client Library. If you are not familiar with **Node.js** you can take a look at the official [Node.js Documentation](https://nodejs.org/en/docs/).

## Prerequisites

- [Node.js](https://nodejs.org/en) (version 10 or above) installed on your machine. You can verify the version by running `node -v` in your terminal.
- Access to an Umbraco Heartcore project.
- An API key generated from your Heartcore project. For more information, see the [Backoffice Users and API Keys](../getting-started/backoffice-users-and-api-keys.md) article.
- Basic familiarity with terminal commands and Node.js.

## Step 1: Create Content and Media in Your Heartcore Project

1. Log into your Heartcore project on the Umbraco Cloud Portal.
2. Navigate to the Content section.
3. Create a new content item, such as a "Home Page." Fill in the necessary fields and publish it.
4. Go to the Media section.
5. Upload an image.
6. Note the content’s URL and media ID for fetching via the Node.js client.

## Step 2: Initialize a Node.js Project

1. Open a terminal or command prompt.
2. Navigate to the directory where you want your project to reside.
3. Run the following command to create a `package.json` file:

```bash
npm init -y
```

## Step 3: Install the Client Library

There are two ways to install the Umbraco Headless Client Library:

- Clone or download the [Umbraco.Headless.Client.NodeJs](https://github.com/umbraco/Umbraco.Headless.Client.NodeJs) client library from GitHub, or

- Run the following command in your terminal:

```bash
npm install @umbraco/headless-client
```

## Step 4: Write the code to Fetch Content and Media

1. Create a new file called `app.js` using a text editor (such as Notepad++ or Visual Studio Code) in your project directory.
2. Open the `app.js` file.
3. Use the following code template:

```js
 //Importing the Client Library
const { Client } = require('@umbraco/headless-client')

//Connecting to the Heartcore project on Cloud
const client = new Client({ 
    projectAlias: 'your-project-alias',
    apiKey: 'your-api-key'
})

//Create an async function to fetch content and media
async function run() {
    try {
        //Fetch all content from the root
        const contentResult = await client.delivery.content.root()

        //Fetch a media item by its ID
        const mediaResult = await client.delivery.media.byId('your-media-id')

        //Log results
        console.log('Content:', JSON.stringify(contentResult, null, 2))

        console.log('Media:', JSON.stringify(mediaResult, null, 2))

    } catch (error) {
        console.error('Error fetching data:', error.response ? error.response.data : error.message)
    }
}

run()

```

## Step 5: Run the Script

1. Open a terminal.
2. Navigate to your project folder.
3. Run the following command:

```bash
node app.js

```

## Exploring API Methods

The Node.js library provides a variety of methods to fetch and manage data from your Umbraco Heartcore project. These methods allow you to interact with both the Content Delivery API and the Content Management API, depending on your requirements.

### Content Delivery API

To fetch content or media, use the following convention:

```js
client.delivery.content.root();

client.delivery.media.root();

client.delivery.content.ancestors(contentId);

client.delivery.content.children(parentId);

client.delivery.content.byId(contentId);
```

In the above examples:

- Use `root()` to fetch all content or media from the root level.
- Use `children()` or `ancestors()` to navigate the hierarchy and retrieve related content or media items. You can also fetch specific items directly by their ID or URL.

For a full list of available methods, visit the [Content Delivery API sample repository on GitHub](https://github.com/umbraco/Umbraco.Headless.Client.NodeJs#content-delivery).

### Content Management API

To manage content, media, and other types, use the following convention:

```js
client.management.content.create()

client.management.contentType.all()
```

In the above examples:

- Use `create()` to add new content.
- Use `all()` to fetch all available content types.

For a full list of available methods, visit the [Content Management API sample repository on GitHub](https://github.com/umbraco/Umbraco.Headless.Client.NodeJs#content-management).

## References

- [Node.js Documentation](https://nodejs.org/en/docs/)
- [Umbraco Heartcore API Documentation](../api-documentation/README.md)
- [Create an Umbraco Heartcore project](../getting-started/creating-a-heartcore-project.md)

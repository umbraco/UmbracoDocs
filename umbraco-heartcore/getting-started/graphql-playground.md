---
description: "Documentation for Umbraco Heartcore GraphQL Playground."
---

# GraphQL Playground

With the GraphQL query language, you will be able to limit the amount of data transferred to and from your Heartcore instance and the client by specifying exactly what kind of information you would like to get in your API calls.

You can test and build GraphQL queries directly in the backoffice-integrated GraphQL Playground.

In the Settings section in the Umbraco Backoffice, you will find the Headless tree. From there you can use the GraphQL Playground to test your queries against your project's schema.

The Playground comes with basic features such as real-time error highlighting, syntax highlighting, formatting, query history and more.

## Accessing GraphQL Playground

1. Log into the project backoffice
2. Navigate to the Settings dashboard
3. Find the Headless tree near the bottom of the navigation list
4. Click on GraphQL

![Where to find GraphQL](images/where-to-find-graphql-playground.png)

From there, you can start querying as soon as your content is published.

## Features

### Documentation & Schema

The GraphQL Playground's build-in documentation and schema browser can be found on the left toolbar

This button will open a pane that grants you a quick overview of how content is structured using the Document Types in your solution.

It also gives an idea of how to access specific properties on each of the Document Types as well as nested properties and properties from Compositions.

While at the same time also explains relationships between specific object and properties in your solution.

This will be updated automatically as you make change to the projects schema meaning Document Types, Data Types, Document Type Compositions and Document Type Elements.

![Documentation and schema pane in the Playground](images/schema-helper.png)

## Running GraphQL queries

To run a query use the left side of the GraphQL Playground to type in your query - could be something as basic as getting the names of all your content pages:

```graphql
{
  allContent {
    items {
      name
    }
  }
}
```

To learn more about querying, visit our [API documentation for GraphQL](../api-documentation/graphql/).

{% hint style="info" %}
The Heartcore GraphQL endpoint only supports queries - other operation types, that is mutations and subscriptions, are not supported.
{% endhint %}

After that, press the "Play" button sitting in the center of the Playground. If the query is constructed correctly, the results will be loaded into the right section.

![Sample query in the Playground](images/sample-query.png)

When you are satisfied with the result, you can copy the client URL (CURL) by clicking the `COPY CURL` button located in the top part of the Playground, next to the address bar.

## Sending HTTP headers

GraphQL Playground supports requests made with HTTP headers - in case for example an authorization token is needed. The `HTTP HEADERS` section can be accessed from the bottom-right corner of the Playground window. By default, it contains the `umb-project-alias` header, which is the alias of your Heartcore project. It is possible to add multiple headers.

## Query variables

It is also possible to define variables for queries - such variables's values can be changed in the bottom-left corner of the Playground window, next to the `HTTP HEADERS` section.

![Sample query with variables in the Playground ](images/query-variables.png)

## History

If you happened to make an amazing query and afterwards erased it by accident, you would be able to re-use it by finding it in the History.

The History pane can be opened by clicking the history button in the toolbar to the left.

![Shows where the history button is](images/query-history.png)

## Prettify

The Playground gives you an option to "prettify" your query with a click of a button, which makes it easier for humans to read.

![Schema Tab in the Playground](images/prettify.png)

## Persisted Queries

The Graphql playground supports persisted graphql queries.
To access Persisted queries you have to go to the [GraphQL Playground](#accessing-graphql-playground) and click the persisted queries tab

![Persisted queries tab](images/persisted-queries-tab.png)

### Create a new persisted query

1. Click the `Create Persisted Query` button
2. Enter a name for the query in the new query editor that appears
3. Write your query in the editor
4. Click the `Save` button

![Create persisted query](images/create-persisted-query.png)

### Update a persisted query

1. Find the query you want to update in the persisted queries list
2. Click on the name of the query
3. An editor will appear with the query
4. Make your changes and click the `Save` button

![Update persisted query](images/update-persisted-query.png)

### Delete a persisted query

1. Find the query you want to delete in the persisted queries list
2. Click on the name of the query
3. An editor will appear with the query
4. Click the action menu in the top right corner of the editor
5. Click the `Delete` button
6. Confirm the deletion

![Delete persisted query](images/delete-persisted-query.png)


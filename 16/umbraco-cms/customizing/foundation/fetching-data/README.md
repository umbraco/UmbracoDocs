---
description: Learn how to request data when extending the Backoffice.
---

# Fetching Data

## Fetch Data Through HTTP

There are two main ways to fetch data through HTTP in the Umbraco Backoffice: using the Fetch API or the Umbraco HTTP client. The Fetch API is a modern way to make network requests in JavaScript, while the Umbraco HTTP client is a wrapper around the Fetch API. That provides a more convenient way to make network requests.

For most scenarios, we recommend using the Umbraco HTTP Client because it:

- Automatically handles authentication and error handling.
- Provides type safety for requests and responses.
- Simplifies request and response parsing.
- Integrates seamlessly with the Backoffice.

The Fetch API is an alternative for simpler use cases.

Here is a quick overview of the two options for you to compare:

 | Feature                | [Fetch API](fetch-api.md)                     | [Umbraco HTTP Client](http-client.md)          |
|------------------------|-------------------------------|------------------------------|
| Authentication         | Manual                       | Automatic                   |
| Error Handling         | Manual                       | Built-in                    |
| Type Safety            | No                           | Yes                         |
| Request Cancellation   | Yes (via AbortController)    | Yes (via AbortController)   |
| Recommended Use Case   | Standard requests              | Complex or frequent requests|

Once you have decided which option to use, you can read more about how to use it below. After that, you can read about how to work with the data you receive from the server.

### [Fetch API](fetch-api.md)

The Fetch API is a modern way to make network requests in JavaScript. It provides a more powerful and flexible feature set than the older XMLHttpRequest.

### [HTTP Client](http-client.md)

The HTTP Client is a wrapper around the Fetch API that provides a more convenient way to make network requests. It handles things like request and response parsing, error handling, and retries.

## Handle Requests

## [Executing Requests](try-execute.md)

Executing the request is the next step after fetching data. You can use the `tryExecute` function to handle errors and refresh the token if it is expired.

## Advanced Topics

### [Custom Generated Client](custom-generated-client.md)

It can be useful to generate a custom client for your API. This can save you a lot of time and effort when working with custom API controllers.

## Further Reading

### [Working with Data](../working-with-data/README.md)

Once you have the data using one of the methods above, you can read more about how to work with it here.

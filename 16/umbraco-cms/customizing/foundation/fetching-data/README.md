---
description: Learn how to request data when extending the Backoffice.
---

# Fetching Data

## Fetch Data Through HTTP

There are two main ways to fetch data through HTTP in the Umbraco Backoffice: 

- [Fetch API](#fetch-api)
- [Umbraco HTTP Client](#umbraco-http-client). 

The Fetch API is a modern way to make network requests in JavaScript, while the Umbraco HTTP client is a wrapper around it, providing a more convenient interface.


For most scenarios, the Umbraco HTTP Client  is recommended because it:

- Automatically handles authentication and error handling.
- Provides type safety for requests and responses.
- Simplifies request and response parsing.
- Integrates seamlessly with the Backoffice.

The Fetch API is an alternative for simpler use cases.

The following table provides a comparison of the two options:

 | Feature                | [Fetch API](fetch-api.md)                     | [Umbraco HTTP Client](http-client.md)          |
|------------------------|-------------------------------|------------------------------|
| Authentication         | Manual                       | Automatic                   |
| Error Handling         | Manual                       | Built-in                    |
| Type Safety            | No                           | Yes                         |
| Request Cancellation   | Yes (via AbortController)    | Yes (via AbortController)   |
| Recommended Use Case   | Common requests | Complex or frequent requests |

After selecting a method, refer to the sections below for implementation details and guidance on handling the received data.

### [Fetch API](fetch-api.md)

The Fetch API is a modern way to make network requests in JavaScript. It provides a more powerful and flexible feature set than the older XMLHttpRequest.

### [Umbraco HTTP Client](http-client.md)

The Umbraco HTTP Client is a wrapper around the Fetch API that provides a more convenient way to make network requests. It handles request and response parsing, error handling, and retries.

## Handle Requests

Once you have chosen a method to fetch data, the next step is to handle the execution of requests. This includes managing errors, refreshing tokens, and ensuring proper authentication.

## [Executing Requests](try-execute.md)

After fetching data, the next step is to execute the request. You can use the `tryExecute` function to handle errors and refresh the token if it is expired.

## Advanced Topics

### [Custom Generated Client](custom-generated-client.md)

For advanced scenarios, you can generate a custom client for your API using tools like **@hey-api/openapi-ts**. This approach is ideal when working with custom API controllers or when you need type-safe, reusable client code.

## Further Reading

### [Working with Data](../working-with-data/README.md)

Once you have the data using one of the methods above, you can read more about how to work with it here.

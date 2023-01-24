# Client Libraries

In order for you to get started with Umbraco Heartcore we have created a set of client libraries for you to use for testing and for getting a seamless start with the product.

The client libraries provide you with a starting point where you do not need to worry about implementing the use of each API endpoint, as these have already been setup. All you need to do is connect the client library to your Umbraco Heartcore project. How this connection is made depends on the client library, but usually requires configuring a couple of parameters.

We recommend testing with these libraries if you are looking to explore the potential of Umbraco Heartcore.

Both client libraries include samples that you can connect to your Heartcore project and start testing in no time.

tip Our client libraries are open source and free to use.

Found a bug? Please let us know by using the Issue Tracker on the GitHub repositories:

* [.NET Standard client library](https://github.com/umbraco/Umbraco.Headless.Client.Net/issues)
* [Node.js client library](https://github.com/umbraco/Umbraco.Headless.Client.NodeJs/issues)

## [.NET Standard](dot-net-core/)

A .NET client library based on .NET Standard 2.0 to support application development including Xamarin/UWP applications.

This client library includes three samples:

* An [ASP.NET Core MVC](dot-net-core/mvc-samples.md) sample site, with custom routing and controller hijacking.
* A[ console application](dot-net-console.md), with options using the Content Delivery and the Content Management API.
* A [Blazor Server sample](https://github.com/umbraco/Umbraco.Headless.Client.Net/tree/master/samples/Umbraco.Headless.Client.Samples.BlazorServer) showing how to use the .NET library to present your Umbraco Heartcore content in a Blazor application.

## [Node.js](node-js.md)

A Node.js client library including a Koa sample that you can hook up to your Umbraco Heartcore project for testing.

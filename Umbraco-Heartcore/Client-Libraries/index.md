---
versionFrom: 8.0.0
---

# Client Libraries

In order for you to get started with Umbraco Heartcore we have created a set of client libraries for you to use for testing and for getting a seamless start with the product. 

The client libraries provides you with a starting point where you do not need to worry about implementing the use of each API endpoint, as these have already been setup. All you need to do is connect to the client library to your Umbraco Heartcore project. How this connection is made depends on the client library, but usually requires configuration of a couple parameters.

We recommend testing with these libraries if you are looking to explore the potential of Umbraco Heartcore.

Both the .NET Core and the Node.js client libraries includes samples that you can connect to you Heartcore project and start testing in no time.

:::tip
Our client libraries are open source and free to use.

Found a bug? Please let us know by using the Issue Tracker on the GitHub repositories:
- [.NET Core client library](https://github.com/umbraco/Umbraco.Headless.Client.Net/issues)
- [Node.js client library](https://github.com/umbraco/Umbraco.Headless.Client.NodeJs/issues)
:::

## [.NET Core](Dot-Net-Core)

A .NET Core client library for the Umbraco Heartcore APIs. The library is based on Netstandard2.0 to support application development including Xamarin/UWP applications.

This client library includes 2 samples:

* An [ASP.NET Core MVC sample](Dot-Net-Core/MVC-Sample) site, with custom routing and controller hijacking.
* A [console application](Dot-Net-Core/#console-sample), with options using the Content Delivery and the Content Management API.

## [Node.js](Node-JS)

A Node.js client library for the Umbraco Heartcore REST APIs. This client library includes a Koa sample that you can hook up to your Umbraco Heartcore project for testing.
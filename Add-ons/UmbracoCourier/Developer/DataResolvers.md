# Data Resolvers

Data resolvers are used by Courier to understand and transfer your data.

## Intended audience
Developers who understands .net, c# and have a clear idea of how Umbraco works and what components in Umbraco do what. 

These concepts are targeted at developers who wish to add support for 3rd party components such as Data Types, or change or extend the way Courier handles current built-in components.

## What is a Data Resolver

In short, a Data resolver is simply a .net class, which inherits from a specific base class, which allows the developer to hook into different events during the data packaging and extraction.

Out of the box, Courier, can understand all standard data-types in Umbraco. This means that Courier knows that a Content picker contains an ID for a document, which then becomes a dependency, and the ID gets translated into a GUID which can safely be deployed to another location. It also knows that a template might contain references to JavaScript files or internal links, using the [locallink:] syntax. Or a lot of other cases where data have a special meaning. 

This is what data resolvers do, add special meaning to specific data that matches certain criteria, for instance properties using a specific data type, templates containing a certain keyword and so on.

## Sample Data Resolver
If you need to build your own Data Resolvers for Courier there are some great examples in the [Courier Contrib project](https://github.com/umbraco/Umbraco.Courier.Contrib). The project contains resolvers for both custom [property editors](https://github.com/umbraco/Umbraco.Courier.Contrib/tree/dev/src/Umbraco.Courier.Contrib.Resolvers/PropertyDataResolvers) and custom [grid editors](https://github.com/umbraco/Umbraco.Courier.Contrib/tree/dev/src/Umbraco.Courier.Contrib.Resolvers/GridCellDataResolvers).
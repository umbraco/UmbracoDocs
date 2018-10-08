# UDI Identifiers

## Introduction 

**Umbraco 7.6.0+** Umbraco stores identifiers in UDI format for most Umbraco object types. This identifier stores all of the metadata required to retrieve an Umbraco object and is parse-able within text. Example: `umb://document/4fed18d8c5e34d5e88cfff3a5b457bf2`. UDI's can be used in many of the querying APIs.

*NOTE: UDI is currently not an acronym for something. There is no official definition of what it's short for. Therefore it's just called UDI*

## Format

An Umbraco UDI consists of three parts: the scheme, the type and a GUID Identifier. For example: `umb://document/4fed18d8c5e34d5e88cfff3a5b457bf2`.

Breaking it down:

1. The scheme is `umb://` - this is always the same and makes it easy to identify an Umbraco UDI
2. The type is `document` - so in this is an Umbraco node, but it could also be `media`, `member`, etc.
3. The GUID Id is `4fed18d8c5e34d5e88cfff3a5b457bf2` - this is a GUID (dashes removed) which is randomly generated when the item is being created

## Usage

You can use UDIs in several of the Querying and Management/Service APIs. The UDI API reference is found here:

* [https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.Udi.html](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.Udi.html)

There are 2x types of UDIs:

* [GUID UDI](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.GuidUdi.html)
* [String UDI](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.StringUdi.html)

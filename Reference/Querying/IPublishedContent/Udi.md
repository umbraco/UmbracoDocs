# UDI Identifiers

## Introduction 
Ever since Umbraco 7.6.0 Umbraco stores identifiers in UDI format for a number of datatypes. So there is no longer a node Id to refer to.

Each UDI is unique between environments and makes it easier to deploy changes between environments. 

## Format
An Umbraco UDI consists of three parts: the scheme, the type and a GUID Identifier. For example: `umb://document/4fed18d8c5e34d5e88cfff3a5b457bf2`.

Breaking it down:
1. The scheme is `umb://` - this is always the same and makes it easy to identify an Umbraco UDI
2. The type is `document` - so in this is an Umbraco node, but it could also be `media`, `member`, etc.
3. The GUID Id is `4fed18d8c5e34d5e88cfff3a5b457bf2` - this is a GUID (dashes removed) which is randomly generated when the item is being created

## Usage
Im most cases you will not have to change anything to use UDIs instead of integer Ids. All of the Services in Umbraco should accept a UDI as an argument instead of an integer.

## Usage with legacy code
Sometimes you will need to pass an integer Id to legacy code. We have some helpers built into Umbraco for that. From an object of type `Umbraco.Core.Udi` you can get the `PublishedContent` item it refers to so that we can get the integer node Id. Make sure that you add this using statement: `using Umbraco.Web.Extensions`:

		var integerNodeId = -1;
		var content = sourceUdi.ToPublishedContent();
		if (content != null) 
		{
			integerNodeId = content.Id;
		}


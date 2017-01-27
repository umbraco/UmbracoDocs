#Breaking changes

_Defines what a breaking change is in regards to the Umbraco core codebase and describes how to deal with required breaking changes._

##What is a breaking change?

This section describes what a breaking change is in regards to the Umbraco codebase. Generally breaking changes are only made on major releases, however in minor releases there may be changes to the codebase that some developers may consider 'breaking' as well. The following points describe what changes to the core codebase are or are not considered breaking changes.

##General codebase

###Non-breaking

* Any changes to the installation objects, classes, interfaces, views, client files, etc... are not considered breaking changes

* Any changes to the interfaces in the namespaces `Umbraco.Core.Services`, `Umbraco.Core.Models`, `Umbraco.Core.Models.Membership`,  are not considered breaking changes
	* Even though changes to an interface are normally considered breaking, these interfaces should not be implemented except by the core code and therefore we do not consider changes to these interfaces as breaking changes.

* Changes to class inheritance are not considered breaking if they do not break API usage
	* Take the following for example, if in v6 a class exists called `MyClass` with the following structure:
		
		    public class MyClass 
    		{
    			public int Id {get;set;}
    			public string Name {get;set;}
    		}
		
	* Then in v6.1 the class structure changes to this:

		    public class MyClass : MySubClass
    		{
				public string Name {get;set;}    			
    		}

			public class MySubClass
			{
				public int Id {get;set;}
			}
	* With the above change, any API usage of MyClass will not break, however if a developer is using reflection to target `MyClass` explicitly, in some cases this will break the reflection call. We **do not** consider these types of changes as breaking changes.
* Changes made to any non-public or non-protected property, methods, interfaces or classes are not considered breaking
	* Generally these types of changes will never break a developers usage unless they are using reflection to target non-public/non-protected objects. 

###Breaking

* Changes made to public or protected method/property definitions
* Changes made to a public interface

##Back Office Controllers

###Non-breaking

* Any changes made to MVC or WebApi controllers found in the namespace `Umbraco.Web.Editors` - these controllers are used solely for the purposes of Umbraco's own management of the back office data. These controllers are not meant for public consumption. It is recommended to create your own controllers for your own components.

##UI files

###Non-breaking

* Changes to CSS are not considered breaking changes
* Changes to HTML/Markup are not considered breaking changes
* Changes to images are not considered breaking changes
* Changes made to the inclusion, exclusion or location change of referenced JS/CSS libraries
* Changes made to .less files are not considered breaking changes

###Breaking

* Changing the file location of CSS or Images is a breaking change
 
_It is advised to use Umbraco's Angular directives if you wish to create back office components, this will mean that you are not referencing CSS or Html markup directly_

##JavaScript

###Non-breaking

* Changes made to publicly accessible APIs that are not documented
* Changes made to publicly accessible API methods that are prefixed with an underscore (meaning these are flagged as internal)
* Changing the location of AngularJS service, controller, directive files

###Breaking

* Changes made to publicly accessble APIs that are documented
* Changing the location of JS library files
* Changing the alias of AngularJS controller, service or directive
 
##Database

###Non-breaking

* Adding items to the schema (i.e. adding a column or a table) is not considered a breaking change
* Changing a column type if it does not cause data loss (i.e. changing from NVarchar to Text) is not considered breaking

###Breaking

* Removing an item from the schema (i.e. removing a column or a table) is considered a breaking change
* Changing a column type if it causes data loss or the result CLR type is different (i.e. Reducing an NVarchar length, or changing a column type from NVarchar to int)

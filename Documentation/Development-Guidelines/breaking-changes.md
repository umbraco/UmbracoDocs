#Breaking changes

_Defines what a breaking change is in regards to the Umbraco core codebase and describes how to deal with required breaking changes._

##What is a breaking change?

This section describes what a breaking change is in regards to the Umbraco codebase. Generally breaking changes are only made on major releases, however in minor releases there may be changes to the codebase that some developers may consider 'breaking' as well. The following points describe what changes to the core codebase are **not** considered breaking changes:

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
* Changes made to any non-public or non-protected property, method or class are not considered breaking
	* Generally these types of changes will never break a developers usage unless they are using reflection to target non-public/non-protected objects. 
* Changes to CSS are not considered breaking changes
* Changes to HTML/Markup are not considered breaking changes

**NOTE: This documention is not complete yet**
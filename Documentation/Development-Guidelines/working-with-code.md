#Working with the code

_Guidelines for creating and updating code in the Umbraco core_

##General Guidelines

* All new code goes in either *Umbraco.Core* or *Umbraco.Web*
	* Depending on what type of code you are writing. If it has to do with the web, then of course it goes in Umbraco.Web. If you could use it in a console app or something like that, then it goes in Umbraco.Core
* *Umbraco.Web.UI* is **only** for rendering files: *JS, CSS, ASPX, ASCX, CSHTML*
	* Any new *ASPX, ASCX* will also put their code behind files here too 
	* All old code behind files exist in *Umbraco.Web*, these can be migrated over to *Umbraco.Web.UI* if and when you work on them
* If you are updating existing code, you should consider moving it to the correct project and namespace, refactoring it to have consistent and correct naming conventions and code reviewing the legacy code to bring it up to date (i.e. removing what isn't needed and fixing what you see) 
	* This is however not a requirement as in some cases this may take more time than you wish to commit to which is ok. Eventually this code will be moved and refactored, we don't have to do it all at once
* If you are updating existing code you should still put any new classes that are created for the legacy code into the new projects/namespaces
* All folders no matter what content exists in it should be *Proper* cased **not** lower cased or cAmel cAsed, see [Naming Conventions](Coding-Standards/naming-conventions.md) for full details.
* New code should be written as unit testable code, you should always use constructor dependencies where possible instead of relying on global singletons to access services. Of course this is not always possible when you don't have control over instantiating objects but when it is you should always use constructor dependencies. This forces you to write clean and unit testable code.
* New and updated code should have unit tests written for them in the Umbraco.Tests project which uses Nunit, by writing unit tests for your code you realize how to improve the APIs you are writing and of course create something that we can test.
* When obsoleting old code be sure to remove references throughout the codebase to this obsolete code and update the codebase to use the new classes and methods
* All new classes should be marked 'internal' until we decide we want to publicly expose the APIs.

##Developing for the v7 AngularJs back office

Describes how to work with the code for building the v7 back office UI

* [Building v7 AngularJs backoffice project](v7-building-angular-project.md)
* [Test driven development flow](v7-test-driven-flow.md)

##Potential issues

* You may come across some issues when developing new classes in *Umbraco.Core* because you may need objects that exist in other projects 
	* This is because *Umbraco.Core* doesn't reference any other projects (except for umbraco.interfaces) and it **never** should 
	* To get around these problems you will need to migrate the code you want to reference in to the *Umbraco.Core* project and obsolete the old code, sometimes this is very easy to do, othertimes it could mean a bit of work and in those cases it will be up to you to decide if you will just put the new code where the legacy code is if time does not permit. However, the new code still needs to be marked internal so we can easily move later on
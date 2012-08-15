#Solution and project structure

_How the Visual Studio solution is structured and what the funcionality of each project is. This also describes the end goal of how we'd like the solution structured._

##The goal
The goal of the Umbraco project is to be able to be left with only a few Visual Studio projects:

* Umbraco.Core
* Umbraco.Web
* Umbraco.Web.UI
* Umbraco.Tests

Acheiving this goal will take quite a lot of time by slowly migrating over old code and refactoring it into new code under new namespaces and projects. This cannot all happen at the same time but starting down this path now means that we can  realize this goal sooner.

##The structure

* Umbraco.Core
	* Contains all functionality in Umbraco that does not pertain to the Web. For example, it contains any classes and objects that could be used in a console application.
	* Assembly: **Umbraco.Core.dll**
	* Does not reference ANY other project except for *umbraco.interfaces*
* Umbraco.Web
	* Contains all functionality in Umbraco pertaining to the web.
	* Contains all of the legacy code (including code behinds) that exists in the umbraco.dll file under the old namespaces but this code will slowly be migrated over to the new namespaces
	* Assembly:  **umbraco.dll**
		* Unfortunately due to the legacy code this project cannot produce a consistent DLL called Umbraco.Web.dll so we are stuck with umbraco.dll until maybe one day when 'the goal' is acheived we might be able to make a switch but this is low priority.
* Umbraco.Web.UI
	* Contains ONLY rendering files, webforms files and MVC Views: *JS, CSS, ASPX, ASCX, ASMX, CSHTML*
	* Legacy webforms files have their codebehind files in the Umbraco.Web project. If these legacy webforms files need to be worked on, we can migrate their codebehind files to the Umbraco.Web.UI project as we see fit.
* Umbraco.Tests
	* Contains all unit tests for Umbraco
	* Uses Nunit for unit tests

##Legacy projects

_The code in the legacy projects will eventually be migrated and refactored with correct naming and code conventions into the new projects and namespaces_

**TODO: Documentation to be completed**

* SqlCE4Umbraco
* umbraco.businesslogic
* umbraco.cms
* umbraco.controls
* umbraco.datalayer
* umbraco.editorControls
* umbraco.interfaces
* umbraco.MacroEngines
* umbraco.MacroEngines.Iron
* umbraco.macroRenderings
* umbraco.providers
* umbraco.webservices
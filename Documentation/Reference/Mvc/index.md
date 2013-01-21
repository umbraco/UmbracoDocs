#Working with MVC in Umbraco

**Applies to: Umbraco 4.10.0+**

_This section will define the syntax for rendering content in your views_ 

Before getting started with MVC you need to enable this in ~/config/umbracoSettings.config by setting the defaultRenderingEngine setting to MVC as such.

	<defaultRenderingEngine>Mvc</defaultRenderingEngine>

##[Views](views.md)
Documentation covering the syntax to use in your Views to render and query content

##[Partial Views](partial-views.md)
Documentation covering how to use Partial Views. This is not documentation about using "Partial View Macros", this documentation relates simply to using native MVC partial views within Umbraco.

##[Surface Controllers](surface-controllers.md)
What is a Surface Controller and how to use them

##[Child Actions](child-actions.md)
Using MVC Child Actions in Umbraco

##[Forms](forms.md)
How to create html forms to submit data

##[Querying](querying.md)
How to query for data in your Views

##[Custom controllers (hijacking routes)](custom-controllers.md)
Creating custom controllers to have 100% full control over how your pages are rendered. AKA: Hijacking Umbraco Routes

##[Custom routes](custom-routes.md)
How to specify your own custom MVC routes in your application to work outside of the Umbraco pipeline

##[Using IoC](using-ioc.md)
How to setup IoC/Dependency Injection containers for use in MVC within Umbraco

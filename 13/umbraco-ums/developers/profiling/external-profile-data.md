# External Profile Data

*Note: this functionality is available starting from v1.12.0*

Your system may associate a Umbraco uMS visitor with other data that comes from some external system such as a Customer  Relation Management (CRM). Note Umbraco uMS does not provide a built-in way to add additional data to a profile. You can store the data in any format and in any way you want. 

If external data is to be used in a custom segment you have to write the data access yourself in the custom segment code.

## Visualization

It is possible to visualize this external data alongside the Umbraco uMS profile in the backoffice by providing a custom AngularJS component for this purpose.

When this component is registered a new tab will be rendered in the Profiles section when viewing profile details. This will render the custom component that was provided and gets passed the Umbraco uMS visitor ID.

![External profile data tab]()

### Register custom components

In order to render this External Profile Tab with a custom component, you only have to create your component and register it with Umbraco uMS. The following code will show how to do both. Put the below code in a .js file in App\_Plugins and load the in the usual way using a package.manifest file. If you have your own custom module, you can use this:
 
```Angular
angular.module("myCustomModule", ["uMarketingSuite"]);// angular.module("umbraco").requires.push("myCustomModule");// angular.module("myCustomModule").run([ ... ]) // Create a component. We create a component named "myCustomExternalProfileDataComponent" here:angular.module("umbraco").component("myCustomExternalProfileDataComponent", {  bindings: { visitorId: "<" },  template: "<h1>My custom external profile data component! visitorId = {{$ctrl.visitorId}}</h1>",  controller: [function () {    this.$onInit = function () {      // Your logic here    }  }]});// Register your custom external profile data component.// Please note you have to use kebab-case for your component name here// just like how you would use it in an AngularJS template (i.e. myCustomComponent -> my-custom-component)angular.module("umbraco").run(["umsCustomComponents", function (customComponents) {  customComponents.profiles.externalProfileData = "my-custom-external-profile-data-component";}]);
```

That is all that is required to render your custom component.
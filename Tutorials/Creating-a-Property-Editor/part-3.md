---
versionFrom: 9.0.0
---


# Integrating services with a property editor

## Overview

This is step 3 in the property editor tutorial. In this part, we will integrate one of the built-in Umbraco services. For this sample, we will use the `notificationsService` to show a dialog with a custom view when you click in a textbox and the content is longer than 30 characters.

## Injecting the service

First up, we need to get access to the service. This is done in the `suggestion.controller.js`, where we add it as a parameter:

```javascript
angular.module("umbraco")
    .controller("SuggestionPluginController",
    // inject Umbraco's assetsService and editor service
    function ($scope, notificationsService) { ... }
```

## Hooking into Textbox

To hook the service with the textbox, we will use the add method of the notificationsService to render our own view by setting the view property. We will also pass an args object which contains the property value and a callback function that we are going to call from our notification.

```javascript
// function to show custom notification
$scope.showNotification = function () {
        if ($scope.model.value.length > 35) {
            notificationsService.add({
                // the path of our custom notification view
                view: "/App_Plugins/Suggestions/notification.html",
                // arguments object we want to pass to our custom notification
                args: {
                    value: $scope.model.value,
                    callback: $scope.TrimText
                }
            });
        }
    };
```

Notice the callback, this callback is used to return whatever data we want to the editor.

So now that we have access to the editor events, we will trim the text to a length of 30. 

```javascript
   $scope.TrimText = function () {
        $scope.model.value = $scope.model.value.substring(0, 35);
    };
   
```

So at this point your controller should look like this:

```javascript
angular.module('umbraco').controller('SuggestionPluginController', function ($scope, notificationsService) {
    console.log($scope.model)
       
    if ($scope.model.value === null || $scope.model.value === "") {
        $scope.model.value = $scope.model.config.defaultValue;
    }

    $scope.aSuggestions = ["You should take a break", "I suggest that you visit the Eiffel Tower", "How about starting a book club?", "Are you hungry?"];

    $scope.getSuggestion = function () {

        $scope.model.value = $scope.aSuggestions[$scope.aSuggestions.length * Math.random() | 0];

    }

    $scope.getState = function () {
        if ($scope.model.config.isEnabled === "1") {
            return false;
        }
        return true;
    }

    // trial code

    $scope.TrimText = function () {
        $scope.model.value = $scope.model.value.substring(0, 35);
    };
   

    $scope.showNotification = function () {
        if ($scope.model.value.length > 35) {
            notificationsService.add({
                // the path of our custom notification view
                view: "/App_Plugins/Suggestions/notification.html",
                // arguments object we want to pass to our custom notification
                args: {
                    value: $scope.model.value,
                    callback: $scope.TrimText
                }
            });
        }
    };

  });
```

### Add the directive in the `suggestion.html`

```html
    <input type="text" ng-model="model.value" ng-click="showNotification()"/>
```

### Add the Javascript file in `package.manifest`

```json
{
 "javascript": [
        "~/App_Plugins/Suggestions/suggestion.controller.js",
        "~/App_Plugins/Suggestions/notification.controller.js"
    ]
}
```

## Creating custom Notification View and Controller

Now, we will add 2 files to the /App_Plugins/Suggestions/ folder:

- `notification.html`
- `notification.controller.js`

In the `notification.html`, we'll add:

```html
<div ng-controller="NotificationController">
    <h4>Your Suggestion is too long.</h4>
    <p>Do you want to trim the text ?</p>
    <p>Trimmed text : {{trimmedtext}}</p>
    <button class="btn umb-alert--warning" ng-click="cancel(notification)">No</button>
    <button class="btn umb-alert--info" ng-click="trim(notification)">Yes</button>
</div>
```

and in the `notification.controller.js` we will add:

```javascript
angular.module('umbraco')
 .controller('NotificationController', function ($scope, notificationsService) {

      // the notification is set on scope by umbraco, so we can access our args object passed in
   $scope.trimmedtext = $scope.notification.args.value.substring(0, 35);

   $scope.trim = function (not) {
    // call our callback function set on the args object in our property editor controller
    not.args.callback();
    notificationsService.remove(not);
   };

   $scope.cancel = function (not) {
    notificationsService.remove(not);
   };
  });
```

Now, restart the application and either enter a suggestion longer than 35 characters or click on `Get Suggestions` button. When you do so and click in the textarea, you will be presented with a notification like this:

![Suggestion Notification](images/suggestion-notification.png)

So, what's happening here? The notification object contains the args object that we passed to the view in our `suggestion.controller.js`. When we click the `Yes` button in the notification, we call the callback function from the Suggestions controller so it gets executed in the scope of our Suggestions property editor.

## Wrap up

So over the 3 previous steps, we've:

- Created a plugin
- Defined an editor
- Registered the data type in Umbraco
- Added a $scope object to pass information from the controller to the view.
- Added configuration to the property editor
- Connected the editor with notification service
- Looked at the notification dialog in play

[Next - Adding server-side data to a property editor](part-4.md)

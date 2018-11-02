# Umbraco.Web.UI.Client project structure

_This is the AngularJS backoffice UI project_

## Overview
This document outlines the location of different files in the Umbraco 7 source code.
The Client-side part of Umbraco 7 is located in the project folder: `Umbraco.Web.Ui.Client

## Root folders
The folders found in the root of the client-side project and their contents:

*/assets*
This folder contains various client-side assets, most of them are obsolete now and will over time be merged into the source

*/build*
Folder containing the compiled and minified bits outputted by Gulp

*/docs*
Automated documentation files by ngdoc project from inline comments in source files as well as from .ngdoc files in /docs/src/

*/lib*
Folder containing all 3rd party dependencies used by the Umbraco web application

*/node_modules*
Dependencies used by Node.js and gulp to build the project

*/src*
The source code of Umbraco 7 UI

*/test*
Test configuration and test files used by the Karma testrunner to unit-test the project.

## Source folders
Inside the /src folder, the Umbraco 7 source code is divided into 3 groups of code: 

- Less files
- Common / shared JavaScript 
- Views 

### Less files
Everything is loaded into the belle.less which specifies what files to include, the variables.less contains global variables

### /views
The Views folder contains all the HTML for the application as well as the controllers used on those views. The convention for views and controllers are:

- /views/section/viewname.html
- /views/section/section.viewname.controller.js

So if you are looking for the HTML and JavaScript used by the content editor look in /src/views/content/edit.html and `/src/views/content/content.edit.controller.js`

### /common
The Common folder contains all the items that are shared between multiple parts of the application, such as Services, Directives and Filters.

If you would like to access the navigationService look in `/src/common/services/navigation.service.js`

For the Umbraco 7 application, we have also introduced the concept of a `Resource`, this term is used for a shared service which primarily is used to access data from the database and perform CRUD operations on this data. 

Example resources could be:

- /src/common/resources/media.resource.js
- /src/common/resources/entity.resource.js

All resources return a promise when data is fetched, they use the same pattern for errors and generally require an HTTP backend to work.
On our serverless setup, we use a mocked http backend to simulate data.

### Packages
Folder containing various sample projects on how to use the external API, good for referencing how the package.manifest and property editors work. 

### app.js and app.dev.js
The central application script handles which modules to inject, app.js is for production, app.dev.js is for testing

### loader.js
yepnope.js based loader for async loading JavaScript files, this file specifies which files to load on application start

### routes.js
Routing setup for /umbraco/ pages, by default it contains an mvc-like convention based pattern, which means that we seldom need to modify this.
=======
# Umbraco.Web.UI.Client project structure

_This is the AngularJS backoffice UI project_

## Overview
This document outlines the location of different files in the Umbraco 7 source code.
The Client-side part of Umbraco 7 is located in the project folder: `Umbraco.Web.Ui.Client`.

## Root folders
The folders found in the root of the client-side project and their contents:

*/assets*
This folder contains various client-side assets, most of them are obsolete now and will over time be merged into the source

*/build*
Folder containing the compiled and minified bits outputted by Gulp

*/docs*
Automated documentation files by ngdoc project from inline comments in source files as well as from .ngdoc files in /docs/src/

*/lib*
Folder containing all 3rd party dependencies used by the Umbraco web application

*/node_modules*
Dependencies used by Node.js and gulp to build the project

*/src*
The source code of Umbraco 7 UI

*/test*
Test configuration and test files used by the Karma testrunner to unit-test the project.

## Source folders
Inside the /src folder, the Umbraco 7 source code is divided into 3 groups of code: 

- Less files
- Common / shared JavaScript 
- Views 

### Less files
Everything is loaded into the belle.less which specifies what files to include, the variables.less contains global variables

### /views
The Views folder contains all the HTML for the application as well as the controllers used on those views. The convention for views and controllers are:

- /views/section/viewname.html
- /views/section/section.viewname.controller.js

So if you are looking for the HTML and JavaScript used by the content editor look in /src/views/content/edit.html and `/src/views/content/content.edit.controller.js`

### /common
The Common folder contains all the items that are shared between multiple parts of the application, such as Services, Directives and Filters.

If you would like to access the navigationService look in `/src/common/services/navigation.service.js`

For the Umbraco 7 application, we have also introduced the concept of a `Resource`, this term is used for a shared service which primarily is used to access data from the database and perform CRUD operations on this data. 

Example resources could be:

- /src/common/resources/media.resource.js
- /src/common/resources/entity.resource.js

All resources return a promise when data is fetched, they use the same pattern for errors and generally require a HTTP backend to work.
On our serverless setup, we use a mocked http backend to simulate data.

### Packages
Folder containing various sample projects on how to use the external API, good for referencing how the package.manifest and property editors work. 

### app.js and app.dev.js
The central application script handles which modules to inject, app.js is for production, app.dev.js is for testing

### loader.js
yepnope.js based loader for async loading JavaScript files, this file specifies which files to load on application start

### routes.js
Routing setup for /umbraco/ pages, by default it contains an mvc-like convention based pattern, which means that we seldom need to modify this.

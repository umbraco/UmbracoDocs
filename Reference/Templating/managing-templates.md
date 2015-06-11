#Managing templates

_Describes how to create/modify templates and describes nested templates_

##Creating templates

Templates can be created in 2 ways: 

* They can be automatically created when you create a [Document Type](../../Using-Umbraco/Backoffice-Overview/Document-Types/index.md) when you've selected the checkbox 'Create matching template'
* They can be created directly in the Template [tree](../../Using-Umbraco/Backoffice-Overview/#Tree) in the Settings [section](../../Using-Umbraco/Backoffice-Overview/#ApplicationsSections)

Templates must be created this way because each template requires a reference in the template database table.

##Modifying templates

Templates can be updated in the Umbraco back office by click on a template in the template tree in the Settings section. Once changes have been made to the template, click the save button to save your changes.

Alternatively you can directly edit the template files in an editor of your choice. 

* MVC views are located in the **~/Views/** folder
* WebForms master pages are located in the **~/Masterpages/** folder

##Nested templates

Templates can be nested which means that you can re-use different parts of your html/markup for other templates. In the template tree you can create a nested template just by selecting 'Create' from the context menu on an existing template.

![creating a nested template](images/create-nested-template.png?raw=true)

You can change a current template's parent template by changing the 'Master template' drop down list.

![change a parent template](images/change-parent-template.png?raw=true)

If you are familiar with WebForms or MVC technologies then you are also able to change how a template is nested by directly modify the template syntax as template nesting does not rely on database entries.
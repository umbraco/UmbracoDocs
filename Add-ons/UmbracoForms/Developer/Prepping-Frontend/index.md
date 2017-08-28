#Preparing your frontend
In order for UmbracoForms to work correctly, Umbraco Forms needs three (3) client dependencies.

- jquery
- jquery validate 
- jquery validate unobtrusive. 

##Adding the scripts to your template
Simply add the three (3) client dependencies to your template within the head tags or at the bottom of the page (if you add them to the bottom you'll need to perform an [extra step](../Rendering-Scripts/index.md)).

Easiest way to add the dependencies is to fetch them from a cdn (like http://www.asp.net/ajax/cdn).
So simply add the following 3 scripts

Example within <head> tags.
```
<head>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.1.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/mvc/5.1/jquery.validate.unobtrusive.min.js"></script>
</head>
```
or just before the </body> tag.
```
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.1.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/mvc/5.1/jquery.validate.unobtrusive.min.js"></script>
</body>
```





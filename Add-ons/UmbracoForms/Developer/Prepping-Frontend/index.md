#Preparing your frontend
In order for Umbraco Forms to work correctly, Umbraco Forms needs three (3) client dependencies.

- jQuery
- jQuery validate 
- jQuery validate unobtrusive. 

##Adding the scripts to your template
Easiest way to add the dependencies is to fetch them from a [CDN](https://en.wikipedia.org/wiki/Content_delivery_network) (like http://www.asp.net/ajax/cdn).

Simply add the three (3) client dependencies below to your template within the head tags or at the bottom of the page.

Example within <head> tags.

<head>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.1.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/mvc/5.1/jquery.validate.unobtrusive.min.js"></script>
</head>

or to add the script to the bottom of the page,  you'll need to perform an [extra step](../Rendering-Scripts/index.md)).
	

	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.1.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/mvc/5.1/jquery.validate.unobtrusive.min.js"></script>






#Preparing your frontend
In order to work correctly Umbraco Forms needs some client dependencies, being jquery, jquery validate and jquery validate unobtrusive. 

##Adding the scripts to your template
Simply add those to your template these can be in the head or at the bottom of the page (if you add them to the bottom you'll need to perform an [extra step](../Rendering-Scripts/index.md)).

Easiest way to add the dependencies is to fetch them from a cdn (like http://www.asp.net/ajax/cdn).
So simply add the following 3 scripts

	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.1.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/mvc/5.1/jquery.validate.unobtrusive.min.js"></script>






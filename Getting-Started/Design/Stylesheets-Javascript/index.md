# Working with stylesheets and javascript

## Bundling & Minification for JavaScript and CSS

You can of course use whatever tools you are comfortable with for bundling & minification but it's worth 
noting that Umbraco ships with the ClientDependency Framework which offers simple runtime bundling & minification.

You can bundle and minify as follows in a view template file.

	@using ClientDependency.Core.Mvc
	@using ClientDependency.Core
	@{
		Html.RequiresJs("~/scripts/Script1.js", 1);
		Html.RequiresJs("~/scripts/Script2.js", 2);

		Html.RequiresCss("~/css/style.css");
	}
	<html>
	<head>
		@Html.RenderCssHere()
		@Html.RenderJsHere()
	</head>
	
Full details of the ClientDependency Framework can be found here: [http://github.com/Shandem/ClientDependency](http://github.com/Shandem/ClientDependency)	
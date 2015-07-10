#Working with stylesheets and javascript

_Umbraco contains ClientDependency Framework which bundles and minifies CSS and JavaScript files.
Visual Studio can also bundle and minify, but that is different from Umbraco's one.
You can see the details of ClientDependency Framework in the following site.  [http://github.com/Shandem/ClientDependency](http://github.com/Shandem/ClientDependency)_

You can reference stylesheets and javascript files as normal html, /scripts and /css are the default folders umbraco will place these assets in

    <script type="text/javascript" src="/scripts/my-script.js"></script>
    <link rel="stylesheet" href="/css/style.css" />

You can also bundle and minify as follows in a view template file - this means Umbraco will cache and minify these assets and serve them as a single file.

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

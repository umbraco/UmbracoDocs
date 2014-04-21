#Creating More Pages

## Using a Maintainable Template Structure

We’ve seen how to create a **_Document Type_**. We have a simple three page site, Home, News and Contact Us. We could easily just create three **_Document Types_** and leave **_Create matching template_** checkbox checked to also create three matching templates. Then we’d copy the same HTML code, job-lot into each template.  

This would work – on a very simple site it actually has some merits however once a site starts to grow this would lead to problems – for instance changing anything in the menu needs to be done on each template - it also means we’d need the user to set the footer on each page etc. 

Umbraco provides us with an elegant solution to keeping a consistent base template – those familiar with MVC will recognise it. 

To start we’re going to unpick a little bit of what we did in creating the homepage to sit the homepage template under a master. 


#Create a Master Template 


Go to the **_Settings > Templates_** and open up the tree.  At the moment we just have our **_Homepage_** template.  Hover over the **_Templates_** menu and click the menu **_..._** button. Create a new template called Master, click **_+ Create_** and then give it the name "_Master_" . Remember to click **_Save_**. 


![Master Template](images/figure-22-master-template.png?raw=true)


*Figure 22 - Master Template**


Now we’re going to move the **_Homepage_** template under the **_Master_** template. To do this select the **_Settings > Homepage node_** and from the **_Properties tab > Master template drop down_**, select _“Master”_ and then click **_Save_**.  This will update the Razor code section to change `Layout = null;` to `Layout = "Master.cshtml";` 

>NOTE: You may have to click off the **_Homepage node_** and back on to see this update – a bug that will be fixed in a future release of Umbraco. 


![Homepage Template now sits under the Master](images/figure-23-homepage-has-master-template.png?raw=true)


*Figure 23 - Homepage Template now sits under the Master*


Now we need to move the parts of our HTML template that are common across all pages into the **_Master_**. This is where as a developer you might need to use your brain as it will be slightly different for different websites – e.g. do all pages have a `<div id="main">` as so can we put this in the master or does this belong to only certain pages? For this site we’ll assume this is part of the child page. Cut everything from the closing curly brace to line 37 `<div id="main-container">` - we’re going to move the header and nav of the site to the master template. Cut this and click **_Save_**. 


![Homepage Template After Cutting the Header](images/figure-24-homepage-after-cutting-the-header.png?raw=true)


*Figure 24 - Homepage Template After Cutting the Header*


Now click on your **_Master_** template and paste this HTML markup after the closing curly brace and remember to click **_Save_**.


![Master Template after Pasting the Header](images/figure-25-master-template-with-header.png?raw=true)

*Figure 25 - Master Template after Pasting the Header*


At the end of this markup we need to tell Umbraco to insert the child template’s content – this is done by adding the code **_@RenderBody()_** at the end (around line 37). Click **_Save_**. 


![Adding RenderBody() to the Master Template](images/figure-26-adding-renderbody.png?raw=true)


*Figure 26 - Adding RenderBody() to the Master Template*


Now we’ll do the same with the footer content. Cut everything from the opening of the _footer-container _div (approximately line 33) from the **_Settings > Templates > Homepage > template tab_**, click **_Save_** and then paste this into the **_Master_** template under the **_@RenderBody_** field we’ve just added. Remember to click **_Save_**. 


![Completed Master Template](images/figure-27-master-template-complete.png?raw=true)


*Figure 27 – Completed Master Template*


Now we’ve done a lot of work – and what we should see if we refresh our localhost page is nothing has changed!  If you have a compilation error you’ve perhaps mistyped **_@RenderBody()_**. If you’re missing any content (header or footer) check that what you have in the templates matches the following:

```
@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
    Layout = null;
}<!doctype html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<title></title>
	<meta name="description" content="">
	<meta name="author" content="">

	<meta name="viewport" content="width=device-width,initial-scale=1">

	<link rel="stylesheet" href="css/style.css">

	<script src="js/libs/modernizr-2.0.6.min.js"></script>
</head>
<body>

	<div id="header-container">
		<header class="wrapper clearfix">
			<h1 id="title">@Umbraco.Field("pageTitle")</h1>
			<nav>
				<ul>
					<li><a href="#">nav ul li a</a></li>
					<li><a href="#">nav ul li a</a></li>
					<li><a href="#">nav ul li a</a></li>
				</ul>
			</nav>
		</header>
	</div>
			
	@RenderBody()
			
	<div id="footer-container">
		<footer class="wrapper">
			<h3>@Umbraco.Field("footerText")</h3>
		</footer>
	</div>

</body>
</html>

```

*Figure 28 - Complete Master Template*

```
@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
    Layout = "Master.cshtml";
}
	<div id="main-container">
		<div id="main" class="wrapper clearfix">
			
			<article>
				<header>
					@Umbraco.Field("bodyText")
				</header>
				<section>
					<h2>article section h2</h2>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sodales urna non odio egestas tempor. Nunc vel vehicula ante. Etiam bibendum iaculis libero, eget molestie nisl pharetra in. In semper consequat est, eu porta velit mollis nec. Curabitur posuere enim eget turpis feugiat tempor. Etiam ullamcorper lorem dapibus velit suscipit ultrices. Proin in est sed erat facilisis pharetra.</p>
				</section>
				<section>
					<h2>article section h2</h2>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sodales urna non odio egestas tempor. Nunc vel vehicula ante. Etiam bibendum iaculis libero, eget molestie nisl pharetra in. In semper consequat est, eu porta velit mollis nec. Curabitur posuere enim eget turpis feugiat tempor. Etiam ullamcorper lorem dapibus velit suscipit ultrices. Proin in est sed erat facilisis pharetra.</p>
				</section>
				<footer>
					<h3>article footer h3</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sodales urna non odio egestas tempor. Nunc vel vehicula ante. Etiam bibendum iaculis libero, eget molestie nisl pharetra in. In semper consequat est, eu porta velit mollis nec. Curabitur posuere enim eget turpis feugiat tempor.</p>
				</footer>
			</article>
			
			<aside>
				<h3>aside</h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sodales urna non odio egestas tempor. Nunc vel vehicula ante. Etiam bibendum iaculis libero, eget molestie nisl pharetra in. In semper consequat est, eu porta velit mollis nec. Curabitur posuere enim eget turpis feugiat tempor. Etiam ullamcorper lorem dapibus velit suscipit ultrices.</p>
			</aside>
			
		</div> <!-- #main -->
	</div> <!-- #main-container -->

```	

*Figure 29 - Complete Homepage Template*


>If you’re new to these concepts then I don’t think what we’ve just done is going to make much sense until we make our next page. 


---
##Next - [Creating Master Template Part 2](Creating-Master-Template-Part-2.md)
Part 2 - using the Master template to create new page types. 
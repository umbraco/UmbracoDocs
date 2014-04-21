#Master Template – The Menu


Now let’s fix the menu – there are two ways of doing this, you could have Umbraco dynamically create a menu from the pages it has in the Content Tree, so that when an editor creates a page it automatically appears or, more simply you can hardcode it. We’re going to hardcode this for now (it’s a good idea as you start building a site to hard code this so you can move around testing before you replace this) and we’ll leave it to you as an exercise to do this later. Edit your **_Master template_** – edit the <li> items under the <nav> tags to say:

```
<nav>
	<ul>
		<li><a href="/">Home</a></li>
		<li><a href="/contact-us">Contact Us</a></li>
		<li><a href="/articles">Articles</a></li>
	</ul>
</nav>

```

*Figure 34 - Master Template - Menu / Nav Section*


**_Save_** your changes and let’s test our menu. You’ll find that clicking on the Article link throws an Umbraco error as we’ve not created this page yet. Let’s do that now.



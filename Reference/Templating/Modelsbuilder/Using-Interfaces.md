# Using Interfaces

When using compositions, Models Builder generates an interface for the composed model, which enables
us to not have to switch back to using `GetPropertyValue()` for the composed properties.

A common use-case for this is if you have a separate composition for the "SEO properties" `Page Title` and `Page Description`.

You would usually use this composition on both your `Home` and `Textpage` document types, but you won't
be able to use the simpler Models Builder syntax (e.g. `Model.PageTitle`) to render them on neither the **Home** template nor
the **Textpage** template, because they would be bound to their respective models. And you won't be able to use it on any Master Template they'd be children of, because that would need to be bound to the generic `IPublishedContent`.
So you'd have to resort to
the *ever-so-slightly* clumsier `Model.GetPropertyValue("pageTitle")` syntax to render these properties.

## Render with a partial

If you create a partial and change the first line to use the *interface name* for the model binding, you can use the nice Models Builder syntax when rendering the properties, like this:


	@inherits Umbraco.Web.Mvc.UmbracoViewPage<ISeocomposition>
	<title>@Model.PageTitle</title>
	<meta name="description" content="@Model.PageDescription">


You can then render the partial from your Master Template with something like this (assuming the partial is named "Metatags.cshtml"):


	<head>
		@Html.Partial("Metatags")
	</head>


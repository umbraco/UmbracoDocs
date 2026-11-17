# Preparing your Frontend

For Umbraco Forms to work correctly, you need to include some client dependencies.

## Client-Side Validation

Umbraco Forms ships with client-side form validation features provided by the [ASP.NET Client Validation library](https://github.com/haacked/aspnet-client-validation).

You can use the following Razor helper to output script tags containing the dependencies. To access this method you will need a reference to `Umbraco.Forms.Web`:

```csharp
@using Umbraco.Forms.Web
<head>
    @Html.RenderUmbracoFormDependencies(Url)
</head>
```

`Url` is a parameter passed into the method. It’s defined as a property on the base view model for an Umbraco template, so it will be automatically available in your Razor views.

Alternatively, you can add the dependencies to the body tag:

```csharp
@using Umbraco.Forms.Web
...

<body>
    @Html.RenderUmbracoFormDependencies(Url)
</body>
```

All dependencies originate from your Umbraco Forms installation, which means that no external references are needed.

If you want to modify the rendering of the scripts, you can provide a object parameter named `htmlAttributes`. The contents of the object will be written out as HTML attributes on the script tags.

You can use this to apply `async` or `defer` attributes. For example:

```csharp
@Html.RenderUmbracoFormDependencies(Url, new { @async = "async" })
```

If using `async`, please make sure to [disable the Forms client-side validation framework check](../developer/configuration/README.md#disableclientsidevalidationdependencycheck). This is necessary as it's not possible to guarantee that the asynchronous script will load in time to be recognized by the check. This can then cause a false positive warning.

{% hint style="info" %}
Umbraco Forms 19 supports only the ASP.NET Client Validation library. Support for jQuery Validation is removed. For the upgrade steps, see the [Version Specific Upgrade Notes](../upgrading/version-specific.md#client-side-validation-without-jquery) article.
{% endhint %}

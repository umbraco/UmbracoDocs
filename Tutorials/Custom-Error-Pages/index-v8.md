---
versionFrom: 8.0.0
---

# Implementing custom error pages

Since Umbraco is built upon Microsoft's .NET Framework and is using ASP.NET, you have several options when it comes to setting up custom error pages on your website.

Custom error handling might make your site look more on-brand and minimize the impact of errors on user experience - for example, a custom 404 with some helpful links (or a search function) could bring some value to the site.

## Contents

This article contains guides on how to create custom error pages for the following types of errors:

* [50* errors (hosting related)](#50-errors)
* [404 errors ("Page note found")](#404-errors)
* [Errors with booting a project](#errors-with-booting-a-project)

## In-code error page handling

One way is to watch for error events and serve corresponding pages via C# code. Please refer to the [Custom 404 handlers](../../Reference/Config/404handlers/) article for an example.

## 50* errors

Another approach for implementing a custom error page would be to specify a page that will be displayed whenever the application encounters a particular error.
For this, you will need to create `.aspx` files to use as error pages, and change the `customErrors` line in `web.config` file.

For a generic error message:

```html
<customErrors mode="On" redirectMode="ResponseRewrite" defaultRedirect="error.aspx"/>
```

If you want to handle error code 500:

```html
<customErrors mode="On" redirectMode="ResponseRewrite" defaultRedirect="error.aspx">
          <error statusCode="500" redirect="500.aspx" />
</customErrors>
```

The above code would work for error 500, which covers compilation errors in Umbraco.

Please note the `error.aspx` and `500.aspx` pages in the above examples would be placed in the root of the site - relative to `web.config`.

The above approach for handling 404 errors would not work, however - for this, we need to change things up a bit.

## 404 errors

In this method we will use a 404 page created via the backoffice.

### Why is the method different for error 404?

In the first example, we set up a custom error 500 page in web.config. If you try setting it up in umbracoSettings.config it will not work. Although the 404 page sample we set up in the above section did work. Why is that?

The 50* errors are all related to the hosting - they come from IIS. That means they are hit 1 layer above Umbraco itself, and as such you can't manage them from Umbraco. It is possible to customize them through the web.config, though.

### Create a 404 page in the backoffice

First, create a new document type (though you could also use a more generic document type if you already have one) called Page404.
Make sure the permissions are set to create it under Content.
Properties on this document type are optional - in most cases, the 404 not found page would be static.
Make sure to assign (and fill out) the template for your error page, and then create it in Content.`

### Set a custom 404 page in umbracoSettings.config

Once all of that is done, grab your published error page's ID, GUID or path and head on over to the config folder. In there, find umbracoSettings.config file and open it up.
In the ``` <errors> ``` section, you can specify redirects for specific error codes as well!

Let us look at the `<error404>` tag.
As the config specifies in the example, the value for error pages can be:

* A content item's GUID ID      (example: 26C1D84F-C900-4D53-B167-E25CC489DAC8)
* An XPath statement            (example: //errorPages[@nodeName='My cool error']
* A content item's integer ID   (example: 1234)

That is where the value you grabbed earlier comes in. Fill it out like so:

```html
<error404>
      <errorPage culture="default">81dbb860-a2e3-49df-9a1c-2e04a8012c03</errorPage>
</error404>
```

The above sample uses a GUID value.

:::note
With this approach, you can set different 404 pages for different languages (cultures) - such as `en-us`, `it` etc.
:::

:::warning
If you are hosting your site on Umbraco Cloud, the best approach would be using an XPath statement - since content IDs might differ across Cloud environments.
:::

## Errors with booting a project

Sometimes you might experience issues with booting up your Umbraco project. This could be a brand new project, or it could be an existing project after an upgrade.

When there is an error during boot you will presented with a generic error page.

![Boot Failed. Umbraco failed to boot, if you are the owner of the website please see the log file for more details.](images/BootFailedGeneric.png "Screen shot of generic BootFailed page")

The file used for rendering this error page can be found here `~/umbraco/views/errors/BootFailed.html`.

In order to customize this error page it is recommend that you create a **new HTML file** in `~/config/errors/` using the name `BootFailed.html`.

:::note
The `BootFailed.html` page will only be shown if debugging is disabled in `web.config` i.e. `<compilation debug="false" />`.  The full error can always be found in the log file.
:::

## Are the error pages not working?

If you set up everything correctly and the error pages are not showing correctly, make sure that you are not using

* Custom [ContentFinders](../../Reference/routing/request-pipeline/IContentFinder/) in your solution,
* Any packages that allow you to customize redirects, or
* Rewrite rules in web.config that might interefere with custom error handling.

# Rewrite rules

To make rewrite rules on Umbraco Cloud as seamless as possible, we've installed the IIS Rewrite Module on all our Umbraco Cloud servers.

You need to use [config transform](../../build-and-customize-your-solution/set-up-your-project/project-settings/config-transforms.md) to add rewrite rules.

{% hint style="info" %}
If you are running Umbraco 8, the rewrite rule can be added directly to your project's `web.config`.
{% endhint %}

The rewrite rules should be added to the `<system.webServer><rewrite>` module in your project's `web.config` file.

```xml
<!--
<rewrite>
    <rules></rules>
</rewrite>
-->
```

## Best practices

When setting up rewrite rules on Umbraco Cloud, there are a few important things to keep in mind:

* Always include a condition to exclude the Umbraco backoffice path (`/umbraco`). Failing to do so may prevent you from deploying to and from the environment.
* To continue working locally with your Umbraco Cloud project, you should also add a condition to exclude `localhost`.
* To serve verification files from the `.well-known` directory (for example, Apple Pay or Google), follow the [Rewrite rule workaround in the CMS documentation](https://docs.umbraco.com/umbraco-cms/reference/routing/iisrewriterules#example-serving-files-from-the-well-known-path).
* If the Umbraco Cloud baseline feature is used, only apply the rewrites to the child project and not the baseline itself.

## Hiding the default `umbraco.io` URL

After assigning a hostname to your live environment, you may want to hide the project's default URL (for example, example.euwest01.umbraco.io). This could be for improving Search Engine Optimization (SEO) or to communicate to your users that the site is accessible only through the primary hostname.

One approach for this is to add a new rewrite rule to the `<system.webServer><rewrite><rules>` section in the `web.config` file. For example, the following rule will redirect all requests for the project `example.euwest01.umbraco.io` to `example.com`. It will use HTTPS and include the `www.` prefix, responding with a permanent redirect status.

```xml
<rule name="Redirect umbraco.io to primary hostname" stopProcessing="true">
  <match url=".*" />
  <conditions>
    <add input="{HTTP_HOST}" pattern="\.umbraco\.io$" />
    <add input="{HTTP_HOST}" pattern="^(dev-|stage-)(.*)?\.umbraco\.io$" ignoreCase="true" negate="true" />
    <add input="{REQUEST_URI}" pattern="^/umbraco" ignoreCase="true" negate="true" />
    <add input="{REQUEST_URI}" pattern="^/App_Plugins" ignoreCase="true" negate="true" />
    <add input="{REQUEST_URI}" pattern="^/sb" negate="true" /> <!-- Don't redirect Smidge Bundle -->
    <add input="{HTTP_COOKIE}" pattern="^(.+; )?UMB_UCONTEXT=([^;]*)(;.+)?$" negate="true" /> <!-- Ensure preview can render -->
	<add input="{HTTP_HOST}" pattern="^localhost(:[0-9]+)?$" negate="true" />
  </conditions>
  <action type="Redirect" url="https://www.example.com/{R:0}" redirectType="Permanent" />
</rule>
```

{% hint style="info" %}
This will not rewrite anything under the `/umbraco` path so that you can still do content deployments. You don't have to give your editors the `umbraco.io` URL, and they won't see it if you give them the actual hostname. This rule will also not apply to your local copy of the site running on `localhost`.
{% endhint %}

## Running your site on HTTPS only

Once you've applied a certificate to your site, anybody visiting your site will always end up on HTTPS instead of the insecure HTTP.

To accomplish this, add a rewrite rule to the live environment's `web.config` in the `<system.webServer><rewrite><rules>` section.

For example, the following rule will redirect all requests for the site http://example.com URL to the secure https://example.com URL and respond with a permanent redirect status.

```xml
<rule name="Redirect HTTP to HTTPS" stopProcessing="true">
  <match url=".*" />
  <conditions>
    <add input="{HTTPS}" pattern="^OFF$" />
    <add input="{HTTP_HOST}" negate="true" pattern="^localhost(:[0-9]+)?$" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/\.well-known/acme-challenge/" />
  </conditions>
  <action type="Redirect" url="https://{HTTP_HOST}/{R:0}" redirectType="Permanent" />
</rule>
```

{% hint style="info" %}
This redirect rule will not apply when the request is already going to the secure HTTPS URL. This redirect rule will also not apply to your local copy of the site running on `localhost`.
{% endhint %}

## Adding a trailing slash to your URLs

It is possible to transform all of your URLs to use a trailing slash consistently for SEO.

To accomplish this, add a rewrite rule to the Live environment's `web.config` in the `<system.webServer><rewrite><rules>` section.

For example, the following rule will redirect all requests for `https://example.com/page` to `https://example.com/page/`, and respond with a permanent redirect status. This way you can ensure that you use the trailing slashes consistently on your site.

```xml
<rule name="Add trailing slash" stopProcessing="true">
  <match url="(.*[^/])$" />
  <conditions>
    <add input="{REQUEST_FILENAME}" negate="true" matchType="IsDirectory" />
    <add input="{REQUEST_FILENAME}" negate="true" matchType="IsFile" />
    <add input="{REQUEST_FILENAME}" negate="true" pattern="(.*?)\.[a-zA-Z0-9]{1,4}$" />
    <add input="{REQUEST_URI}" pattern="^/umbidlocallogin" negate="true" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/umbraco" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/DependencyHandler.axd" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/App_Plugins/" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/\.well-known/acme-challenge/" />
  </conditions>
  <action type="Redirect" url="{R:1}/" />
</rule>
```

{% hint style="info" %}
Take note of the negates in the rewrite rule.

It is important to negate the file paths on your site. If a trailing slash is added, your media may not display correctly after [migrating to Azure Blob Storage](../../build-and-customize-your-solution/handle-deployments-and-environments/media/).
{% endhint %}

## Redirect from non-www to www

Another example would be to redirect from non-www to www:

```xml
<rule name="Redirect to www prefix" stopProcessing="true">
  <match url=".*" />
  <conditions>
    <add input="{HTTP_HOST}" negate="true" pattern="^www\." />
    <add input="{HTTP_HOST}" negate="true" pattern="^localhost(:[0-9]+)?$" />
    <add input="{HTTP_HOST}" negate="true" pattern="\.azurewebsites\.net$" />
    <add input="{HTTP_HOST}" negate="true" pattern="\.umbraco\.io$" />
  </conditions>
  <action type="Redirect" url="https://www.{HTTP_HOST}/{R:0}" />
</rule>
```

{% hint style="warning" %}
Adding the `.azurewebsites.net` pattern is required for the deployment service and the content transfer between environments to continue to function.
{% endhint %}

## Custom Rewrite Rules for Umbraco Cloud

An example configuration to help ensure your custom rules integrate properly:

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
  <location path="." inheritInChildApplications="false">
    <system.webServer>
      <rewrite xdt:Transform="Insert">
        <rules>
          <!-- Add your custom rules here -->
        </rules>
      </rewrite>
    </system.webServer>
  </location>
</configuration>
```

## Troubleshooting

Sometimes, you might experience an issue where a `.azurewebsites.net` link will appear instead of the custom hostname. In this case, a restart will usually fix the issue, however, it is not ideal that this appears at all.

The following redirect is a way to amend the issue where the `.azurewebsites.net` link appears instead of the hostname. It will redirect from the `.azurewebsites.net` link to the hostname of the website, should this link be called instead.

```xml
<rule name="Redirects azurewebsites.net to actual domain" stopProcessing="true">
  <match url=".*" />
  <conditions>
    <add input="{HTTP_HOST}" pattern="^(.*)?.azurewebsites.net$" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/umbraco" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/DependencyHandler.axd" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/App_Plugins" />
    <add input="{REQUEST_URI}" negate="true" pattern="localhost" />
  </conditions>
  <action type="Redirect" url="https://www.hostname.com/{R:0}" appendQueryString="true" redirectType="Permanent" />
</rule>
```

{% hint style="warning" %}
The redirect for `.azurewebsites.net` can be used on projects where only one custom hostname is configured.
{% endhint %}

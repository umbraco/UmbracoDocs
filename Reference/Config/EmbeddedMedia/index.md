# EmbeddedMedia.config

/config/EmbeddedMedia.config

This configuration file lists the [Embedded Media Providers](../../../extending/Embedded-Media-Provider/) configured for use in your Umbraco site.

## Providers

Each Embedded Media Provider is listed as a *provider* element. The *provider* configuration maps the Url of the 'resource to embed' to the code responsible for embedding that type of resource, using a regular expression.

### Anatomy of the configuration

     <provider name="YourEmbedProvider" type="YourEmbedNamespace.YourOEmbedClass, YourDllName">
        <urlShemeRegex><![CDATA[yourregextomatchyourproviderwebsite\.com/]]></urlShemeRegex>
        <apiEndpoint><![CDATA[https://www.yourproidersoembedurl.com/oembed]]></apiEndpoint>
        <requestParams type="Umbraco.Web.Media.EmbedProviders.Settings.Dictionary, umbraco">
          <param name="format">xml</param>
        </requestParams>
      </provider>

- **provider name** - each provider should have a unique name
- **provider type** - the 'type' of the code that provides the implementation, eg.  "YourEmbedNamespace.YourOEmbedClass, YourDllName"
- **urlShemeRegex** - The regex to match the url entered by the editor to the specific provider
- **apiEndPoint** - Used with the generic Umbraco oEmbed providers, sets the url of the oEmbed endpoint to use for the provider
- **requestParams** -  Used with the generic Umbraco oEmbed providers, sets the type of the method responsible for sending additional querystring parameters to the embed Url, there are two methods provided: 
  - Umbraco.Web.Media.EmbedProviders.Settings.Dictionary, umbraco
  - Umbraco.Web.Media.EmbedProviders.Settings.String, umbraco

### Example configuration

     <!-- Youtube Settings -->
      <provider name="Youtube" type="Umbraco.Web.Media.EmbedProviders.OEmbedVideo, umbraco">
        <urlShemeRegex><![CDATA[youtu(?:\.be|be\.com)/(?:(.*)v(/|=)|(.*/)?)([a-zA-Z0-9-_]+)]]></urlShemeRegex>
        <apiEndpoint><![CDATA[https://www.youtube.com/oembed]]></apiEndpoint>
        <requestParams type="Umbraco.Web.Media.EmbedProviders.Settings.Dictionary, umbraco">
          <param name="iframe">1</param>
          <param name="format">xml</param>
          <param name="scheme">https</param>
        </requestParams>
      </provider>

The provider for YouTube is using the generic OEmbedVideo provider, matches a variety of youtube.com urls, and passes several parameters to the request.

Check out the /config/embeddedmedia.config file for more examples.

### Custom Embedded Media Providers

[More information about creating your own Custom Embedded Media Providers can be found here](../../../Extending/Embedded-Media-Provider.md)

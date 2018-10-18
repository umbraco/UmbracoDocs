# Adding a Sitemap.xml

_Note: By default Umbraco doesn't ship with a sitemap.xml but thanks to the wonderful community there are several free and open source methods to add this to your Umbraco site. In this tutorial we'll be using a NuGet package created and maintained by [MarcelDigital](https://www.marceldigital.com/) ._

## Installation

The package is only available trough NuGet, if you are unsure on how to install NuGet packages on your Umbraco site please check [this guide](https://docs.microsoft.com/en-us/nuget/consume-packages/ways-to-install-a-package). The name of the package is **MarcelDigital.UmbracoExtensions.XmlSitemap** so simply enter the command 

`Install-Package MarcelDigital.UmbracoExtensions.XmlSitemap`

in the package manager console

## Configuration

Once the package is installed you should now be able to see a sitemap.xml if you browse to yourdomain.com/sitemap.xml , depending on how your site is setup you might need to define some content filters (to filter out documents by type, by property, ...)

## Default Content Filters

The Umbraco XML Sitemap comes with a number of filters out of the box to cover most of the needs of an Umbraco site.
### No Template Filter
This filter will remove all Umbraco nodes from the sitemap which have no display template assigned to them. 

To configure this filter, use the following class in the `xmlSitemap.config` of the website:
```xml
<umbracoXmlSitemap>
  <filters>
    <filter type="MarcelDigital.UmbracoExtensions.XmlSitemap.Filters.NoTemplateFilter, MarcelDigital.UmbracoExtensions.XmlSitemap" />
  </filters>
</umbracoXmlSitemap>
```

### Document Type Whitelist Filter
This filter will add all the Umbraco nodes that have a matching document type alias in the list of document type aliases provided
in the sitemap configuration. 

To configure this filter, use the following class in the `xmlSitemap.config` of the website and add the whitelist of document types:
```xml
<umbracoXmlSitemap>
  <filters>
    <filter type="MarcelDigital.UmbracoExtensions.XmlSitemap.Filters.DocumentTypeWhitelistFilter, MarcelDigital.UmbracoExtensions.XmlSitemap">
        <documentTypes>
            <add alias="DocumentTypeAlias1" />
            <add alias="DocumentTypeAlias2" />
        </documentTypes>
    </filter>
  </filters>
</umbracoXmlSitemap>
```

### Document Type Blacklist Filter
This filter will remove all the Umbraco nodes that have a matching document type alias in the list of document type aliases provided
in the sitemap configuration. 

To configure this filter, use the following class in the `xmlSitemap.config` of the website and add the whitelist of document types:
```xml
<umbracoXmlSitemap>
  <filters>
    <filter type="MarcelDigital.UmbracoExtensions.XmlSitemap.Filters.DocumentTypeBlacklistFilter, MarcelDigital.UmbracoExtensions.XmlSitemap">
        <documentTypes>
            <add alias="DocumentTypeAlias1" />
            <add alias="DocumentTypeAlias2" />
        </documentTypes>
    </filter>
  </filters>
</umbracoXmlSitemap>
```

### Property Filter
This filter gives the ability remove Umbraco nodes based on their properties and values.

To configure this filter, use the following class in the `xmlSitemap.config` of the website and add the properties to filter on:
```xml
<umbracoXmlSitemap>
  <filters>
    <filter type="MarcelDigital.UmbracoExtensions.XmlSitemap.Filters.PropertiesFilter, MarcelDigital.UmbracoExtensions.XmlSitemap">
        <properties>
            <property alias="propAlias1" value="myValue" operator="equals" required="true" />
        </properties>
    </filter>
  </filters>
</umbracoXmlSitemap>
```

The filter has the following options that can be applied to configure each property to filter on:
* Alias - The alias of the property to filter on.
* Value - The value to check the properties value against.
* Operator - The operator type to check he values against.
  * Values: `equal, unequal`
  * Default: `equal`
* Required - If the node does not have the property, automatically remove.
  * Values: `true, false`
  * Default: `false`

## Further documentation	

For more details about the package and the source code please see [https://github.com/marceldigital/Umbraco-XML-Sitemap](https://github.com/marceldigital/Umbraco-XML-Sitemap)



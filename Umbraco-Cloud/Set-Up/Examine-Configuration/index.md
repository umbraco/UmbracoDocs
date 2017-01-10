# Index strategy for sites on Umbraco Cloud
Umbraco utilizes Lucene indexes in order to fetch data in a fast way. Fetching data from an index is multiple times faster than having to go directly to the database. 

The indexes are used in order to provide search capability in the backoffice (notice the search bar in the very top left of the backoffice), and they also serve as the cache for all metadata on media items.
That means that once a media item is stored, metadata about the media item will be stored in the index, and fetched from it when requested.

These indexes need to be kept in sync, and are required for Umbraco to start up. The way this is done, will directly affect your sites performance.
When working on Umbraco Cloud, there is some key settings that changes, dependending on whether  you are working locally or on your development/staging/live environment. 
Working with Lucene indexes in Umbraco is done via an integration of Examine, which provides a simpler interface for interacting with the indexes. Tweaking settings is done through two key configuration files; `~/Config/ExamineSettings.config` and `~/Config/ExamineIndexes.config`.

## ExamineSettings.config
The Examine settings are split into two parts, the internal index configuration and the external search configuration. Both are defined in `~/Config/ExamineSettings.config`. Each part has the concept of providers and these are the ones that we can do some tweaking on. 
A provider is defined as

    <add name="InternalIndexer" type="UmbracoExamine.UmbracoContentIndexer, UmbracoExamine"
        supportUnpublished="true"
        supportProtected="true"
        analyzer="Lucene.Net.Analysis.WhitespaceAnalyzer, Lucene.Net"/>

The above is the default internal indexer for an Umbraco installation. In order to specify where the indexes are stored we need to add an attribute called `useTempStorage` to the providers.

The following options are available 

* `useTempStorage` is not set
  * This will store the indexes local to the files on the website, defaults to `~/App_Data/TEMP/ExamineIndexes`.
  * On Umbraco Cloud this location is in reality a network share, and is therefore slower than having the files stored locally.
  * The indexes will survive code change and configuration changes, but is in general slower than using `LocalOnly`

* `useTempStorage="LocalOnly"`
  * This setting is default on Umbraco Cloud. It will store the indexes in ASP.NET Temporary storage. The ASP.NET Temporary storage is local to the website and therefore the fastest place to store the files.
  Trouble with having the files here, is that ASP.NET temp storage will be wiped and needs to rebuild again, whenever a code change or configuration change happens.

* `useTempStorage="Sync"`
  * Sync is a "Best of both"-option, but it also has some drawbacks. This will store the indexes in the default location, meaning `~/App_Data/TEMP/ExamineIndexes` AND store them in ASP.NET Temporary storage.
  The system will then write to both locations, but only read from the ASP.NET Temporary storage. The advantage is that when a code change or configuration change happens, the ASP.NET Temporary files
  will be wiped, but instead of the system having to rebuild the indexes, it will just copy them from the `~/App_Data/TEMP/ExamineIndexes` location. This adds a bit to the startup time, but if the site contains a large
  amount of content and media, it will be much faster than having to rebuild everything again.

The conclusion on the settings is that the default setting on Umbraco Cloud is `LocalOnly`, we recommend this setting for most sites. 
For your local development, `LocalOnly` will be a pain, and therefore it should just not have the setting at all. 
Finally, if your site has a large amount of content and media, you should try out `Sync`. You will notice the need for `Sync` by your site having long startup time (speaking many minutes).
On Umbraco Cloud we are ensuring that the ExamineSettings.config is running with `useTempStorage="LocalOnly"`. If you want to change this setting you need to add in a [Config Transform](../Config-Transforms/), that will change the settings.
And example would be this, if you need to change it to `Sync` for all indexes:

    <?xml version="1.0"?>
    <Examine xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
      <ExamineIndexProviders>
        <providers>
          <add useTempStorage="Sync"
              xdt:Transform="SetAttributes(useTempStorage)"/>
        </providers>
      </ExamineIndexProviders>    
      <ExamineSearchProviders>
        <providers>
          <add useTempStorage="Sync"
              xdt:Transform="SetAttributes(useTempStorage)"/>      
        </providers>
      </ExamineSearchProviders> 
    </Examine>

## ExamineIndex.config
Umbraco ships with the ExamineIndex.config file which determines in which path the indexes are stored. It contains a number of `IndexSet` elements, which all have a `IndexPath`-setting.
The setting will define where the files are stored, relative to the `useTempStorage` setting. This means that if the setting is `LocalOnly` It will be stored in the specified location, in ASP.NET Temporary storage.
If it's not set, it will store it relative to the webroot. 
The default setting for the value is `~/App_Data/TEMP/ExamineIndexes/` and then the index name. On Umbraco Cloud, this should always be the same location. We will default the location of the indexes to that location for the three indexes we ship, but if you are utilizing your own custom indexes, remember to update their paths accordingly.

Example for the Internal index:

    <IndexSet SetName="InternalIndexSet" IndexPath="~/App_Data/TEMP/ExamineIndexes/Internal/"/>

## References
* [The .NET port of the original Lucene project](https://lucenenet.apache.org/). This is the library we implement in Umbraco
* [The original Java Lucene project](https://lucene.apache.org/)
* The [source repository for Examine](https://github.com/Shazwazza/Examine), which is the wrapper of the Lucene.NET implementation used in Umbraco
* A [detailed description](https://cultiv.nl/blog/making-sure-your-umbraco-site-performs-on-azure/) of running you sites on Azure (Umbraco Cloud is running on Azure)

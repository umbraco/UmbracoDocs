# ExamineIndex.config

The 'ExamineIndex.config' file contains the configuration for the Examine IndexSets used for storing indexed content in an Umbraco installation.

[See 'ExamineSettings.config'](../ExamineSettings/index.md) for the details of how to configure the methods for populating and searching an IndexSet.

Umbraco ships with three IndexSets:

* **InternalIndexSet** - used to power the Umbraco Backoffice search, and therefore includes unpublished content - (do not remove this)
* **InternalMemberIndexSet** - used by the Umbraco Backoffice to index Members - (do not remove this)
* **ExternalIndexSet** - Available to use for searching published content on the Umbraco site implementation.

In addition custom IndexSets can be created for indexing different parts or sites within your Umbraco implementation, or indexing content in different languages, or even content sources outside of Umbraco!

## Basic Configuration for an IndexSet

The basic configuration for an IndexSet involves specifying the following two attributes:

* **SetName** - the name of the IndexSet, it's convention to have 'IndexSet' at the end of the name, eg ExampleIndexSet will work 'by convention' with an ExampleIndexer and an ExampleSearcher.
* **IndexPath** - the path on disk where your Examine Index files will be stored.
* **IndexParentId** - the Umbraco id of the item in the tree to begin indexing beneath, this defaults to -1 (the root of the site). You could use this to create separate IndexSets for different parts of your site.
eg

        <IndexSet SetName="ExampleIndexSet" IndexPath="~/App_Data/TEMP/ExamineIndexes/Example/" />

would create an IndexSet in the app_data temp folder of your Umbraco site. Make sure your application has the necessary permissions to update files in this location.

You can view the status of your IndexSets via the Umbraco backoffice's Developer Section - Examine Management tab. From here you can see how many items are in a particular index, search the index, and can trigger an index rebuild.

### Advanced configuration for an IndexSet

### Filters
In addition to the basic configuration of an IndexSet you can also specify the following filters on the XML content that is sent to Examine for indexing:

* **IndexAttributeFields** - a list of attributes to include in the index (if the XML you are indexing contains attributes).
* **IndexUserFields** - A list of additional fields to include in your index, eg specific custom Umbraco properties.
* **IncludeNodeTypes** - only allow certain document types (by alias) to be added to the index.
* **ExcludeNodeTypes** - disallow certain document types (by alias) from being added to the index.

If a filter isn't specified then the default behaviour is to index all, eg if IncludeNodeTypes isn't specified in the IndexSet all document types will be indexed.
eg:

    <ExamineLuceneIndexSets>
      <IndexSet SetName="favouriteThingsIndexSet" IndexPath="~/App_Data/TEMP/ExamineIndexes/favouriteThings/">
        <IndexUserFields>
          <add Name="favouriteThingTitle" />
          <add Name="favouriteThingDescription" />
        </IndexUserFields>
        <IncludeNodeTypes>
          <add Name="favThings" />
        </IncludeNodeTypes>
      </IndexSet>
    </ExamineLuceneIndexSets>

In this example only document types based on the favThings doc type will be added to the index, and only the title and description properties will be indexed.

### Field Types and Sorting

By default Examine will index all field values as strings.  What this means is that if you want to perform custom queries such as a Range query on numbers or dates, or to be able to sort search results by a certain field, then you need to tell Examine about the field 'type' in the IndexSet configuration to avoid unpredictable results. (eg 1,10,100,2,3,30,4 - if numbers are sorted alphabetically)

Available Types are: NUMBER, INT, FLOAT, DOUBLE, LONG, DATE, DATETIME, DATE.YEAR, DATE.MONTH, DATE.DAY, DATE.HOUR, DATE.MINUTE

To specify the type of a field, add a Type attribute to its specification in the IndexUserFields list

eg: 

    <add Name="favouriteThingDateCreated" Type="DATETIME" />

and if you want to be able to sort search results by this field add EnableSorting="true" flag.

    <add Name="favouriteThingDateCreated" Type="DATETIME" EnableSorting="true" />

## Example Default ExamineIndex.Config file

    <ExamineLuceneIndexSets>
      <!-- The internal index set used by Umbraco backoffice - DO NOT REMOVE -->
      <IndexSet SetName="InternalIndexSet" IndexPath="~/App_Data/TEMP/ExamineIndexes/Internal/"/>

      <!-- The internal index set used by Umbraco backoffice for indexing members - DO NOT REMOVE -->
      <IndexSet SetName="InternalMemberIndexSet" IndexPath="~/App_Data/TEMP/ExamineIndexes/InternalMember/">
        <IndexAttributeFields>
          <add Name="id" />
          <add Name="nodeName"/>
          <add Name="updateDate" />
          <add Name="writerName" />
          <add Name="loginName" />
          <add Name="email" />
          <add Name="nodeTypeAlias" />
        </IndexAttributeFields>
      </IndexSet>
    
      <!-- Default Indexset for external searches, this indexes all fields on all types of nodes-->
      <IndexSet SetName="ExternalIndexSet" IndexPath="~/App_Data/TEMP/ExamineIndexes/External/" />
    </ExamineLuceneIndexSets>



 

## Further information

You can find more information about Examine, its conventions and documentation at the [Examine GitHub Repository Wiki](https://github.com/Shazwazza/Examine/wiki)

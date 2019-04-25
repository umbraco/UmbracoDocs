# How to resolve collision errors

:::note
If your project is using Umbraco Courier, please refer to this article instead: [Schema Mismatches with Courier](../../Courier/Structure-Errors-Courier)
:::

On some occasions, it is possible that you will encounter **collision errors** on your Umbraco Cloud environments. 

This means that two (or more) `.uda` files have been created for the same entity. The `.uda` files contain schema data for each of your entities e.g Document Types, Templates, Macros, Dictionary Items, Data types etc (for a full list of these entities see [What are UDA files?](../../Setup/Power-Tools/Generating-UDA-files/#what-are-uda-files)).

Here's an example of a collision error:

    Some artifacts collide on unique identifiers.
    This means that they have different Udis, yet
    they refer to the same unique Umbraco object
    and therefore cannot be processed.
    ---------------------------------------------
    Collisions for entity type "document-type": 
      Collisions for unique identifier "home":
        UdaFile: ~/data/revision/document-type__4c04d968448747d791b5eae254afc7ec.uda
        UdaFile: ~/data/revision/document-type__f848c577f02b4ee5aea84f87458072a4.uda


In the example above there are two files in the `~/data/revision` folder which contain the same alias for a Document Type. Each file has a different file name due to having a different unique key (UDI), but the Document Type they both contain is `home`. When Deploy tries to create the site structure from these files, it is inspecting each file to try to create a Document Type with the aliases specified.

In the case above, there are two files (Document Type representations) who share the same alias which leads to a conflict: it's impossible for Deploy to know which is the "correct" file, so it gives up and sends an error back.

### Cause

<iframe width="800" height="450" src="https://www.youtube.com/embed/pF5SUh30FKI?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

The main cause of this problem is when a Document Type (or Media Type, Data Type, etc) is manually created in two environments using the same alias. Since each of the environments are isolated and do not know what the other one is doing until they are synchronized - creating a Document Type in each environment will actually create duplicate Document Types that are considered separate entities even though they look the same and share the same alias in the backoffice of both environments.

If you have two or more Cloud environments, we recommend that you never create or make schema changes directly on the Live or Staging environments. You should work with schema only in your Development environment or even better, your local clone of the project.
# Examine Terminology
_Describes the different terms/names used throughout Examine_

## Index

An *Index* is the repository that stores searchable data, generally Examine uses Lucene as its index repository but if you really wanted it is possible to use any repository, though this would require writing a lot of code.

## The 3 basic parts

Examine is made up of 3 basic parts:**Indexers**, **Searchers** and **Index Sets**. Each one of these components requires exactly 1 of the other components, there is a **1 to 1 to 1 ratio** between these objects. For example, each Index Set will have an associated Indexer and Searcher.

## Indexer

An indexer in Examine is the object that performs the storing data into the index. The most basic interface that defines an indexer is `Examine.IIndexer`. An indexer's functionality is to: Add or update index data for a data entity, delete index data for a data entity, re-index all data based on a specified data source.

## Searcher

A searcher in Examine is the object that performs the searching of data that is stored in the index.The most basic interface that defines a searcher is `Examine.ISearcher`. Examine has the capability to search based on its own Fluent Api, or by querying directly to Lucene using raw lucene search syntax.

## Index Set

An index set is what defines an index, where the index is saved and how the information is stored in the index. 

## Naming conventions

It is important to note the naming conventions above. Your Indexer, Searcher and associated Index Set must all be named according to convention so that they match. With the above examples the naming conventions are:

ExternalIndexer 
ExternalSearcher 
ExternalIndexSet 

Notice that the prefix is all the same, this is a requirement. The suffixes must also match so that the indexer name is suffixed with Indexer, the searcher is suffixed with Searcher and the index set is suffixed with IndexSet.
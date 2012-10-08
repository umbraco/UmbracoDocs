#Plugins

**Applies to: Umbraco 4.10.0+**

_The term 'Plugins' is refering to any types in Umbraco that are found in assemblies that are used to extend and/or enhance the Umbraco application. Plugins can also be added directly registered to their specific 'Resolver' if the plugin type is not public or if the Resolver type doesn't support finding types in assemblies._ 

##[What is a Resolver](resolvers.md)
What is a Resolver and what kinds of Resolvers are there?

##[Creating a Resolver for a Plugin](creating-resolvers.md)
Creating a single object and multiple object Resolver

##[Finding types](finding-types.md)
Using the PluginManager to lookup types in assemblies to register in Resolvers

##[Initializing a Resolver](initializing-resolvers.md)
All Resolvers need to be initialized, this shows you where this needs to occur, how it is done and how to combine type finding with resolvers.
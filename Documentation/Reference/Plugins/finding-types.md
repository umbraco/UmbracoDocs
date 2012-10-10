#Finding types

**Applies to: Umbraco 4.10.0+**

_Whenever types need to be found in assemblies in order to add them to resolvers, the PluginManager should be used. The TypeFinder should never be used directly in any code except for in PluginManager extension methods or in the PluingManager itself._ 

##The Plugin Manager

The `Umbraco.Core.PluginManager` class is responsible for finding and caching all plugin types. It is also responsible for instantiating these types. It contains 4 important methods:

* IEnumerable<Type> ResolveTypes<T>()
	* Generic method to find the specified type and cache the result
* IEnumerable<Type> ResolveTypesWithAttribute<T, TAttribute>()
	* Generic method to find the specified type that has an attribute and cache the result
* IEnumerable<Type> ResolveAttributedTypes<TAttribute>()
	* Generic method to find any type that has the specified attribute and cache the result
* T CreateInstance<T>(Type type, bool throwException = false)
	* Used to create an instance of the specified type based on the resolved/cached plugin types

##Finding types

It is definitely possible to simply use  the methods above to find types in your code but this is not recommended practice. It is recommended to create extension methods for the PluginManager named accordingly to find specific types. For example: 

	PluginManager.Current.ResolveTrees();

The code for this method is as follows:

	internal static IEnumerable<Type> ResolveTrees(this PluginManager resolver)
	{
		return resolver.ResolveTypes<ITree>();
	}

The code simply calls the PluginManager's ResolveTypes method but this method is human readable and easy to distinguish.




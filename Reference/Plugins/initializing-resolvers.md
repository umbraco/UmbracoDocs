#Initializing Resolvers

**Applies to: Umbraco 4.10.0+**

_All resolvers need to be initialized, this occurs in an IBootManager_ 

##Initializing the singleton

An `IBootManager` is a bootstrapper that initializing all required objects during application startup, this includes initializing all resolvers. 

This is a ver easy process, for example to initialize the custom resolvers we've made in the previous steps we would just do the following:

	//initialize the singleton with a DefaultErrorLogger
	ErrorLoggerResolver.Current = new ErrorLoggerResolver(new DefaultErrorLogger());

	//initialize the language converters singleton with 
	//our default language converter types
	LanguageConvertersResolver.Current = new LanguageConvertersResolver(
		new Type[] {
			typeof(EnglishLanguageConverter),
			typeof(SpanishLanguageConverter)
		});

##Initialization with type finding

Instead of initializing multiple object resolvers with an array of known types, we can initialize them with types found in the current application pool if this is the desired behavior. This is quite easy to do once we've created an extension method for the PluginManager to find the specified type. This example initializes the ActionsResolver:

	ActionsResolver.Current = new ActionsResolver(
		PluginManager.Current.ResolveActions());




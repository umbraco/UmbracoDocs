#Creating Resolvers

**Applies to: Umbraco 4.10.0+**

_A Resolver should be created for any plugin type.  Resolvers are the standard way to retreive/create/register plugin types._ 

##Creating a single object resolver

As an example, we'll create a resolver to resolve an application error logger:
	
	/// <summary>
	/// An object resolver to return the IErrorLogger
	/// </summary>
	public class ErrorLoggerResolver : SingleObjectResolverBase<ErrorLoggerResolver, IErrorLogger>
	{
		internal ContentStoreResolver(IErrorLogger errorLogger)
			: base(errorLogger)
		{
		} 
		
		/// <summary>
		/// Can be used by developers at runtime to set their IErrorLogger at app startup
		/// </summary>
		/// <param name="contentStore"></param>
		public void SetErrorLogger(IErrorLogger errorLogger)
		{
			Value = contentStore;
		}
	
		/// <summary>
		/// Returns the IErrorLogger
		/// </summary>
		public IErrorLogger ErrorLogger
		{
			get { return Value; }
		}
	}
	
All you need to do is inherit from `Umbraco.Core.ObjectResolution.SingleObjectResolverBase<TResolver, TResolved>` and then add whatever constructors, properties and methods you would like to expose. 

In the example above we have a constructor that accepts a default `IErrorLogger`. Normally in Umbraco this resolver will be constructored in a `IBootManager` with a default object. The we expose a method to allow developers to change to a custom `IErrorLogger` at runtime called `SetErrorLogger`. Then we create a property to expose the `IErrorLogger` called ErrorLogger.

Its usage is then very easy:

	//get the error logger
	IErrorLogger logger = ErrorLoggerResolver.Current.ErrorLogger;

	//set the error logger (can only be done during application startup)
	ErrorLoggerResolver.Current.SetErrorLogger(new MyCustomErrorLogger("../my-file-path"));

##Creating a multiple object resolver

Creating a multiple object resolver is just as simple. As an example we'll create a LanguageConvertersResolver.

(NOTE: the naming convention for multiple objects resolvers are plural: We've named this LanguageConverter**s**Resolver with a pluralized 'Converters' to denote that this resolver returns multiple objects)

	public sealed class LanguageConvertersResolver : ManyObjectsResolverBase<LanguageConvertersResolver, ILanguageConverter>
    {	
		/// <summary>
		/// Constructor
		/// </summary>
		/// <param name="converters"></param>		
		internal LanguageConvertersResolver(IEnumerable<Type> converters)
			: base(providers)
		{
		}

		/// <summary>
		/// Return the converters
		/// </summary>
		public IEnumerable<ILanguageConverter> Converters
		{
			get { return Values; }
		}        

    }

When creating a multiple object resolver you need to decide what lifetime scope the objects created and returned will have which is defined in the constructor created. The default constructor of the `ManyObjectsResolverBase` specifies that the objects created will have an Application based lifetime scope which means the objects will be singletons only one instance of each one will exist for the lifetime of the application. There are 3 lifetime scopes that can be specified:

* ObjectLifetimeScope.Application
	* One instance of each object will be created for the entire lifetime of the application (singleton)
* ObjectLifetimeScope.Transient
	* A new instance of each object will be created each time the 'Values' collection is accessed
* ObjectLifetimeScope.HttpRequest
	* One instance of each object will be created for the lifetime of the current http request




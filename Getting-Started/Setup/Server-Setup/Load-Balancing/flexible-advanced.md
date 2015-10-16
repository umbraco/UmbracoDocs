#Advanced techniques with Flexible Load Balancing

_This describes some more advanced techniques that you could achieve with flexible load balancing. 
Some of these techniques are based on theory and haven't been particularly well tested... be warned !_

## Front-end servers - readonly database access

_This description pertains ONLY to Umbraco database tables_

In some cases infrastructure admins will not want their front-end servers to have write access to the database. 
By default front-end servers will require write full access to the following tables:

* umbracoServer
* umbracoNode

This is because by default each server will inform the database that they are active and more importantly it is
used for task scheduling. Only a single server can execute task scheduling and these tables are used for servers 
to use a master server election process without the need for any configuration. So in the case that a front-end
server becomes the master task scheduler, **it will actually require write access to all of the Umbraco tables**.

This is actually configurable and in order to do this you will need to have separate application startup handlers
for your front-end servers and your admin server... of course you could make this a configuration option in your own code.

The first thing to do is create a a couple classes for your front-end servers and master server to use:

```
public class MasterServerRegistrar : IServerRegistrar2
{
    public IEnumerable<IServerAddress> Registrations
    {
        get { return Enumerable.Empty<IServerAddress>(); }
    }
    public ServerRole GetCurrentServerRole()
    {
        return ServerRole.Master;
    }
    public string GetCurrentServerUmbracoApplicationUrl()
    {
        //NOTE: If you want to explicitly define the URL that your application is running on,
        // this wil be used for the server to communicate with itself, you can return the 
        // custom path here and it needs to be in this format:
        // http://www.mysite.com/umbraco

        return null;
    }
}

public class FrontEndReadOnlyServerRegistrar : IServerRegistrar2
{
    public IEnumerable<IServerAddress> Registrations
    {
        get { return Enumerable.Empty<IServerAddress>(); }
    }        
    public ServerRole GetCurrentServerRole()
    {
        return ServerRole.Slave;
    }        
    public string GetCurrentServerUmbracoApplicationUrl()
    {
        return null;
    }
}
```

then you'll need to swap the default `DatabaseServerRegistrar` for the your custom registrars during application startup.
You'll need to create an [ApplicationEventHandler](/Documentation/Reference/Events/Application-Startup) and override `ApplicationStarting`. 
During this event you can swap the registrar objects:

```
//This should be executed on your master server
ServerRegistrarResolver.Current.SetServerRegistrar(new MasterServerRegistrar());

//This should be executed on your slave servers
ServerRegistrarResolver.Current.SetServerRegistrar(new FrontEndReadOnlyServerRegistrar());
```

Now that your front-end servers are using your custom `FrontEndReadOnlyServerRegistrar` class, they will always be deemed 'Slave' servers and will not 
attempt any master election or task scheduling and because you are no longer using the default `DatabaseServerRegistrar` they will not try to ping
the umbracoServer table.

By setting your master server to use your custom `MasterServerRegistrar` class, it will always be deemed the 'Master' and will always be the one that 
executes all task scheduling.

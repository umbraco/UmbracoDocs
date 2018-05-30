# Packaging, Extracting and transfering

To understand how Courier works, and to use its API, you must know and understand 3 central concepts Courier uses:

- Packaging
- Extraction
- Transfering

These 3 concepts is what enables Courier to perform deployments in a way that can decouple the Courier client from the sites/destinations it's deploying to/from. 

The below descriptions are from a API point of view, and provides simple exemples on how to use each concept. 

## Packaging
Packaging collects data and files from a given target repository, which supports packaging. Out of the box, any Courier enabled website supports this, however, you cannot perform a packaging on a network share, subversion repository.

When an item has been packaged, its data is serialized to a xml file and stored at a given destination, for the storage you can use the local storage on any repository the client is connected to. 

So to take a packaging step by step:

- A courier client is started, and given a manifest of items to package
- The client connects to a given Source site and starts retrieving data.
- During packaging, the client will find dependencies and resources, and add these to its queue
- When each item is packaged, it's saved as a xml file at a given destination.

To translate this into code, we need a couple of things defined: 

- The client runs on "Machine A"
- The Source repository is "devsite" 
- The Destination repository is "qasite"

So the code we are executeting is not on neither the devsite or qasite, but it could be, if no Source or Destination is set, Courier will try to use the local machine for storage. 


### Configuration
For our configuration, I've setup the 2 repositories in the courier.config file:

	<repositories>
        <repository name="QA site" alias="qasite" type="CourierWebserviceRepositoryProvider" visible="true">
            <url>http://qa.local</url>
            <login>admin</login>
            <password>1234</password>
            <passwordEncoding>Hashed</passwordEncoding>
        </repository>

		<repository name="DEV site" alias="devsite" type="CourierWebserviceRepositoryProvider" visible="true">
            <url>http://dev.local</url>
            <login>admin</login>
            <password>1234</password>
            <passwordEncoding>Hashed</passwordEncoding>
	    </repository>
    </repositories>
 
Notice I use the webservice repository type for both, I could however, use any of the supportd repositories as my **destination** as this is just a simple storage. 

### Code

#### Usings
These are the required usings to work with the sample, only the Courier Core dll should be needed

	using Umbraco.Courier.Core;
    using Umbraco.Courier.Core.Storage;
    using Umbraco.Courier.Core.Packaging;
    using Umbraco.Courier.Core.Collections.Manifests;

#### Connecting to destination and source
Use `RepositoryStorage` to retrieve repositories from the courier.config 

	var rs = new RepositoryStorage();
	Repository destination = rs.GetByAlias("qasite");
    Repository source = rs.GetByAlias("devsite");

#### Creating a new RevisionPackaging
To create a new Packaging operation, you need to specify a name of the data you are working with, this defines where the files are stored, then connect it with the 2 repositories.

	var engine = new RevisionPackaging(Revision);
    engine.Source = source;
    engine.Destination = destination;        

#### Instant Comparison
If you want to allow Courier to perform comparison checking against a destination, you can enable this. This means that courier will do a hashed comparison of all items to determine if they are needed in the revision, this can save time, but it should only be used if you know the destination will not change before the extraction happens.

	engine.EnableInstantCompare(destination);

            




## Extraction


## Transfering
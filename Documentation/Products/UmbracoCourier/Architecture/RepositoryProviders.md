#Repository Providers

A repository provider is a location to store the files courier produces when data is serialized from objects to files. A repository is a simple file store, which can return items in sets, based on a revision alias, so it is possible to store sets of changes in a revision with a certain name, and simply let the Repository store and handle where the files actually exists.

##Local
* **Type**:  `Local`
* **Guid**:  e0472598-e73b-11df-9492-0800200c9a67
* **Full name**:  `Umbraco.Courier.Providers.RepositoryProviders. Local`

The underlying IO provider, this provider is used whenever Courier access revisions or files on the local machine. 

This cannot be configured as Courier always automatically list all revisions from the local provider.

##Courier Webservice
* **Type**:  `CourierWebserviceRepositoryProvider`
* **Guid**:  e0472596-e73b-11df-9492-0800200c9a66
* **Full name**:  `Umbraco.Courier.Providers.RepositoryProviders. CourierWebserviceRepositoryProvider`

The courier webservice provider can connect any other website running umbraco, with courier installed as a repository. It is possible to transfer items back and forth using the http protocol.  To install, add the following to your courier.config under “repositories”.


####Configuration XML
	<repository name="Live" alias="1" type="CourierWebserviceRepositoryProvider" visible="true">
	    <url>http://cws.local</url>
	    <user>0</user>
	    
	    <login>login</login>
	    <password>pass</password>
	    <passwordEncoding>Clear|Hashed</passwordEncoding>
	</repository>

####Settings
* **Url**: url to the website where the other instance is accessible
* **User**: The ID of the umbraco user you want to use to authenticate with
* **Login**: (optional) Instead of user ID you can set a specific login name
* **Password**: (optional) Instead of user ID, you can set a specific password
* **PasswordEncoding**: (optional) specify if Courier should keep password clear or Hashed to match your target repository

**Note**: Courier alwas encrypts credentials. Encoding is more to do with how Umbraco stores user passwords.
Custom Umbraco Membership Providers
If you use a custom umbraco membership provider, you must always specify the login and password on the repository configuration. And set passwordEncoding to Clear.


##Network Share
* **Type**:  NetworkShareProvider
* **Guid**:  e0472598-e73b-11df-9492-0800200c9a66
* **Full name**:  `Umbraco.Courier.Providers.RepositoryProviders. NetworkShareProvider`

The network share repository can transfer items back and forth to a local or network directory where the asp.net application has access. To add a network share repository, add the following to the courier.config under “repositories”

####Configuration XML
	<repository name="Revisions" alias="revisions" type="NetworkShareProvider" visible="true">
	    <path>C:\path\to\repository</path>
	</repository>

####Settings
* **Path**: Contains the fully valid path to the directory where revisions should be stored 


##Subversion 
* **Type**:  SubversionRepository
* **Guid**: e0474ca8-e73b-11df-9492-0800200c9a66
* **Full name**:  Umbraco.Courier.SubversionRepository. SubversionRepository

Provider can connect to a subversion repository

####Configuration XML
	<repository name="SVN Repo" alias="svnRepo" type="SubversionRepository" visible="true">
	    <url>http://cws.local</url>
	    <login>login</login>
	    <password>pass</password>
	</repository>

####Settings
* **Url**: url to subversion repository
* **Login**: Your subversion username
* **Password**: Your subversion password
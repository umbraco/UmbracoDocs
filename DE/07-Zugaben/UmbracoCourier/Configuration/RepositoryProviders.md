---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Repository Providers

A repository provider is a location to store the files Courier produces when data is serialized from objects to files.

A repository is a file storage, which can return items in sets based on a revision alias. It is possible to store sets of changes in a revision with a certain name, and let the repository store and handle where the files exists.

### Local
* **Type**:  `Local`
* **Guid**:  e0472598-e73b-11df-9492-0800200c9a67
* **Full name**:  `Umbraco.Courier.Providers.RepositoryProviders.Local`

The underlying IO provider. This provider is used whenever Courier access revisions or files on the local machine.

This cannot be configured as Courier always automatically lists all revisions from the local provider.

### Courier Webservice
* **Type**:  `CourierWebserviceRepositoryProvider`
* **Guid**:  e0472596-e73b-11df-9492-0800200c9a66
* **Full name**:  `Umbraco.Courier.Providers.RepositoryProviders.CourierWebserviceRepositoryProvider`

The Courier webservice provider can connect any other website running Umbraco, with Courier installed as a repository. It is possible to transfer items back and forth using the HTTP protocol.

To install, add the following to your `courier.config` under `<repositories>`:

```xml
<repository name="Live" alias="1" type="CourierWebserviceRepositoryProvider" visible="true">
    <url>http://cws.local</url>
    <user>0</user>
    <login>login</login>
    <password>pass</password>
    <passwordEncoding>Clear|Hashed</passwordEncoding>
</repository>
```

* **Url**: URL to the website where the other instance is accessible
* **User**: The ID of the Umbraco user you want to use to authenticate with
* **Login (optional)**: Instead of user ID you can set a specific login name
* **Password (optional)**: Instead of user ID, you can set a specific password
* **PasswordEncoding (optional)**: Specify if Courier should keep password clear or Hashed to match your target repository

**Note**: Courier always encrypts credentials. Encoding is more to do with how Umbraco stores user passwords.

If you use a custom Umbraco membership provider, you must always specify the login and password on the repository configuration, and set passwordEncoding to `Clear`.

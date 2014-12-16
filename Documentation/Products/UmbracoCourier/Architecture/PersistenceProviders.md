#PersistenceProviders
Persistence providers are the underlying database connection courier uses to retrieve and persist items. A persistene provider contains a collection of persisters which handle each unique type of object from courier differently. It is very large undertaking to write a complete PersistenceProvider, but it is possible to add individual Item persisters to fairly easy add database support for new item providers.

A persistence provider handles the entire transaction from opening the connect, adding items to the transaction, comitting, and in case of errors it can also perform a rollback of the changes. 

####NHibernate
Provider build on nhibernate 3.x, using FluentNhibernate for mappings. This replicates the umbraco datalayer, and bypasses all events handles in umbraco as well. It also ensures that all transfers are handled as transactions in a safe manner to ensure data is not broken incase a single item fails.

* **Full name:** `Umbraco.Courier.Persistence.V4.NHibernate.NHibernateProvider`
* **DLL:** umbraco.courier.persistence.v4.nhibernate.dll

# Health Checks

In this article, you will find information about Umbraco Forms-related health checks that can be run from the Umbraco backoffice to ensure that your installation is running seamlessly.

Read the [Health Check](https://docs.umbraco.com/umbraco-cms/extending/health-check) article to learn more about the feature in general.

## Database Integrity Health Check

Running this health check will verify whether the database tables for the Umbraco Forms installation are all set up correctly with the proper data integrity checks.

In this section, you can learn more about the background for adding this check, as well as how to use and understand the results.

### Background

A health check was introduced to confirm the Umbraco Forms database tables are all set up with the expected data integrity checks - i.e. primary keys, foreign keys and unique constraints.

In most cases, you can expect them all to be in place without any developer intervention. For new installs, the database schema is initialized with all the necessary integrity constraints. And for upgrades, any new schema changes are automatically applied.

There remains the possibility though that not all will be in place for a particular installation. For example, this could happen if a constraint is added in a new version. It can't be added via an automated migration due to existing data integrity issues.

In particular, prior to version 8.7, there were a number of tables that weren't defined as strictly as they should be in this area. So we've added some primary key, foreign key and unique constraints with this version. If you've been running a version prior to this and are upgrading, these schema updates will be applied automatically _unless_ there is existing data in the tables that prevent them from being added.

There shouldn't be - but without these constraints in place it's always possible for an application bug to exist that allows for example the creation of duplicate records, or the orphaning of records, that aren't correct. This is the reason for the constraints to exist, and why we want to ensure they are in place.

### Running The Health Check

To run the health check:

1.  Navigate to the **Health Check** dashboard in the **Settings** section in the Umbraco backoffice.

    <figure><img src="images/Umb-backoffice.png" alt=""><figcaption></figcaption></figure>
2.  Click on the **Forms** button and select **Check Group**. You'll see a result that looks something like this: \\

    <figure><img src="images/healthcheck.png" alt=""><figcaption></figcaption></figure>

If you have a full set of green ticks, then you're all good - and no need to read on!

If you have one or more red crosses though, that means a particular constraint wasn't able to be applied via the automatic schema migrations when you installed a new version of Umbraco Forms, due to existing data issues.

It isn't essential that they are resolved - the package can and does function correctly without them - but for reasons of ensuring data integrity and performance, it is recommended that they are.

### Resolving Reported Problems

When Umbraco Forms installs an upgrade, it will attempt to apply any schema changes. If though, the update isn't essential, and it can't proceed due to existing data integrity issues, the failed update will be logged and then the rest of the migration will continue.

As well as in the log files, such issues will be visible via the health check and will need to be resolved by applying scripts directly to the database.

To support this, we provide the following SQL scripts:

* Apply database integrity schema changes for 8.7.0+ - [8.7.0-apply-keys-and-indexes](apply-keys.md)
* Apply database integrity schema changes for 8.7.0+ (Forms in database tables) - [8.7.0-apply-keys-and-indexes-forms-in-db](forms-in-the-database-apply-keys.md)

The first of these provides the SQL statements required to apply the schema updates for 8.7.0+ to the common Umbraco Forms tables. The second applies to those tables used for when Forms are stored in the database, and hence only need to be applied if that option is configured.

{% hint style="info" %}
Before running any scripts or queries, be sure to have a database backup in place.
{% endhint %}

To take an example, let's say that via the health check results you can see that the _"Unique constraint on table 'UFForms', column 'Key' is missing."_

If you look in the SQL script you'll see that in order to apply this directly to the database, you would need to run the following SQL statement:

```sql
-- Adds unique constraint to UFForms.
ALTER TABLE dbo.UFForms
ADD CONSTRAINT UK_UFForms_Key UNIQUE NONCLUSTERED
(
 [Key] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
```

If you run it though, you'll see the reason why the migration that ran when Umbraco Forms was upgraded couldn't apply the change:

```sql
The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object name 'dbo.UFForms' and the index name 'UK_UFForms_Key'. The duplicate key value is (...).
```

The constraint can't be applied if there are existing duplicate values, so first they need to be found and removed.

To find duplicate values in the 'Key' field in this table you can run the following SQL statement:

```sql
SELECT [Key]
FROM UFForms
GROUP BY [Key]
HAVING COUNT(*) > 1
```

Running the statement above will list out the 'Key' fields that are duplicated in the table.

To see the full details of the duplicate records, you can use this query:

```sql
SELECT *
FROM UFForms
WHERE [Key] IN (SELECT [Key]
 FROM UFForms
 GROUP BY [Key]
 HAVING COUNT(*) > 1
)
```

From the `Id` field you can identify the Form records that are duplicated and should be removed, and delete the records. To check you have found them all, run one of the above queries again, and confirm you find no records returned.

Finally you can run the `ALTER TABLE...` statement shown above to apply the constraint, and confirm via the health check that it's now in place.

By repeating similar steps as required, you'll be able to ensure that all recommended keys, constraints and indexes are in place.

If for any reason you wish to revert the changes - perhaps when testing these updates in a non-production environment - reversion scripts for all the 8.7 updates are also provided:

To support this, we provide the following SQL scripts:

* Revert database integrity schema changes for 8.7.0+ - [8.7.0-apply-keys-and-indexes\_revert](apply-keys.md#revert-application-of-keys-and-indexes)
* Revert database integrity schema changes for 8.7.0+ (Forms in database tables) - [8.7.0-apply-keys-and-indexes-forms-in-db\_revert](forms-in-the-database-apply-keys.md#reverting-the-application-of-keys-and-indexes)

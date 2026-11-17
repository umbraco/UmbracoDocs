# Apply keys and indexes for forms in the database

```sql
/*
 Applies recommended primary keys, foreign keys and indexes to Umbraco Forms tables relating to "forms in the database" (i.e.
 when configuration key StoreUmbracoFormsInDb = true).
 This replicates for SQL Server the migration AddFormKeysAndIndexes.
 */

-- Adds unique constraint to UFForms.
ALTER TABLE dbo.UFForms
ADD CONSTRAINT UK_UFForms_Key UNIQUE NONCLUSTERED 
(
	[Key] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-- Adds unique constraint to UFDataSource.
ALTER TABLE dbo.UFDataSource
ADD CONSTRAINT UK_UFDataSource_Key UNIQUE NONCLUSTERED 
(
	[Key] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-- Adds unique constraint to UFPrevalueSource.
ALTER TABLE dbo.UFPrevalueSource
ADD CONSTRAINT UK_UFPrevalueSource_Key UNIQUE NONCLUSTERED 
(
	[Key] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-- Adds unique constraint to UFWorkflows.
ALTER TABLE dbo.UFWorkflows
ADD CONSTRAINT UK_UFWorkflows_Key UNIQUE NONCLUSTERED 
(
	[Key] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-- Adds index on join field in UFWorkflows.
CREATE NONCLUSTERED INDEX IX_UFWorkflows_FormId ON dbo.UFWorkflows
(
	FormId ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
```

## Reverting the application of keys and indexes

```sql
/*
 Reverts application of recommended primary keys, foreign keys and indexes to Umbraco Forms tables relating to "forms in the database" (i.e.
 when configuration key StoreUmbracoFormsInDb = true).
 This reverts for SQL Server the migration AddFormKeysAndIndexes and can be used for rolling that back in testing.
 */

-- Reverts addition of unique constraint to UFForms.
ALTER TABLE dbo.UFForms
DROP CONSTRAINT IF EXISTS UK_UFForms_Key
GO

-- Reverts addition of unique constraint to UFPrevalueSource.
ALTER TABLE dbo.UFDataSource
DROP CONSTRAINT IF EXISTS UK_UFDataSource_Key
GO

-- Reverts addition of unique constraint to UFPrevalueSource.
ALTER TABLE dbo.UFPrevalueSource
DROP CONSTRAINT IF EXISTS UK_UFPrevalueSource_Key
GO

-- Reverts addition of unique constraint to UFWorkflows.
ALTER TABLE dbo.UFWorkflows
DROP CONSTRAINT IF EXISTS UK_UFWorkflows_Key
GO

-- Reverts addition of index on foreign key fields in UFWorkflows.
DROP INDEX IF EXISTS IX_UFWorkflows_FormId ON dbo.UFWorkflows
GO

-- Reverts addition of index on foreign key fields in UFWorkflows.
DROP INDEX IF EXISTS IX_UFWorkflows_FormId ON dbo.UFWorkflows
GO
```

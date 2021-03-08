/*
 Reverts application of recommended primary keys, foreign keys and indexes to Umbraco Forms tables relating to "forms in the database" (i.e.
 when configuration key StoreUmbracoFormsInDb = true).
 This reverts for SQL Server the migration AddFormKeysAndIndexes and can be used for rolling that back in testing.
 */

 -- Reverts addition of relationship between UFForms and UFWorkflows.
ALTER TABLE dbo.UFWorkflows
DROP CONSTRAINT IF EXISTS FK_UFWorkflows_UFForms_FormId
GO

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